Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeCLJbp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:31:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeCLJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:31:44 -0400
Date: Mon, 12 Mar 2018 02:31:01 -0700
From: tip-bot for Sai Praneeth <tipbot@zytor.com>
Message-ID: <tip-7e904a91bf6049071ef9d605a52f863ae774081d@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, luto@kernel.org,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com, ricardo.neri@intel.com,
        ravi.v.shankar@intel.com, bp@alien8.de, matt@codeblueprint.co.uk,
        mingo@kernel.org, mst@redhat.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, jlee@suse.com,
        sai.praneeth.prakhya@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: ricardo.neri@intel.com, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, luto@kernel.org, ravi.v.shankar@intel.com,
        bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, jlee@suse.com,
        torvalds@linux-foundation.org, tony.luck@intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        sai.praneeth.prakhya@intel.com, matt@codeblueprint.co.uk,
        mingo@kernel.org, mst@redhat.com
In-Reply-To: <20180312084500.10764-2-ard.biesheuvel@linaro.org>
References: <20180312084500.10764-2-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Use efi_mm in x86 as well as ARM
Git-Commit-ID: 7e904a91bf6049071ef9d605a52f863ae774081d
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

Commit-ID:  7e904a91bf6049071ef9d605a52f863ae774081d
Gitweb:     https://git.kernel.org/tip/7e904a91bf6049071ef9d605a52f863ae774081d
Author:     Sai Praneeth <sai.praneeth.prakhya@intel.com>
AuthorDate: Mon, 12 Mar 2018 08:44:56 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 10:05:01 +0100

efi: Use efi_mm in x86 as well as ARM

Presently, only ARM uses mm_struct to manage EFI page tables and EFI
runtime region mappings. As this is the preferred approach, let's make
this data structure common across architectures. Specially, for x86,
using this data structure improves code maintainability and readability.

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
[ardb: don't #include the world to get a declaration of struct mm_struct]
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180312084500.10764-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/efi.h         | 1 +
 arch/x86/platform/efi/efi_64.c     | 3 +++
 drivers/firmware/efi/arm-runtime.c | 9 ---------
 drivers/firmware/efi/efi.c         | 9 +++++++++
 include/linux/efi.h                | 2 ++
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index a399c1ebf6f0..c62443fa7d0a 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -7,6 +7,7 @@
 #include <asm/processor-flags.h>
 #include <asm/tlb.h>
 #include <asm/nospec-branch.h>
+#include <asm/mmu_context.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 780460aa5ea5..29425b6c98a7 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -233,6 +233,9 @@ int __init efi_alloc_page_tables(void)
 		return -ENOMEM;
 	}
 
+	mm_init_cpumask(&efi_mm);
+	init_new_context(NULL, &efi_mm);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 13561aeb7396..5889cbea60b8 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -31,15 +31,6 @@
 
 extern u64 efi_system_table;
 
-static struct mm_struct efi_mm = {
-	.mm_rb			= RB_ROOT,
-	.mm_users		= ATOMIC_INIT(2),
-	.mm_count		= ATOMIC_INIT(1),
-	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
-	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
-	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
-};
-
 #ifdef CONFIG_ARM64_PTDUMP_DEBUGFS
 #include <asm/ptdump.h>
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 92b9e79e5da9..232f4915223b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -75,6 +75,15 @@ static unsigned long *efi_tables[] = {
 	&efi.mem_attr_table,
 };
 
+struct mm_struct efi_mm = {
+	.mm_rb			= RB_ROOT,
+	.mm_users		= ATOMIC_INIT(2),
+	.mm_count		= ATOMIC_INIT(1),
+	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
+	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
+	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
+};
+
 static bool disable_runtime;
 static int __init setup_noefi(char *arg)
 {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f5083aa72eae..f1b7d68ac460 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -966,6 +966,8 @@ extern struct efi {
 	unsigned long flags;
 } efi;
 
+extern struct mm_struct efi_mm;
+
 static inline int
 efi_guidcmp (efi_guid_t left, efi_guid_t right)
 {
