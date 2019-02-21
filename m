Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391A62086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfBULfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:35:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfBULfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:35:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33748165C;
        Thu, 21 Feb 2019 03:35:23 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A693F3F5C1;
        Thu, 21 Feb 2019 03:35:19 -0800 (PST)
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
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v2 02/13] x86/mm: Add p?d_large() definitions
Date:   Thu, 21 Feb 2019 11:34:51 +0000
Message-Id: <20190221113502.54153-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221113502.54153-1-steven.price@arm.com>
References: <20190221113502.54153-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exposing the pud/pgd levels of the page tables to walk_page_range() means
we may come across the exotic large mappings that come with large areas
of contiguous memory (such as the kernel's linear map).

Expose p?d_large() from each architecture to detect these large mappings.

x86 already has these defined as inline functions, add a macro of the
same name so we don't end up with the generic version too.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/include/asm/pgtable.h | 3 +++
 arch/x86/mm/dump_pagetables.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23..3695f6acb6af 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -234,6 +234,7 @@ static inline int pmd_large(pmd_t pte)
 {
 	return pmd_flags(pte) & _PAGE_PSE;
 }
+#define pmd_large(x)	pmd_large(x)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
@@ -873,6 +874,7 @@ static inline int pud_large(pud_t pud)
 	return 0;
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
+#define pud_large(x)	pud_large(x)
 
 static inline unsigned long pud_index(unsigned long address)
 {
@@ -1214,6 +1216,7 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 }
 
 static inline int pgd_large(pgd_t pgd) { return 0; }
+#define pgd_large(x)	pgd_large(x)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e3cdc85ce5b6..cf37abc0f58a 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -432,6 +432,7 @@ static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
 
 #else
 #define walk_pmd_level(m,s,a,e,p) walk_pte_level(m,s,__pmd(pud_val(a)),e,p)
+#undef pud_large
 #define pud_large(a) pmd_large(__pmd(pud_val(a)))
 #define pud_none(a)  pmd_none(__pmd(pud_val(a)))
 #endif
@@ -469,6 +470,7 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 
 #else
 #define walk_pud_level(m,s,a,e,p) walk_pmd_level(m,s,__pud(p4d_val(a)),e,p)
+#undef p4d_large
 #define p4d_large(a) pud_large(__pud(p4d_val(a)))
 #define p4d_none(a)  pud_none(__pud(p4d_val(a)))
 #endif
@@ -503,6 +505,7 @@ static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
 	}
 }
 
+#undef pgd_large
 #define pgd_large(a) (pgtable_l5_enabled() ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
 #define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
 
-- 
2.20.1

