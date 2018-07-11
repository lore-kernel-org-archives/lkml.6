Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB208C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7013020B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrC6Zypm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7013020B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeGKK0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:26:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39756 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeGKK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:26:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so1947681wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aG25gl6pS+AkVbFHrZrZY2QVtM3wSzXCwwNR2jZQ6bU=;
        b=BrC6Zypmxc8u15PcWR5hqKvdCGn5aihOxfOxFoMqj3cz8pYWD66mYurtln4TnG3Z9N
         sng47CiO9ycT0Syq3FY9wgaTDnaV3ohsprP8h5bqyE9bOc6lO4oVwYpjDEdV0X9FRkLe
         5m6u68NNjvhoO05MiFgH8FYRdCmkS+PcJ/R6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aG25gl6pS+AkVbFHrZrZY2QVtM3wSzXCwwNR2jZQ6bU=;
        b=ay0G9+XQ5jCnCWTBWqQcveF8SnnffkFPGozdjq1PGquxEiV7h8dFsonpw5MYqu1PJ1
         eBF8jyINesLO08pgLFryn4Q2qPYNOcN/cx/GD60+OOEacKuxnR4Plxoe7C2gJkz2GbJT
         7V6z1+hYq6MAht/CO050StDYm0dv5Bl6hPebFM5FXX0ffn0PKKqKzGogRt8TJdyBh5KA
         Ej0lV9IjJGUOSzUxt+IZXq6qomKJBGLvtjVVHAoNg+iSMqRVt1fgOV56mZB4ap+wJNCc
         xp5hvY4KzsP+Kf0/3sorBjVbFpXEThsZleVvmLl23gG2r3uclvJBC0pmunyKDc3K7bPM
         N+Xw==
X-Gm-Message-State: APt69E1P2Rg5shhIVVu877dGK6Zk+KiW+PeaFTbcNkBVgNCsXDvwoG4C
        J1KZ2Fm3n1hDEp/aAPN/vcqgGw==
X-Google-Smtp-Source: AAOMgpdSK6Ljh5aXgGlgmhf8eW0C1ToFzcs1EQIb9/Y7mN4cB3wiTsmHHgSXvB272xu2GmTJ6ZSbuA==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr2088985wme.109.1531304574395;
        Wed, 11 Jul 2018 03:22:54 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2462032wmu.37.2018.07.11.03.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 03:22:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        Freeman Liu <freeman.liu@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/4] nvmem: Add Spreadtrum SC27XX efuse support
Date:   Wed, 11 Jul 2018 11:20:41 +0100
Message-Id: <20180711102043.24079-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
References: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@spreadtrum.com>

This patch add the efuse driver which is embeded in Spreadtrum SC27XX
series PMICs. The sc27xx efuse contains 32 blocks and each block's
data width is 16 bits.

Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig        |  11 ++
 drivers/nvmem/Makefile       |   3 +-
 drivers/nvmem/sc27xx-efuse.c | 264 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvmem/sc27xx-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 54a3c298247b..0a7a470ee859 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -181,4 +181,15 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
+config SC27XX_EFUSE
+	tristate "Spreadtrum SC27XX eFuse Support"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple driver to dump specified values of Spreadtrum
+	  SC27XX PMICs from eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-sc27xx-efuse.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 27e96a8efd1c..4e8c61628f1a 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -39,4 +39,5 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
 obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
-
+obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
+nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
new file mode 100644
index 000000000000..33185d8d82cf
--- /dev/null
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Spreadtrum Communications Inc.
+
+#include <linux/hwspinlock.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/nvmem-provider.h>
+
+/* PMIC global registers definition */
+#define SC27XX_MODULE_EN		0xc08
+#define SC27XX_EFUSE_EN			BIT(6)
+
+/* Efuse controller registers definition */
+#define SC27XX_EFUSE_GLB_CTRL		0x0
+#define SC27XX_EFUSE_DATA_RD		0x4
+#define SC27XX_EFUSE_DATA_WR		0x8
+#define SC27XX_EFUSE_BLOCK_INDEX	0xc
+#define SC27XX_EFUSE_MODE_CTRL		0x10
+#define SC27XX_EFUSE_STATUS		0x14
+#define SC27XX_EFUSE_WR_TIMING_CTRL	0x20
+#define SC27XX_EFUSE_RD_TIMING_CTRL	0x24
+#define SC27XX_EFUSE_EFUSE_DEB_CTRL	0x28
+
+/* Mask definition for SC27XX_EFUSE_BLOCK_INDEX register */
+#define SC27XX_EFUSE_BLOCK_MASK		GENMASK(4, 0)
+
+/* Bits definitions for SC27XX_EFUSE_MODE_CTRL register */
+#define SC27XX_EFUSE_PG_START		BIT(0)
+#define SC27XX_EFUSE_RD_START		BIT(1)
+#define SC27XX_EFUSE_CLR_RDDONE		BIT(2)
+
+/* Bits definitions for SC27XX_EFUSE_STATUS register */
+#define SC27XX_EFUSE_PGM_BUSY		BIT(0)
+#define SC27XX_EFUSE_READ_BUSY		BIT(1)
+#define SC27XX_EFUSE_STANDBY		BIT(2)
+#define SC27XX_EFUSE_GLOBAL_PROT	BIT(3)
+#define SC27XX_EFUSE_RD_DONE		BIT(4)
+
+/* Block number and block width (bytes) definitions */
+#define SC27XX_EFUSE_BLOCK_MAX		32
+#define SC27XX_EFUSE_BLOCK_WIDTH	2
+
+/* Timeout (ms) for the trylock of hardware spinlocks */
+#define SC27XX_EFUSE_HWLOCK_TIMEOUT	5000
+
+/* Timeout (us) of polling the status */
+#define SC27XX_EFUSE_POLL_TIMEOUT	3000000
+#define SC27XX_EFUSE_POLL_DELAY_US	10000
+
+struct sc27xx_efuse {
+	struct device *dev;
+	struct regmap *regmap;
+	struct hwspinlock *hwlock;
+	struct mutex mutex;
+	u32 base;
+};
+
+/*
+ * On Spreadtrum platform, we have multi-subsystems will access the unique
+ * efuse controller, so we need one hardware spinlock to synchronize between
+ * the multiple subsystems.
+ */
+static int sc27xx_efuse_lock(struct sc27xx_efuse *efuse)
+{
+	int ret;
+
+	mutex_lock(&efuse->mutex);
+
+	ret = hwspin_lock_timeout_raw(efuse->hwlock,
+				      SC27XX_EFUSE_HWLOCK_TIMEOUT);
+	if (ret) {
+		dev_err(efuse->dev, "timeout to get the hwspinlock\n");
+		mutex_unlock(&efuse->mutex);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sc27xx_efuse_unlock(struct sc27xx_efuse *efuse)
+{
+	hwspin_unlock_raw(efuse->hwlock);
+	mutex_unlock(&efuse->mutex);
+}
+
+static int sc27xx_efuse_poll_status(struct sc27xx_efuse *efuse, u32 bits)
+{
+	int ret;
+	u32 val;
+
+	ret = regmap_read_poll_timeout(efuse->regmap,
+				       efuse->base + SC27XX_EFUSE_STATUS,
+				       val, (val & bits),
+				       SC27XX_EFUSE_POLL_DELAY_US,
+				       SC27XX_EFUSE_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(efuse->dev, "timeout to update the efuse status\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
+{
+	struct sc27xx_efuse *efuse = context;
+	u32 buf;
+	int ret;
+
+	if (offset > SC27XX_EFUSE_BLOCK_MAX || bytes > SC27XX_EFUSE_BLOCK_WIDTH)
+		return -EINVAL;
+
+	ret = sc27xx_efuse_lock(efuse);
+	if (ret)
+		return ret;
+
+	/* Enable the efuse controller. */
+	ret = regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN,
+				 SC27XX_EFUSE_EN, SC27XX_EFUSE_EN);
+	if (ret)
+		goto unlock_efuse;
+
+	/*
+	 * Before reading, we should ensure the efuse controller is in
+	 * standby state.
+	 */
+	ret = sc27xx_efuse_poll_status(efuse, SC27XX_EFUSE_STANDBY);
+	if (ret)
+		goto disable_efuse;
+
+	/* Set the block address to be read. */
+	ret = regmap_write(efuse->regmap,
+			   efuse->base + SC27XX_EFUSE_BLOCK_INDEX,
+			   offset & SC27XX_EFUSE_BLOCK_MASK);
+	if (ret)
+		goto disable_efuse;
+
+	/* Start reading process from efuse memory. */
+	ret = regmap_update_bits(efuse->regmap,
+				 efuse->base + SC27XX_EFUSE_MODE_CTRL,
+				 SC27XX_EFUSE_RD_START,
+				 SC27XX_EFUSE_RD_START);
+	if (ret)
+		goto disable_efuse;
+
+	/*
+	 * Polling the read done status to make sure the reading process
+	 * is completed, that means the data can be read out now.
+	 */
+	ret = sc27xx_efuse_poll_status(efuse, SC27XX_EFUSE_RD_DONE);
+	if (ret)
+		goto disable_efuse;
+
+	/* Read data from efuse memory. */
+	ret = regmap_read(efuse->regmap, efuse->base + SC27XX_EFUSE_DATA_RD,
+			  &buf);
+	if (ret)
+		goto disable_efuse;
+
+	/* Clear the read done flag. */
+	ret = regmap_update_bits(efuse->regmap,
+				 efuse->base + SC27XX_EFUSE_MODE_CTRL,
+				 SC27XX_EFUSE_CLR_RDDONE,
+				 SC27XX_EFUSE_CLR_RDDONE);
+
+disable_efuse:
+	/* Disable the efuse controller after reading. */
+	regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN, SC27XX_EFUSE_EN, 0);
+unlock_efuse:
+	sc27xx_efuse_unlock(efuse);
+
+	if (!ret)
+		memcpy(val, &buf, bytes);
+
+	return ret;
+}
+
+static int sc27xx_efuse_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct nvmem_config econfig = { };
+	struct nvmem_device *nvmem;
+	struct sc27xx_efuse *efuse;
+	int ret;
+
+	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	efuse->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!efuse->regmap) {
+		dev_err(&pdev->dev, "failed to get efuse regmap\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(np, "reg", &efuse->base);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get efuse base address\n");
+		return ret;
+	}
+
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get hwspinlock id\n");
+		return ret;
+	}
+
+	efuse->hwlock = hwspin_lock_request_specific(ret);
+	if (!efuse->hwlock) {
+		dev_err(&pdev->dev, "failed to request hwspinlock\n");
+		return -ENXIO;
+	}
+
+	mutex_init(&efuse->mutex);
+	efuse->dev = &pdev->dev;
+	platform_set_drvdata(pdev, efuse);
+
+	econfig.stride = 1;
+	econfig.word_size = 1;
+	econfig.read_only = true;
+	econfig.name = "sc27xx-efuse";
+	econfig.size = SC27XX_EFUSE_BLOCK_MAX * SC27XX_EFUSE_BLOCK_WIDTH;
+	econfig.reg_read = sc27xx_efuse_read;
+	econfig.priv = efuse;
+	econfig.dev = &pdev->dev;
+	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
+	if (IS_ERR(nvmem)) {
+		dev_err(&pdev->dev, "failed to register nvmem config\n");
+		hwspin_lock_free(efuse->hwlock);
+		return PTR_ERR(nvmem);
+	}
+
+	return 0;
+}
+
+static int sc27xx_efuse_remove(struct platform_device *pdev)
+{
+	struct sc27xx_efuse *efuse = platform_get_drvdata(pdev);
+
+	hwspin_lock_free(efuse->hwlock);
+	return 0;
+}
+
+static const struct of_device_id sc27xx_efuse_of_match[] = {
+	{ .compatible = "sprd,sc2731-efuse" },
+	{ }
+};
+
+static struct platform_driver sc27xx_efuse_driver = {
+	.probe = sc27xx_efuse_probe,
+	.remove = sc27xx_efuse_remove,
+	.driver = {
+		.name = "sc27xx-efuse",
+		.of_match_table = sc27xx_efuse_of_match,
+	},
+};
+
+module_platform_driver(sc27xx_efuse_driver);
+
+MODULE_AUTHOR("Freeman Liu <freeman.liu@spreadtrum.com>");
+MODULE_DESCRIPTION("Spreadtrum SC27xx efuse driver");
+MODULE_LICENSE("GPL v2");
-- 
2.16.2

