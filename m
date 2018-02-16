Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934909AbeBPLDd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:03:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:03:31 -0500
Date: Fri, 16 Feb 2018 02:51:59 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-4c2b4058ab32581931c2caf760b689fd4b019a87@git.kernel.org>
Cc: dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com,
        luto@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, bp@suse.de, peterz@infradead.org,
        dan.j.williams@intel.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@kernel.org
Reply-To: luto@kernel.org, arjan@linux.intel.com, dwmw2@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        dan.j.williams@intel.com, peterz@infradead.org, bp@suse.de,
        mingo@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com
In-Reply-To: <20180214182542.69302-2-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Initialize 'pgtable_l5_enabled' at boot-time
Git-Commit-ID: 4c2b4058ab32581931c2caf760b689fd4b019a87
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

Commit-ID:  4c2b4058ab32581931c2caf760b689fd4b019a87
Gitweb:     https://git.kernel.org/tip/4c2b4058ab32581931c2caf760b689fd4b019a87
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:34 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:46 +0100

x86/mm: Initialize 'pgtable_l5_enabled' at boot-time

'pgtable_l5_enabled' indicates which paging mode we are using. We need to
initialize it at boot-time according to machine capability.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214182542.69302-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c |  8 +++++++-
 arch/x86/kernel/head64.c         | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b18e8f9..d02a838 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -47,7 +47,7 @@
 #include <linux/decompress/mm.h>
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int pgtable_l5_enabled __ro_after_init = 1;
+unsigned int pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 48;
 unsigned int ptrs_per_p4d __ro_after_init = 512;
 #endif
@@ -729,6 +729,12 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+#ifdef CONFIG_X86_5LEVEL
+	if (__read_cr4() & X86_CR4_LA57) {
+		pgtable_l5_enabled = 1;
+	}
+#endif
+
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	/* Prepare to add new identity pagetables on demand. */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 98b0ff4..ffb31c5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -40,7 +40,7 @@ static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int pgtable_l5_enabled __ro_after_init = 1;
+unsigned int pgtable_l5_enabled __ro_after_init;
 EXPORT_SYMBOL(pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 48;
 EXPORT_SYMBOL(pgdir_shift);
@@ -64,6 +64,26 @@ static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 	return ptr - (void *)_text + (void *)physaddr;
 }
 
+#ifdef CONFIG_X86_5LEVEL
+static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
+{
+	return fixup_pointer(ptr, physaddr);
+}
+
+static void __head check_la57_support(unsigned long physaddr)
+{
+	if (native_cpuid_eax(0) < 7)
+		return;
+
+	if (!(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		return;
+
+	*fixup_int(&pgtable_l5_enabled, physaddr) = 1;
+}
+#else
+static void __head check_la57_support(unsigned long physaddr) {}
+#endif
+
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
@@ -76,6 +96,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	int i;
 	unsigned int *next_pgt_ptr;
 
+	check_la57_support(physaddr);
+
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
 		for (;;);
