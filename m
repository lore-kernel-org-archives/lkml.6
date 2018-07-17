Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950DB20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvlZP04J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950DB20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGQK2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42899 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbeGQK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id f4-v6so238546plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DqPFt5x3OUOTKWEsmEhPrn2yMih4/aLmjeB79zORALA=;
        b=AvlZP04J4J6kYwNmuee9U45Bpxy9RKWOn9Jv0AlEz9ZPZXerNGDTHk5X8zERZUzAbT
         7HdFAA3zYO3JiWFU6UOGfNBwJQnz5Xhn6r8OdcBgSUfXbR8VHny3N9cAfykjAbA0PTXt
         DZla3B+UY1P6FwQfD6+XoroT3qdX33L03qb/87pwjb2h6xUWvIw0giQIuwpfKayOh7LK
         F7CAg2j3cFPQ+e4pYoHfErjv9/TUCbL0iaid/TrA0LgrepfdkaSKri5DmdjXriM3elRY
         LVSbvEI9AjMk7TZEtIdCppN/JetFtIMAjKu8e8tJU/wVENSfnPS5eodZDDucgZMoOghU
         4GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DqPFt5x3OUOTKWEsmEhPrn2yMih4/aLmjeB79zORALA=;
        b=Q97Lxpri9IzUZZlK9G7PhDduCQuWiqUVaz7L/RYPIq8ZHHkUXRd6PmjjucXjzzWtlr
         OGWfcb75kxx37fqshfIINbJ8TDIRX5PYvW4BavWXy41UKxC3FyvXl6TRLVi0Wpsy5vOd
         r25cdb5eMt6gnuXInOULNoShrbqCcvQikKU6Ur94zj79Q2ivLOmelMSIo91mXYx0YqoN
         VNALdSTszAYg+ry3sTLmplNr8b4+ovAm2zYrWnrrHppfDtbRvEDQFPz/3tdvHhG3MVkN
         htJazfEfeWy9jjeW8x2Ly0LhdUdymX2C+YahXVpvvbxB+u7T6BrpgFH3T+n286nDduCA
         bKQA==
X-Gm-Message-State: AOUpUlFQfKHMosWdjPyMHeDX78lB1hltwJSOT5fQT9rVajuLGBeqIojs
        WEkBWdOCJDftfENKoPauKGE=
X-Google-Smtp-Source: AAOMgpeLTRFCpXECTNqdbylkjduwdE4P1bjE3OgsGeEaL3tm0K8Pwykmg7tnhneYpAnSFoA/06qnwg==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr966053pld.163.1531821391514;
        Tue, 17 Jul 2018 02:56:31 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id u2-v6sm1232542pfn.59.2018.07.17.02.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:56:31 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] arm64/mm: Create initial page tables in init_pg_dir
Date:   Tue, 17 Jul 2018 17:56:05 +0800
Message-Id: <20180717095608.11008-4-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717095608.11008-1-yaojun8558363@gmail.com>
References: <20180717095608.11008-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create initial page tables in init_pg_dir and then create final
page tables in swapper_pg_dir directly.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h |  2 ++
 arch/arm64/kernel/head.S         |  4 ++--
 arch/arm64/kernel/setup.c        |  1 +
 arch/arm64/mm/mmu.c              | 24 ++++--------------------
 4 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1bdeca8918a6..46ef21ebfe47 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -712,6 +712,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_end[];
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c3e4b1886cde..a5fc47ccf7f8 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -376,7 +376,7 @@ __create_page_tables:
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
-	adrp	x0, swapper_pg_dir
+	adrp	x0, init_pg_dir
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	mov	x4, PTRS_PER_PGD
@@ -833,7 +833,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
-	adrp	x1, swapper_pg_dir
+	adrp	x1, init_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..b065c08d4008 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -249,6 +249,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
 	init_mm.brk	   = (unsigned long) _end;
+	init_mm.pgd	   = init_pg_dir;
 
 	*cmdline_p = boot_command_line;
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..cdce3ec4c7bb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -629,26 +629,10 @@ static void __init map_kernel(pgd_t *pgdp)
  */
 void __init paging_init(void)
 {
-	phys_addr_t pgd_phys = early_pgtable_alloc();
-	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
-
-	map_kernel(pgdp);
-	map_mem(pgdp);
-
-	/*
-	 * We want to reuse the original swapper_pg_dir so we don't have to
-	 * communicate the new address to non-coherent secondaries in
-	 * secondary_entry, and so cpu_switch_mm can generate the address with
-	 * adrp+add rather than a load from some global variable.
-	 *
-	 * To do this we need to go via a temporary pgd.
-	 */
-	cpu_replace_ttbr1(__va(pgd_phys));
-	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
-
-	pgd_clear_fixmap();
-	memblock_free(pgd_phys, PAGE_SIZE);
+	map_kernel(swapper_pg_dir);
+	map_mem(swapper_pg_dir);
+	cpu_replace_ttbr1(swapper_pg_dir);
+	init_mm.pgd = swapper_pg_dir;
 
 	/*
 	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
-- 
2.17.1

