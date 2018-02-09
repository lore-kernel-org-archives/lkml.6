Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x224HMf4e23Rk18ZeWP4Cv9Sy8xY+7uU0v6YlyPQpmsW9O9aZmXeUCFGOQBmGXU+DgjQqliEW
ARC-Seal: i=1; a=rsa-sha256; t=1518168360; cv=none;
        d=google.com; s=arc-20160816;
        b=hCZ3ebt84JwkpetxH4OKtHQu9Myx9WrfwINvo8r3n8vUo8g6sk34Oit32jQ6Z21B7A
         vC/bPRxIaO+N3KOxgB21MJO2bXD9GmxzFgIdXKaaaAQzdn+UIWFeaWlFQ9OjPS3VyE2K
         cu8gXKAisM7Wwz9k8BQT4Py2xLMzoSjC+Diio+lyn0mKfw7KYITLmQ/TcrG5ibtSvPHf
         373mxUMWAfYIg/HCoI1O2rBW201z6vN4WChJX/GgITE2pJRfxJiwcpQ65D3TZYb9loJF
         6G6WLjeb7zQOSkrOsfWjN5+W2AQp3/mXzJmMGSn9+TtZkv92qac4XFqtgw9iuLMeY/0V
         da4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=3/5kUbIEAs/f7+jNQG0KP0VmXR4ogAxlEw45KqMVs0Y=;
        b=f5f+hrUW3VbpJB9nrHbzoY2ktCndzqPtQOtCNXHQFglHj/mdl0wwJp5s+UlMKFsqET
         jBSSNHF1M0Zuq399u6hkPuYJmuu9prbmfNZMDEP+Lg8z48TYcqI2ChQ1i5z9WJu5edB0
         NNslVT3onM4Qv2t2AyRFkRNIg4AUuCE0Gvdzzmsns148KOq0pS5BswMsfjjKI7EFkjH/
         hOyrN0yi/juLdZ0oBeKGojv/JoFvlq0z5Hf/9ZPwnYADwaG1LU2+J8QNfeuMw0p2anLq
         kU+f1+V6q/gI4TvEhI1McKYw1lq13h3S/dBApM9SykIVtfbualUUygb3upCAPtJtV6jJ
         ZmIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FD80PHkg;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FD80PHkg;
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
Subject: [PATCH 17/31] x86/pgtable: Move pti_set_user_pgd() to pgtable.h
Date: Fri,  9 Feb 2018 10:25:26 +0100
Message-Id: <1518168340-9392-18-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914907157362349?=
X-GMAIL-MSGID: =?utf-8?q?1591914907157362349?=
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
index 0a9f746..c9d3cf9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -618,8 +618,31 @@ static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 
 pmd_t *populate_extra_pmd(unsigned long vaddr);
 pte_t *populate_extra_pte(unsigned long vaddr);
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd);
+
+/*
+ * Take a PGD location (pgdp) and a pgd value that needs to be set there.
+ * Populates the user and returns the resulting PGD that must be set in
+ * the kernel copy of the page tables.
+ */
+static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return pgd;
+	return __pti_set_user_pgd(pgdp, pgd);
+}
+#else   /* CONFIG_PAGE_TABLE_ISOLATION */
+static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
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
index 58d7f10..396664d 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -145,27 +145,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (ptr & ~PAGE_MASK) < (PAGE_SIZE / 2);
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd);
-
-/*
- * Take a PGD location (pgdp) and a pgd value that needs to be set there.
- * Populates the user and returns the resulting PGD that must be set in
- * the kernel copy of the page tables.
- */
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return pgd;
-	return __pti_set_user_pgd(pgdp, pgd);
-}
-#else
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
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
