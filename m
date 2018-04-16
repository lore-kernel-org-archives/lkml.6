Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49iuP14firGpNDuV3qImYhfre8RTJePbXQlUef/LlT2DH3fq0PiYA2PmTdlg1JY4gVEoz6I
ARC-Seal: i=1; a=rsa-sha256; t=1523892349; cv=none;
        d=google.com; s=arc-20160816;
        b=Bt1bDt/bdywGHA2PXmtJDP+DBqde2qfVxh2gtW4QERcz2hAafCXGXepN2+zeROv7oU
         IccLeAZGDtEjGpJjQxpdsLv/UUL6FUQnAjO37f+fNuLzEKStbM+t1RkZgqLfpczawObZ
         zShV1HObZodGqNRZlxHWJJEktiaXVE29Db5pPT3pKUQ+NC3sOrQUl9Q8cYSMET+BT6WO
         C95yp5sou63+tNOTBGM2jWDUBTS2ZSXAS1pWuvZ+fvnOsTBMxvEN/J2q+EZ3CAxvL03+
         d8bcj6nQrYULORRyTC7kSMm5lhqoaty9aEJ5MRbBJG3DSYSkwKxAkgtnDVnxw22r37fQ
         lcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TcOVtVnr+aW/8VDEtvIk3oEsqpy7c98bNgeUFUA7HCA=;
        b=n97RZkcH8VT9v36Kq1iLPcmeF3wIFh3Si/R2CU8AAI/blz6AeDAfQAAj0nL6tX06rg
         HmN1Ar32xKjshn5X0Ldt/bHPEoSpaBjMRBjMkYmyB1My9qRAvwTLPyzHzrOtQ9YfN6uA
         K62d+z/lh9NdkdktjyfxVY+3rcfyzR5iITSVyrXMNghr0w4hxJ38SP555LFeZDXSqoyz
         d0KpSS3BKN0fsLwf3oWWguM7Fl+5y1qAXqrt4Byh6qgdtDWx/3KS1YPBHv7tAV6MqZME
         IvnhoalEh8F7DqW1es+ipB+4ymxZM76oJLzklx/CzAafrrBsPp98KXcgP4ADW0Oi5Nn3
         1WvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=QZ/20mUS;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=QZ/20mUS;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 23/35] x86/mm/legacy: Populate the user page-table with user pgd's
Date: Mon, 16 Apr 2018 17:25:11 +0200
Message-Id: <1523892323-14741-24-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916944209676914?=
X-GMAIL-MSGID: =?utf-8?q?1597916944209676914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Also populate the user-spage pgd's in the user page-table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable-2level.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 685ffe8..c399ea5 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -19,6 +19,9 @@ static inline void native_set_pte(pte_t *ptep , pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pmd.pud.p4d.pgd = pti_set_user_pgtbl(&pmdp->pud.p4d.pgd, pmd.pud.p4d.pgd);
+#endif
 	*pmdp = pmd;
 }
 
@@ -58,6 +61,9 @@ static inline pte_t native_ptep_get_and_clear(pte_t *xp)
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgtbl(&xp->pud.p4d.pgd, __pgd(0));
+#endif
 	return __pmd(xchg((pmdval_t *)xp, 0));
 }
 #else
@@ -67,6 +73,9 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 #ifdef CONFIG_SMP
 static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgtbl(&xp->p4d.pgd, __pgd(0));
+#endif
 	return __pud(xchg((pudval_t *)xp, 0));
 }
 #else
-- 
2.7.4
