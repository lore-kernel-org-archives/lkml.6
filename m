Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvZxkkuOAbNftr/BqqaNNIK8Cqos4Vm9zqmabOwaUqmNuxLBRS6NMfvtMgWlD/TamMWyxB0
ARC-Seal: i=1; a=rsa-sha256; t=1521228610; cv=none;
        d=google.com; s=arc-20160816;
        b=kmKgPkKOabjSY24fN+OOYTf39WtPBK1O0wUhm0yZYFlIXQwn0DzsdZ6G0z5GXoK7wn
         YR/Q1ZxzunYudp5ZUV/V8/YB/svYS1PJMDvAyrrn4sEzm/vjzv/ZkZBU8d7QuDJqfDje
         cv9nvwRCpzBPy7VFXNpEK8QQIe034WXopSz115cC3Z1erk54lfKe0tEl8gpsyEF2qnJL
         uA6XfJ5pTcXpRIn58k/N9QuiWrs3PM/+uSbJ7h7UEYjG1ZfVJODdmwrSR/VHR6OmRIb5
         KXhgYyAG5AhPadaFhF3GORchlQu4lpxtFCGsqOEPUmY4DlTa5uGMkdloFmJRbrAq+Rmv
         3IxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TcOVtVnr+aW/8VDEtvIk3oEsqpy7c98bNgeUFUA7HCA=;
        b=Mky/HoER8qBxSqiqgjQgzmaGIz2nIeMm4vlkathntcysxl2tlaN6joB/Btx3of6IPY
         23MNaq36Ux8dnXsuG6oMjdLX1OSCSKakigndV5eaRI7XCuLCTxrIZkrRLtfgMeO0jXaO
         kQELtG4ZfNSpNaIwVgu0BeMCR/qh3Ac/BuZcudhhtb1oBtu08KPFKEq6jlQGKnaRRapi
         SPUcp3lTCwGAu70aO1eCkxbv/Tuyq3cFiwf2s0pWo4gSt9St8w4fJmXNEXlAz0R/IEH/
         r3ZG7EOLVxyDMqrzXsWqGivv8+idSqJdHi5konerapMS+8F83bjpxQfTFCC2mwT5fa8d
         BJ5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=GkdCcOQ7;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=GkdCcOQ7;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 23/35] x86/mm/legacy: Populate the user page-table with user pgd's
Date: Fri, 16 Mar 2018 20:29:41 +0100
Message-Id: <1521228593-3820-24-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123811172678799?=
X-GMAIL-MSGID: =?utf-8?q?1595123811172678799?=
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
