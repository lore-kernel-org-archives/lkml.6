Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A4DC28CBE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B11B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhnWIgfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B11B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbeI1XBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:01:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbeI1XBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:01:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so2846354wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:in-reply-to:references:content-transfer-encoding;
        bh=Wd9PsEpbdDIUpvUnFkO1EFCbhWUNsZE2rT0pRRXdnQM=;
        b=OhnWIgfgjPxbAy4t1OlDiOMCeG+DYcJeHzkKAYMX9hnU/EqxOITug7WS8Vhv1nDgoo
         HIe9gpZ5Rp6ubK65o8h3pHYZPUhcesXJ6II+vAh3q2hsDTiwdfJIM5Aal57V2LMxPekH
         rwVdFtXiN9HqemSKaU6lClQtMZfpDJFnre4Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:in-reply-to:references
         :content-transfer-encoding;
        bh=Wd9PsEpbdDIUpvUnFkO1EFCbhWUNsZE2rT0pRRXdnQM=;
        b=skooe+kMT/Gl2Eb4xtrE6tqqIxQGIMS65EaeujMzBavqQnsHH4rhG4zoY2jRwhtTz3
         xn9jYcNluVQzZBHSmSLsJrd+zKMcA9vjJmFvEk1qrkydahFdaLp3Gczc06x7R/kJNpXO
         1uFtJoTG5oxZqPwL1QgA3h5O/AST1BCaJFEy4lcrvtMxZ/gvMbtXd3Dbbxh3XZM6tT1Q
         eKbUhonen1Pk4o30l9gkeLdwFsjvsEzv96jgVLrX/yj6hl9YZVVI+AcW2or2HBwWRwIP
         xsoG8Bt3pN91s3D+tAhcUYike0jxw0cx4MvXKqbGR42exkBUQf5QkdLbj7FJkc7e00j0
         /BGA==
X-Gm-Message-State: ABuFfogMEPTibEKa7CE50m+lEpfQM4JNADEEAvV8OshTgdDPVng9C489
        APW9qeXQ8cn3dZV+1qfM0riA/tPZD6+ppA==
X-Google-Smtp-Source: ACcGV61twfRxI9ktaqy5gaPksGhyI+mBErGgobQTIONivqswP47OglSinlyWb71zhxCjGh6R2aaJgg==
X-Received: by 2002:a7b:c259:: with SMTP id b25-v6mr2073221wmj.138.1538152587334;
        Fri, 28 Sep 2018 09:36:27 -0700 (PDT)
Received: from localhost ([49.248.49.136])
        by smtp.gmail.com with ESMTPSA id z8-v6sm6471585wrr.67.2018.09.28.09.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:36:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        mka@chromium.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 2/2] drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
Date:   Fri, 28 Sep 2018 22:06:06 +0530
Message-Id: <f3bd452e2f3829366e6a776f7ed5e24805d9654a.1538141538.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538141538.git.amit.kucheria@linaro.org>
References: <cover.1538141538.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
In-Reply-To: <cover.1538141538.git.amit.kucheria@linaro.org>
References: <cover.1538141538.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the directory a bit allowing just one place to look for
thermal related drivers for QCOM platforms instead of being scattered in
the root directory and the qcom/ subdirectory. Compile-tested with
ARCH=arm64 defconfig and the driver explicitly enabled with menuconfig.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/Kconfig                           | 11 -----------
 drivers/thermal/Makefile                          |  1 -
 drivers/thermal/qcom/Kconfig                      | 11 +++++++++++
 drivers/thermal/qcom/Makefile                     |  1 +
 drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
 5 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 6f18110f1480..c075f1190e63 100644
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
index a821929ede0b..f029f09442c7 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
+obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)▸     += qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
similarity index 100%
rename from drivers/thermal/qcom-spmi-temp-alarm.c
rename to drivers/thermal/qcom/qcom-spmi-temp-alarm.c
-- 
2.17.1

