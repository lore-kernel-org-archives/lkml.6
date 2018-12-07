Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5692720850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvHNHMSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5692720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLGGzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:55:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55900 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGGzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:55:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so3225151wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y9ih5SmefT0dcqg1u9P8rxz2diEFPgH9knaz8DEMQ4Y=;
        b=VvHNHMSKT8r4pEktxWc1WU2z3JFMwYbkigtXAbUFvHPm+ylxYI5+f1GtX+VLY9dHqS
         mLtoc8OgkAaDXQ6sEI6GzPwGwRS87NmKm1GL/rpoVFJIJXcmM/9Tw4Nq70RnyRViR4bG
         780gOegaUXSflO0vFfeGbI7aKE1NI6BOJ4lXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y9ih5SmefT0dcqg1u9P8rxz2diEFPgH9knaz8DEMQ4Y=;
        b=h3YJTMdXH5c6FX/xwEhgQlkPJv4T1RoId57hkDfR7ezEUOxzcr12r2wjLPtd2M7DdV
         Ljm4Q9TkdTKvw5ozSE+ycNKXG8Ht8ro5x1e94uw53b5QUFrEiFZET5oRT4d8ZT10cd8k
         P0dz5G+yQC2zf0ZoYER7wgznZ9LynRJRQwGXoakoKwbToe+1dwCeoy0NNGXwxmdZyhpP
         4eIMj/AgF9eQ6aOU92miZd/sRu8PBrQcjVxsa1mthMDTmQ4pZjTb8vdmKGfsNrpMojXz
         HilBlwgJH0vc0hArXYl5pyLPgaGBqwdtQgX4HfIbRweWiT6K2FqR/JCwswsG9M0L9+xN
         1SXg==
X-Gm-Message-State: AA+aEWZeBsIxaQbjdVN8kdLioSVC8jrL/dJuI/p93E0lcQ8+Bt9cMUMm
        nV9lmES+dA5TeeWb33Dyx5AdM9TrDLI=
X-Google-Smtp-Source: AFSGD/Wfq46s3QLdMTRx7tRkASLD+GI/hMwWBU7nnxP2eLGH5VfL4d/BUVZ120SxkqGA7Aaq0yuFDw==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr1214476wmf.144.1544165743304;
        Thu, 06 Dec 2018 22:55:43 -0800 (PST)
Received: from localhost ([49.248.194.38])
        by smtp.gmail.com with ESMTPSA id x76sm6412515wmd.27.2018.12.06.22.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 22:55:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com, sfr@canb.auug.org.au,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v4 1/2] drivers: thermal: Move various drivers for intel platforms into a subdir
Date:   Fri,  7 Dec 2018 12:25:26 +0530
Message-Id: <71f989496124ada8e83056341410af17eaa49374.1544165234.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1544165234.git.amit.kucheria@linaro.org>
References: <cover.1544165234.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1544165234.git.amit.kucheria@linaro.org>
References: <cover.1544165234.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the directory a bit, now that we have several other
platforms using platform-specific sub-directories. Compile-tested with
ARCH=x86 defconfig and the drivers explicitly enabled with menuconfig.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig                       | 83 ++-----------------
 drivers/thermal/Makefile                      |  9 +-
 drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++++
 drivers/thermal/intel/Makefile                | 12 +++
 .../{ => intel}/int340x_thermal/Kconfig       |  0
 .../{ => intel}/int340x_thermal/Makefile      |  0
 .../int340x_thermal/acpi_thermal_rel.c        |  0
 .../int340x_thermal/acpi_thermal_rel.h        |  0
 .../int340x_thermal/int3400_thermal.c         |  0
 .../int340x_thermal/int3402_thermal.c         |  0
 .../int340x_thermal/int3403_thermal.c         |  0
 .../int340x_thermal/int3406_thermal.c         |  0
 .../int340x_thermal/int340x_thermal_zone.c    |  0
 .../int340x_thermal/int340x_thermal_zone.h    |  0
 .../processor_thermal_device.c                |  0
 .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
 .../thermal/{ => intel}/intel_pch_thermal.c   |  0
 .../thermal/{ => intel}/intel_powerclamp.c    |  0
 .../{ => intel}/intel_quark_dts_thermal.c     |  0
 .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
 .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
 .../{ => intel}/intel_soc_dts_thermal.c       |  0
 .../{ => intel}/x86_pkg_temp_thermal.c        |  0
 23 files changed, 95 insertions(+), 86 deletions(-)
 create mode 100644 drivers/thermal/intel/Kconfig
 create mode 100644 drivers/thermal/intel/Makefile
 rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.h (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.h (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/processor_thermal_device.c (100%)
 rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
 rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
 rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5422523c03f8..772ab9dadda7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -326,84 +326,6 @@ config DA9062_THERMAL
 	  zone.
 	  Compatible with the DA9062 and DA9061 PMICs.
 
-config INTEL_POWERCLAMP
-	tristate "Intel PowerClamp idle injection driver"
-	depends on THERMAL
-	depends on X86
-	depends on CPU_SUP_INTEL
-	help
-	  Enable this to enable Intel PowerClamp idle injection driver. This
-	  enforce idle time which results in more package C-state residency. The
-	  user interface is exposed via generic thermal framework.
-
-config X86_PKG_TEMP_THERMAL
-	tristate "X86 package temperature thermal driver"
-	depends on X86_THERMAL_VECTOR
-	select THERMAL_GOV_USER_SPACE
-	select THERMAL_WRITABLE_TRIPS
-	default m
-	help
-	  Enable this to register CPU digital sensor for package temperature as
-	  thermal zone. Each package will have its own thermal zone. There are
-	  two trip points which can be set by user to get notifications via thermal
-	  notification methods.
-
-config INTEL_SOC_DTS_IOSF_CORE
-	tristate
-	depends on X86 && PCI
-	select IOSF_MBI
-	help
-	  This is becoming a common feature for Intel SoCs to expose the additional
-	  digital temperature sensors (DTSs) using side band interface (IOSF). This
-	  implements the common set of helper functions to register, get temperature
-	  and get/set thresholds on DTSs.
-
-config INTEL_SOC_DTS_THERMAL
-	tristate "Intel SoCs DTS thermal driver"
-	depends on X86 && PCI && ACPI
-	select INTEL_SOC_DTS_IOSF_CORE
-	select THERMAL_WRITABLE_TRIPS
-	help
-	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
-	  temperature sensor (DTS). These SoCs have two additional DTSs in
-	  addition to DTSs on CPU cores. Each DTS will be registered as a
-	  thermal zone. There are two trip points. One of the trip point can
-	  be set by user mode programs to get notifications via Linux thermal
-	  notification methods.The other trip is a critical trip point, which
-	  was set by the driver based on the TJ MAX temperature.
-
-config INTEL_QUARK_DTS_THERMAL
-	tristate "Intel Quark DTS thermal driver"
-	depends on X86_INTEL_QUARK
-	help
-	  Enable this to register Intel Quark SoC (e.g. X1000) platform digital
-	  temperature sensor (DTS). For X1000 SoC, it has one on-die DTS.
-	  The DTS will be registered as a thermal zone. There are two trip points:
-	  hot & critical. The critical trip point default value is set by
-	  underlying BIOS/Firmware.
-
-menu "ACPI INT340X thermal drivers"
-source drivers/thermal/int340x_thermal/Kconfig
-endmenu
-
-config INTEL_BXT_PMIC_THERMAL
-	tristate "Intel Broxton PMIC thermal driver"
-	depends on X86 && INTEL_SOC_PMIC_BXTWC && REGMAP
-	help
-	  Select this driver for Intel Broxton PMIC with ADC channels monitoring
-	  system temperature measurements and alerts.
-	  This driver is used for monitoring the ADC channels of PMIC and handles
-	  the alert trip point interrupts and notifies the thermal framework with
-	  the trip point and temperature details of the zone.
-
-config INTEL_PCH_THERMAL
-	tristate "Intel PCH Thermal Reporting Driver"
-	depends on X86 && PCI
-	help
-	  Enable this to support thermal reporting on certain intel PCHs.
-	  Thermal reporting device will provide temperature reading,
-	  programmable trip points and other information.
-
 config MTK_THERMAL
 	tristate "Temperature sensor driver for mediatek SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
@@ -415,6 +337,11 @@ config MTK_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Mediatek SoCs
 
+menu "Intel thermal drivers"
+depends on X86 || X86_INTEL_QUARK || COMPILE_TEST
+source "drivers/thermal/intel/Kconfig"
+endmenu
+
 menu "Broadcom thermal drivers"
 depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
 source "drivers/thermal/broadcom/Kconfig"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82bb50dc6423..0b5d33a49b3e 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -44,15 +44,8 @@ obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
-obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
-obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
-obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)	+= intel_soc_dts_iosf.o
-obj-$(CONFIG_INTEL_SOC_DTS_THERMAL)	+= intel_soc_dts_thermal.o
-obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+= intel_quark_dts_thermal.o
+obj-y				+= intel/
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
-obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
-obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
-obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
 obj-y				+= st/
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-y				+= tegra/
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
new file mode 100644
index 000000000000..9c06d4ad7c97
--- /dev/null
+++ b/drivers/thermal/intel/Kconfig
@@ -0,0 +1,77 @@
+config INTEL_POWERCLAMP
+	tristate "Intel PowerClamp idle injection driver"
+	depends on THERMAL
+	depends on X86
+	depends on CPU_SUP_INTEL
+	help
+	  Enable this to enable Intel PowerClamp idle injection driver. This
+	  enforce idle time which results in more package C-state residency. The
+	  user interface is exposed via generic thermal framework.
+
+config X86_PKG_TEMP_THERMAL
+	tristate "X86 package temperature thermal driver"
+	depends on X86_THERMAL_VECTOR
+	select THERMAL_GOV_USER_SPACE
+	select THERMAL_WRITABLE_TRIPS
+	default m
+	help
+	  Enable this to register CPU digital sensor for package temperature as
+	  thermal zone. Each package will have its own thermal zone. There are
+	  two trip points which can be set by user to get notifications via thermal
+	  notification methods.
+
+config INTEL_SOC_DTS_IOSF_CORE
+	tristate
+	depends on X86 && PCI
+	select IOSF_MBI
+	help
+	  This is becoming a common feature for Intel SoCs to expose the additional
+	  digital temperature sensors (DTSs) using side band interface (IOSF). This
+	  implements the common set of helper functions to register, get temperature
+	  and get/set thresholds on DTSs.
+
+config INTEL_SOC_DTS_THERMAL
+	tristate "Intel SoCs DTS thermal driver"
+	depends on X86 && PCI && ACPI
+	select INTEL_SOC_DTS_IOSF_CORE
+	select THERMAL_WRITABLE_TRIPS
+	help
+	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
+	  temperature sensor (DTS). These SoCs have two additional DTSs in
+	  addition to DTSs on CPU cores. Each DTS will be registered as a
+	  thermal zone. There are two trip points. One of the trip point can
+	  be set by user mode programs to get notifications via Linux thermal
+	  notification methods.The other trip is a critical trip point, which
+	  was set by the driver based on the TJ MAX temperature.
+
+config INTEL_QUARK_DTS_THERMAL
+	tristate "Intel Quark DTS thermal driver"
+	depends on X86_INTEL_QUARK
+	help
+	  Enable this to register Intel Quark SoC (e.g. X1000) platform digital
+	  temperature sensor (DTS). For X1000 SoC, it has one on-die DTS.
+	  The DTS will be registered as a thermal zone. There are two trip points:
+	  hot & critical. The critical trip point default value is set by
+	  underlying BIOS/Firmware.
+
+menu "ACPI INT340X thermal drivers"
+source drivers/thermal/intel/int340x_thermal/Kconfig
+endmenu
+
+config INTEL_BXT_PMIC_THERMAL
+	tristate "Intel Broxton PMIC thermal driver"
+	depends on X86 && INTEL_SOC_PMIC_BXTWC && REGMAP
+	help
+	  Select this driver for Intel Broxton PMIC with ADC channels monitoring
+	  system temperature measurements and alerts.
+	  This driver is used for monitoring the ADC channels of PMIC and handles
+	  the alert trip point interrupts and notifies the thermal framework with
+	  the trip point and temperature details of the zone.
+
+config INTEL_PCH_THERMAL
+	tristate "Intel PCH Thermal Reporting Driver"
+	depends on X86 && PCI
+	help
+	  Enable this to support thermal reporting on certain intel PCHs.
+	  Thermal reporting device will provide temperature reading,
+	  programmable trip points and other information.
diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
new file mode 100644
index 000000000000..0d9736ced5d4
--- /dev/null
+++ b/drivers/thermal/intel/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for various Intel thermal drivers.
+
+obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
+obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
+obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)	+= intel_soc_dts_iosf.o
+obj-$(CONFIG_INTEL_SOC_DTS_THERMAL)	+= intel_soc_dts_thermal.o
+obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+= intel_quark_dts_thermal.o
+obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
+obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
+obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
diff --git a/drivers/thermal/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
similarity index 100%
rename from drivers/thermal/int340x_thermal/Kconfig
rename to drivers/thermal/intel/int340x_thermal/Kconfig
diff --git a/drivers/thermal/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
similarity index 100%
rename from drivers/thermal/int340x_thermal/Makefile
rename to drivers/thermal/intel/int340x_thermal/Makefile
diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
similarity index 100%
rename from drivers/thermal/int340x_thermal/acpi_thermal_rel.c
rename to drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.h b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
similarity index 100%
rename from drivers/thermal/int340x_thermal/acpi_thermal_rel.h
rename to drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
similarity index 100%
rename from drivers/thermal/int340x_thermal/int3400_thermal.c
rename to drivers/thermal/intel/int340x_thermal/int3400_thermal.c
diff --git a/drivers/thermal/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
similarity index 100%
rename from drivers/thermal/int340x_thermal/int3402_thermal.c
rename to drivers/thermal/intel/int340x_thermal/int3402_thermal.c
diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
similarity index 100%
rename from drivers/thermal/int340x_thermal/int3403_thermal.c
rename to drivers/thermal/intel/int340x_thermal/int3403_thermal.c
diff --git a/drivers/thermal/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
similarity index 100%
rename from drivers/thermal/int340x_thermal/int3406_thermal.c
rename to drivers/thermal/intel/int340x_thermal/int3406_thermal.c
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
similarity index 100%
rename from drivers/thermal/int340x_thermal/int340x_thermal_zone.c
rename to drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
similarity index 100%
rename from drivers/thermal/int340x_thermal/int340x_thermal_zone.h
rename to drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
similarity index 100%
rename from drivers/thermal/int340x_thermal/processor_thermal_device.c
rename to drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
similarity index 100%
rename from drivers/thermal/intel_bxt_pmic_thermal.c
rename to drivers/thermal/intel/intel_bxt_pmic_thermal.c
diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
similarity index 100%
rename from drivers/thermal/intel_pch_thermal.c
rename to drivers/thermal/intel/intel_pch_thermal.c
diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
similarity index 100%
rename from drivers/thermal/intel_powerclamp.c
rename to drivers/thermal/intel/intel_powerclamp.c
diff --git a/drivers/thermal/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
similarity index 100%
rename from drivers/thermal/intel_quark_dts_thermal.c
rename to drivers/thermal/intel/intel_quark_dts_thermal.c
diff --git a/drivers/thermal/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
similarity index 100%
rename from drivers/thermal/intel_soc_dts_iosf.c
rename to drivers/thermal/intel/intel_soc_dts_iosf.c
diff --git a/drivers/thermal/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
similarity index 100%
rename from drivers/thermal/intel_soc_dts_iosf.h
rename to drivers/thermal/intel/intel_soc_dts_iosf.h
diff --git a/drivers/thermal/intel_soc_dts_thermal.c b/drivers/thermal/intel/intel_soc_dts_thermal.c
similarity index 100%
rename from drivers/thermal/intel_soc_dts_thermal.c
rename to drivers/thermal/intel/intel_soc_dts_thermal.c
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
similarity index 100%
rename from drivers/thermal/x86_pkg_temp_thermal.c
rename to drivers/thermal/intel/x86_pkg_temp_thermal.c
-- 
2.17.1

