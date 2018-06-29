Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A807C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C223927DB5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C223927DB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937235AbeF2Tcm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:32:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:17992 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937085AbeF2TbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:31:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 12:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="241786818"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 12:31:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E1B1D75E; Fri, 29 Jun 2018 22:31:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/6] x86/platform/intel-mid: Remove per platform code
Date:   Fri, 29 Jun 2018 22:31:13 +0300
Message-Id: <20180629193113.84425-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After custom TSC calibration gone, there is no more reason to have
custom platform code for each of Intel MID.

Thus, remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-mid.h              | 29 ----------------
 arch/x86/platform/intel-mid/Makefile          |  2 +-
 arch/x86/platform/intel-mid/intel-mid.c       | 17 +---------
 .../platform/intel-mid/intel_mid_weak_decls.h | 18 ----------
 arch/x86/platform/intel-mid/mfld.c            | 34 -------------------
 arch/x86/platform/intel-mid/mrfld.c           | 31 -----------------
 6 files changed, 2 insertions(+), 129 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/intel_mid_weak_decls.h
 delete mode 100644 arch/x86/platform/intel-mid/mfld.c
 delete mode 100644 arch/x86/platform/intel-mid/mrfld.c

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 376eb8ada62d..52f815a80539 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -80,35 +80,6 @@ enum intel_mid_cpu_type {
 
 extern enum intel_mid_cpu_type __intel_mid_cpu_chip;
 
-/**
- * struct intel_mid_ops - Interface between intel-mid & sub archs
- * @arch_setup: arch_setup function to re-initialize platform
- *		structures (x86_init, x86_platform_init)
- *
- * This structure can be extended if any new interface is required
- * between intel-mid & its sub arch files.
- */
-struct intel_mid_ops {
-	void (*arch_setup)(void);
-};
-
-/* Helper API's for INTEL_MID_OPS_INIT */
-#define DECLARE_INTEL_MID_OPS_INIT(cpuname, cpuid)				\
-	[cpuid] = get_##cpuname##_ops
-
-/* Maximum number of CPU ops */
-#define MAX_CPU_OPS(a)			(sizeof(a)/sizeof(void *))
-
-/*
- * For every new cpu addition, a weak get_<cpuname>_ops() function needs be
- * declared in arch/x86/platform/intel_mid/intel_mid_weak_decls.h.
- */
-#define INTEL_MID_OPS_INIT {							\
-	DECLARE_INTEL_MID_OPS_INIT(penwell, INTEL_MID_CPU_CHIP_PENWELL),	\
-	DECLARE_INTEL_MID_OPS_INIT(cloverview, INTEL_MID_CPU_CHIP_CLOVERVIEW),	\
-	DECLARE_INTEL_MID_OPS_INIT(tangier, INTEL_MID_CPU_CHIP_TANGIER)		\
-};
-
 #ifdef CONFIG_X86_INTEL_MID
 
 static inline enum intel_mid_cpu_type intel_mid_identify_cpu(void)
diff --git a/arch/x86/platform/intel-mid/Makefile b/arch/x86/platform/intel-mid/Makefile
index fa021dfab088..5cf886c867c2 100644
--- a/arch/x86/platform/intel-mid/Makefile
+++ b/arch/x86/platform/intel-mid/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_X86_INTEL_MID) += intel-mid.o intel_mid_vrtc.o mfld.o mrfld.o pwr.o
+obj-$(CONFIG_X86_INTEL_MID) += intel-mid.o intel_mid_vrtc.o pwr.o
 
 # SFI specific code
 ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index aac15a4018d5..56f66eafb94f 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -36,8 +36,6 @@
 #include <asm/apb_timer.h>
 #include <asm/reboot.h>
 
-#include "intel_mid_weak_decls.h"
-
 /*
  * the clockevent devices on Moorestown/Medfield can be APBT or LAPIC clock,
  * cmdline option x86_intel_mid_timer can be used to override the configuration
@@ -61,10 +59,6 @@
 
 enum intel_mid_timer_options intel_mid_timer_options;
 
-/* intel_mid_ops to store sub arch ops */
-static struct intel_mid_ops *intel_mid_ops;
-/* getter function for sub arch ops*/
-static void *(*get_intel_mid_ops[])(void) = INTEL_MID_OPS_INIT;
 enum intel_mid_cpu_type __intel_mid_cpu_chip;
 EXPORT_SYMBOL_GPL(__intel_mid_cpu_chip);
 
@@ -128,6 +122,7 @@ static void intel_mid_arch_setup(void)
 	case 0x3C:
 	case 0x4A:
 		__intel_mid_cpu_chip = INTEL_MID_CPU_CHIP_TANGIER;
+		x86_platform.legacy.rtc = 1;
 		break;
 	case 0x27:
 	default:
@@ -135,17 +130,7 @@ static void intel_mid_arch_setup(void)
 		break;
 	}
 
-	if (__intel_mid_cpu_chip < MAX_CPU_OPS(get_intel_mid_ops))
-		intel_mid_ops = get_intel_mid_ops[__intel_mid_cpu_chip]();
-	else {
-		intel_mid_ops = get_intel_mid_ops[INTEL_MID_CPU_CHIP_PENWELL]();
-		pr_info("ARCH: Unknown SoC, assuming Penwell!\n");
-	}
-
 out:
-	if (intel_mid_ops->arch_setup)
-		intel_mid_ops->arch_setup();
-
 	/*
 	 * Intel MID platforms are using explicitly defined regulators.
 	 *
diff --git a/arch/x86/platform/intel-mid/intel_mid_weak_decls.h b/arch/x86/platform/intel-mid/intel_mid_weak_decls.h
deleted file mode 100644
index 3c1c3866d82b..000000000000
--- a/arch/x86/platform/intel-mid/intel_mid_weak_decls.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * intel_mid_weak_decls.h: Weak declarations of intel-mid.c
- *
- * (C) Copyright 2013 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- */
-
-
-/* For every CPU addition a new get_<cpuname>_ops interface needs
- * to be added.
- */
-extern void *get_penwell_ops(void);
-extern void *get_cloverview_ops(void);
-extern void *get_tangier_ops(void);
diff --git a/arch/x86/platform/intel-mid/mfld.c b/arch/x86/platform/intel-mid/mfld.c
deleted file mode 100644
index e66b51f5c206..000000000000
--- a/arch/x86/platform/intel-mid/mfld.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * mfld.c: Intel Medfield platform setup code
- *
- * (C) Copyright 2013 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- */
-
-#include <linux/init.h>
-
-#include <asm/intel-mid.h>
-
-#include "intel_mid_weak_decls.h"
-
-static void __init penwell_arch_setup(void)
-{
-}
-
-static struct intel_mid_ops penwell_ops = {
-	.arch_setup = penwell_arch_setup,
-};
-
-void *get_penwell_ops(void)
-{
-	return &penwell_ops;
-}
-
-void *get_cloverview_ops(void)
-{
-	return &penwell_ops;
-}
diff --git a/arch/x86/platform/intel-mid/mrfld.c b/arch/x86/platform/intel-mid/mrfld.c
deleted file mode 100644
index c5538ec2d62d..000000000000
--- a/arch/x86/platform/intel-mid/mrfld.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Intel Merrifield platform specific setup code
- *
- * (C) Copyright 2013 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- */
-
-#include <linux/init.h>
-
-#include <asm/intel-mid.h>
-
-#include "intel_mid_weak_decls.h"
-
-static void __init tangier_arch_setup(void)
-{
-	x86_platform.legacy.rtc = 1;
-}
-
-/* tangier arch ops */
-static struct intel_mid_ops tangier_ops = {
-	.arch_setup = tangier_arch_setup,
-};
-
-void *get_tangier_ops(void)
-{
-	return &tangier_ops;
-}
-- 
2.18.0

