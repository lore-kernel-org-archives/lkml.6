Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbeDDBNo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 21:13:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:41790 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754985AbeDDBMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 21:12:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,403,1517904000";
   d="scan'208";a="39177868"
Subject: [PATCH 09/11] x86/pti: enable global pages for shared areas
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        aarcange@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        keescook@google.com, hughd@google.com, jgross@suse.com, x86@kernel.org,
        namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 03 Apr 2018 18:10:07 -0700
References: <20180404010946.6186729B@viggo.jf.intel.com>
In-Reply-To: <20180404010946.6186729B@viggo.jf.intel.com>
Message-Id: <20180404011007.A381CC8A@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The entry/exit text and cpu_entry_area are mapped into userspace and
the kernel.  But, they are not _PAGE_GLOBAL.  This creates unnecessary
TLB misses.

Add the _PAGE_GLOBAL flag for these areas.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: Nadav Amit <namit@vmware.com>
---

 b/arch/x86/mm/cpu_entry_area.c |   10 +++++++++-
 b/arch/x86/mm/pti.c            |   14 +++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff -puN arch/x86/mm/cpu_entry_area.c~kpti-why-no-global arch/x86/mm/cpu_entry_area.c
--- a/arch/x86/mm/cpu_entry_area.c~kpti-why-no-global	2018-04-02 16:41:17.157605167 -0700
+++ b/arch/x86/mm/cpu_entry_area.c	2018-04-02 16:41:17.162605167 -0700
@@ -27,8 +27,16 @@ EXPORT_SYMBOL(get_cpu_entry_area);
 void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 {
 	unsigned long va = (unsigned long) cea_vaddr;
+	pte_t pte = pfn_pte(pa >> PAGE_SHIFT, flags);
 
-	set_pte_vaddr(va, pfn_pte(pa >> PAGE_SHIFT, flags));
+	/*
+	 * The cpu_entry_area is shared between the user and kernel
+	 * page tables.  All of its ptes can safely be global.
+	 */
+	if (boot_cpu_has(X86_FEATURE_PGE))
+		pte = pte_set_flags(pte, _PAGE_GLOBAL);
+
+	set_pte_vaddr(va, pte);
 }
 
 static void __init
diff -puN arch/x86/mm/pti.c~kpti-why-no-global arch/x86/mm/pti.c
--- a/arch/x86/mm/pti.c~kpti-why-no-global	2018-04-02 16:41:17.159605167 -0700
+++ b/arch/x86/mm/pti.c	2018-04-02 16:41:17.163605167 -0700
@@ -300,6 +300,18 @@ pti_clone_pmds(unsigned long start, unsi
 			return;
 
 		/*
+		 * Setting 'target_pmd' below creates a mapping in both
+		 * the user and kernel page tables.  It is effectively
+		 * global, so set it as global in both copies.  Note:
+		 * the X86_FEATURE_PGE check is not _required_ because
+		 * the CPU ignores _PAGE_GLOBAL when PGE is not
+		 * supported.  The check keeps consistentency with
+		 * code that only set this bit when supported.
+		 */
+		if (boot_cpu_has(X86_FEATURE_PGE))
+			*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
+
+		/*
 		 * Copy the PMD.  That is, the kernelmode and usermode
 		 * tables will share the last-level page tables of this
 		 * address range
@@ -348,7 +360,7 @@ static void __init pti_clone_entry_text(
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
 			(unsigned long) __irqentry_text_end,
-		       _PAGE_RW | _PAGE_GLOBAL);
+		       _PAGE_RW);
 }
 
 /*
_
