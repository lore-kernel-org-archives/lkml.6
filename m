Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE76C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E95620C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E95620C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeHTXdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:33:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:13318 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbeHTXdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:33:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 13:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="83404724"
Received: from maru.jf.intel.com ([10.54.51.80])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2018 13:16:34 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH i2c-next v4] i2c: aspeed: Handle master/slave combined irq events properly
Date:   Mon, 20 Aug 2018 13:16:32 -0700
Message-Id: <20180820201632.29229-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most of cases, interrupt bits are set one by one but there are
also a lot of other cases that Aspeed I2C IP sends multiple
interrupt bits with combining master and slave events using a
single interrupt call. It happens much more in multi-master
environment than single-master. For an example, when master is
waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
SLAVE_MATCH and RX_DONE interrupts could come along with the
NORMAL_STOP in case of an another master immediately sends data
just after acquiring the bus. In this case, the NORMAL_STOP
interrupt should be handled by master_irq and the SLAVE_MATCH and
RX_DONE interrupts should be handled by slave_irq. This commit
modifies irq hadling logic to handle the master/slave combined
events properly.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
Changes since v3:
- Fixed typos in a comment.

Changes since v2:
- Changed the name of ASPEED_I2CD_INTR_ERRORS to ASPEED_I2CD_INTR_MASTER_ERRORS
- Removed a member irq_status from the struct aspeed_i2c_bus and changed
  master_irq and slave_irq handlers to make them return status_ack.
- Added a comment to explain why it needs to try both irq handlers.

Changes since v1:
- Fixed a grammar issue in commit message.
- Added a missing line feed character into a message printing.

 drivers/i2c/busses/i2c-aspeed.c | 110 +++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a4f956c6d567..09eb4a9b355c 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -82,6 +82,11 @@
 #define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
 #define ASPEED_I2CD_INTR_TX_NAK				BIT(1)
 #define ASPEED_I2CD_INTR_TX_ACK				BIT(0)
+#define ASPEED_I2CD_INTR_MASTER_ERRORS					       \
+		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
+		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
+		 ASPEED_I2CD_INTR_ABNORMAL |				       \
+		 ASPEED_I2CD_INTR_ARBIT_LOSS)
 #define ASPEED_I2CD_INTR_ALL						       \
 		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
 		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
@@ -227,20 +232,16 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 }
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
+static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 {
-	u32 command, irq_status, status_ack = 0;
+	u32 command, status_ack = 0;
 	struct i2c_client *slave = bus->slave;
-	bool irq_handled = true;
 	u8 value;
 
-	if (!slave) {
-		irq_handled = false;
-		goto out;
-	}
+	if (!slave)
+		return 0;
 
 	command = readl(bus->base + ASPEED_I2C_CMD_REG);
-	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 
 	/* Slave was requested, restart state machine. */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
@@ -249,10 +250,8 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 	}
 
 	/* Slave is not currently active, irq was for someone else. */
-	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
-		irq_handled = false;
-		goto out;
-	}
+	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
+		return status_ack;
 
 	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
 		irq_status, command);
@@ -281,19 +280,19 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 		status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
+	if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
+		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
 
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
 		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
 			dev_err(bus->dev, "Unexpected ACK on read request.\n");
 		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
-
 		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
 		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
 		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
 		break;
 	case ASPEED_I2C_SLAVE_READ_PROCESSED:
-		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
 		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
 			dev_err(bus->dev,
 				"Expected ACK after processed read.\n");
@@ -317,14 +316,7 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 		break;
 	}
 
-	if (status_ack != irq_status)
-		dev_err(bus->dev,
-			"irq handled != irq. expected %x, but was %x\n",
-			irq_status, status_ack);
-	writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
-
-out:
-	return irq_handled;
+	return status_ack;
 }
 #endif /* CONFIG_I2C_SLAVE */
 
@@ -380,21 +372,21 @@ static int aspeed_i2c_is_irq_error(u32 irq_status)
 	return 0;
 }
 
-static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
+static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 {
-	u32 irq_status, status_ack = 0, command = 0;
+	u32 status_ack = 0, command = 0;
 	struct i2c_msg *msg;
 	u8 recv_byte;
 	int ret;
 
-	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	/* Ack all interrupt bits. */
-	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
-
 	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
 		status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
 		goto out_complete;
+	} else {
+		/* Master is not currently active, irq was for someone else. */
+		if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE)
+			goto out_no_complete;
 	}
 
 	/*
@@ -403,19 +395,22 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 * INACTIVE state.
 	 */
 	ret = aspeed_i2c_is_irq_error(irq_status);
-	if (ret < 0) {
+	if (ret) {
 		dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
 			irq_status);
 		bus->cmd_err = ret;
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+		status_ack |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
 		goto out_complete;
 	}
 
 	/* We are in an invalid state; reset bus to a known state. */
 	if (!bus->msgs) {
-		dev_err(bus->dev, "bus in unknown state\n");
+		dev_err(bus->dev, "bus in unknown state irq_status: 0x%x\n",
+			irq_status);
 		bus->cmd_err = -EIO;
-		if (bus->master_state != ASPEED_I2C_MASTER_STOP)
+		if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
+		    bus->master_state != ASPEED_I2C_MASTER_INACTIVE)
 			aspeed_i2c_do_stop(bus);
 		goto out_no_complete;
 	}
@@ -428,6 +423,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 */
 	if (bus->master_state == ASPEED_I2C_MASTER_START) {
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
+			if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_NAK))) {
+				bus->cmd_err = -ENXIO;
+				bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+				goto out_complete;
+			}
 			pr_devel("no slave present at %02x\n", msg->addr);
 			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 			bus->cmd_err = -ENXIO;
@@ -506,7 +506,9 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		goto out_no_complete;
 	case ASPEED_I2C_MASTER_STOP:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
-			dev_err(bus->dev, "master failed to STOP\n");
+			dev_err(bus->dev,
+				"master failed to STOP irq_status:0x%x\n",
+				irq_status);
 			bus->cmd_err = -EIO;
 			/* Do not STOP as we have already tried. */
 		} else {
@@ -540,33 +542,51 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		bus->master_xfer_result = bus->msgs_index + 1;
 	complete(&bus->cmd_complete);
 out_no_complete:
-	if (irq_status != status_ack)
-		dev_err(bus->dev,
-			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
-			irq_status, status_ack);
-	return !!irq_status;
+	return status_ack;
 }
 
 static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
-	bool ret;
+	u32 irq_received, irq_status, irq_acked;
 
 	spin_lock(&bus->lock);
+	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	irq_status = irq_received;
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	if (aspeed_i2c_slave_irq(bus)) {
-		dev_dbg(bus->dev, "irq handled by slave.\n");
-		ret = true;
-		goto out;
+	/*
+	 * In most cases, interrupt bits will be set one by one, although
+	 * multiple interrupt bits could be set at the same time. It's also
+	 * possible that master interrupt bits could be set along with slave
+	 * interrupt bits. Each case needs to be handled using corresponding
+	 * handlers depending on the current state.
+	 */
+	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
+		irq_acked = aspeed_i2c_master_irq(bus, irq_status);
+		irq_status &= ~irq_acked;
+		if (irq_status)
+			irq_acked = aspeed_i2c_slave_irq(bus, irq_status);
+	} else {
+		irq_acked = aspeed_i2c_slave_irq(bus, irq_status);
+		irq_status &= ~irq_acked;
+		if (irq_status)
+			irq_acked = aspeed_i2c_master_irq(bus, irq_status);
 	}
+#else
+	irq_acked = aspeed_i2c_master_irq(bus, irq_status);
 #endif /* CONFIG_I2C_SLAVE */
 
-	ret = aspeed_i2c_master_irq(bus);
+	irq_status &= ~irq_acked;
+	if (irq_status)
+		dev_err(bus->dev,
+			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
+			irq_received, irq_received ^ irq_status);
 
-out:
+	/* Ack all interrupt bits. */
+	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
 	spin_unlock(&bus->lock);
-	return ret ? IRQ_HANDLED : IRQ_NONE;
+	return irq_status ? IRQ_NONE : IRQ_HANDLED;
 }
 
 static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
-- 
2.18.0

