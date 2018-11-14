Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A65C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116A2250F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7MtDXrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9116A2250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbeKNTKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:10:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36404 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeKNTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:10:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so762877pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pM4xo8EH7+FwIopWG51Di3D79VxY65IdP6hwSYGqO0I=;
        b=K7MtDXrg1XRlZAecffDu2MzNpa1VDLB9fXSRB8vDJw5KyHvioYDjarzVXJlTrF9oqa
         veU3zPb4ithaS3sbFvKBqwAR/N27mZtvfmRGvpiHCqosUZlcDN8saJrRzX0s3aPWxGpI
         WE+pIAHTzb+YiCU9tHXnD1U94RjQtAN7ufFEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pM4xo8EH7+FwIopWG51Di3D79VxY65IdP6hwSYGqO0I=;
        b=tUSxg6eKS6tAE/rXsFjIrsY0t9l7HA8B49J/b+gVqjBQrZ96NlbZc0w8nTXskXVl8K
         sGi89lqRMeNYGp4ik9I8nCEbzEr2EKn21JB8Ko+EoXw9h4d8OmH8rF5VXAhY1m701Mr9
         23fyF+mVerHiUKJxZPJewgPZrX5/fVRhNQEWm/peL2C2P+KHKQynVICkAw5Bopg2bxFN
         JAJvFZ8CTZzH+9hfK1S6Z0ss1iKnVBERinOlJDS67k+zM6Yl+fe3PWN/stsIXmBEr49+
         LlTnXOojkAUZggWX3OLGj+P385qwijhxFjNttmi+++dRqM20WouEONj9w/ZWYSkZrV2g
         0YLQ==
X-Gm-Message-State: AGRZ1gJ7T2uvW8w3UgK7H+uVMkEzpk0N/klitqj46TKVVyDrdhdpUnIb
        SRLDO7375TUsUeMfF0++32QjLA==
X-Google-Smtp-Source: AJdET5cJNV7IPnDyhU28H6D7jCTdXdaSAi42OMoFm4jW4HpXXYxzDcchu0+/4c+LAERMwEcW2NJXVA==
X-Received: by 2002:a63:1204:: with SMTP id h4mr988699pgl.51.1542186477038;
        Wed, 14 Nov 2018 01:07:57 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 127-v6sm25048814pfx.91.2018.11.14.01.07.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:07:56 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 4/5] power: supply: sc27xx: Add suspend/resume interfaces
Date:   Wed, 14 Nov 2018 17:07:07 +0800
Message-Id: <edd5230db26b5f69b9b4030972b5a34927055460.1542185618.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add fuel gauge platform suspend and resume interfaces. In suspend state,
we should enable the low voltage and coulomb counter threshold interrupts
to wake up system to calibrate the battery capacity in lower voltage stage.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   77 ++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 962d0f8..8c52e29 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -789,6 +789,7 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	data->bat_present = !!ret;
 	mutex_init(&data->lock);
 	data->dev = &pdev->dev;
+	platform_set_drvdata(pdev, data);
 
 	fgu_cfg.drv_data = data;
 	fgu_cfg.of_node = np;
@@ -846,6 +847,81 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sc27xx_fgu_resume(struct device *dev)
+{
+	struct sc27xx_fgu_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
+				 SC27XX_FGU_LOW_OVERLOAD_INT |
+				 SC27XX_FGU_CLBCNT_DELTA_INT, 0);
+	if (ret) {
+		dev_err(data->dev, "failed to disable fgu interrupts\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sc27xx_fgu_suspend(struct device *dev)
+{
+	struct sc27xx_fgu_data *data = dev_get_drvdata(dev);
+	int ret, status, ocv;
+
+	ret = sc27xx_fgu_get_status(data, &status);
+	if (ret)
+		return ret;
+
+	/*
+	 * If we are charging, then no need to enable the FGU interrupts to
+	 * adjust the battery capacity.
+	 */
+	if (status != POWER_SUPPLY_STATUS_NOT_CHARGING)
+		return 0;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
+				 SC27XX_FGU_LOW_OVERLOAD_INT,
+				 SC27XX_FGU_LOW_OVERLOAD_INT);
+	if (ret) {
+		dev_err(data->dev, "failed to enable low voltage interrupt\n");
+		return ret;
+	}
+
+	ret = sc27xx_fgu_get_vbat_ocv(data, &ocv);
+	if (ret)
+		goto disable_int;
+
+	/*
+	 * If current OCV is less than the minimum voltage, we should enable the
+	 * coulomb counter threshold interrupt to notify events to adjust the
+	 * battery capacity.
+	 */
+	if (ocv < data->min_volt) {
+		ret = regmap_update_bits(data->regmap,
+					 data->base + SC27XX_FGU_INT_EN,
+					 SC27XX_FGU_CLBCNT_DELTA_INT,
+					 SC27XX_FGU_CLBCNT_DELTA_INT);
+		if (ret) {
+			dev_err(data->dev,
+				"failed to enable coulomb threshold int\n");
+			goto disable_int;
+		}
+	}
+
+	return 0;
+
+disable_int:
+	regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
+			   SC27XX_FGU_LOW_OVERLOAD_INT, 0);
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops sc27xx_fgu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sc27xx_fgu_suspend, sc27xx_fgu_resume)
+};
+
 static const struct of_device_id sc27xx_fgu_of_match[] = {
 	{ .compatible = "sprd,sc2731-fgu", },
 	{ }
@@ -856,6 +932,7 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	.driver = {
 		.name = "sc27xx-fgu",
 		.of_match_table = sc27xx_fgu_of_match,
+		.pm = &sc27xx_fgu_pm_ops,
 	}
 };
 
-- 
1.7.9.5

