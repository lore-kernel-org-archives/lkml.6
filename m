Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F707C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0648321B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfBKSyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:54:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:56449 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKSyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:54:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="132750344"
Received: from maru.jf.intel.com ([10.54.51.75])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Feb 2019 10:54:51 -0800
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2] i2c: aspeed: Add multi-master use case support
Date:   Mon, 11 Feb 2019 10:54:44 -0800
Message-Id: <20190211185444.4965-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-master environment, this driver's master cannot know
exactly when a peer master sends data to this driver's slave so
cases can be happened that this master tries sending data through
the master_xfer function but slave data from a peer master is still
being processed or slave xfer is started by a peer immediately
after it queues a master command. To support multi-master use cases
properly, this H/W provides arbitration in physical level and it
provides priority based command handling too to avoid conflicts in
multi-master environment, means that if a master and a slave events
happen at the same time, H/W will handle a higher priority event
first and a pending event will be handled when bus comes back to
the idle state.

To support this H/W feature properly, this patch adds the 'pending'
state of master and its handling code so that the pending master
xfer can be continued after slave operation properly.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes since v9:
* Removed cppcheck warnings.

 drivers/i2c/busses/i2c-aspeed.c | 119 +++++++++++++++++++++++++-------
 1 file changed, 93 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 8dc9161ced38..882c4ab1d18a 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -117,6 +117,7 @@
 
 enum aspeed_i2c_master_state {
 	ASPEED_I2C_MASTER_INACTIVE,
+	ASPEED_I2C_MASTER_PENDING,
 	ASPEED_I2C_MASTER_START,
 	ASPEED_I2C_MASTER_TX_FIRST,
 	ASPEED_I2C_MASTER_TX,
@@ -126,12 +127,13 @@ enum aspeed_i2c_master_state {
 };
 
 enum aspeed_i2c_slave_state {
-	ASPEED_I2C_SLAVE_STOP,
+	ASPEED_I2C_SLAVE_INACTIVE,
 	ASPEED_I2C_SLAVE_START,
 	ASPEED_I2C_SLAVE_READ_REQUESTED,
 	ASPEED_I2C_SLAVE_READ_PROCESSED,
 	ASPEED_I2C_SLAVE_WRITE_REQUESTED,
 	ASPEED_I2C_SLAVE_WRITE_RECEIVED,
+	ASPEED_I2C_SLAVE_STOP,
 };
 
 struct aspeed_i2c_bus {
@@ -156,6 +158,8 @@ struct aspeed_i2c_bus {
 	int				cmd_err;
 	/* Protected only by i2c_lock_bus */
 	int				master_xfer_result;
+	/* Multi-master */
+	bool				multi_master;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	struct i2c_client		*slave;
 	enum aspeed_i2c_slave_state	slave_state;
@@ -251,7 +255,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	}
 
 	/* Slave is not currently active, irq was for someone else. */
-	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
+	if (bus->slave_state == ASPEED_I2C_SLAVE_INACTIVE)
 		return irq_handled;
 
 	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
@@ -277,16 +281,15 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
-	if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
+	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
+	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
 		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
-	if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
-		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
 
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
-		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
+		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_ACK))
 			dev_err(bus->dev, "Unexpected ACK on read request.\n");
 		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
 		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
@@ -294,9 +297,12 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
 		break;
 	case ASPEED_I2C_SLAVE_READ_PROCESSED:
-		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
+		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
 			dev_err(bus->dev,
 				"Expected ACK after processed read.\n");
+			break;
+		}
+		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
 		i2c_slave_event(slave, I2C_SLAVE_READ_PROCESSED, &value);
 		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
 		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
@@ -310,10 +316,15 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		break;
 	case ASPEED_I2C_SLAVE_STOP:
 		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
+		break;
+	case ASPEED_I2C_SLAVE_START:
+		/* Slave was just started. Waiting for the next event. */;
 		break;
 	default:
-		dev_err(bus->dev, "unhandled slave_state: %d\n",
+		dev_err(bus->dev, "unknown slave_state: %d\n",
 			bus->slave_state);
+		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 		break;
 	}
 
@@ -329,6 +340,17 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
 	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
 
 	bus->master_state = ASPEED_I2C_MASTER_START;
+
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	/*
+	 * If it's requested in the middle of a slave session, set the master
+	 * state to 'pending' then H/W will continue handling this master
+	 * command when the bus comes back to the idle state.
+	 */
+	if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
+		bus->master_state = ASPEED_I2C_MASTER_PENDING;
+#endif /* CONFIG_I2C_SLAVE */
+
 	bus->buf_index = 0;
 
 	if (msg->flags & I2C_M_RD) {
@@ -384,10 +406,6 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
 		irq_handled |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
 		goto out_complete;
-	} else {
-		/* Master is not currently active, irq was for someone else. */
-		if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE)
-			goto out_no_complete;
 	}
 
 	/*
@@ -399,11 +417,32 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	if (ret) {
 		dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
 			irq_status);
-		bus->cmd_err = ret;
-		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
 		irq_handled |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
-		goto out_complete;
+		if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
+			bus->cmd_err = ret;
+			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+			goto out_complete;
+		}
+	}
+
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	/*
+	 * A pending master command will be started by H/W when the bus comes
+	 * back to idle state after completing a slave operation so change the
+	 * master state from 'pending' to 'start' at here if slave is inactive.
+	 */
+	if (bus->master_state == ASPEED_I2C_MASTER_PENDING) {
+		if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
+			goto out_no_complete;
+
+		bus->master_state = ASPEED_I2C_MASTER_START;
 	}
+#endif /* CONFIG_I2C_SLAVE */
+
+	/* Master is not currently active, irq was for someone else. */
+	if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE ||
+	    bus->master_state == ASPEED_I2C_MASTER_PENDING)
+		goto out_no_complete;
 
 	/* We are in an invalid state; reset bus to a known state. */
 	if (!bus->msgs) {
@@ -423,6 +462,20 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	 * then update the state and handle the new state below.
 	 */
 	if (bus->master_state == ASPEED_I2C_MASTER_START) {
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+		/*
+		 * If a peer master starts a xfer immediately after it queues a
+		 * master command, change its state to 'pending' then H/W will
+		 * continue the queued master xfer just after completing the
+		 * slave mode session.
+		 */
+		if (unlikely(irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH)) {
+			bus->master_state = ASPEED_I2C_MASTER_PENDING;
+			dev_dbg(bus->dev,
+				"master goes pending due to a slave start\n");
+			goto out_no_complete;
+		}
+#endif /* CONFIG_I2C_SLAVE */
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
 			if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_NAK))) {
 				bus->cmd_err = -ENXIO;
@@ -566,7 +619,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	 * interrupt bits. Each case needs to be handled using corresponding
 	 * handlers depending on the current state.
 	 */
-	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
+	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE &&
+	    bus->master_state != ASPEED_I2C_MASTER_PENDING) {
 		irq_handled = aspeed_i2c_master_irq(bus, irq_remaining);
 		irq_remaining &= ~irq_handled;
 		if (irq_remaining)
@@ -601,15 +655,16 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
 	unsigned long time_left, flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&bus->lock, flags);
 	bus->cmd_err = 0;
 
-	/* If bus is busy, attempt recovery. We assume a single master
-	 * environment.
-	 */
-	if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
+	/* If bus is busy in a single master environment, attempt recovery. */
+	if (!bus->multi_master &&
+	    (readl(bus->base + ASPEED_I2C_CMD_REG) &
+	     ASPEED_I2CD_BUS_BUSY_STS)) {
+		int ret;
+
 		spin_unlock_irqrestore(&bus->lock, flags);
 		ret = aspeed_i2c_recover_bus(bus);
 		if (ret)
@@ -629,10 +684,20 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 	time_left = wait_for_completion_timeout(&bus->cmd_complete,
 						bus->adap.timeout);
 
-	if (time_left == 0)
+	if (time_left == 0) {
+		/*
+		 * If timed out and bus is still busy in a multi master
+		 * environment, attempt recovery at here.
+		 */
+		if (bus->multi_master &&
+		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
+		     ASPEED_I2CD_BUS_BUSY_STS))
+			aspeed_i2c_recover_bus(bus);
+
 		return -ETIMEDOUT;
-	else
-		return bus->master_xfer_result;
+	}
+
+	return bus->master_xfer_result;
 }
 
 static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
@@ -672,7 +737,7 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 	__aspeed_i2c_reg_slave(bus, client->addr);
 
 	bus->slave = client;
-	bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 	spin_unlock_irqrestore(&bus->lock, flags);
 
 	return 0;
@@ -827,7 +892,9 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	if (ret < 0)
 		return ret;
 
-	if (!of_property_read_bool(pdev->dev.of_node, "multi-master"))
+	if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
+		bus->multi_master = true;
+	else
 		fun_ctrl_reg |= ASPEED_I2CD_MULTI_MASTER_DIS;
 
 	/* Enable Master Mode */
-- 
2.20.1

