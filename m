Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbeCLM1M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:27:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeCLM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:27:03 -0400
Date: Mon, 12 Mar 2018 05:25:41 -0700
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-50beba07a0e42ebd4454adc97515a2a2a969645b@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, jgross@suse.com, tglx@linutronix.de,
        rafael.j.wysocki@intel.com, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, andriy.shevchenko@linux.intel.com,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com, jgross@suse.com,
        rafael.j.wysocki@intel.com, tglx@linutronix.de
In-Reply-To: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] ACPI, x86/boot: Split out
 acpi_generic_reduce_hw_init() and export
Git-Commit-ID: 50beba07a0e42ebd4454adc97515a2a2a969645b
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

Commit-ID:  50beba07a0e42ebd4454adc97515a2a2a969645b
Gitweb:     https://git.kernel.org/tip/50beba07a0e42ebd4454adc97515a2a2a969645b
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Tue, 20 Feb 2018 20:05:04 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:32:57 +0100

ACPI, x86/boot: Split out acpi_generic_reduce_hw_init() and export

This is a preparation patch to allow override the hardware reduced
initialization on ACPI enabled platforms.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180220180506.65523-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
