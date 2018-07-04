Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FFF20841
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhwrB8tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FFF20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbeGDLpT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934165AbeGDLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:45:16 -0400
Received: from localhost.localdomain (unknown [122.167.70.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8826A242EF;
        Wed,  4 Jul 2018 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530704715;
        bh=hbXEjmygzjPBSVObJiIro+7rf/uoG9UZvmd8cbLXrSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FhwrB8tNv985pLVaZYTQ+nDwNAuCB8qYvgRM8lwm7Xp4iamU+SsTTFYEbW6h51UTC
         LgWITRGKp3Wzxd+jECXR3E1PI1rUeGqMFPwQE2k/O81VKoRezdK2ymt61yJy1femZz
         qOG9uRrQ0F8z7ZW8/83lW423VkbmtIIn9/pR/GVo=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 3/6] crypto: Add Qcom prng driver
Date:   Wed,  4 Jul 2018 17:14:24 +0530
Message-Id: <20180704114427.29953-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180704114427.29953-1-vkoul@kernel.org>
References: <20180704114427.29953-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ports the Qcom prng from older hw_random driver.

No change of functionality and move from hw_random to crypto
APIs is done.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/crypto/Kconfig    |  11 +++
 drivers/crypto/Makefile   |   1 +
 drivers/crypto/qcom-rng.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/crypto/qcom-rng.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 43cccf6aff61..b8d9e71e550a 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -585,6 +585,17 @@ config CRYPTO_DEV_QCE
 	  hardware. To compile this driver as a module, choose M here. The
 	  module will be called qcrypto.
 
+config CRYPTO_DEV_QCOM_RNG
+	tristate "Qualcomm Randon Number Generator Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select CRYPTO_RNG
+	help
+	  This driver provides support for the Random Number
+	  Generator hardware found on Qualcomm SoCs.
+
+	  To compile this driver as a module, choose M here. the
+          module will be called qcom-rng. If unsure, say N.
+
 config CRYPTO_DEV_VMX
 	bool "Support for VMX cryptographic acceleration instructions"
 	depends on PPC64 && VSX
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 7ae87b4f6c8d..3602875c4f80 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CRYPTO_DEV_PICOXCELL) += picoxcell_crypto.o
 obj-$(CONFIG_CRYPTO_DEV_PPC4XX) += amcc/
 obj-$(CONFIG_CRYPTO_DEV_QAT) += qat/
 obj-$(CONFIG_CRYPTO_DEV_QCE) += qce/
+obj-$(CONFIG_CRYPTO_DEV_QCOM_RNG) += qcom-rng.o
 obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rockchip/
 obj-$(CONFIG_CRYPTO_DEV_S5P) += s5p-sss.o
 obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
new file mode 100644
index 000000000000..53e1d276e05e
--- /dev/null
+++ b/drivers/crypto/qcom-rng.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017-18 Linaro Limited
+//
+// Based on msm-rng.c and downstream driver
+
+#include <crypto/internal/rng.h>
+#include <linux/clk.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+/* Device specific register offsets */
+#define PRNG_DATA_OUT		0x0000
+#define PRNG_STATUS		0x0004
+#define PRNG_LFSR_CFG		0x0100
+#define PRNG_CONFIG		0x0104
+
+/* Device specific register masks and config values */
+#define PRNG_LFSR_CFG_MASK	0x0000ffff
+#define PRNG_LFSR_CFG_CLOCKS	0x0000dddd
+#define PRNG_CONFIG_HW_ENABLE	BIT(1)
+#define PRNG_STATUS_DATA_AVAIL	BIT(0)
+
+#define WORD_SZ			4
+
+struct qcom_rng {
+	struct mutex lock;
+	void __iomem *base;
+	struct clk *clk;
+};
+
+struct qcom_rng_ctx {
+	struct qcom_rng *rng;
+};
+
+static struct qcom_rng *qcom_rng_dev;
+
+static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
+{
+	unsigned int currsize = 0;
+	u32 val;
+
+	/* read random data from hardware */
+	do {
+		val = readl_relaxed(rng->base + PRNG_STATUS);
+		if (!(val & PRNG_STATUS_DATA_AVAIL))
+			break;
+
+		val = readl_relaxed(rng->base + PRNG_DATA_OUT);
+		if (!val)
+			break;
+
+		if ((max - currsize) >= WORD_SZ) {
+			memcpy(data, &val, WORD_SZ);
+			data += WORD_SZ;
+			currsize += WORD_SZ;
+		} else {
+			/* copy only remaining bytes */
+			memcpy(data, &val, max - currsize);
+			break;
+		}
+	} while (currsize < max);
+
+	return currsize;
+}
+
+static int qcom_rng_generate(struct crypto_rng *tfm,
+			     const u8 *src, unsigned int slen,
+			     u8 *dstn, unsigned int dlen)
+{
+	struct qcom_rng_ctx *ctx = crypto_rng_ctx(tfm);
+	struct qcom_rng *rng = ctx->rng;
+	int ret;
+
+	ret = clk_prepare_enable(rng->clk);
+	if (ret)
+		return ret;
+
+	mutex_lock(&rng->lock);
+
+	ret = qcom_rng_read(rng, dstn, dlen);
+
+	mutex_unlock(&rng->lock);
+	clk_disable_unprepare(rng->clk);
+
+	return 0;
+}
+
+static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
+			 unsigned int slen)
+{
+	return 0;
+}
+
+static int qcom_rng_enable(struct qcom_rng *rng)
+{
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(rng->clk);
+	if (ret)
+		return ret;
+
+	/* Enable PRNG only if it is not already enabled */
+	val = readl_relaxed(rng->base + PRNG_CONFIG);
+	if (val & PRNG_CONFIG_HW_ENABLE)
+		goto already_enabled;
+
+	val = readl_relaxed(rng->base + PRNG_LFSR_CFG);
+	val &= ~PRNG_LFSR_CFG_MASK;
+	val |= PRNG_LFSR_CFG_CLOCKS;
+	writel(val, rng->base + PRNG_LFSR_CFG);
+
+	val = readl_relaxed(rng->base + PRNG_CONFIG);
+	val |= PRNG_CONFIG_HW_ENABLE;
+	writel(val, rng->base + PRNG_CONFIG);
+
+already_enabled:
+	clk_disable_unprepare(rng->clk);
+
+	return 0;
+}
+
+static int qcom_rng_init(struct crypto_tfm *tfm)
+{
+	struct qcom_rng_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	ctx->rng = qcom_rng_dev;
+
+	return qcom_rng_enable(ctx->rng);
+}
+
+static struct rng_alg qcom_rng_alg = {
+	.generate	= qcom_rng_generate,
+	.seed		= qcom_rng_seed,
+	.seedsize	= 0,
+	.base		= {
+		.cra_name		= "stdrng",
+		.cra_driver_name	= "qcom-rng",
+		.cra_flags		= CRYPTO_ALG_TYPE_RNG,
+		.cra_priority		= 300,
+		.cra_ctxsize		= sizeof(struct qcom_rng_ctx),
+		.cra_module		= THIS_MODULE,
+		.cra_init		= qcom_rng_init,
+	}
+};
+
+static int qcom_rng_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct qcom_rng *rng;
+	int ret;
+
+	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rng);
+	mutex_init(&rng->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rng->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rng->base))
+		return PTR_ERR(rng->base);
+
+	rng->clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(rng->clk))
+		return PTR_ERR(rng->clk);
+
+	qcom_rng_dev = rng;
+	ret = crypto_register_rng(&qcom_rng_alg);
+	if (ret) {
+		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
+		qcom_rng_dev = NULL;
+	}
+
+	return ret;
+}
+
+static int qcom_rng_remove(struct platform_device *pdev)
+{
+	crypto_unregister_rng(&qcom_rng_alg);
+
+	qcom_rng_dev = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_rng_of_match[] = {
+	{ .compatible = "qcom,prng" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
+
+static struct platform_driver qcom_rng_driver = {
+	.probe = qcom_rng_probe,
+	.remove =  qcom_rng_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(qcom_rng_of_match),
+	}
+};
+module_platform_driver(qcom_rng_driver);
+
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_DESCRIPTION("Qualcomm random number generator driver");
+MODULE_LICENSE("GPL v2");
-- 
2.14.4

