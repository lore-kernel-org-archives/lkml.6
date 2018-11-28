Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45850205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcJP4fbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45850205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeK1Vpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37004 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeK1Vp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so18978934lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYiM9hsLAwjDtY6nnK0M2ohtbKlx4iqaNDXUO8IxYxE=;
        b=HcJP4fbq2N7Qxt3f1FdI/Sjnzz0LP4Hb4PYty22w1YFJE2KjFeuXaUte5yhiURHTU1
         hNgOrbejD9xUDBvEfN1F6XmphAvXPGJxyeMzg4fYKkxod9pUE5fT/GL4JGg8++HEGBex
         4ldFonVtUGGgQUye+6Uw47YHDdpj0UajWw4dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYiM9hsLAwjDtY6nnK0M2ohtbKlx4iqaNDXUO8IxYxE=;
        b=LUHfL2Feqpe4O4BHTwLr7wIwGzQjUgpdUSBwk/7bktbDHECQV/YuHF4/eif4UCpTSu
         GnLd/oPQfNf5GaYAU8o4auxXsLYbyv4N6hG9YHZwSA3BkX7GVuj/v2Uh86ZJpGeIC5Es
         PSNg1NYVsrPNzvaVEewohJPKq5RMl1oGB6Su663oTlnNalZtVFKE52tbVbRq0eTftTey
         76klYm+wGnAOpyiFA5wsuqVlUQi5dfbJp9kY6AJxP9rps3kP2/PE7SlpZJdKXrcwGNkP
         E+vhc7rWMwIvd4L3NBiB09Et+IQd0xgbLhK1WvDYe14WxIAVl6U/u8CKQI+JhjYeg/91
         cEhw==
X-Gm-Message-State: AGRZ1gIOwMx2rJU+FBzvBCdR9TPXFcVBg15Xhx812J8MA0146UoD5Frm
        FxB/wPjcf6nvP2Q+uHmj/Zr6tYp4/FuPFg==
X-Google-Smtp-Source: AJdET5c1Z5oYtcfF1JinpX0Iaoi4w6BrsWMtnf0c5+06j88W8v897M0DFbO4bbajZQYoT7j3fZqE2A==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr19908179lfk.155.1543401854599;
        Wed, 28 Nov 2018 02:44:14 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/10] regulator: s5m8767: Let core handle GPIO descriptors
Date:   Wed, 28 Nov 2018 11:43:49 +0100
Message-Id: <20181128104350.31902-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get_from_of_node() rather than the devm_*
version so that the regulator core can handle the lifecycle
of these descriptors.

Introduce an errorpath so we free any retrieved descriptors
properly.

This patch requires "gpio: Export gpiod_get_from_of_node()"
to be applied first.

Fixes: 9ae5cc75ceaa ("regulator: s5m8767: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/s5m8767.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 219b9afda0cb..2d8f6cd4f142 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -528,7 +528,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 	struct device_node *pmic_np, *regulators_np, *reg_np;
 	struct sec_regulator_data *rdata;
 	struct sec_opmode_data *rmode;
-	unsigned int i, dvs_voltage_nr = 8, ret;
+	unsigned int i, j, dvs_voltage_nr = 8, ret;
 
 	pmic_np = iodev->dev->of_node;
 	if (!pmic_np) {
@@ -559,6 +559,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 
 	pdata->regulators = rdata;
 	pdata->opmode = rmode;
+	j = 0; /* Keeps track of populated elements for errorpath */
 	for_each_child_of_node(regulators_np, reg_np) {
 		for (i = 0; i < ARRAY_SIZE(regulators); i++)
 			if (!of_node_cmp(reg_np->name, regulators[i].name))
@@ -571,9 +572,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 			continue;
 		}
 
-		rdata->ext_control_gpiod = devm_gpiod_get_from_of_node(
-			&pdev->dev,
-			reg_np,
+		rdata->ext_control_gpiod = gpiod_get_from_of_node(reg_np,
 			"s5m8767,pmic-ext-control-gpios",
 			0,
 			GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
@@ -597,6 +596,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 			rmode->mode = S5M8767_OPMODE_NORMAL_MODE;
 		}
 		rmode++;
+		j++;
 	}
 
 	of_node_put(regulators_np);
@@ -608,7 +608,8 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 				"s5m8767,pmic-buck2-dvs-voltage",
 				pdata->buck2_voltage, dvs_voltage_nr)) {
 			dev_err(iodev->dev, "buck2 voltages not specified\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_gpiod_put;
 		}
 	}
 
@@ -619,7 +620,8 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 				"s5m8767,pmic-buck3-dvs-voltage",
 				pdata->buck3_voltage, dvs_voltage_nr)) {
 			dev_err(iodev->dev, "buck3 voltages not specified\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_gpiod_put;
 		}
 	}
 
@@ -630,15 +632,18 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 				"s5m8767,pmic-buck4-dvs-voltage",
 				pdata->buck4_voltage, dvs_voltage_nr)) {
 			dev_err(iodev->dev, "buck4 voltages not specified\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_gpiod_put;
 		}
 	}
 
 	if (pdata->buck2_gpiodvs || pdata->buck3_gpiodvs ||
 						pdata->buck4_gpiodvs) {
 		ret = s5m8767_pmic_dt_parse_dvs_gpio(iodev, pdata, pmic_np);
-		if (ret)
-			return -EINVAL;
+		if (ret) {
+			ret = -EINVAL;
+			goto err_gpiod_put;
+		}
 
 		if (of_property_read_u32(pmic_np,
 				"s5m8767,pmic-buck-default-dvs-idx",
@@ -654,8 +659,10 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 	}
 
 	ret = s5m8767_pmic_dt_parse_ds_gpio(iodev, pdata, pmic_np);
-	if (ret)
-		return -EINVAL;
+	if (ret) {
+		ret = -EINVAL;
+		goto err_gpiod_put;
+	}
 
 	if (of_get_property(pmic_np, "s5m8767,pmic-buck2-ramp-enable", NULL))
 		pdata->buck2_ramp_enable = true;
@@ -674,6 +681,14 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 	}
 
 	return 0;
+
+err_gpiod_put:
+	while (j) {
+		gpiod_put(rdata->ext_control_gpiod);
+		rdata--;
+		j--;
+	}
+	return ret;
 }
 #else
 static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
-- 
2.19.1

