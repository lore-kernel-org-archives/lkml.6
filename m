Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeBZIsM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:48:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35917 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeBZIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:48:06 -0500
Date: Mon, 26 Feb 2018 00:46:37 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-038bac2b02989acf1fc938cedcb7944c02672b9f@git.kernel.org>
Cc: rafael.j.wysocki@intel.com, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bp@alien8.de,
        ebiederm@xmission.com, mingo@kernel.org, keescook@chromium.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, torvalds@linux-foundation.org, jgross@suse.com
Reply-To: hpa@zytor.com, ebiederm@xmission.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        rafael.j.wysocki@intel.com, keescook@chromium.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de, jgross@suse.com,
        torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20180219100906.14265-3-jgross@suse.com>
References: <20180219100906.14265-3-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/acpi: Add a new x86_init_acpi structure to
 x86_init_ops
Git-Commit-ID: 038bac2b02989acf1fc938cedcb7944c02672b9f
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

Commit-ID:  038bac2b02989acf1fc938cedcb7944c02672b9f
Gitweb:     https://git.kernel.org/tip/038bac2b02989acf1fc938cedcb7944c02672b9f
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 19 Feb 2018 11:09:05 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 26 Feb 2018 08:43:20 +0100

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
index 11881726ed37..6609dd7289b5 100644
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
index fc2f082ac635..2e2c34d2bb00 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -130,6 +130,14 @@ struct x86_hyper_init {
 	void (*init_mem_mapping)(void);
 };
 
+/**
+ * struct x86_init_acpi - x86 ACPI init functions
+ * @get_root_pointer:		get RSDP address
+ */
+struct x86_init_acpi {
+	u64 (*get_root_pointer)(void);
+};
+
 /**
  * struct x86_init_ops - functions for platform specific setup
  *
@@ -144,6 +152,7 @@ struct x86_init_ops {
 	struct x86_init_iommu		iommu;
 	struct x86_init_pci		pci;
 	struct x86_hyper_init		hyper;
+	struct x86_init_acpi		acpi;
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1151ccd72ce9..9e4e994a4836 100644
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
