Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934881AbeBPLDC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:03:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:03:00 -0500
Date: Fri, 16 Feb 2018 02:52:31 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-b16e770bfa5344f1cd4f7b4ecd7bbae25001e120@git.kernel.org>
Cc: jpoimboe@redhat.com, mingo@kernel.org, dan.j.williams@intel.com,
        luto@kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, arjan@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com
Reply-To: hpa@zytor.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, luto@kernel.org, dwmw2@infradead.org,
        mingo@kernel.org, dan.j.williams@intel.com, jpoimboe@redhat.com
In-Reply-To: <20180214182542.69302-3-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Initialize 'pgdir_shift' and 'ptrs_per_p4d' at
 boot-time
Git-Commit-ID: b16e770bfa5344f1cd4f7b4ecd7bbae25001e120
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

Commit-ID:  b16e770bfa5344f1cd4f7b4ecd7bbae25001e120
Gitweb:     https://git.kernel.org/tip/b16e770bfa5344f1cd4f7b4ecd7bbae25001e120
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:35 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:47 +0100

x86/mm: Initialize 'pgdir_shift' and 'ptrs_per_p4d' at boot-time

Switching between paging modes requires the folding of the p4d page table level
when we only have 4 paging levels, which means we need to adjust 'pgdir_shift'
and 'ptrs_per_p4d' during early boot according to paging mode.

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
Link: http://lkml.kernel.org/r/20180214182542.69302-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c | 6 ++++--
 arch/x86/kernel/head64.c         | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d02a838..66e42a0 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -48,8 +48,8 @@
 
 #ifdef CONFIG_X86_5LEVEL
 unsigned int pgtable_l5_enabled __ro_after_init;
-unsigned int pgdir_shift __ro_after_init = 48;
-unsigned int ptrs_per_p4d __ro_after_init = 512;
+unsigned int pgdir_shift __ro_after_init = 39;
+unsigned int ptrs_per_p4d __ro_after_init = 1;
 #endif
 
 extern unsigned long get_cmd_line_ptr(void);
@@ -732,6 +732,8 @@ void choose_random_location(unsigned long input,
 #ifdef CONFIG_X86_5LEVEL
 	if (__read_cr4() & X86_CR4_LA57) {
 		pgtable_l5_enabled = 1;
+		pgdir_shift = 48;
+		ptrs_per_p4d = 512;
 	}
 #endif
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index ffb31c5..8a0a485 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -42,9 +42,9 @@ pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 #ifdef CONFIG_X86_5LEVEL
 unsigned int pgtable_l5_enabled __ro_after_init;
 EXPORT_SYMBOL(pgtable_l5_enabled);
-unsigned int pgdir_shift __ro_after_init = 48;
+unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
-unsigned int ptrs_per_p4d __ro_after_init = 512;
+unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
 #endif
 
@@ -79,6 +79,8 @@ static void __head check_la57_support(unsigned long physaddr)
 		return;
 
 	*fixup_int(&pgtable_l5_enabled, physaddr) = 1;
+	*fixup_int(&pgdir_shift, physaddr) = 48;
+	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
 }
 #else
 static void __head check_la57_support(unsigned long physaddr) {}
