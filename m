Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F846214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F846214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeI0EN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:13:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:4547 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeI0ENu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:13:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 14:58:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="73957805"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2018 14:58:48 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
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
Subject: [PATCH i2c-next v3 3/3] i2c: aspeed: Add bus idle waiting logic for multi-master use cases
Date:   Wed, 26 Sep 2018 14:58:42 -0700
Message-Id: <20180926215842.23125-4-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
code if any slave operation is ongoing and it waits up to the
timeout duration before starting a master_xfer operation.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 62 ++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 0d934ce0c028..957649009b53 100644
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
@@ -115,8 +117,9 @@
 /* 0x18 : I2CD Slave Device Address Register   */
 #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
 
-/* Timeout */
+/* Timeout & Busy checking */
 #define ASPEED_I2C_BUS_TIMEOUT_US_DEFAULT		(5 * 1000 * 1000)
+#define ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US		(10 * 1000)
 
 enum aspeed_i2c_master_state {
 	ASPEED_I2C_MASTER_INACTIVE,
@@ -159,6 +162,8 @@ struct aspeed_i2c_bus {
 	int				cmd_err;
 	/* Protected only by i2c_lock_bus */
 	int				master_xfer_result;
+	/* Multi-master */
+	bool				multi_master;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	struct i2c_client		*slave;
 	enum aspeed_i2c_slave_state	slave_state;
@@ -599,27 +604,50 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
 
+static int aspeed_i2c_check_bus_busy(struct aspeed_i2c_bus *bus)
+{
+	u32 status_check_mask = ASPEED_I2CD_BUS_BUSY_STS;
+	ktime_t timeout;
+
+	if (bus->multi_master) {
+		might_sleep();
+		timeout = ktime_add_us(ktime_get(),
+				       jiffies_to_usecs(bus->adap.timeout));
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
@@ -830,7 +858,9 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	if (ret < 0)
 		return ret;
 
-	if (!of_property_read_bool(pdev->dev.of_node, "multi-master"))
+	if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
+		bus->multi_master = true;
+	else
 		fun_ctrl_reg |= ASPEED_I2CD_MULTI_MASTER_DIS;
 
 	/* Enable Master Mode */
-- 
2.19.0

