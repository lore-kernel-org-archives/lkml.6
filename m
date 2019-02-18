Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ED7C00319
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061C521900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kim7VCp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfBRXN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:13:27 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38484 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfBRXNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:13:25 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so1919437itg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/EYw2rlCI4mDqlXBqXNVekL8hDo+V+cu5waHUfY2FU=;
        b=Kim7VCp0StMXRnvvAWqYcMEpvO63kYz5zHERRNvlruuQQyJ/O/6e+78airAc6V3njt
         QPh65tXH7igo5M8n9Y+AY35NXYR4O99incnRtGZjj5tDT4G/3SpUfm/d5+VrXm3QMc14
         75MeWggtjgmG93XKz8SbkdnbNJxnW40gBOu2nYy4fTAaAZalUyFgJHBLbbsFBZcpmf7r
         gIqdQ766/KCsrLwCM+YpAq/CN78i4u/aY+3DZvUca0RcFYIOEnylrKumqeycBQkWaONH
         MUXpvu3EkRdDRMckSlclBjo8KbsFUEzseKNLXMHT/gA5Kd3J8udX+m6D9rsbbBHZIn4Z
         4luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/EYw2rlCI4mDqlXBqXNVekL8hDo+V+cu5waHUfY2FU=;
        b=DSo7BzeenVT1CHe3dDJBAxioBdITXYDjIrlwY6j7bph5opTAqr3EVT+1WyvWgDnjXM
         A9A55jrf3OKWRfDynB6ue1QckPM0LsKA/JhYi+PST5leDQ1gjW7fzWY59p21sPODUjG9
         auyThtTUXpFGXjVAME6B+gF2Lpf5yFIZYQmz5MnfQT6HQwutlcNKachFJcChF5Nmh1gO
         LERHZGe3z3JHWG6C/byyWNry68ebJZT77X0fALusEpn/5cnOPlS4rzTjlcttmSYi50xe
         ovAwIsMC2g+w6AplqhsKGSEvjyc4gwYsTA1xD6k3f8wTIO48Yyq615//2gDRqPV9BWpG
         gBvA==
X-Gm-Message-State: AHQUAubpppl0/42sSqUjpPXONWFK2x6081Du3kHBHpW/z1+VkXmFCIz9
        ghC08gjAR6YW8NIPBYxcXGySzA==
X-Google-Smtp-Source: AHgI3IZhDNTkjmRqX5ciPMAt1QHx6yCLXNgtuFuVzvtd4/Fv0kqYiBMJG132E3NRHTpB/NiNuEH4qw==
X-Received: by 2002:a24:918c:: with SMTP id i134mr744158ite.92.1550531604541;
        Mon, 18 Feb 2019 15:13:24 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id x23sm6541463ion.38.2019.02.18.15.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 15:13:23 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Date:   Mon, 18 Feb 2019 16:13:17 -0700
Message-Id: <20190218231319.178224-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214211642.2200-1-yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pte page, use pgtable_page_ctor(); for pmd page, use
pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
p4d and pgd), don't use any.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b6f5aa52ac67..fa7351877af3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -98,7 +98,7 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static phys_addr_t __init early_pgtable_alloc(void)
+static phys_addr_t __init early_pgtable_alloc(int shift)
 {
 	phys_addr_t phys;
 	void *ptr;
@@ -173,7 +173,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void),
+				phys_addr_t (*pgtable_alloc)(int),
 				int flags)
 {
 	unsigned long next;
@@ -183,7 +183,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	if (pmd_none(pmd)) {
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
-		pte_phys = pgtable_alloc();
+		pte_phys = pgtable_alloc(PAGE_SHIFT);
 		__pmd_populate(pmdp, pte_phys, PMD_TYPE_TABLE);
 		pmd = READ_ONCE(*pmdp);
 	}
@@ -207,7 +207,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot,
-		     phys_addr_t (*pgtable_alloc)(void), int flags)
+		     phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pmd_t *pmdp;
@@ -245,7 +245,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void), int flags)
+				phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
@@ -257,7 +257,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	if (pud_none(pud)) {
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
-		pmd_phys = pgtable_alloc();
+		pmd_phys = pgtable_alloc(PMD_SHIFT);
 		__pud_populate(pudp, pmd_phys, PUD_TYPE_TABLE);
 		pud = READ_ONCE(*pudp);
 	}
@@ -293,7 +293,7 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 
 static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(void),
+			   phys_addr_t (*pgtable_alloc)(int),
 			   int flags)
 {
 	unsigned long next;
@@ -303,7 +303,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	if (pgd_none(pgd)) {
 		phys_addr_t pud_phys;
 		BUG_ON(!pgtable_alloc);
-		pud_phys = pgtable_alloc();
+		pud_phys = pgtable_alloc(PUD_SHIFT);
 		__pgd_populate(pgdp, pud_phys, PUD_TYPE_TABLE);
 		pgd = READ_ONCE(*pgdp);
 	}
@@ -344,7 +344,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 unsigned long virt, phys_addr_t size,
 				 pgprot_t prot,
-				 phys_addr_t (*pgtable_alloc)(void),
+				 phys_addr_t (*pgtable_alloc)(int),
 				 int flags)
 {
 	unsigned long addr, length, end, next;
@@ -370,11 +370,20 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
-static phys_addr_t pgd_pgtable_alloc(void)
+static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
-	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
-		BUG();
+	BUG_ON(!ptr);
+
+	/*
+	 * Initialize page table locks in case later we need to
+	 * call core mm functions like apply_to_page_range() on
+	 * this pre-allocated page table.
+	 */
+	if (shift == PAGE_SHIFT)
+		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
+	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
+		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));
 
 	/* Ensure the zeroed page is visible to the page table walker */
 	dsb(ishst);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

