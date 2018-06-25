Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1597254B5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXwGcKCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1597254B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeFYGcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:32:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32798 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeFYGcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:32:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so6003603pfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HS4dglDvxaLnGKlnSpuMBlKcz+iwGT2+VjskuU83onY=;
        b=CXwGcKCDZQvmgyLyXb5QPkVlp8SQKSEmmQAnPr1c6p8DxUOGbCOdLThO6d3K5fY4Xm
         t5wcJtsRx0M0xORtV1cH52fplJT5//ifhX6m8audtKm7Mf5OcJ239L1C2RIFbeiw5+cT
         Mnyq7zCN2uoRP81jxsF0XbPZXv9LmSdTqmIww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HS4dglDvxaLnGKlnSpuMBlKcz+iwGT2+VjskuU83onY=;
        b=Al8m3M93NVxw2Z4qss0eiQ3ClPS4dEd9/1e4uG2l8wMbOsbKzHXOEUtrLR13Rb6KHL
         SfDsFdp/v4IOWYKeCYfnd8uCRhs612DCctQyqKg+4z78tcYzlc861oiXWJ4dfGp8vfVF
         dMEbwIiZQJ3RDl9/KKGtsfxWDTr4nT2Od//CqDYtircQlFEL4urVnsdZt6n/pQxB1gSS
         chx/wTPtSJnyHU7CthlwW1e8IMvyqTujVFnPjqcCCUZ/M3jxt21owElqYd97ehqa3Nx4
         87QYfIzo4FvW10/tBUz8LnfLdtS6wMkmKuOLgOqV1zIAs0lwS0NVouzL3g4vUUgYIy02
         iVaA==
X-Gm-Message-State: APt69E3u/3YLYhDAT0g9KAxPVgI7rEmJaBt+A44gIQSSDZ/e9U+NtD3m
        XHGFnDS/O5ZWJ0U908ZiY2So3A==
X-Google-Smtp-Source: ADUXVKICAHcd/SXFTdJro2HPMBqLjq9WDGNgcsf4GOUsJfSVtmDOEMSaY0rdp69MOeFfE2eQtbK09A==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr9502727pgf.319.1529908337425;
        Sun, 24 Jun 2018 23:32:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k15-v6sm20267911pfi.37.2018.06.24.23.32.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jun 2018 23:32:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     broonie@kernel.org, freeman.liu@spreadtrum.com,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nvmem: Add Spreadtrum SC27XX efuse support
Date:   Mon, 25 Jun 2018 14:31:21 +0800
Message-Id: <d49c27421b2166dc5d535fb448e6cc11475a2a79.1529908086.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
References: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
In-Reply-To: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
References: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
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
---
Changes since v1:
 - Fix one typo.
---
 drivers/nvmem/Kconfig        |   11 ++
 drivers/nvmem/Makefile       |    3 +-
 drivers/nvmem/sc27xx-efuse.c |  263 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvmem/sc27xx-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 54a3c29..0a7a470e 100644
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
index 27e96a8..4e8c616 100644
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
index 0000000..07c210c
--- /dev/null
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -0,0 +1,263 @@
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
+	ret = regmap_write(efuse->regmap, efuse->base + SC27XX_EFUSE_BLOCK_INDEX,
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
1.7.9.5

