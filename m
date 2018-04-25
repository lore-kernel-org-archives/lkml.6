Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDYJKT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:10:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDYJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:10:16 -0400
Date: Wed, 25 Apr 2018 02:09:13 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-316d097c4cd4e7f2ef50c40cff2db266593c4ec4@git.kernel.org>
Cc: torvalds@linux-foundation.org, keescook@google.com, mingo@kernel.org,
        namit@vmware.com, dave.hansen@linux.intel.com, bp@alien8.de,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com, hpa@zytor.com,
        peterz@infradead.org, dwmw2@infradead.org, aarcange@redhat.com,
        jpoimboe@redhat.com, luto@kernel.org, jgross@suse.com,
        arjan@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com, hughd@google.com
Reply-To: namit@vmware.com, mingo@kernel.org, keescook@google.com,
        torvalds@linux-foundation.org, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, aarcange@redhat.com, jpoimboe@redhat.com,
        peterz@infradead.org, hpa@zytor.com, luto@kernel.org, jgross@suse.com,
        tglx@linutronix.de, arjan@linux.intel.com, fengguang.wu@intel.com,
        hughd@google.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180420222028.99D72858@viggo.jf.intel.com>
References: <20180420222028.99D72858@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Filter at vma->vm_page_prot population
Git-Commit-ID: 316d097c4cd4e7f2ef50c40cff2db266593c4ec4
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

Commit-ID:  316d097c4cd4e7f2ef50c40cff2db266593c4ec4
Gitweb:     https://git.kernel.org/tip/316d097c4cd4e7f2ef50c40cff2db266593c4ec4
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:20:28 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 25 Apr 2018 11:02:51 +0200

x86/pti: Filter at vma->vm_page_prot population

commit ce9962bf7e22bb3891655c349faff618922d4a73

0day reported warnings at boot on 32-bit systems without NX support:

attempted to set unsupported pgprot: 8000000000000025 bits: 8000000000000000 supported: 7fffffffffffffff
WARNING: CPU: 0 PID: 1 at
arch/x86/include/asm/pgtable.h:540 handle_mm_fault+0xfc1/0xfe0:
 check_pgprot at arch/x86/include/asm/pgtable.h:535
 (inlined by) pfn_pte at arch/x86/include/asm/pgtable.h:549
 (inlined by) do_anonymous_page at mm/memory.c:3169
 (inlined by) handle_pte_fault at mm/memory.c:3961
 (inlined by) __handle_mm_fault at mm/memory.c:4087
 (inlined by) handle_mm_fault at mm/memory.c:4124

The problem is that due to the recent commit which removed auto-massaging
of page protections, filtering page permissions at PTE creation time is not
longer done, so vma->vm_page_prot is passed unfiltered to PTE creation.

Filter the page protections before they are installed in vma->vm_page_prot.

Fixes: fb43d6cb91 ("x86/mm: Do not auto-massage page protections")
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Link: https://lkml.kernel.org/r/20180420222028.99D72858@viggo.jf.intel.com


---
 arch/x86/Kconfig               |  4 ++++
 arch/x86/include/asm/pgtable.h |  5 +++++
 mm/mmap.c                      | 11 ++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 00fcf81f2c56..c07f492b871a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -52,6 +52,7 @@ config X86
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
+	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
@@ -273,6 +274,9 @@ config ARCH_HAS_CPU_RELAX
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_HAS_FILTER_PGPROT
+	def_bool y
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5f49b4ff0c24..f1633de5a675 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -601,6 +601,11 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 
 #define canon_pgprot(p) __pgprot(massage_pgprot(p))
 
+static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
+{
+	return canon_pgprot(prot);
+}
+
 static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 					 enum page_cache_mode pcm,
 					 enum page_cache_mode new_pcm)
diff --git a/mm/mmap.c b/mm/mmap.c
index 188f195883b9..9d5968d1e8e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -100,11 +100,20 @@ pgprot_t protection_map[16] __ro_after_init = {
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
+#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
+static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
+{
+	return prot;
+}
+#endif
+
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	return __pgprot(pgprot_val(protection_map[vm_flags &
+	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
 				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
+
+	return arch_filter_pgprot(ret);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 
