Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3583C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDB521741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GVgwB5lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeL0DjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:39:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43060 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbeL0DjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:39:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so14317921eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=77YznGe383TM+MRliV0NB4cvegi1Y8F54mehtyPrTxc=;
        b=GVgwB5lg1HHJILFFv7OKfkJB+9+IZlYfiQ4Y9F+HKo0WNOyeOCSLOLmX6RSnzEK/oz
         d+0G3pVOlLJ/VlOIVTwpbm1ejQ4PTF9RQW/kRDI1aSNJn/6ouR33UqeUz54g0KmiNvHd
         bsRLDiHvamX5mHZOk8jmpKCo1XKafxRn1AH+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=77YznGe383TM+MRliV0NB4cvegi1Y8F54mehtyPrTxc=;
        b=qEVrBcuKGcIBU/rrDxf5enDOOKyx8gFIYoJpfpxWsMoC0Ndq/ACIafTxse7MTEXFe8
         HqUpskjownIERirXoUfY3TaVOL0l9nJFMwrxECHaqHa7tWC3FZzYSpx9ZF6DF3hOHeIS
         +YnNBcPu4UqjRh0aNlgNoovZdurBueRfTJago4AoUU8CueUkYq6swgThJ4UY8gR5+4l+
         02KLfClW1KVkUXYDboaahl8POKOFZ0l109rFI4ZbXy90PQmwBudrEmQZhVPIn2lKysMM
         o0q83kLU0yci2UHioSp4DcfmmSFNwQLCa5+SGO5MLnJBX0kqq+IzBTPpOl5leFup/HWA
         9xMQ==
X-Gm-Message-State: AA+aEWZJJZzEAQV1A76uBPeZxj65+EVmNqNH4LRtvOJT95Rtt3XLLTWD
        btP1C8pCEgc30t6Nb1xJzmNpIQ==
X-Google-Smtp-Source: AFSGD/XyCrjij50Yu0fIiQ4TPTXXqS9QmavYjiGBmv9bkmYHvsVNXmP5R6YzmO8yk54yGUuUazz0zg==
X-Received: by 2002:a17:906:8301:: with SMTP id j1-v6mr14497478ejx.60.1545881960080;
        Wed, 26 Dec 2018 19:39:20 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id o6-v6sm4351664ejs.32.2018.12.26.19.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 19:39:19 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] nvmem: bcm-ocotp: Add ACPI support to BCM OCOTP
Date:   Thu, 27 Dec 2018 09:09:01 +0530
Message-Id: <1545881941-19986-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support to bcm ocotp driver

This patch is based on Linux-4.20-rc7.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/nvmem/bcm-ocotp.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 4159b3f..a809751 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -11,13 +11,14 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 /*
@@ -78,9 +79,9 @@ static struct otpc_map otp_map_v2 = {
 };
 
 struct otpc_priv {
-	struct device       *dev;
-	void __iomem        *base;
-	struct otpc_map     *map;
+	struct device *dev;
+	void __iomem *base;
+	const struct otpc_map *map;
 	struct nvmem_config *config;
 };
 
@@ -237,16 +238,22 @@ static struct nvmem_config bcm_otpc_nvmem_config = {
 };
 
 static const struct of_device_id bcm_otpc_dt_ids[] = {
-	{ .compatible = "brcm,ocotp" },
-	{ .compatible = "brcm,ocotp-v2" },
+	{ .compatible = "brcm,ocotp", .data = &otp_map },
+	{ .compatible = "brcm,ocotp-v2", .data = &otp_map_v2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
 
+static const struct acpi_device_id bcm_otpc_acpi_ids[] = {
+	{ .id = "BRCM0700", .driver_data = (kernel_ulong_t)&otp_map },
+	{ .id = "BRCM0701", .driver_data = (kernel_ulong_t)&otp_map_v2 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, bcm_otpc_acpi_ids);
+
 static int bcm_otpc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *dn = dev->of_node;
 	struct resource *res;
 	struct otpc_priv *priv;
 	struct nvmem_device *nvmem;
@@ -257,14 +264,9 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	if (of_device_is_compatible(dev->of_node, "brcm,ocotp"))
-		priv->map = &otp_map;
-	else if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2"))
-		priv->map = &otp_map_v2;
-	else {
-		dev_err(dev, "%s otpc config map not defined\n", __func__);
-		return -EINVAL;
-	}
+	priv->map = device_get_match_data(dev);
+	if (!priv->map)
+		return -ENODEV;
 
 	/* Get OTP base address register. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -281,7 +283,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 	reset_start_bit(priv->base);
 
 	/* Read size of memory in words. */
-	err = of_property_read_u32(dn, "brcm,ocotp-size", &num_words);
+	err = device_property_read_u32(dev, "brcm,ocotp-size", &num_words);
 	if (err) {
 		dev_err(dev, "size parameter not specified\n");
 		return -EINVAL;
@@ -294,7 +296,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 	bcm_otpc_nvmem_config.dev = dev;
 	bcm_otpc_nvmem_config.priv = priv;
 
-	if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2")) {
+	if (priv->map == &otp_map_v2) {
 		bcm_otpc_nvmem_config.word_size = 8;
 		bcm_otpc_nvmem_config.stride = 8;
 	}
@@ -315,6 +317,7 @@ static struct platform_driver bcm_otpc_driver = {
 	.driver = {
 		.name	= "brcm-otpc",
 		.of_match_table = bcm_otpc_dt_ids,
+		.acpi_match_table = ACPI_PTR(bcm_otpc_acpi_ids),
 	},
 };
 module_platform_driver(bcm_otpc_driver);
-- 
2.7.4

