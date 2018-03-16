Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuB1moALjX/FE2EJzZ7AiE79m+zYSlFc51qskaQLyy69qcH5YypBzsB3N8driQzz5N1MS+g
ARC-Seal: i=1; a=rsa-sha256; t=1521228606; cv=none;
        d=google.com; s=arc-20160816;
        b=nJBvCGgmyMC+hAygb7+ta/bXcD3qC+bb+ZQWggDbtPhoOmlnSGiE4KmTKDILkAnn93
         qvCYrtG2Y/YA8E4O1IXObTtDPgpHPKkynvhzco+Jrr1VJ2UwW1kZNVEyQD6qoBGRRW3L
         e+ZsiN9yKM++1WwuQZRhX+fCJB7KsM+PQ9UcSH/Fu+0YH00IQ4/EqIh0L+H/dtdeqT/Z
         5n4jNJuXPG5mluxRqNzm/AiHIMsDY34QaD/REXYkMTje3v+jngYJ/zMhzlIQ7Jf+pcPt
         8BjcvHttS+UzB510RkrETRsV28Tcb1tkLwbChYaN2bFZh2YEKob5TdqZb9OgC8mZxZx7
         b8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bZlTBQ7TnMdlJzLKKteDNuKBqKGpitP//pbiUgQVl0s=;
        b=iVNrQ0UaBBHF9GnnOc6uByN0e9tiiK+UMCOY/AemvYYWRKCM7qXytstaTZsV2C9a0c
         2/S/ceZtZ0Tx6GIVhfD0/QpEX2fxd/lm5NIj7HBm92qHXAvaaUb2lj4wDx95ugWWe9Ru
         fMDEG9UzyazeN1IxFYyNRyxxraA4YPlhoa+lCbg1f2a1O2VHRyqWioNVpfBPrYzn9Xvm
         akWS0dFEiDOlOSM2w5Rx/a/V95S14NUr3wLgfJsUO96g+VCaA5TekwvIvMb7JIAhj3bc
         u235v/Vo2HV7auRa9VU2Bj9ATSGeKjlc4C7iYWgL8vYmAgicB5Fa44F2MiRDA7tiNJa/
         GxiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=fGIiJVlb;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=fGIiJVlb;
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
Subject: [PATCH 15/35] x86/pgtable: Rename pti_set_user_pgd to pti_set_user_pgtbl
Date: Fri, 16 Mar 2018 20:29:33 +0100
Message-Id: <1521228593-3820-16-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123806989985809?=
X-GMAIL-MSGID: =?utf-8?q?1595123806989985809?=
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
