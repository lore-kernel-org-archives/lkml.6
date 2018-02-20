Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeBTSFN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:05:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:65009 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeBTSFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:05:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="scan'208";a="19169771"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/3] ACPI / x86: boot: Split out acpi_generic_reduce_hw_init() and export
Date: Tue, 20 Feb 2018 20:05:04 +0200
Message-Id: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch to allow override the hardware reduced
initialization on ACPI enabled platforms.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/acpi.h |  4 ++++
 arch/x86/kernel/acpi/boot.c | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 6609dd7289b5..a303d7b7d763 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -140,6 +140,8 @@ static inline u64 acpi_arch_get_root_pointer(void)
 	return x86_init.acpi.get_root_pointer();
 }
 
+void acpi_generic_reduced_hw_init(void);
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
@@ -149,6 +151,8 @@ static inline void acpi_noirq_set(void) { }
 static inline void acpi_disable_pci(void) { }
 static inline void disable_acpi(void) { }
 
+static inline void acpi_generic_reduced_hw_init(void) { }
+
 #endif /* !CONFIG_ACPI */
 
 #define ARCH_HAS_POWER_INIT	1
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2aa92094b59d..baa084ecffdb 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1376,17 +1376,21 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
  *
  * We initialize the Hardware-reduced ACPI model here:
  */
+void __init acpi_generic_reduced_hw_init(void)
+{
+	/*
+	 * Override x86_init functions and bypass legacy PIC in
+	 * hardware reduced ACPI mode.
+	 */
+	x86_init.timers.timer_init	= x86_init_noop;
+	x86_init.irqs.pre_vector_init	= x86_init_noop;
+	legacy_pic			= &null_legacy_pic;
+}
+
 static void __init acpi_reduced_hw_init(void)
 {
-	if (acpi_gbl_reduced_hardware) {
-		/*
-		 * Override x86_init functions and bypass legacy pic
-		 * in Hardware-reduced ACPI mode
-		 */
-		x86_init.timers.timer_init	= x86_init_noop;
-		x86_init.irqs.pre_vector_init	= x86_init_noop;
-		legacy_pic			= &null_legacy_pic;
-	}
+	if (acpi_gbl_reduced_hardware)
+		acpi_generic_reduced_hw_init();
 }
 
 /*
-- 
2.15.1
