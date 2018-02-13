Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966110AbeBMXXv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:23:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:43789 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966082AbeBMXXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:23:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="19785199"
Subject: [PATCH 1/3] x86/mm: factor out conditional pageattr PTE bit setting code
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 13 Feb 2018 15:19:28 -0800
References: <20180213231927.32581D84@viggo.jf.intel.com>
In-Reply-To: <20180213231927.32581D84@viggo.jf.intel.com>
Message-Id: <20180213231928.4DC10279@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The pageattr code has a pattern repeated where it sets a PTE bit
for present PTEs but clears it for non-present PTEs.  This helps
to keep pte_none() from getting messed up.  _PAGE_GLOBAL is the
most frequent target of this pattern.

This pattern also includes a nice, copy-and-pasted comment.

I want to do some special stuff with _PAGE_GLOBAL in a moment,
so refactor this a _bit_ to centralize the comment and the
bit operations.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
---

 b/arch/x86/mm/pageattr.c |   65 ++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 45 deletions(-)

diff -puN arch/x86/mm/pageattr.c~kpti-centralize-global-setting arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~kpti-centralize-global-setting	2018-02-13 15:17:55.602210062 -0800
+++ b/arch/x86/mm/pageattr.c	2018-02-13 15:17:55.606210062 -0800
@@ -512,6 +512,22 @@ static void __set_pmd_pte(pte_t *kpte, u
 #endif
 }
 
+static pgprot_t pgprot_set_on_present(pgprot_t prot, pteval_t flags)
+{
+	/*
+	 * Set 'flags' only if PRESENT.  Ensures that we do not
+	 * set flags in an otherwise empty PTE breaking pte_none().
+	 * A later function (such as canon_pgprot()) must clear
+	 * possibly unsupported flags (like _PAGE_GLOBAL).
+	 */
+	if (pgprot_val(prot) & _PAGE_PRESENT)
+		pgprot_val(prot) |= flags;
+	else
+		pgprot_val(prot) &= ~flags;
+
+	return prot;
+}
+
 static int
 try_preserve_large_page(pte_t *kpte, unsigned long address,
 			struct cpa_data *cpa)
@@ -577,18 +593,7 @@ try_preserve_large_page(pte_t *kpte, uns
 	 * different bit positions in the two formats.
 	 */
 	req_prot = pgprot_4k_2_large(req_prot);
-
-	/*
-	 * Set the PSE and GLOBAL flags only if the PRESENT flag is
-	 * set otherwise pmd_present/pmd_huge will return true even on
-	 * a non present pmd. The canon_pgprot will clear _PAGE_GLOBAL
-	 * for the ancient hardware that doesn't support it.
-	 */
-	if (pgprot_val(req_prot) & _PAGE_PRESENT)
-		pgprot_val(req_prot) |= _PAGE_PSE | _PAGE_GLOBAL;
-	else
-		pgprot_val(req_prot) &= ~(_PAGE_PSE | _PAGE_GLOBAL);
-
+	req_prot = pgprot_set_on_present(req_prot, _PAGE_GLOBAL | _PAGE_PSE);
 	req_prot = canon_pgprot(req_prot);
 
 	/*
@@ -698,16 +703,7 @@ __split_large_page(struct cpa_data *cpa,
 		return 1;
 	}
 
-	/*
-	 * Set the GLOBAL flags only if the PRESENT flag is set
-	 * otherwise pmd/pte_present will return true even on a non
-	 * present pmd/pte. The canon_pgprot will clear _PAGE_GLOBAL
-	 * for the ancient hardware that doesn't support it.
-	 */
-	if (pgprot_val(ref_prot) & _PAGE_PRESENT)
-		pgprot_val(ref_prot) |= _PAGE_GLOBAL;
-	else
-		pgprot_val(ref_prot) &= ~_PAGE_GLOBAL;
+	ref_prot = pgprot_set_on_present(ref_prot, _PAGE_GLOBAL);
 
 	/*
 	 * Get the target pfn from the original entry:
@@ -930,18 +926,7 @@ static void populate_pte(struct cpa_data
 
 	pte = pte_offset_kernel(pmd, start);
 
-	/*
-	 * Set the GLOBAL flags only if the PRESENT flag is
-	 * set otherwise pte_present will return true even on
-	 * a non present pte. The canon_pgprot will clear
-	 * _PAGE_GLOBAL for the ancient hardware that doesn't
-	 * support it.
-	 */
-	if (pgprot_val(pgprot) & _PAGE_PRESENT)
-		pgprot_val(pgprot) |= _PAGE_GLOBAL;
-	else
-		pgprot_val(pgprot) &= ~_PAGE_GLOBAL;
-
+	pgprot = pgprot_set_on_present(pgprot, _PAGE_GLOBAL);
 	pgprot = canon_pgprot(pgprot);
 
 	while (num_pages-- && start < end) {
@@ -1234,17 +1219,7 @@ repeat:
 
 		new_prot = static_protections(new_prot, address, pfn);
 
-		/*
-		 * Set the GLOBAL flags only if the PRESENT flag is
-		 * set otherwise pte_present will return true even on
-		 * a non present pte. The canon_pgprot will clear
-		 * _PAGE_GLOBAL for the ancient hardware that doesn't
-		 * support it.
-		 */
-		if (pgprot_val(new_prot) & _PAGE_PRESENT)
-			pgprot_val(new_prot) |= _PAGE_GLOBAL;
-		else
-			pgprot_val(new_prot) &= ~_PAGE_GLOBAL;
+		new_prot = pgprot_set_on_present(new_prot, _PAGE_GLOBAL);
 
 		/*
 		 * We need to keep the pfn from the existing PTE,
_
