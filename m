Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D31CC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BC42184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VumhuCF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfAYHDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:03:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35928 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfAYHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:02:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so6564050edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M5tXVSorWIxjyx2W+vXR4nkHOdqq0FYsZWQiwd4C6lQ=;
        b=VumhuCF2lE2V20MUI6pPWSxmHxM9lbw8uK2pFz39OqJPiVJr6A9+UcPL0jM5gEJ4dL
         +/cApfsQOFSMK2gSkFhu8j9LM/XfEnmi2RLwg9WSSqqAUrCIVHC20WOyad9arys8HMrm
         eqSjGWKel/ezVlaXpKu6lL+SBBbctZCKoCY34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M5tXVSorWIxjyx2W+vXR4nkHOdqq0FYsZWQiwd4C6lQ=;
        b=JMigKtuYQ1RMS6W5Ib+T5so9J3q5IIlfLPZn2QV4+HWuZgc9itV333n2NvJOy/0n1u
         FGeSmRYF4pdsD0/TVYWWsWrPtkqTOlN/bTKDU5qx/XoWn6IRoqAF3Ge/mRinYhkcPqGh
         8M2Z/80PDfhCu7k2kMVoM+Ow/B+4woTlv3IyzEKDUNzGygFUDfbthHCRyDKPTMAAR26c
         k3QG7hSdelwQFFqVBkv0Vyzt3M8YbM+wiebWY1/gYjR+MlViD2O5rO1ya2Shewpx2cfp
         AYdCjg98ALavT5H9foqIltWeMUWavjFIeMEGjR8/JbiAhGMTHP72ekqrQ2GXV+OMgjty
         IM2A==
X-Gm-Message-State: AJcUukcr0G2GaghfAk0y7ULIySSg3GckCpIMHJru9u/zYuOc2WYrMCCl
        Uj56Xyw0sAZIunB8GF3GlYIchvHGnZE=
X-Google-Smtp-Source: ALg8bN5Bzv1WWd8g42SR39L7OAM6Tk1Pj3tkZ0kdBltvKbVUWbgIJWZJGq7+krWVkDCMAh4Yo/HW2g==
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr9827585edy.81.1548399776747;
        Thu, 24 Jan 2019 23:02:56 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id s19sm402863eja.52.2019.01.24.23.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:02:56 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 1/9] thermal: cpu_cooling: Require thermal core to be compiled in
Date:   Fri, 25 Jan 2019 12:32:21 +0530
Message-Id: <0d63ca44cff5f47ef0102b2c86b4fe9eca9b658b.1548398851.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
driver to register as a cooling device and cool down the platform by
throttling the CPU frequency. In order to be able to auto-register a
cpufreq driver as a cooling device from the cpufreq core, we need access
to code inside cpu_cooling.c which, in turn, accesses code inside
thermal core.

CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
(e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
CONFIG_CPU_FREQ is compiled in. This leads to following error:

drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'

Given that platforms using CPU_THERMAL usually want it compiled-in so it
is available early in boot, make CPU_THERMAL depend on THERMAL being
compiled-in instead of allowing it to be a module.

As a result of this change, get rid of the ugly (!CPU_THERMAL ||
THERMAL) dependency in all cpufreq drivers using CPU_THERMAL.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/Kconfig     | 3 ---
 drivers/cpufreq/Kconfig.arm | 5 -----
 drivers/thermal/Kconfig     | 1 +
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 608af20a3494..b22e6bba71f1 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -207,8 +207,6 @@ comment "CPU frequency scaling drivers"
 config CPUFREQ_DT
 	tristate "Generic DT based cpufreq driver"
 	depends on HAVE_CLK && OF
-	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
-	depends on !CPU_THERMAL || THERMAL
 	select CPUFREQ_DT_PLATDEV
 	select PM_OPP
 	help
@@ -327,7 +325,6 @@ endif
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
 	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
-	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 688f10227793..ca8567c3152c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -29,8 +29,6 @@ config ARM_ARMADA_37XX_CPUFREQ
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
 	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
-	# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
@@ -38,7 +36,6 @@ config ARM_BIG_LITTLE_CPUFREQ
 config ARM_SCPI_CPUFREQ
 	tristate "SCPI based CPUfreq driver"
 	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
-	depends on !CPU_THERMAL || THERMAL
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCPI
 	  protocol for CPU power management.
@@ -93,7 +90,6 @@ config ARM_KIRKWOOD_CPUFREQ
 config ARM_MEDIATEK_CPUFREQ
 	tristate "CPU Frequency scaling support for MediaTek SoCs"
 	depends on ARCH_MEDIATEK && REGULATOR
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUFreq driver support for MediaTek SoCs.
@@ -233,7 +229,6 @@ config ARM_SA1110_CPUFREQ
 config ARM_SCMI_CPUFREQ
 	tristate "SCMI based CPUfreq driver"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCMI
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 30323426902e..58bb7d72dc2b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -152,6 +152,7 @@ config CPU_THERMAL
 	bool "generic cpu cooling support"
 	depends on CPU_FREQ
 	depends on THERMAL_OF
+	depends on THERMAL=y
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
-- 
2.17.1

