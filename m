Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A442C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5687921104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqHH8yew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5687921104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeK1F6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:58:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35608 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbeK1F6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:58:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so114103wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VPbmyas9NlZ6E8jNGd5atlSp+2kjXH4RHxf4hQaqr5E=;
        b=KqHH8yewrjxLbKLIdYdPuJs7H9D4T2N8PrHGC49h2+HkPYIPgwUCujFbStV1okHUZY
         soJY9SJRFbKUxw4fGsKwi4ad/KHRIB/ARXkloqfI/tJWbdoa3RF2fBBO67D4nvn8bJV5
         4ELMmDzSBQrZxECdrXkLwa9Z2UaIcP8uzy5bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VPbmyas9NlZ6E8jNGd5atlSp+2kjXH4RHxf4hQaqr5E=;
        b=N5TDSyAgrGfuUv7GDCsFdNaJNUsImJIv8Ar6JsOY4OwSLB2/04PNYVPewek8gnu3Wn
         IfeBISiKDmxY+Fq0DhKFcO++Ghu1yTMdg1tmRq+FCPMZ5DJ+EZhp2nQGCbtm3cVb7oOQ
         /r2uhJz5te8aXpDOsCyZNvecetdlRcQL/xWFycF20okb3Kw62PJfPf7yghPn1GskjJOM
         3eqSRZj1wdUfyrgt75M1IHaprreVdwytAzFpsFO9GH4TvnhZT5nT8eKSzYer2OsMBPdJ
         bdBk3IxNcTlN3SprXtNhtlyJhWZKiOquTqtLVkVhsc/S1WKvlaOXmGPHK+SoHONYWPRR
         DNGg==
X-Gm-Message-State: AA+aEWYrz5nPcPTQTvur9fXakCcdAhXNcP/k5nnl/yvX6NbccER6PDq+
        NhcyXRmfVM28OSbil9YoxI4Ao65N2t8=
X-Google-Smtp-Source: AFSGD/WI4iWVv+aPWNwu/yi6N6cHBe1LZwcMADfpCV105p5kdKRT66hbRmde0M7wu90C/gNz33wNKw==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr73966wma.85.1543345155624;
        Tue, 27 Nov 2018 10:59:15 -0800 (PST)
Received: from localhost ([49.248.92.105])
        by smtp.gmail.com with ESMTPSA id 129sm84582wmd.18.2018.11.27.10.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 10:59:15 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 2/2] drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
Date:   Wed, 28 Nov 2018 00:28:41 +0530
Message-Id: <e526504923c569e575b8916f77b5c207679316e9.1543343156.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1543343156.git.amit.kucheria@linaro.org>
References: <cover.1543343156.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1543343156.git.amit.kucheria@linaro.org>
References: <cover.1543343156.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the directory a bit allowing just one place to look for
thermal related drivers for QCOM platforms instead of being scattered in
the root directory and the qcom/ subdirectory. Compile-tested with
ARCH=arm64 defconfig and the driver explicitly enabled with menuconfig.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig                           | 11 -----------
 drivers/thermal/Makefile                          |  1 -
 drivers/thermal/qcom/Kconfig                      | 11 +++++++++++
 drivers/thermal/qcom/Makefile                     |  1 +
 drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
 5 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 772ab9dadda7..344f6459862b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -374,17 +374,6 @@ config TANGO_THERMAL
 
 source "drivers/thermal/tegra/Kconfig"
 
-config QCOM_SPMI_TEMP_ALARM
-	tristate "Qualcomm SPMI PMIC Temperature Alarm"
-	depends on OF && SPMI && IIO
-	select REGMAP_SPMI
-	help
-	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
-	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
-	  trip points. The temperature reported by the thermal sensor reflects the
-	  real time die temperature if an ADC is present or an estimate of the
-	  temperature based upon the over temperature stage value.
-
 config GENERIC_ADC_THERMAL
 	tristate "Generic ADC based thermal sensor"
 	depends on IIO
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 031f61e7dfe8..415361685480 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -29,7 +29,6 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
 # platform thermal drivers
 obj-y				+= broadcom/
-obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index be32e5abce3c..cdb455ffd575 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -9,3 +9,14 @@ config QCOM_TSENS
 	  thermal zone device via the mode file results in disabling the sensor.
 	  Also able to set threshold temperature for both hot and cold and update
 	  when a threshold is reached.
+
+config QCOM_SPMI_TEMP_ALARM
+	tristate "Qualcomm SPMI PMIC Temperature Alarm"
+	depends on OF && SPMI && IIO
+	select REGMAP_SPMI
+	help
+	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
+	  PMIC devices. It shows up in sysfs as a thermal sensor with multiple
+	  trip points. The temperature reported by the thermal sensor reflects the
+	  real time die temperature if an ADC is present or an estimate of the
+	  temperature based upon the over temperature stage value.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index a821929ede0b..717a08600bb5 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
+obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
similarity index 100%
rename from drivers/thermal/qcom-spmi-temp-alarm.c
rename to drivers/thermal/qcom/qcom-spmi-temp-alarm.c
-- 
2.17.1

