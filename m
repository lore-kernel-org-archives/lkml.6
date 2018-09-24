Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E758C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2167D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2167D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIYFKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:10:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:38858 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbeIYFKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:10:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 16:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,299,1534834800"; 
   d="scan'208";a="93371996"
Received: from maru.jf.intel.com ([10.54.51.77])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2018 16:04:54 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH i2c-next v2 2/2] i2c: aspeed: Add bus idle waiting logic for multi-master use cases
Date:   Mon, 24 Sep 2018 16:04:42 -0700
Message-Id: <20180924230442.7732-3-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924230442.7732-1-jae.hyun.yoo@linux.intel.com>
References: <20180924230442.7732-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multi-master environment, this driver's master cannot know
exactly when peer master sends data to this driver's slave so a
case can be happened that this master tries to send data through
the master_xfer function but slave data from peer master is still
being processed by this driver.

To prevent state corruption in the case, this patch adds checking
if any slave operation is ongoing and it waits up to the timeout
duration before starting a master_xfer operation.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 70 ++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 8dc9161ced38..acc26e2a8866 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
@@ -99,6 +100,7 @@
 		 ASPEED_I2CD_INTR_TX_ACK)
 
 /* 0x14 : I2CD Command/Status Register   */
+#define ASPEED_I2CD_XFER_MODE_STS_MASK			GENMASK(22, 19)
 #define ASPEED_I2CD_SCL_LINE_STS			BIT(18)
 #define ASPEED_I2CD_SDA_LINE_STS			BIT(17)
 #define ASPEED_I2CD_BUS_BUSY_STS			BIT(16)
@@ -115,6 +117,10 @@
 /* 0x18 : I2CD Slave Device Address Register   */
 #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
 
+/* Bus busy checking */
+#define ASPEED_I2C_IDLE_WAIT_TIMEOUT_MS_DEFAULT		100   /* 100 ms */
+#define ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US		10000 /* 10 ms */
+
 enum aspeed_i2c_master_state {
 	ASPEED_I2C_MASTER_INACTIVE,
 	ASPEED_I2C_MASTER_START,
@@ -156,6 +162,9 @@ struct aspeed_i2c_bus {
 	int				cmd_err;
 	/* Protected only by i2c_lock_bus */
 	int				master_xfer_result;
+	/* Multi-master */
+	bool				multi_master;
+	u32				idle_wait_timeout_ms;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	struct i2c_client		*slave;
 	enum aspeed_i2c_slave_state	slave_state;
@@ -596,27 +605,49 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
 
+static int aspeed_i2c_check_bus_busy(struct aspeed_i2c_bus *bus)
+{
+	u32 status_check_mask = ASPEED_I2CD_BUS_BUSY_STS;
+	ktime_t timeout;
+
+	if (bus->multi_master) {
+		might_sleep();
+		timeout = ktime_add_ms(ktime_get(), bus->idle_wait_timeout_ms);
+		/*
+		 * ASPEED_I2CD_XFER_MODE_STS_MASK is marked as
+		 * 'for debugging purpose only' in datasheet but ASPEED
+		 * confirmed that this reflects real information and good to be
+		 * used in practical code. It will be used only in multi-master
+		 * use cases.
+		 */
+		status_check_mask |= ASPEED_I2CD_XFER_MODE_STS_MASK;
+	}
+
+	for (;;) {
+		if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
+		      status_check_mask))
+			return 0;
+		if (!bus->multi_master)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0)
+			break;
+		usleep_range((ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US >> 2) + 1,
+			     ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US);
+	}
+
+	return aspeed_i2c_recover_bus(bus);
+}
+
 static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 				  struct i2c_msg *msgs, int num)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
 	unsigned long time_left, flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&bus->lock, flags);
-	bus->cmd_err = 0;
 
-	/* If bus is busy, attempt recovery. We assume a single master
-	 * environment.
-	 */
-	if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
-		spin_unlock_irqrestore(&bus->lock, flags);
-		ret = aspeed_i2c_recover_bus(bus);
-		if (ret)
-			return ret;
-		spin_lock_irqsave(&bus->lock, flags);
-	}
+	if (aspeed_i2c_check_bus_busy(bus))
+		return -EAGAIN;
 
+	spin_lock_irqsave(&bus->lock, flags);
 	bus->cmd_err = 0;
 	bus->msgs = msgs;
 	bus->msgs_index = 0;
@@ -827,8 +858,17 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	if (ret < 0)
 		return ret;
 
-	if (!of_property_read_bool(pdev->dev.of_node, "multi-master"))
+	if (of_property_read_bool(pdev->dev.of_node, "multi-master")) {
+		bus->multi_master = true;
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "idle-wait-timeout-ms",
+					   &bus->idle_wait_timeout_ms);
+		if (ret)
+			bus->idle_wait_timeout_ms =
+				ASPEED_I2C_IDLE_WAIT_TIMEOUT_MS_DEFAULT;
+	} else {
 		fun_ctrl_reg |= ASPEED_I2CD_MULTI_MASTER_DIS;
+	}
 
 	/* Enable Master Mode */
 	writel(readl(bus->base + ASPEED_I2C_FUN_CTRL_REG) | fun_ctrl_reg,
-- 
2.18.0

