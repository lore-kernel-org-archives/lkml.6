Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuQwJ/QtPz3lTTAIZP3lXLVj7uqqWIKh6LvrUvzL3wls2m+XyfnjRilzP07CqNbL8AbJ878
ARC-Seal: i=1; a=rsa-sha256; t=1520245580; cv=none;
        d=google.com; s=arc-20160816;
        b=KEHIcfVLZ+APuALJVNDabKa+xD6F4BG9pYUHmnwZVwM0lbTXaxk40wGTf0PSpWWYQq
         qR81ZzPZyoP9xOoAX7f9zwMk7pSSm6xDioATfzoQQe/4+PQ5TJXvrKS5ek9uiDDIxDld
         xjHaHkYS1+C8v8ZUacGoTUzFXhYYeAheYeM+d1CIRuNE4zEdcn4D7b+nyfI7cIFk/nKb
         uBZavCCPJtcxU5ZnW06TYlwlrjTa148ukitSeCd56z3/HqaJ665FvJ6REgr0tp4OqoTy
         T+8/SYFCR1qypvmCHNgV+O7TpAEdZKszHZJeusoZiBrsnR4LV2jQKFlj53hOMWwaJjy7
         rQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TcOVtVnr+aW/8VDEtvIk3oEsqpy7c98bNgeUFUA7HCA=;
        b=OItsFqJ+UwjhxPQctzOG7sLP+8iQXvl/vV21LTzmpW7AutpKGBGJlqe4tz7RQMpMV4
         RNNd4JNBTeA54AYg9RTH5wNuqmYxq9ZA6Y4fdvXTOhoUPKKt5Qgl5K54X/ZqrfIl8sNj
         6qC8+mtrwhU1EZpUCixoxLErnBXAVHP8uIWPSwcxlUURs+DBCny729vrS+2DNEeYm5O6
         RMhfS1V3XF0zmHUpiKd5EX1xMI/jI0i+L786krGUr1BBCApZ486cdcEY+gfI9H5nbl0i
         2mGvW1OQZ816pppZVm89V2foVSwSsYR66imxmVeWIT6lu0wGDi7LNeBxzYh46gekD9+d
         ocew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=iCzvyA35;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=iCzvyA35;
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
Subject: [PATCH 23/34] x86/mm/legacy: Populate the user page-table with user pgd's
Date: Mon,  5 Mar 2018 11:25:52 +0100
Message-Id: <1520245563-8444-24-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093029087556625?=
X-GMAIL-MSGID: =?utf-8?q?1594093029087556625?=
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
