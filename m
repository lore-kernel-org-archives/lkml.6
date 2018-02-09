Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x225zYKbVOS4b1b3YI6O1QsVzER9yp7jfGOQlgA/DFuCM+FsbR2SLEcvhhxm83IG0CBkG5h4t
ARC-Seal: i=1; a=rsa-sha256; t=1518168363; cv=none;
        d=google.com; s=arc-20160816;
        b=fS193+8Ip9kxeSvI5KpXECaaErEzlfizvFCAuqSgdGPWokwo0hk87KgKA9FnC3OGDe
         jM14q2dHaJhLFZftWcPj42RUxZey12kb7oivrYIXdDPoH3cc+hSVoOgxSY9ZW1UFYcdE
         giLuhazSgIvLQAcHSw6+FelwLe+RA4B05oiUvpwcMNayovOZ5j2v9wqk2QTZod9JkznF
         rOW9gVYrk8Fc0R91b/6edNr1Z4Unj1S95IqqcjTtlOAhLO/LiKyDnQGniW90iz5aoikM
         R/EvDk/P9Ml2aHJ4bzltDikhJLSRS+J78u26y0j2GsQ2E6C9QiLidZhyQrf2/XQIhbXo
         8DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=xg+AaEAuaGjZ1uB3W9vPyacpGtnPhtq2PnVl56DOf1k=;
        b=cpWaxS6lJ5XBs//d1kiMdqXLo729NnctrVAF1pCtD2qWj6704ovKDMVi/YV/2NEOa4
         rqG2y0rHKscxNgTYd7yYH5cIFd5If152C1dB1ixMeuUcaVhz0ZltlkyRile2MA5ZTMGj
         TaYVrh3Sg60Olp8Y5NsPBraOr+G56H4yQ/rrfU3u9rFFk8XJD+8hReBOfLj76LWezRes
         Mk5tq5SlBkFpXp435AdN5/tP8/iOcT2CohGbrFgAkbzB3CeqglMgFlymSracohLmIg4o
         HTkw4jY+p4Jzne6ZeFsJHnPRxtGHP/qHiK0X8kIGovS2aQw3sVo+VH5xubtQtT0EzVc0
         95iA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=LIyfyuma;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=LIyfyuma;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 21/31] x86/mm/legacy: Populate the user page-table with user pgd's
Date: Fri,  9 Feb 2018 10:25:30 +0100
Message-Id: <1518168340-9392-22-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914909730752112?=
X-GMAIL-MSGID: =?utf-8?q?1591914909730752112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Also populate the user-spage pgd's in the user page-table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable-2level.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 685ffe8..d772554 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -19,6 +19,9 @@ static inline void native_set_pte(pte_t *ptep , pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pmd.pud.p4d.pgd = pti_set_user_pgd(&pmdp->pud.p4d.pgd, pmd.pud.p4d.pgd);
+#endif
 	*pmdp = pmd;
 }
 
@@ -58,6 +61,9 @@ static inline pte_t native_ptep_get_and_clear(pte_t *xp)
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgd(&xp->pud.p4d.pgd, __pgd(0));
+#endif
 	return __pmd(xchg((pmdval_t *)xp, 0));
 }
 #else
@@ -67,6 +73,9 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 #ifdef CONFIG_SMP
 static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgd(&xp->p4d.pgd, __pgd(0));
+#endif
 	return __pud(xchg((pudval_t *)xp, 0));
 }
 #else
-- 
2.7.4
