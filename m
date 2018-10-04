Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52ACC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2E521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTnSzD4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2E521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJDOoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:44:32 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39743 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeJDOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:44:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id v1-v6so3407122ywv.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JWF3lv0izd3kQMjG0xl0p6X0RF+nnvok+00YcCm5gOs=;
        b=JTnSzD4ISv3NpGnG8grQVMXZOkb6EHGUk8RgurbOkoOaSb2zj2CAj9B2U2orPQ15+V
         ziNjwm9NJKME3kPYaOQAzhU69ZIMu0fudrneuNkOWz60h6UhJ2BVbrNQWIYnGQ+Ijzlo
         yrP0UhMh57vtadu5LUBkS6oNMxGaZTwG7oD38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JWF3lv0izd3kQMjG0xl0p6X0RF+nnvok+00YcCm5gOs=;
        b=Bv8K9DFPOQQxNDaeO1++XslOL3tYv3aNCwVpzgt/gGJpvx0fd6vKVs0iSU8hwnJe9L
         UnnGwWufuyO+ogVxND4mStdVKZOKY4c2LJve3sRKF0McDePUi8f+M/0FRqYw0ha8m953
         UFLLV1HhTi1gyKs5TBPnjxUYDYxyW0a/M0rz0GUsw0/rXa1DB850gYGJ6B/ERPTGPe5i
         KLLg/q27ZLJpd6BLTozL6lJeVT3ZnH88mXIiu/HqEVMzUUyXxVAMOFxN84rGc1b/ax4p
         sJBNtNZnddoNkK0Gtk2I81qi3lr/L2Bwoe22kk1TYnlIGWeR9I8Th128zd5EO6G8B0MS
         Z8WA==
X-Gm-Message-State: ABuFfog9qFEemUtHxsbkxthgcMEjmFafhKP9ToGRhz5hRHUvhNKSSHFP
        cRW43UmVxT7QH710wjgToHlq7FTv1DdITw==
X-Google-Smtp-Source: ACcGV63IA982tHyFZZhyI7pJUyKgBtTJ0cC+B9x11FEC8ZvkRzc5OnpzoLXeW12sK3PO6Is1CU3wkA==
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr2924185ywd.124.1538639553115;
        Thu, 04 Oct 2018 00:52:33 -0700 (PDT)
Received: from localhost ([202.189.238.75])
        by smtp.gmail.com with ESMTPSA id y198-v6sm1650915ywy.64.2018.10.04.00.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:52:32 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, rui.zhang@intel.com, edubezval@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 2/2] drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
Date:   Thu,  4 Oct 2018 13:22:12 +0530
Message-Id: <18c718d98eeb519c14c52b02141783f93b95442c.1538638640.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538638640.git.amit.kucheria@linaro.org>
References: <cover.1538638640.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1538638640.git.amit.kucheria@linaro.org>
References: <cover.1538638640.git.amit.kucheria@linaro.org>
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

