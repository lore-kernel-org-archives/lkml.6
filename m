Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D13C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F286625D1B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F286625D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeGBVkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:40:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:28861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753132AbeGBVkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:40:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 14:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,300,1526367600"; 
   d="scan'208";a="52149754"
Received: from maru.jf.intel.com ([10.54.51.80])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jul 2018 14:40:12 -0700
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
Subject: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
Date:   Mon,  2 Jul 2018 14:40:11 -0700
Message-Id: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts spinlock scope to make it wrap the whole irq
handler using a single lock/unlock which covers both master and
slave handlers.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 60e4d0e939a3..9f02aa959a3e 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -234,7 +234,6 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 	bool irq_handled = true;
 	u8 value;
 
-	spin_lock(&bus->lock);
 	if (!slave) {
 		irq_handled = false;
 		goto out;
@@ -325,7 +324,6 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 	writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
 
 out:
-	spin_unlock(&bus->lock);
 	return irq_handled;
 }
 #endif /* CONFIG_I2C_SLAVE */
@@ -389,7 +387,6 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	u8 recv_byte;
 	int ret;
 
-	spin_lock(&bus->lock);
 	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	/* Ack all interrupt bits. */
 	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
@@ -547,22 +544,29 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		dev_err(bus->dev,
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_status, status_ack);
-	spin_unlock(&bus->lock);
 	return !!irq_status;
 }
 
 static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
+	bool ret;
+
+	spin_lock(&bus->lock);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	if (aspeed_i2c_slave_irq(bus)) {
 		dev_dbg(bus->dev, "irq handled by slave.\n");
-		return IRQ_HANDLED;
+		ret = true;
+		goto out;
 	}
 #endif /* CONFIG_I2C_SLAVE */
 
-	return aspeed_i2c_master_irq(bus) ? IRQ_HANDLED : IRQ_NONE;
+	ret = aspeed_i2c_master_irq(bus);
+
+out:
+	spin_unlock(&bus->lock);
+	return ret ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
-- 
2.17.1

