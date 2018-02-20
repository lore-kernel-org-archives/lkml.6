Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeBTKfz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:35:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41159 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeBTKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:35:54 -0500
Date: Tue, 20 Feb 2018 02:24:40 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-62d8b7fba8d3ba9c046b7a1a95946c6aaf7c5da9@git.kernel.org>
Cc: keescook@chromium.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, rafael.j.wysocki@intel.com,
        kirill.shutemov@linux.intel.com, andy.shevchenko@gmail.com,
        jgross@suse.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        hpa@zytor.com, ebiederm@xmission.com, mingo@kernel.org,
        peterz@infradead.org
Reply-To: kirill.shutemov@linux.intel.com, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, keescook@chromium.org,
        torvalds@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        ebiederm@xmission.com, mingo@kernel.org, hpa@zytor.com,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        jgross@suse.com
In-Reply-To: <20180219100906.14265-3-jgross@suse.com>
References: <20180219100906.14265-3-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/acpi: Add a new x86_init_acpi structure to
 x86_init_ops
Git-Commit-ID: 62d8b7fba8d3ba9c046b7a1a95946c6aaf7c5da9
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

Commit-ID:  62d8b7fba8d3ba9c046b7a1a95946c6aaf7c5da9
Gitweb:     https://git.kernel.org/tip/62d8b7fba8d3ba9c046b7a1a95946c6aaf7c5da9
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 19 Feb 2018 11:09:05 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:00:56 +0100

x86/acpi: Add a new x86_init_acpi structure to x86_init_ops

Add a new struct x86_init_acpi to x86_init_ops. For now it contains
only one init function to get the RSDP table address.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: boris.ostrovsky@oracle.com
Cc: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/20180219100906.14265-3-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/acpi.h     | 7 +++++++
 arch/x86/include/asm/x86_init.h | 9 +++++++++
 arch/x86/kernel/x86_init.c      | 5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 1188172..6609dd7 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -31,6 +31,7 @@
 #include <asm/mmu.h>
 #include <asm/mpspec.h>
 #include <asm/realmode.h>
+#include <asm/x86_init.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -133,6 +134,12 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return !!acpi_lapic;
 }
 
+#define ACPI_HAVE_ARCH_GET_ROOT_POINTER
+static inline u64 acpi_arch_get_root_pointer(void)
+{
+	return x86_init.acpi.get_root_pointer();
+}
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index fc2f082..2e2c34d 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -131,6 +131,14 @@ struct x86_hyper_init {
 };
 
 /**
+ * struct x86_init_acpi - x86 ACPI init functions
+ * @get_root_pointer:		get RSDP address
+ */
+struct x86_init_acpi {
+	u64 (*get_root_pointer)(void);
+};
+
+/**
  * struct x86_init_ops - functions for platform specific setup
  *
  */
@@ -144,6 +152,7 @@ struct x86_init_ops {
 	struct x86_init_iommu		iommu;
 	struct x86_init_pci		pci;
 	struct x86_hyper_init		hyper;
+	struct x86_init_acpi		acpi;
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1151ccd..9e4e994 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -30,6 +30,7 @@ int __init iommu_init_noop(void) { return 0; }
 void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
+u64 u64_x86_init_noop(void) { return 0; }
 
 /*
  * The platform setup functions are preset with the default functions
@@ -91,6 +92,10 @@ struct x86_init_ops x86_init __initdata = {
 		.x2apic_available	= bool_x86_init_noop,
 		.init_mem_mapping	= x86_init_noop,
 	},
+
+	.acpi = {
+		.get_root_pointer	= u64_x86_init_noop,
+	},
 };
 
 struct x86_cpuinit_ops x86_cpuinit = {
