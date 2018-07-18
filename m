Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6856AECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0242920864
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="bBLCA8sG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0242920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbeGRKS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:58 -0400
Received: from 8bytes.org ([81.169.241.247]:54792 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730913AbeGRKSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8CD393C92; Wed, 18 Jul 2018 11:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906887; bh=dnHDZhM/YiYbEYMQFwJk/GwQKVbFCx4cKYQ5WVAFrZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBLCA8sGZfYOmpByyH4hXuBw631iV+K7xuRxW0RfhX6IHQ0a/QTFgdJAjzkVX9j4v
         mZZrUhGqd0Ve9wmPLpVXv5KOCIl3O5i7NKNSvrG+PguQ5UHEQX7B/hCznDEeHH73xh
         IEf3k4DGRRd33j54pjQY21o4Gnim4B1eFwOZgJRgM7t18Q0ip2QbZFZe3PKKohHTpZ
         sLk1Xyz84yxSThIBeWFaPvs6G7pinXvexkLW0N2xj8r0CCFmXAstnLe/UljfayodLC
         +CZXYwcgn0j4Gbwd4Te6bNLX4FK/5uy5DXev3BQiViJyaLWOHGwV80cG+/fr5hdGEB
         k9QfX/Z2wJpZQ==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 36/39] x86/ldt: Enable LDT user-mapping for PAE
Date:   Wed, 18 Jul 2018 11:41:13 +0200
Message-Id: <1531906876-13451-37-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This adds the needed special case for PAE to get the LDT
mapped into the user page-table when PTI is enabled. The big
difference to the other paging modes is that we don't have a
full top-level PGD entry available for the LDT, but only PMD
entry.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/mmu_context.h |  5 ----
 arch/x86/kernel/ldt.c              | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index bbc796e..eeeb928 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -71,12 +71,7 @@ struct ldt_struct {
 
 static inline void *ldt_slot_va(int slot)
 {
-#ifdef CONFIG_X86_64
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
-#else
-	BUG();
-	return (void *)fix_to_virt(FIX_HOLE);
-#endif
 }
 
 /*
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 69af9a0..733e6ac 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -126,6 +126,57 @@ static void do_sanity_check(struct mm_struct *mm,
 	}
 }
 
+#ifdef CONFIG_X86_PAE
+
+static pmd_t *pgd_to_pmd_walk(pgd_t *pgd, unsigned long va)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+
+	if (pgd->pgd == 0)
+		return NULL;
+
+	p4d = p4d_offset(pgd, va);
+	if (p4d_none(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, va);
+	if (pud_none(*pud))
+		return NULL;
+
+	return pmd_offset(pud, va);
+}
+
+static void map_ldt_struct_to_user(struct mm_struct *mm)
+{
+	pgd_t *k_pgd = pgd_offset(mm, LDT_BASE_ADDR);
+	pgd_t *u_pgd = kernel_to_user_pgdp(k_pgd);
+	pmd_t *k_pmd, *u_pmd;
+
+	k_pmd = pgd_to_pmd_walk(k_pgd, LDT_BASE_ADDR);
+	u_pmd = pgd_to_pmd_walk(u_pgd, LDT_BASE_ADDR);
+
+	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+		set_pmd(u_pmd, *k_pmd);
+}
+
+static void sanity_check_ldt_mapping(struct mm_struct *mm)
+{
+	pgd_t *k_pgd = pgd_offset(mm, LDT_BASE_ADDR);
+	pgd_t *u_pgd = kernel_to_user_pgdp(k_pgd);
+	bool had_kernel, had_user;
+	pmd_t *k_pmd, *u_pmd;
+
+	k_pmd      = pgd_to_pmd_walk(k_pgd, LDT_BASE_ADDR);
+	u_pmd      = pgd_to_pmd_walk(u_pgd, LDT_BASE_ADDR);
+	had_kernel = (k_pmd->pmd != 0);
+	had_user   = (u_pmd->pmd != 0);
+
+	do_sanity_check(mm, had_kernel, had_user);
+}
+
+#else /* !CONFIG_X86_PAE */
+
 static void map_ldt_struct_to_user(struct mm_struct *mm)
 {
 	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
@@ -143,6 +194,8 @@ static void sanity_check_ldt_mapping(struct mm_struct *mm)
 	do_sanity_check(mm, had_kernel, had_user);
 }
 
+#endif /* CONFIG_X86_PAE */
+
 /*
  * If PTI is enabled, this maps the LDT into the kernelmode and
  * usermode tables for the given mm.
-- 
2.7.4

