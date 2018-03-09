Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607052; cv=none;
        d=google.com; s=arc-20160816;
        b=Zv63wtg2pXV3Q1FZadhnbkLqayPxL2yv9Aob6Vg2iXbAyo7KUBw9A7nWSMsK1+GU8s
         ChdWrqrwPKXyUqFGAIihrgXY/beGBGulMM1ThdJu0D0dDO2s5sbO8CKNNGlOz5JeMs8t
         kTl+FPjcJ2k5eCxS2CZFVG9Van2eHAvOF0AeAQ7mmbPJyYAVdtGDQZzARJPQSnlxa+iz
         GuSxAyKVSgwbmKfwRk4o5xeiYmhPNgGtOeaqZGPBU1Oja8Pim/CO0Zd0knFyTUIpDogT
         m1JfsWUsn6wM9FAM01/BtMuoDuD8u077v8n4GaQmlZHf8bZHTiCULateVge9FN4VmbHx
         4ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=lpctMtysOcxf6hdrVzb3i/6ck+RlkwUyeipEi1tXQa4=;
        b=VOsk0P7ca8ooaG0rQgw2ZjqML2dSvUYsRO8PcpIrA3cQvKf38i63y7rGcFt64Fi+Vq
         DH1Tj6mcwIWepOax6curdToht0UWYnPXPTSSXFfTQ48gQwhj5YDJL98LqU/TBaniqETf
         DL8PAI/8lYF57AdVpz+bKuYaWL37XAYTCq95YA4r4jJKnpf1ckylFmBPTXLn8G5UBcOK
         F9b2/Rg2EHTHE8Qy5KLe5EqWCShzbe70K6F4WXSFiNGLQCWLu//D8seCnQoJ2W55WP9q
         GSYselrOGLPDwfBL31qZlaAZnV/vld/8+grii/vLZ3iwxSdGFMmrt146ztPPH3Du6as5
         ZRNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f9dlyP/U;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f9dlyP/U;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtE2Tyg7hTqdQlsUGw2jN1qcqBE9BxgvfE/7eTf/Q2/25aHWx8rd9g1tvFZrKRVYsy7QxKDPQ==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Andrey Yurovsky <yurovsky@gmail.com>
Subject: [PATCH 22/25] nvmem: add i.MX7 support to snvs-lpgpr
Date: Fri,  9 Mar 2018 14:47:16 +0000
Message-Id: <20180309144719.29904-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472060850243084?=
X-GMAIL-MSGID: =?utf-8?q?1594472060850243084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Yurovsky <yurovsky@gmail.com>

The i.MX7 family has similar SNVS hardware so make the snvs-lpgpr
support it along with the i.MX6 family. The register interface is the
same except for the number and offset of the general purpose registers.

Signed-off-by: Andrey Yurovsky <yurovsky@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/snvs-lpgpr.txt       |  3 ++-
 drivers/nvmem/Kconfig                              |  4 ++--
 drivers/nvmem/snvs_lpgpr.c                         | 27 +++++++++++++++++-----
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
index 20bc49b49799..3cb170896658 100644
--- a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
+++ b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
@@ -1,5 +1,5 @@
 Device tree bindings for Low Power General Purpose Register found in i.MX6Q/D
-Secure Non-Volatile Storage.
+and i.MX7 Secure Non-Volatile Storage.
 
 This DT node should be represented as a sub-node of a "syscon",
 "simple-mfd" node.
@@ -8,6 +8,7 @@ Required properties:
 - compatible: should be one of the fallowing variants:
 	"fsl,imx6q-snvs-lpgpr" for Freescale i.MX6Q/D/DL/S
 	"fsl,imx6ul-snvs-lpgpr" for Freescale i.MX6UL
+	"fsl,imx7d-snvs-lpgpr" for Freescale i.MX7D/S
 
 Example:
 snvs: snvs@020cc000 {
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ff505af064ba..5f9bc787d634 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -167,10 +167,10 @@ config MESON_MX_EFUSE
 
 config NVMEM_SNVS_LPGPR
 	tristate "Support for Low Power General Purpose Register"
-	depends on SOC_IMX6 || COMPILE_TEST
+	depends on SOC_IMX6 || SOC_IMX7D || COMPILE_TEST
 	help
 	  This is a driver for Low Power General Purpose Register (LPGPR) available on
-	  i.MX6 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
+	  i.MX6 and i.MX7 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-snvs-lpgpr.
diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 92e1e41d128e..c050a23a9f2b 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -14,15 +14,21 @@
 #include <linux/regmap.h>
 
 #define IMX6Q_SNVS_HPLR		0x00
-#define IMX6Q_GPR_SL		BIT(5)
 #define IMX6Q_SNVS_LPLR		0x34
-#define IMX6Q_GPR_HL		BIT(5)
 #define IMX6Q_SNVS_LPGPR	0x68
 
+#define IMX7D_SNVS_HPLR		0x00
+#define IMX7D_SNVS_LPLR		0x34
+#define IMX7D_SNVS_LPGPR	0x90
+
+#define IMX_GPR_SL		BIT(5)
+#define IMX_GPR_HL		BIT(5)
+
 struct snvs_lpgpr_cfg {
 	int offset;
 	int offset_hplr;
 	int offset_lplr;
+	int size;
 };
 
 struct snvs_lpgpr_priv {
@@ -36,6 +42,14 @@ static const struct snvs_lpgpr_cfg snvs_lpgpr_cfg_imx6q = {
 	.offset		= IMX6Q_SNVS_LPGPR,
 	.offset_hplr	= IMX6Q_SNVS_HPLR,
 	.offset_lplr	= IMX6Q_SNVS_LPLR,
+	.size		= 4,
+};
+
+static const struct snvs_lpgpr_cfg snvs_lpgpr_cfg_imx7d = {
+	.offset		= IMX7D_SNVS_LPGPR,
+	.offset_hplr	= IMX7D_SNVS_HPLR,
+	.offset_lplr	= IMX7D_SNVS_LPLR,
+	.size		= 16,
 };
 
 static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
@@ -50,14 +64,14 @@ static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
 	if (ret < 0)
 		return ret;
 
-	if (lock_reg & IMX6Q_GPR_SL)
+	if (lock_reg & IMX_GPR_SL)
 		return -EPERM;
 
 	ret = regmap_read(priv->regmap, dcfg->offset_lplr, &lock_reg);
 	if (ret < 0)
 		return ret;
 
-	if (lock_reg & IMX6Q_GPR_HL)
+	if (lock_reg & IMX_GPR_HL)
 		return -EPERM;
 
 	return regmap_bulk_write(priv->regmap, dcfg->offset + offset, val,
@@ -112,7 +126,7 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->dev = dev;
 	cfg->stride = 4;
 	cfg->word_size = 4;
-	cfg->size = 4;
+	cfg->size = dcfg->size,
 	cfg->owner = THIS_MODULE;
 	cfg->reg_read  = snvs_lpgpr_read;
 	cfg->reg_write = snvs_lpgpr_write;
@@ -126,6 +140,7 @@ static const struct of_device_id snvs_lpgpr_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-snvs-lpgpr", .data = &snvs_lpgpr_cfg_imx6q },
 	{ .compatible = "fsl,imx6ul-snvs-lpgpr",
 	  .data = &snvs_lpgpr_cfg_imx6q },
+	{ .compatible = "fsl,imx7d-snvs-lpgpr",	.data = &snvs_lpgpr_cfg_imx7d },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, snvs_lpgpr_dt_ids);
@@ -140,5 +155,5 @@ static struct platform_driver snvs_lpgpr_driver = {
 module_platform_driver(snvs_lpgpr_driver);
 
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
-MODULE_DESCRIPTION("Low Power General Purpose Register in i.MX6 Secure Non-Volatile Storage");
+MODULE_DESCRIPTION("Low Power General Purpose Register in i.MX6 and i.MX7 Secure Non-Volatile Storage");
 MODULE_LICENSE("GPL v2");
-- 
2.15.1
