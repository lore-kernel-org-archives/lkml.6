Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvQEBckBqjAQU84ncqa7lEtA0BV5BX9K2B1R9gdMOOjMaEYGKHQCkGdPfG8MMj7OWLj/x6O
ARC-Seal: i=1; a=rsa-sha256; t=1520245574; cv=none;
        d=google.com; s=arc-20160816;
        b=KmUMn4KIkBQZNfxzbESMBaPjNMwC2n69F9bQI1VoE16kkFFzj8o2YEzvBiu1/ayjsc
         MjhJTrK9W7o0T8Z0ks/mDj6hKeZSQepmu2hIQzDx6/T3zrrBL+WA0feDt1iDc2FsA2en
         ryvJs0kNJBUpbZ1ZWeUNSZKsNeYFEIC1uaD+gs5kEJv56++NRhhFGtETT5YCIcqh1n8D
         nw32kcpr0gCIPct1tLAw78pMKFj20BHGW1afz/otWHbUfmmXyHLlCRUXtWRvz1rYVDJN
         LJWQHxJ4ufMGwKH8JMSLPo1vuFKjSjQ47RDWp63sqZTvaDg1BoevK3y+B1vQ9Mmqv325
         Kmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bZlTBQ7TnMdlJzLKKteDNuKBqKGpitP//pbiUgQVl0s=;
        b=mdm93A55AsKosD0iAr1nRURCQFVoD34uP9hO7Su2puQraK4/SomO2D9IL9fX1dIsuu
         fLeoIhdkcQOVH6MlhOixrNEN5A89ZL4Ivlt22ytDMLQCo6PPBWqxk90A+/6JHTsFl+vE
         iEz8VV2VP0MHK7ZLAQmaB9yBe2/7n7Dkq9NpZXBkqWKvQ528YSigjmPhu4z1QYK98q3s
         SZRpW7AgvxnJn/Q7rXQBmxe3rGGchandkCyBr1++ZQWQIRNpDufLJdM2TEYHYoow8lBw
         vn/CTx9n/ZXt4CBIKb32zTBb2C2ejHn+CNEVj3H5OT/OBn1M6eOyDgxahtnSxnBBZZnA
         3vVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ENYlYPHv;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ENYlYPHv;
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
Subject: [PATCH 15/34] x86/pgtable: Rename pti_set_user_pgd to pti_set_user_pgtbl
Date: Mon,  5 Mar 2018 11:25:44 +0100
Message-Id: <1520245563-8444-16-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093023935493934?=
X-GMAIL-MSGID: =?utf-8?q?1594093023935493934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

With the way page-table folding is implemented on 32 bit, we
are not only setting PGDs with this functions, but also PUDs
and even PMDs. Give the function a more generic name to
reflect that.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_64.h | 12 ++++++------
 arch/x86/mm/pti.c                 |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 81462e9..b68bda5 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -195,21 +195,21 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd);
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
 
 /*
  * Take a PGD location (pgdp) and a pgd value that needs to be set there.
  * Populates the user and returns the resulting PGD that must be set in
  * the kernel copy of the page tables.
  */
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return pgd;
-	return __pti_set_user_pgd(pgdp, pgd);
+	return __pti_set_user_pgtbl(pgdp, pgd);
 }
 #else
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
 }
@@ -218,7 +218,7 @@ static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 #if defined(CONFIG_PAGE_TABLE_ISOLATION) && !defined(CONFIG_X86_5LEVEL)
-	p4dp->pgd = pti_set_user_pgd(&p4dp->pgd, p4d.pgd);
+	p4dp->pgd = pti_set_user_pgtbl(&p4dp->pgd, p4d.pgd);
 #else
 	*p4dp = p4d;
 #endif
@@ -236,7 +236,7 @@ static inline void native_p4d_clear(p4d_t *p4d)
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	*pgdp = pti_set_user_pgd(pgdp, pgd);
+	*pgdp = pti_set_user_pgtbl(pgdp, pgd);
 #else
 	*pgdp = pgd;
 #endif
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ce38f16..8f53d21 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -102,7 +102,7 @@ void __init pti_check_boottime_disable(void)
 	setup_force_cpu_cap(X86_FEATURE_PTI);
 }
 
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	/*
 	 * Changes to the high (kernel) portion of the kernelmode page
-- 
2.7.4
