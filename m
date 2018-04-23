Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx48SfqIsYkheyjq4oSYXw6w4/uarVy/N4ieUVglsiUq4qnKnGhzv7JfG61Mw5drWROXOPz+q
ARC-Seal: i=1; a=rsa-sha256; t=1524498472; cv=none;
        d=google.com; s=arc-20160816;
        b=1LF3hHyjvXnFbnzuJ+QaDZzieOIRRTcTMHdlr7JdB30QWWNEKDScqF3SQjok6j2y2i
         U2eB9D75qhO5QjeFNZ/Q6bv06BNS//y8oM4C4H088ZiqWnxI7S4M11r+54wtL/YV8sng
         elMzcwLNto5S12Jz/dBVZoYBtZWJCtYolOfmNSmPGaEJDrwTJYxR+OfZ6k/ZV214ImT9
         ZYu5thUBnm/TW8/uj00RE0MHW2q3UAb+c9UtqvBVvwfO5nN/GrIRpql2zxT0jdF9xN4a
         g77paZeHXTjFZ2HFsAreYbAGQ1RH771ZYRcbV0IGDT4NPyw44tgpYV7r6QuPXUttqNsx
         6Yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Y8N4hCCOk7avYFElYs/3evka9+flYYVqAWJN/ObKGmk=;
        b=I5s1uzpGw2jsHJyBgVVA2Y6CoX+PJoshcU+dftFuZ9T5p2xO6WKpXNmgXHGGPO8IV4
         QcQrJK5LjqERs+FWLfLKfHg3grFUrMOMqNacj108RDMNu/3eiui4jQUXX3HVo/ErbYFT
         s7Lr7Jap1Tl/1by1EEM44CR8TolWaMUftcfWhiRfmTZp0q/5ChQos5ZrSP8jWsPI/DV5
         EDu4PLmaGj8UyQbDHZDM0lm36pJqZmlRjysPgpuxju7XaN81Ucw92bhfcFvASFphXLsl
         iGTAb9LrQx61hu+nc4cbo9cQ04aTK+Xe4EDtEo9xRPl7UAg5RXDifTJLJH7F9bPsJJ4S
         VjBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=oYjS6/R0;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=oYjS6/R0;
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
Subject: [PATCH 15/37] x86/pgtable: Rename pti_set_user_pgd to pti_set_user_pgtbl
Date: Mon, 23 Apr 2018 17:47:18 +0200
Message-Id: <1524498460-25530-16-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552510005291281?=
X-GMAIL-MSGID: =?utf-8?q?1598552510005291281?=
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
index 877bc27..c863816 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -196,21 +196,21 @@ static inline bool pgdp_maps_userspace(void *__ptr)
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
@@ -226,7 +226,7 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	}
 
 	pgd = native_make_pgd(native_p4d_val(p4d));
-	pgd = pti_set_user_pgd((pgd_t *)p4dp, pgd);
+	pgd = pti_set_user_pgtbl((pgd_t *)p4dp, pgd);
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
@@ -237,7 +237,7 @@ static inline void native_p4d_clear(p4d_t *p4d)
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp = pti_set_user_pgd(pgdp, pgd);
+	*pgdp = pti_set_user_pgtbl(pgdp, pgd);
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index f1fd52f..9bea9c3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -117,7 +117,7 @@ void __init pti_check_boottime_disable(void)
 	setup_force_cpu_cap(X86_FEATURE_PTI);
 }
 
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	/*
 	 * Changes to the high (kernel) portion of the kernelmode page
-- 
2.7.4
