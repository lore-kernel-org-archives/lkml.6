Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BB8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5782147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLkrznzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfA1Rgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36783 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfA1PzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so14437137wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNJ/arubp0NvuRnUSqt6ubxHY3NTyD03p3QIxO+K8Rc=;
        b=QLkrznzkM6Wn+F/suJwPVmSazcvjYunEB6SOf3rxu7iFW3rXherfp6L+TY6aPMARAK
         6jw8TsGs+NpKnpimc/Dkdru2dRUtNRsyzvVM6Nwqa0Z3BnJIGRLKUIddHOk9D1o/hxWP
         /pZFXohhOvlFrqffRy2QiPGi8RPxsEFLdt7/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNJ/arubp0NvuRnUSqt6ubxHY3NTyD03p3QIxO+K8Rc=;
        b=NjnerhiQENDmLdyEZOf+6As22UlTUS+1BVvNNINsMj/8jNK30MzqM5w6l6G3HCOq4S
         aytdyNlI0SXfX+/ezyAi2jZYYWsnw2HLSyFu6T5i2T7X2Hx10tyr8ASlEHx+t7dnIrNX
         1akIoe6/TgvwasrjM5JNOjDsyWyJ90HJHa+3NxLy1kPeUjT8mFp/GJV8sM1/WxTPZMnM
         qsGRNLq33p1gzRO/in3gfl1WAeQkNpaCK7ZzV4HtTTwRY5CnDKCZcRjV6ANn2fRPn1Hg
         ayFoej/zoGb4BzmsVODv0exP+79p8W0ZRk3ixYHL7962twhCJDUfbZuR5+x/pIak9hC4
         H+WA==
X-Gm-Message-State: AJcUukfgW0r5Pk3XqJ0kPDIe4jXMUF9QH6a0qgSHVFngmXrYAZV9XWx3
        7iDRX20SmaIG9diPaZEBhGxLMs4TqO0=
X-Google-Smtp-Source: ALg8bN4z/08KxzMpHIwUHlSlcKOCSQEOO+mN9a0ddsYW1l6qHUFM+67Y4YSauZoWVEBWkvTv1kOu2A==
X-Received: by 2002:a1c:8484:: with SMTP id g126mr18421456wmd.117.1548690910820;
        Mon, 28 Jan 2019 07:55:10 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:10 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] nvmem: bcm-ocotp: Add ACPI support to BCM OCOTP
Date:   Mon, 28 Jan 2019 15:54:55 +0000
Message-Id: <20190128155506.25566-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

Add ACPI support to bcm ocotp driver

This patch is based on Linux-4.20-rc7.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/bcm-ocotp.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 4159b3f41d79..a8097511582a 100644
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
2.20.1

