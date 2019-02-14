Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE88321928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GZL7bMWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437940AbfBNR6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:58:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40430 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437829AbfBNR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:58:06 -0500
Received: by mail-it1-f193.google.com with SMTP id i2so16463270ite.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fF0LtqiU+ezqKDEGBPuxdJhivCCihna6QbzlCwznwyo=;
        b=GZL7bMWsuhT/yxy1rHdCzEmJxBLDze3KipqjsMO9AXNUmndIK/l3k0kAWpt/whJBt9
         9fHjkTAAbCBKGNdGJbpPGGpTT6Bc/+4M8mQ7NCRNgL8bcPE+xk6WHXsTpKU++DxO4/YU
         +0igyBni8rrMxWl00/XM07aa3JleVBnu28Da4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fF0LtqiU+ezqKDEGBPuxdJhivCCihna6QbzlCwznwyo=;
        b=BavNcfawD3gcMBEzfAmIZMriC6R3lDJVNhqoWbDkW4nr1tGYy4NjdsDpIfavmIVVhm
         G24YBpMGTbieUp8KMCM4r29vBG9nAUV8cV1zDf8vQG5g4FplwxQz8rZbQVSnkPEjVZVE
         Q2wAhcU0WKwR5Pi5zFz2/YIAGuWOx6z3fUcZ+oJmNkBXBFoB11fqAdUj9ZpE8hGC26ur
         d3Mc78I/bhJOmrIXYgka3+PBOQDSPpzjn9330lnryJxhZtcFDhfuO0/2u0ZAeMpc4yp9
         W41cS+qAkpU2SjpcgnBKNf8+3OpKFmxz/W0xn8zIppxry20mpEYezI8JM0LS+/y/b17w
         vHVQ==
X-Gm-Message-State: AHQUAubByZ7uR/OV/UWaBaQzRItr1AGnsg8aE0DAjrrh8m6iBHZeSw3l
        vCz/uCMIeYSmi6Ke8KiifCiJ/g==
X-Google-Smtp-Source: AHgI3IY5j6xsuyyk1XVs+BpvsO4vD5bIoDMrBNL02aS+ROITaVKAg9qVntm6joUMi1D2DR5QQ70b7w==
X-Received: by 2002:a24:bdcc:: with SMTP id x195mr1541749ite.149.1550167085551;
        Thu, 14 Feb 2019 09:58:05 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:58:04 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
Date:   Thu, 14 Feb 2019 09:57:24 -0800
Message-Id: <20190214175725.60462-8-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC I2C support to the iProc I2C driver. Access to the NIC I2C base
registers requires going through the IDM wrapper to map into the NIC's
address space

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 79 ++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 5b9cbd7a3776..9598e1d0048e 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -17,9 +17,11 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define IDM_CTRL_DIRECT_OFFSET       0x00
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
@@ -174,11 +176,26 @@ enum bus_speed_index {
 	I2C_SPD_400K,
 };
 
+enum bcm_iproc_i2c_type {
+	IPROC_I2C,
+	IPROC_I2C_NIC
+};
+
 struct bcm_iproc_i2c_dev {
 	struct device *device;
+	enum bcm_iproc_i2c_type type;
 	int irq;
 
 	void __iomem *base;
+	void __iomem *idm_base;
+
+	u32 ape_addr_mask;
+
+	/* lock for indirect access through IDM */
+	spinlock_t idm_lock;
+
+	/* indicates no slave mode support */
+	bool no_slave;
 
 	struct i2c_adapter adapter;
 	unsigned int bus_speed;
@@ -215,13 +232,33 @@ static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
 static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				   u32 offset)
 {
-	return readl(iproc_i2c->base + offset);
+	u32 val;
+
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		val = readl(iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		val = readl(iproc_i2c->base + offset);
+	}
+
+	return val;
 }
 
 static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 offset, u32 val)
 {
-	writel(val, iproc_i2c->base + offset);
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		writel(val, iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		writel(val, iproc_i2c->base + offset);
+	}
 }
 
 static void bcm_iproc_i2c_slave_init(
@@ -766,7 +803,13 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
+	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
+	u32 val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+
+	if (!iproc_i2c->no_slave)
+		val |= I2C_FUNC_SLAVE;
+
+	return val;
 }
 
 static const struct i2c_algorithm bcm_iproc_algo = {
@@ -829,6 +872,8 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iproc_i2c);
 	iproc_i2c->device = &pdev->dev;
+	iproc_i2c->type =
+		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);
 	init_completion(&iproc_i2c->done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -836,6 +881,26 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(iproc_i2c->base))
 		return PTR_ERR(iproc_i2c->base);
 
+	if (iproc_i2c->type == IPROC_I2C_NIC) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		iproc_i2c->idm_base = devm_ioremap_resource(iproc_i2c->device,
+							    res);
+		if (IS_ERR(iproc_i2c->idm_base))
+			return PTR_ERR(iproc_i2c->idm_base);
+
+		ret = of_property_read_u32(iproc_i2c->device->of_node,
+					   "brcm,ape-hsls-addr-mask",
+					   &iproc_i2c->ape_addr_mask);
+		if (ret < 0) {
+			dev_err(iproc_i2c->device,
+				"'brcm,ape-hsls-addr-mask' missing\n");
+			return -EINVAL;
+		}
+
+		spin_lock_init(&iproc_i2c->idm_lock);
+		iproc_i2c->no_slave = true;
+	}
+
 	ret = bcm_iproc_i2c_init(iproc_i2c);
 	if (ret)
 		return ret;
@@ -992,7 +1057,13 @@ static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave)
 }
 
 static const struct of_device_id bcm_iproc_i2c_of_match[] = {
-	{ .compatible = "brcm,iproc-i2c" },
+	{
+		.compatible = "brcm,iproc-i2c",
+		.data = (int *)IPROC_I2C,
+	}, {
+		.compatible = "brcm,iproc-nic-i2c",
+		.data = (int *)IPROC_I2C_NIC,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcm_iproc_i2c_of_match);
-- 
2.17.1

