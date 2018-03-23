Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeCWRuT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:50:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:61817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752209AbeCWRqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:46:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="37596465"
Subject: [PATCH 02/11] x86/mm: undo double _PAGE_PSE clearing
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        aarcange@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        keescook@google.com, hughd@google.com, jgross@suse.com, x86@kernel.org,
        namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 23 Mar 2018 10:44:50 -0700
References: <20180323174447.55F35636@viggo.jf.intel.com>
In-Reply-To: <20180323174447.55F35636@viggo.jf.intel.com>
Message-Id: <20180323174450.C9B99634@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

When clearing _PAGE_PRESENT on a huge page, we need to be careful
to also clear _PAGE_PSE, otherwise it might still get confused
for a valid large page table entry.

We do that near the spot where we *set* _PAGE_PSE.  That's fine,
but it's unnecessary.  pgprot_large_2_4k() already did it.

BTW, I also noticed that pgprot_large_2_4k() and
pgprot_4k_2_large() are not symmetric.  pgprot_large_2_4k() clears
_PAGE_PSE (because it is aliased to _PAGE_PAT) but
pgprot_4k_2_large() does not put _PAGE_PSE back.  Bummer.

Also, add some comments and change "promote" to "move".  "Promote"
seems an odd word to move when we are logically moving a bit to a
lower bit position.  Also add an extra line return to make it clear
to which line the comment applies.

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

 b/arch/x86/mm/pageattr.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff -puN arch/x86/mm/pageattr.c~kpti-undo-double-_PAGE_PSE-clear arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~kpti-undo-double-_PAGE_PSE-clear	2018-03-21 16:31:56.803192321 -0700
+++ b/arch/x86/mm/pageattr.c	2018-03-21 16:31:56.806192321 -0700
@@ -583,6 +583,7 @@ try_preserve_large_page(pte_t *kpte, uns
 	 * up accordingly.
 	 */
 	old_pte = *kpte;
+	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
 	req_prot = pgprot_large_2_4k(old_prot);
 
 	pgprot_val(req_prot) &= ~pgprot_val(cpa->mask_clr);
@@ -597,8 +598,6 @@ try_preserve_large_page(pte_t *kpte, uns
 	req_prot = pgprot_clear_protnone_bits(req_prot);
         if (pgprot_val(req_prot) & _PAGE_PRESENT)
 		pgprot_val(req_prot) |= _PAGE_PSE;
-	else
-		pgprot_val(req_prot) &= ~_PAGE_PSE;
 	req_prot = canon_pgprot(req_prot);
 
 	/*
@@ -684,8 +683,12 @@ __split_large_page(struct cpa_data *cpa,
 	switch (level) {
 	case PG_LEVEL_2M:
 		ref_prot = pmd_pgprot(*(pmd_t *)kpte);
-		/* clear PSE and promote PAT bit to correct position */
+		/*
+		 * Clear PSE (aka _PAGE_PAT) and move
+		 * PAT bit to correct position.
+		 */
 		ref_prot = pgprot_large_2_4k(ref_prot);
+
 		ref_pfn = pmd_pfn(*(pmd_t *)kpte);
 		break;
 
_
