Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C18C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A40621A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A40621A29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbeHFVEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:04:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37148 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732714AbeHFVEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:04:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 42C32207E8; Mon,  6 Aug 2018 20:54:16 +0200 (CEST)
Received: from localhost (LPuteaux-656-1-243-71.w82-127.abo.wanadoo.fr [82.127.120.71])
        by mail.bootlin.com (Postfix) with ESMTPSA id E9BD72072D;
        Mon,  6 Aug 2018 20:54:15 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 4/6] i2c: designware: add MSCC Ocelot support
Date:   Mon,  6 Aug 2018 20:54:10 +0200
Message-Id: <20180806185412.7210-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsemi Ocelot I2C controller is a designware IP. It also has a
second set of registers to allow tweaking SDA hold time and spike
filtering.

Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../bindings/i2c/i2c-designware.txt           |  9 ++++-
 drivers/i2c/busses/i2c-designware-core.h      |  3 ++
 drivers/i2c/busses/i2c-designware-platdrv.c   | 40 +++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fbb0a6d8b964..7886f2dc6675 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -2,7 +2,8 @@
 
 Required properties :
 
- - compatible : should be "snps,designware-i2c"
+ - compatible : should be "snps,designware-i2c" or "mscc,ocelot-i2c" followed by
+   "snps,designware-i2c" for fallback
  - reg : Offset and length of the register set for the device
  - interrupts : <IRQ> where IRQ is the interrupt number.
 
@@ -11,8 +12,12 @@ Recommended properties :
  - clock-frequency : desired I2C bus clock frequency in Hz.
 
 Optional properties :
+ - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
+   time, named ICPU_CFG:TWI_DELAY in the datasheet.
+
  - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
-   This option is only supported in hardware blocks version 1.11a or newer.
+   This option is only supported in hardware blocks version 1.11a or newer and
+   on Microsemi SoCs ("mscc,ocelot-i2c" compatible).
 
  - i2c-scl-falling-time-ns : should contain the SCL falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tLOW period.
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 870444bbbcc4..5e240ce9968e 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -225,6 +225,7 @@
 struct dw_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
+	void __iomem		*ext;
 	struct completion	cmd_complete;
 	struct clk		*clk;
 	struct reset_control	*rst;
@@ -279,6 +280,8 @@ struct dw_i2c_dev {
 #define ACCESS_INTR_MASK	0x00000004
 
 #define MODEL_CHERRYTRAIL	0x00000100
+#define MODEL_MSCC_OCELOT	0x00000200
+#define MODEL_MASK		0x00000f00
 
 u32 dw_readl(struct dw_i2c_dev *dev, int offset);
 void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 1bcaab777a2e..39aab03cb416 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -157,11 +157,48 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 #endif
 
 #ifdef CONFIG_OF
+#define MSCC_ICPU_CFG_TWI_DELAY		0x0
+#define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
+#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
+
+static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
+{
+	writel((dev->sda_hold_time << 1) | MSCC_ICPU_CFG_TWI_DELAY_ENABLE,
+	       dev->ext + MSCC_ICPU_CFG_TWI_DELAY);
+
+	return 0;
+}
+
+int dw_i2c_of_configure(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	struct resource *mem;
+
+	switch (dev->flags & MODEL_MASK) {
+	case MODEL_MSCC_OCELOT:
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		dev->ext = devm_ioremap_resource(&pdev->dev, mem);
+		if (!IS_ERR(dev->ext))
+			dev->set_sda_hold_time = mscc_twi_set_sda_hold_time;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "snps,designware-i2c", },
+	{ .compatible = "mscc,ocelot-i2c", .data = (void *)MODEL_MSCC_OCELOT },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
+#else
+static inline int dw_i2c_of_configure(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
 #endif
 
 static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
@@ -296,6 +333,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 	dev->flags |= (uintptr_t)device_get_match_data(&pdev->dev);
 
+	if (pdev->dev.of_node)
+		dw_i2c_of_configure(pdev);
+
 	if (has_acpi_companion(&pdev->dev))
 		dw_i2c_acpi_configure(pdev);
 
-- 
2.18.0

