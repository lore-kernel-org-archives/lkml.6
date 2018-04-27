Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933925AbeD0PI7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:08:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933714AbeD0PI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:08:56 -0400
Date: Fri, 27 Apr 2018 08:06:48 -0700
From: tip-bot for Rajneesh Bhardwaj <tipbot@zytor.com>
Message-ID: <tip-f79b1c573cb4dc551919f81ed5797419f6fc1f3a@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, andriy.shevchenko@linux.intel.com,
        rajneesh.bhardwaj@intel.com, anshuman.gupta@intel.com,
        tglx@linutronix.de, alan@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: alan@linux.intel.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, rajneesh.bhardwaj@intel.com,
        anshuman.gupta@intel.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org
In-Reply-To: <1522336015-22994-1-git-send-email-anshuman.gupta@intel.com>
References: <1522336015-22994-1-git-send-email-anshuman.gupta@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] x86/i8237: Register device based on FADT legacy boot
 flag
Git-Commit-ID: f79b1c573cb4dc551919f81ed5797419f6fc1f3a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f79b1c573cb4dc551919f81ed5797419f6fc1f3a
Gitweb:     https://git.kernel.org/tip/f79b1c573cb4dc551919f81ed5797419f6fc1f3a
Author:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
AuthorDate: Thu, 29 Mar 2018 20:36:55 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 27 Apr 2018 16:44:29 +0200

x86/i8237: Register device based on FADT legacy boot flag

>From Skylake onwards, the platform controller hub (Sunrisepoint PCH) does
not support legacy DMA operations to IO ports 81h-83h, 87h, 89h-8Bh, 8Fh.
Currently this driver registers as syscore ops and its resume function is
called on every resume from S3. On Skylake and Kabylake, this causes a
resume delay of around 100ms due to port IO operations, which is a problem.

This change allows to load the driver only when the platform bios
explicitly supports such devices or has a cut-off date earlier than 2017
due to the following reasons:

   - The platforms released before year 2017 have support for the 8237.
     (except Sunrisepoint PCH e.g. Skylake)

   - Some of the BIOS that were released for platforms (Skylake, Kabylake)
     during 2016-17 are buggy. These BIOS do not set/unset the
     ACPI_FADT_LEGACY_DEVICES field in FADT table properly based on the
     presence or absence of the DMA device.

Very recently, open source system firmware like coreboot started unsetting
ACPI_FADT_LEGACY_DEVICES field in FADT table if the 8237 DMA device is not
present on the PCH.

Please refer to chapter 21 of 6th Generation Intel® Core™ Processor
Platform Controller Hub Family: BIOS Specification.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rjw@rjwysocki.net
Cc: hpa@zytor.com
Cc: Alan Cox <alan@linux.intel.com>
Link: https://lkml.kernel.org/r/1522336015-22994-1-git-send-email-anshuman.gupta@intel.com
---
 arch/x86/include/asm/x86_init.h   |  1 +
 arch/x86/kernel/i8237.c           | 25 +++++++++++++++++++++++++
 arch/x86/kernel/platform-quirks.c |  7 ++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index ce8b4da07e35..db98e3ab3295 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -301,5 +301,6 @@ extern struct x86_apic_ops x86_apic_ops;
 extern void x86_early_init_platform_quirks(void);
 extern void x86_init_noop(void);
 extern void x86_init_uint_noop(unsigned int unused);
+extern bool x86_pnpbios_disabled(void);
 
 #endif
diff --git a/arch/x86/kernel/i8237.c b/arch/x86/kernel/i8237.c
index 8eeaa81de066..0a3e70fd00d6 100644
--- a/arch/x86/kernel/i8237.c
+++ b/arch/x86/kernel/i8237.c
@@ -9,10 +9,12 @@
  * your option) any later version.
  */
 
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/syscore_ops.h>
 
 #include <asm/dma.h>
+#include <asm/x86_init.h>
 
 /*
  * This module just handles suspend/resume issues with the
@@ -49,6 +51,29 @@ static struct syscore_ops i8237_syscore_ops = {
 
 static int __init i8237A_init_ops(void)
 {
+	/*
+	 * From SKL PCH onwards, the legacy DMA device is removed in which the
+	 * I/O ports (81h-83h, 87h, 89h-8Bh, 8Fh) related to it are removed
+	 * as well. All removed ports must return 0xff for a inb() request.
+	 *
+	 * Note: DMA_PAGE_2 (port 0x81) should not be checked for detecting
+	 * the presence of DMA device since it may be used by BIOS to decode
+	 * LPC traffic for POST codes. Original LPC only decodes one byte of
+	 * port 0x80 but some BIOS may choose to enhance PCH LPC port 0x8x
+	 * decoding.
+	 */
+	if (dma_inb(DMA_PAGE_0) == 0xFF)
+		return -ENODEV;
+
+	/*
+	 * It is not required to load this driver as newer SoC may not
+	 * support 8237 DMA or bus mastering from LPC. Platform firmware
+	 * must announce the support for such legacy devices via
+	 * ACPI_FADT_LEGACY_DEVICES field in FADT table.
+	 */
+	if (x86_pnpbios_disabled() && dmi_get_bios_year() >= 2017)
+		return -ENODEV;
+
 	register_syscore_ops(&i8237_syscore_ops);
 	return 0;
 }
diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index 235fe6008ac8..b348a672f71d 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -33,9 +33,14 @@ void __init x86_early_init_platform_quirks(void)
 		x86_platform.set_legacy_features();
 }
 
+bool __init x86_pnpbios_disabled(void)
+{
+	return x86_platform.legacy.devices.pnpbios == 0;
+}
+
 #if defined(CONFIG_PNPBIOS)
 bool __init arch_pnpbios_disabled(void)
 {
-	return x86_platform.legacy.devices.pnpbios == 0;
+	return x86_pnpbios_disabled();
 }
 #endif
