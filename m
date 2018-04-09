Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+Aj9DHLqJ0NrCtJhveL7ddhkcJz8TOIuQpncpV4uybgTgk6j4ef7miwFJrCWqJDBe45XUk
ARC-Seal: i=1; a=rsa-sha256; t=1523293970; cv=none;
        d=google.com; s=arc-20160816;
        b=qFHq+L4nW7337hjw89fc/xS09tlzJyqiZ7kCCrewfBA1yDf8MPiJp8PHeQ0g8SE2ry
         C6LTYxbkzKwoip20iT1jXQmq3fc2i/IdKe/cqMvzkrQmGT+6k/XyfyK1aC59tGXI7d8p
         cfejaQGpp6odOBQQOodDrbyfQ2ps+OLfVzq9dfzMlnfnJxjJmIFb0FuePyDFXXts5D2H
         +K4FqfDvZThmVj57efp/uMKFhhOOHS2QeLbgGffzDBviuTJrlCyVxK9wVwHsnu4Gpg6K
         OMxT1sl5BZsFTEjru0MMNR56PcM0zc6dMwlTBRJ932FWwi6heBEpPIuLUJV1c2xxAsyA
         biDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=Z8EZzMhd1xwJjtOb/rSy8no4mZZYDuX8PaxOI19Nx7w=;
        b=T6PDnAYgl7VPk+ZmpKQBx1/fDa2Gk/JtbjTYCRiiufBAbdpoSo4pPDpq+TKfLapxd6
         5X2hF1WtWdJWVDCxO8E7jeUlp4WmZ8sOCT8X/CH51Mg4bDKMee5WePottixs2AWFmBb0
         WW6EhdlemrwO0FbXBafbvALTM9vUuxuXa6oRth4CqoMfjawW+JyDgWwUI4XnFO1xQMuF
         rmkS39nRSWP78wBOcf6uTeVmO7hgdLtG+O/g8hFu5245sKe8W7sn65/pxzqUDSwEX4GA
         MTRyuniKzHi7zLEcU7o1yW4tc5tOyMK4HJdapFh10HYMR0uRmq+bRBn7gPj3d1NNanFe
         gaTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:11:54 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-d1440b23c922d845ff039f64694a32ff356e89fa@git.kernel.org>
Cc: jpoimboe@redhat.com, bp@alien8.de, luto@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        arjan@linux.intel.com, dan.j.williams@intel.com, jgross@suse.com,
        dave.hansen@linux.intel.com, dwmw2@infradead.org, aarcange@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, namit@vmware.com,
        peterz@infradead.org, keescook@google.com,
        linux-kernel@vger.kernel.org, hughd@google.com
Reply-To: jgross@suse.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, bp@alien8.de, luto@kernel.org,
        jpoimboe@redhat.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, arjan@linux.intel.com,
        peterz@infradead.org, keescook@google.com, hughd@google.com,
        linux-kernel@vger.kernel.org, aarcange@redhat.com, dwmw2@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, namit@vmware.com, hpa@zytor.com
In-Reply-To: <20180406205502.86E199DA@viggo.jf.intel.com>
References: <20180406205502.86E199DA@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Factor out pageattr _PAGE_GLOBAL setting
Git-Commit-ID: d1440b23c922d845ff039f64694a32ff356e89fa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289498214171150?=
X-GMAIL-MSGID: =?utf-8?q?1597289498214171150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  d1440b23c922d845ff039f64694a32ff356e89fa
Gitweb:     https://git.kernel.org/tip/d1440b23c922d845ff039f64694a32ff356e89fa
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:02 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:32 +0200

x86/mm: Factor out pageattr _PAGE_GLOBAL setting

The pageattr code has a pattern repeated where it sets _PAGE_GLOBAL
for present PTEs but clears it for non-present PTEs.  The intention
is to keep _PAGE_GLOBAL from getting confused with _PAGE_PROTNONE
since _PAGE_GLOBAL is for present PTEs and _PAGE_PROTNONE is for
non-present

But, this pattern makes no sense.  Effectively, it says, if you use
the pageattr code, always set _PAGE_GLOBAL when _PAGE_PRESENT.
canon_pgprot() will clear it if unsupported (because it masks the
value with __supported_pte_mask) but we *always* set it. Even if
canon_pgprot() did not filter _PAGE_GLOBAL, it would be OK.
_PAGE_GLOBAL is ignored when CR4.PGE=0 by the hardware.

This unconditional setting of _PAGE_GLOBAL is a problem when we have
PTI and non-PTI and we want some areas to have _PAGE_GLOBAL and some
not.

This updated version of the code says:
1. Clear _PAGE_GLOBAL when !_PAGE_PRESENT
2. Never set _PAGE_GLOBAL implicitly
3. Allow _PAGE_GLOBAL to be in cpa.set_mask
4. Allow _PAGE_GLOBAL to be inherited from previous PTE

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180406205502.86E199DA@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 66 ++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 43 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 85cf12219dea..4d369d5c04c5 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -512,6 +512,23 @@ static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
 #endif
 }
 
+static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
+{
+	/*
+	 * _PAGE_GLOBAL means "global page" for present PTEs.
+	 * But, it is also used to indicate _PAGE_PROTNONE
+	 * for non-present PTEs.
+	 *
+	 * This ensures that a _PAGE_GLOBAL PTE going from
+	 * present to non-present is not confused as
+	 * _PAGE_PROTNONE.
+	 */
+	if (!(pgprot_val(prot) & _PAGE_PRESENT))
+		pgprot_val(prot) &= ~_PAGE_GLOBAL;
+
+	return prot;
+}
+
 static int
 try_preserve_large_page(pte_t *kpte, unsigned long address,
 			struct cpa_data *cpa)
@@ -577,18 +594,11 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
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
+	req_prot = pgprot_clear_protnone_bits(req_prot);
 	if (pgprot_val(req_prot) & _PAGE_PRESENT)
-		pgprot_val(req_prot) |= _PAGE_PSE | _PAGE_GLOBAL;
+		pgprot_val(req_prot) |= _PAGE_PSE;
 	else
-		pgprot_val(req_prot) &= ~(_PAGE_PSE | _PAGE_GLOBAL);
-
+		pgprot_val(req_prot) &= ~_PAGE_PSE;
 	req_prot = canon_pgprot(req_prot);
 
 	/*
@@ -698,16 +708,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
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
+	ref_prot = pgprot_clear_protnone_bits(ref_prot);
 
 	/*
 	 * Get the target pfn from the original entry:
@@ -930,18 +931,7 @@ static void populate_pte(struct cpa_data *cpa,
 
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
+	pgprot = pgprot_clear_protnone_bits(pgprot);
 	pgprot = canon_pgprot(pgprot);
 
 	while (num_pages-- && start < end) {
@@ -1234,17 +1224,7 @@ repeat:
 
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
+		new_prot = pgprot_clear_protnone_bits(new_prot);
 
 		/*
 		 * We need to keep the pfn from the existing PTE,
