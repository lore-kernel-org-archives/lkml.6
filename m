Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCIJNQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:13:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeCIJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:13:14 -0500
Date: Fri, 9 Mar 2018 01:12:51 -0800
From: tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-7e611e7dbb235938fca1dd359bad5e5f86ceabcb@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, will.deacon@arm.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, ard.biesheuvel@linaro.org,
        torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
        ard.biesheuvel@linaro.org, mingo@kernel.org, will.deacon@arm.com,
        matt@codeblueprint.co.uk
In-Reply-To: <20180308080020.22828-6-ard.biesheuvel@linaro.org>
References: <20180308080020.22828-6-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/arm64: Check whether x18 is preserved by runtime
 services calls
Git-Commit-ID: 7e611e7dbb235938fca1dd359bad5e5f86ceabcb
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

Commit-ID:  7e611e7dbb235938fca1dd359bad5e5f86ceabcb
Gitweb:     https://git.kernel.org/tip/7e611e7dbb235938fca1dd359bad5e5f86ceabcb
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 8 Mar 2018 08:00:13 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:58:22 +0100

efi/arm64: Check whether x18 is preserved by runtime services calls

Whether or not we will ever decide to start using x18 as a platform
register in Linux is uncertain, but by that time, we will need to
ensure that UEFI runtime services calls don't corrupt it.

So let's start issuing warnings now for this, and increase the
likelihood that these firmware images have all been replaced by that time.

This has been fixed on the EDK2 side in commit:

  6d73863b5464 ("BaseTools/tools_def AARCH64: mark register x18 as reserved")

dated July 13, 2017.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180308080020.22828-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/include/asm/efi.h       |  4 +++-
 arch/arm64/kernel/Makefile         |  3 ++-
 arch/arm64/kernel/efi-rt-wrapper.S | 41 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/efi.c            |  6 ++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 8389050328bb..192d791f1103 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -31,7 +31,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 ({									\
 	efi_##f##_t *__f;						\
 	__f = p->f;							\
-	__f(args);							\
+	__efi_rt_asm_wrapper(__f, #f, args);				\
 })
 
 #define arch_efi_call_virt_teardown()					\
@@ -40,6 +40,8 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 	efi_virtmap_unload();						\
 })
 
+efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
+
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
 /* arch specific definitions used by the stub code */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index b87541360f43..6a4bd80c75bd 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -38,7 +38,8 @@ arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
 arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
-arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
+arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o		\
+					   efi-rt-wrapper.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
new file mode 100644
index 000000000000..05235ebb336d
--- /dev/null
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+ENTRY(__efi_rt_asm_wrapper)
+	stp	x29, x30, [sp, #-32]!
+	mov	x29, sp
+
+	/*
+	 * Register x18 is designated as the 'platform' register by the AAPCS,
+	 * which means firmware running at the same exception level as the OS
+	 * (such as UEFI) should never touch it.
+	 */
+	stp	x1, x18, [sp, #16]
+
+	/*
+	 * We are lucky enough that no EFI runtime services take more than
+	 * 5 arguments, so all are passed in registers rather than via the
+	 * stack.
+	 */
+	mov	x8, x0
+	mov	x0, x2
+	mov	x1, x3
+	mov	x2, x4
+	mov	x3, x5
+	mov	x4, x6
+	blr	x8
+
+	ldp	x1, x2, [sp, #16]
+	cmp	x2, x18
+	ldp	x29, x30, [sp], #32
+	b.ne	0f
+	ret
+0:	b	efi_handle_corrupted_x18	// tail call
+ENDPROC(__efi_rt_asm_wrapper)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index a8bf1c892b90..4f9acb5fbe97 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -126,3 +126,9 @@ bool efi_poweroff_required(void)
 {
 	return efi_enabled(EFI_RUNTIME_SERVICES);
 }
+
+asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
+{
+	pr_err_ratelimited(FW_BUG "register x18 corrupted by EFI %s\n", f);
+	return s;
+}
