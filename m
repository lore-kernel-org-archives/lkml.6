Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeC2PIU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:08:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:54487 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeC2PIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:08:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="41807443"
From: Anshuman Gupta <anshuman.gupta@intel.com>
To: tglx@linutronix.de
Cc: x86@kernel.org, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
        andriy.shevchenko@linux.intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com,
        anshuman.gupta@intel.com
Subject: [PATCH v4] x86: i8237: Register based on FADT legacy boot flag
Date: Thu, 29 Mar 2018 20:36:55 +0530
Message-Id: <1522336015-22994-1-git-send-email-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <alpine.DEB.2.21.1803261110430.1585@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803261110430.1585@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>

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
https://github.com/coreboot/coreboot/blob/05132707ca1e13a11cd13c77326bc65011b09feb/src/soc/intel/skylake/acpi.c#L271

Please refer to chapter 21 of 6th Generation Intel® Core™ Processor
Platform Controller Hub Family: BIOS Specification.

https://www.intel.in/content/www/in/en/embedded/products/skylake/u-mobile/software-and-drivers.html

Cc: Alan Cox <alan@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
---
    Changes in v4:
     * Modified the commit message about cut-off date year 2017.
    
    Changes in v3:
     * Added x86_pnpbios_disabled and using it instead of pnpbios.
     * Modified the commit message.
    
    Changes in v2:
     * changed to dma_inb()
---
 arch/x86/include/asm/x86_init.h   |  1 +
 arch/x86/kernel/i8237.c           | 25 +++++++++++++++++++++++++
 arch/x86/kernel/platform-quirks.c |  7 ++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index fc2f082..b6ceac0 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -286,6 +286,7 @@ extern struct x86_msi_ops x86_msi;
 extern struct x86_io_apic_ops x86_io_apic_ops;
 
 extern void x86_early_init_platform_quirks(void);
+extern bool x86_pnpbios_disabled(void);
 extern void x86_init_noop(void);
 extern void x86_init_uint_noop(unsigned int unused);
 
diff --git a/arch/x86/kernel/i8237.c b/arch/x86/kernel/i8237.c
index 8eeaa81..0a3e70f 100644
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
index 235fe60..b348a67 100644
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
-- 
2.7.4
