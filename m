Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF0C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A023A20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A023A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGKB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:01:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39799 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:01:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so2585124lfh.6;
        Fri, 07 Dec 2018 02:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o8k2273110BnODQykBaLlzXPM5poh1m/c+9LrfSR9gE=;
        b=A4FIp9OEGCfNlSHCHY2IiAoEV2w5lJHW3pGsJxJmKjtZ38h9iiWXMmdQHZdU/6BWP/
         xpT5J132gqKhLwaAalykXbCV4dqI6L1W/2hTTTCNEFHMHPXaTeyR+GebjQxgq/9tzWyE
         nt7TQjE8WMAIW127SFNTBzzgsTjwbCElBlmQD1/HUxdSin11buM8w+5ijaueIOPiL+13
         1LWFyNgHtICS8gnJSF4S7h5ab6oBqXhv5xxoArZ02iNIg2wqvPLlEEq9SoKAbOkN6qM1
         jxmF7eUrfACUOUoZSaqiouy42zEkm2tppv7oUvKFq2dZ7Mk4onzP5+/G+rsqbUaI0vQ3
         5WcA==
X-Gm-Message-State: AA+aEWYVL61oWlit20Ohz+uWsdKvcvYpenj2Mvu8Y8vX+kyUdu+qPDMA
        sMfeH6rrW4WOb4bmbEciXmU=
X-Google-Smtp-Source: AFSGD/VTx01TJSSUwqGrVCigO7kAUDBjrUMEZxGq8/itfgfEJeufOKZWL+FwlNQrk98PwaxHzte2TQ==
X-Received: by 2002:a19:2755:: with SMTP id n82mr881359lfn.94.1544176913879;
        Fri, 07 Dec 2018 02:01:53 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id p10-v6sm489589ljh.59.2018.12.07.02.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 02:01:53 -0800 (PST)
Date:   Fri, 7 Dec 2018 12:01:44 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v7] clk: bd718x7: Initial support for ROHM bd71837/bd71847
 PMIC clock
Message-ID: <20181207100144.GA21411@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM bd71837 and bd71847 contain 32768Hz clock gate. Support the clock
using generic clock framework. Note, only bd71837 is tested but bd71847
should be identical what comes to clk parts.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

This is a split from series
https://lore.kernel.org/linux-clk/20181204114527.GC31204@localhost.localdomain/T/#t

Change history:

v7: (kept the series version number)
 - Patches 2, 3, 6, 7, 8 and 9 from v6 were already applied.
 - Patches 1, 4, and 5 will be provided as own series touching only clkdev
   lookups.
 - the (already obsoleted) file name was removed from clk-bd718x7 driver
 - clkdev lookup registration was removed from clk-bd718x7 driver

Changelog (for the whole series) v6
- Drop 'devm_of_clk_add_parent_hw_provider'. Change
  'devm_of_clk_add_hw_provider' to look the parent device node for
  provider information if device's own node does not contain
  #clock-cells - property.
- Add kerneldoc in own patch.
- Remove NULL checks from devres match function for clkdev releasing
- Clean styling issues from clkdev.c

Changelog (for the whole series) v5
- Split v4 patch 1. Place clkdev stuff to patch 1 and clk provider to patch 2
- Remove devm_clk_release_clkdev from devres.txt
- Added kerneldoc for managed provider registrations.
- Cleaned styling issues.

Changelog (for whole series) v4
- Add support for ROHM bd718x7 PMIC clock gate. Included in this patch
  series because it depends on managed interfaces added in patch 1.

Changelog (for whole series) v3
Address issues spotted by Krzysztof Kozlowski
- Drop patch 3 for clk-s3c2410-dclk as this device can never be removed
- Fix indentiation for clk-max77686
- Rest  of the patches are unchanged.

Changelog (for whole series) v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

 drivers/clk/Kconfig       |   7 +++
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-bd718x7.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/clk/clk-bd718x7.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 81cdb4eaca07..2dc12bf75b1b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -283,6 +283,13 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
 
+config COMMON_CLK_BD718XX
+	tristate "Clock driver for ROHM BD718x7 PMIC"
+	depends on MFD_ROHM_BD718XX
+	help
+	  This driver supports ROHM BD71837 and ROHM BD71847
+	  PMICs clock gates.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 72be7a38cff1..a47430b387db 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -21,6 +21,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
+obj-$(CONFIG_COMMON_CLK_BD718XX)	+= clk-bd718x7.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
new file mode 100644
index 000000000000..60422c72d142
--- /dev/null
+++ b/drivers/clk/clk-bd718x7.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mfd/rohm-bd718x7.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/regmap.h>
+
+struct bd718xx_clk {
+	struct clk_hw hw;
+	u8 reg;
+	u8 mask;
+	struct platform_device *pdev;
+	struct bd718xx *mfd;
+};
+
+static int bd71837_clk_set(struct clk_hw *hw, int status)
+{
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	return regmap_update_bits(c->mfd->regmap, c->reg, c->mask, status);
+}
+
+static void bd71837_clk_disable(struct clk_hw *hw)
+{
+	int rv;
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	rv = bd71837_clk_set(hw, 0);
+	if (rv)
+		dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d)\n", rv);
+}
+
+static int bd71837_clk_enable(struct clk_hw *hw)
+{
+	return bd71837_clk_set(hw, 1);
+}
+
+static int bd71837_clk_is_enabled(struct clk_hw *hw)
+{
+	int enabled;
+	int rval;
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	rval = regmap_read(c->mfd->regmap, c->reg, &enabled);
+
+	if (rval)
+		return rval;
+
+	return enabled & c->mask;
+}
+
+static const struct clk_ops bd71837_clk_ops = {
+	.prepare = &bd71837_clk_enable,
+	.unprepare = &bd71837_clk_disable,
+	.is_prepared = &bd71837_clk_is_enabled,
+};
+
+static int bd71837_clk_probe(struct platform_device *pdev)
+{
+	struct bd718xx_clk *c;
+	int rval = -ENOMEM;
+	const char *parent_clk;
+	struct device *parent = pdev->dev.parent;
+	struct bd718xx *mfd = dev_get_drvdata(parent);
+	struct clk_init_data init = {
+		.name = "bd718xx-32k-out",
+		.ops = &bd71837_clk_ops,
+	};
+
+	c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	init.num_parents = 1;
+	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
+
+	init.parent_names = &parent_clk;
+	if (!parent_clk) {
+		dev_err(&pdev->dev, "No parent clk found\n");
+		return -EINVAL;
+	}
+
+	c->reg = BD718XX_REG_OUT32K;
+	c->mask = BD718XX_OUT32K_EN;
+	c->mfd = mfd;
+	c->pdev = pdev;
+	c->hw.init = &init;
+
+	of_property_read_string_index(parent->of_node,
+				      "clock-output-names", 0, &init.name);
+
+	rval = devm_clk_hw_register(&pdev->dev, &c->hw);
+	if (rval) {
+		dev_err(&pdev->dev, "failed to register 32K clk");
+		return rval;
+	}
+	rval = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get,
+					   &c->hw);
+	if (rval)
+		dev_err(&pdev->dev, "adding clk provider failed\n");
+
+	return rval;
+}
+
+static struct platform_driver bd71837_clk = {
+	.driver = {
+		.name = "bd718xx-clk",
+	},
+	.probe = bd71837_clk_probe,
+};
+
+module_platform_driver(bd71837_clk);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
