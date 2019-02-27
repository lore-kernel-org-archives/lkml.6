Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4883C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA8F21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfB0RHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:07:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36032 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730115AbfB0RHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:07:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39D221684;
        Wed, 27 Feb 2019 09:07:02 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABECA3F738;
        Wed, 27 Feb 2019 09:06:58 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v3 09/34] m68k: mm: Add p?d_large() definitions
Date:   Wed, 27 Feb 2019 17:05:43 +0000
Message-Id: <20190227170608.27963-10-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For m68k, we don't support large pages, so add stubs returning 0

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-m68k@lists.linux-m68k.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/m68k/include/asm/mcf_pgtable.h      | 2 ++
 arch/m68k/include/asm/motorola_pgtable.h | 2 ++
 arch/m68k/include/asm/pgtable_no.h       | 1 +
 arch/m68k/include/asm/sun3_pgtable.h     | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 5d5502cb2b2d..63827d28a017 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -196,11 +196,13 @@ static inline int pmd_none2(pmd_t *pmd) { return !pmd_val(*pmd); }
 static inline int pmd_bad2(pmd_t *pmd) { return 0; }
 #define pmd_bad(pmd) pmd_bad2(&(pmd))
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
+#define pmd_large(pmd) (0)
 static inline void pmd_clear(pmd_t *pmdp) { pmd_val(*pmdp) = 0; }
 
 static inline int pgd_none(pgd_t pgd) { return 0; }
 static inline int pgd_bad(pgd_t pgd) { return 0; }
 static inline int pgd_present(pgd_t pgd) { return 1; }
+static inline int pgd_large(pgd_t pgd) { return 0; }
 static inline void pgd_clear(pgd_t *pgdp) {}
 
 #define pte_ERROR(e) \
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 7f66a7bad7a5..a649eb8a91de 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -138,6 +138,7 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_bad(pmd)		((pmd_val(pmd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pmd_present(pmd)	(pmd_val(pmd) & _PAGE_TABLE)
+#define pmd_large(pmd)		(0)
 #define pmd_clear(pmdp) ({			\
 	unsigned long *__ptr = pmdp->pmd;	\
 	short __i = 16;				\
@@ -150,6 +151,7 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		((pgd_val(pgd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pgd_present(pgd)	(pgd_val(pgd) & _PAGE_TABLE)
+#define pgd_large(pgd)		(0)
 #define pgd_clear(pgdp)		({ pgd_val(*pgdp) = 0; })
 #define pgd_page(pgd)		(mem_map + ((unsigned long)(__va(pgd_val(pgd)) - PAGE_OFFSET) >> PAGE_SHIFT))
 
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fc3a96c77bd8..eeef17b2eae8 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -17,6 +17,7 @@
  * Trivial page table functions.
  */
 #define pgd_present(pgd)	(1)
+#define pgd_large(pgd)		(0)
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
 #define pgd_clear(pgdp)
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index c987d50866b4..eea72e3515db 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -143,6 +143,7 @@ static inline int pmd_bad2 (pmd_t *pmd) { return 0; }
 static inline int pmd_present2 (pmd_t *pmd) { return pmd_val (*pmd) & SUN3_PMD_VALID; }
 /* #define pmd_present(pmd) pmd_present2(&(pmd)) */
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
+#define pmd_large(pmd) (0)
 static inline void pmd_clear (pmd_t *pmdp) { pmd_val (*pmdp) = 0; }
 
 static inline int pgd_none (pgd_t pgd) { return 0; }
@@ -150,6 +151,7 @@ static inline int pgd_bad (pgd_t pgd) { return 0; }
 static inline int pgd_present (pgd_t pgd) { return 1; }
 static inline void pgd_clear (pgd_t *pgdp) {}
 
+static inline int pgd_large(pgd_t pgd) { return 0; }
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-- 
2.20.1

