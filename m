Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELv6PlclRlUwdvwROOb10UWIdANFV4a/34tYqg7YxTMucsCLcCcwdFK2B95DVidgho/kV7J1
ARC-Seal: i=1; a=rsa-sha256; t=1521228608; cv=none;
        d=google.com; s=arc-20160816;
        b=Q9RYo2dj3a1bgyV2n5XjQm9pMS0EK62m4njZFcjMgqbfQWU1zm7gaeDKJZ6gKDEYZo
         R55SJbKO+RxScnELWFaNkNDpBathLCvSM6Epci4YTLs3p5jafhLhd2uaK5ubpUnfc1Hy
         p15+Hy1UfXvbNqUl6yTyEcQMNdiZ4x/LNy1pegtv4liknlTbZIsjQXaZLSgpMbpyS3nP
         5lzVHprfHzQEkIuybe+Oe5nyntK+ct2pHqhy1I38P0GQy6nZ1+BQ2vuagJwCojZgj6eI
         l9fIgbEbbNeqISHnfoakUWCSKawXD6vYXb6fNdbEwuX3nOjzq7vxPPgk+hLVU/PlC0Lv
         nhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5pIUFR3j827UoBgxXj6zwaByJODpiTnnoQVsy0h1RsQ=;
        b=Uwq+fLrhJzTno9/wn/L9j6qrXE/qU8lOLNXM7/CUEqx/S2h00oNBuNwkqAS9FB0kbQ
         RJ5MP8ewx3YQCKRsZMonpKzPWX1/R1oyK1O8e6vWpLIpoNFcQ9fxItenNwxbu/vR3MyW
         mdquN/muG9Oq4LD85ZuYpcK7uhr4q4nwYz5odDHdycKcW2k7TSgcV8j9/Vo5A+Cvl/uR
         xpAtjcbEpitA3pXTbUSGniTARmmg8TA3N6vIDYAItBi19xjQF/ZJQxkjMoNzZ4uqb10D
         MGlAV9P2CP3h6twUXOf/Nv+SCSMIqWFrck+hys5SiFQhrLhQ2xELebf4AHvv5iXJk+xi
         tfOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=A5FXVZ5a;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=A5FXVZ5a;
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
Subject: [PATCH 19/35] x86/pgtable: Move pti_set_user_pgtbl() to pgtable.h
Date: Fri, 16 Mar 2018 20:29:37 +0100
Message-Id: <1521228593-3820-20-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123809697375841?=
X-GMAIL-MSGID: =?utf-8?q?1595123809697375841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

There it is also usable from 32 bit code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable.h    | 23 +++++++++++++++++++++++
 arch/x86/include/asm/pgtable_64.h | 21 ---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0a9f746..1e900c1 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -618,8 +618,31 @@ static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 
 pmd_t *populate_extra_pmd(unsigned long vaddr);
 pte_t *populate_extra_pte(unsigned long vaddr);
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
+
+/*
+ * Take a PGD location (pgdp) and a pgd value that needs to be set there.
+ * Populates the user and returns the resulting PGD that must be set in
+ * the kernel copy of the page tables.
+ */
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return pgd;
+	return __pti_set_user_pgtbl(pgdp, pgd);
+}
+#else   /* CONFIG_PAGE_TABLE_ISOLATION */
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
+{
+	return pgd;
+}
+#endif  /* CONFIG_PAGE_TABLE_ISOLATION */
+
 #endif	/* __ASSEMBLY__ */
 
+
 #ifdef CONFIG_X86_32
 # include <asm/pgtable_32.h>
 #else
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 5e68083..4cbf517 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -145,27 +145,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (ptr & ~PAGE_MASK) < (PAGE_SIZE / 2);
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
-
-/*
- * Take a PGD location (pgdp) and a pgd value that needs to be set there.
- * Populates the user and returns the resulting PGD that must be set in
- * the kernel copy of the page tables.
- */
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return pgd;
-	return __pti_set_user_pgtbl(pgdp, pgd);
-}
-#else
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	return pgd;
-}
-#endif
-
 static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 #if defined(CONFIG_PAGE_TABLE_ISOLATION) && !defined(CONFIG_X86_5LEVEL)
-- 
2.7.4
