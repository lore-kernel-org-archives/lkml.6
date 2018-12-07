Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4E5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84DB20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jne2E8bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84DB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGGzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:55:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38121 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGGzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:55:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2740456wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HwvSgP64bKQDlpi0ap9Z/MZsdq68kIB1wq6c38Sv56k=;
        b=jne2E8bSg+kFQ99DNjye77ayA1vuXreU1+ZqX1A4kk/UZTmARykw1v9F7Q+jsM+d/U
         YWM8vik5N5Vj/LYfMVF2tDTqoV3IztUOL6IT0L0qUVS0ldgYu7HgxV9x4SY50IoVm//v
         NyqRqFZGuxy9t9Rr7RvEwvsnm5j7yH03KEz7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HwvSgP64bKQDlpi0ap9Z/MZsdq68kIB1wq6c38Sv56k=;
        b=X3KR9CHQF9tes31T40D45yN9MeALJ4sqhOimTxklwt4jSYqpG42ZZh5E+IA9uj4fzZ
         Zbji2vAWwdcpN/DBPyRocxPP/ngqJUq6ZEOo7DemQDlW+v2NcaR6WJ/5a3qN17/aND4y
         HCcKhDMukl6P6fI2XdvM1X1ZbyjVWXYg5boFXb6/xJIEEKG+FevmgcvHlAeDVXTmBgZV
         Z1yOHtBii9u78VAs47KFsk2QEAT4JsQlBXaQ5Cr6DN467XVS5u7sTCN8hvoMo6j+gF0I
         QsRRF3/1I8t5PZHSqRgbZqTeWXIbzTY6Nw8OOXq/+v3rgOssiDxICyXqri+2D5mGuX00
         WyLA==
X-Gm-Message-State: AA+aEWZuSdHUQAkjdKgT+bVteuxBZ9jRpsj/5CXHJsT3FkR2Z+/W7f9t
        Ty+0fqxS4HBzoLzVz4lS2zWRFHd1/fs=
X-Google-Smtp-Source: AFSGD/XjCJsrWqNCQgFxn8pATtACeeIDI0UrMyVL9n979iOe/HywoxlsNCMVoMq0V04pX2Twj0l+4Q==
X-Received: by 2002:adf:8001:: with SMTP id 1mr738660wrk.23.1544165749588;
        Thu, 06 Dec 2018 22:55:49 -0800 (PST)
Received: from localhost ([49.248.194.38])
        by smtp.gmail.com with ESMTPSA id l197sm7466278wma.44.2018.12.06.22.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 22:55:49 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com, sfr@canb.auug.org.au,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v4 2/2] drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir
Date:   Fri,  7 Dec 2018 12:25:27 +0530
Message-Id: <40e807c17ef0ca34852f635eb2c3b25333fe9f76.1544165234.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1544165234.git.amit.kucheria@linaro.org>
References: <cover.1544165234.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1544165234.git.amit.kucheria@linaro.org>
References: <cover.1544165234.git.amit.kucheria@linaro.org>
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
 drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (99%)

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
index 0b5d33a49b3e..486d682be047 100644
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
similarity index 99%
rename from drivers/thermal/qcom-spmi-temp-alarm.c
rename to drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index b2d5d5bf4a9b..c1fd71dbab3e 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -23,7 +23,7 @@
 #include <linux/regmap.h>
 #include <linux/thermal.h>
 
-#include "thermal_core.h"
+#include "../thermal_core.h"
 
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
-- 
2.17.1

