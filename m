Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FE825529
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU24nm74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FE825529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964883AbeGBLRm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:17:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44919 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933436AbeGBLRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:17:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id j3-v6so7365911pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OMw/YQpPoYxWHrkBBC9sGgaYiXQ0YeuDhG8NQ04XFWA=;
        b=bU24nm74uYvLuhGsxvvKPWrDRJ5Obu1nxLfUwqNFH4rX3JN3Cs/lORQWpuIOnrNRkk
         gTKW3MXgD8VkLH9bYIXVE4JzyobNZOwaJxE5M/1zZ11WcqzbEFEeA/qLyVR1k1S9khz6
         A31jR0C2i2pFma2T70T93h7Mbb4sx323TWeMfWdhCm9ofgaU9obflAe/bdwFFHE6FJct
         SpUpNsUSQfawYvph52ICCdKCM7srD+1aCgY9xVumY4E0JZN0WxDWAXq9+wgj63EEFJsj
         w+4g6dcx+MkPHGuFI30ib4SCWMXk09QeDGhYgUSI6Ol2E0RikXGZXjcatdUfuJMpBLqb
         asYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OMw/YQpPoYxWHrkBBC9sGgaYiXQ0YeuDhG8NQ04XFWA=;
        b=aZqjoxOW5PtcZQG+Tl+U7gz5ruA5MFvvprmkZmHX1CfsVafeUTxJWjNtCfRwxNCfHC
         JSlrAlWmMEcSsHDIDE3zXQWWyE7gJ3nm5kVunNkbTeXL25oBQm4sMWP7oC4x4EOivtI8
         1m2QoTj8YppRmJbJPY4G5S7aPUP+Qe3WF2grsgSwkKImQTsmYKTZyMFGmCZFGMwXPXLc
         TbzSRz7zbpIXMFNlAVIOMMrnwiGFVjxdBX8dC3xbpr06bHGa2s81HLBsZvXRmIyID2g3
         RaTk8EZbiGZ3a22DOhO0hA7yWSHi/pz314PhNxra2Qv5MearuOCAbFelUyo8/ob15nWp
         bpCA==
X-Gm-Message-State: APt69E07jAhYFJ5Bk8auf2qO/pzIkKHPi4tObmhh+sF9LJIABgWcGQJD
        lXysRxzaNNKnKoyochNTS94HUQ==
X-Google-Smtp-Source: AAOMgpd8DIa/O2EHrtOhfG9sRjFRrriBjusbhQ91vF5vVygXhnJcBqMEvntVJxxJM1KsOyvNmRSE+w==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr15234780pga.353.1530530257705;
        Mon, 02 Jul 2018 04:17:37 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id s2-v6sm11262150pfh.186.2018.07.02.04.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:17:37 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] arm64/mm: Create initial page tables in init_pg_dir
Date:   Mon,  2 Jul 2018 19:16:57 +0800
Message-Id: <20180702111659.25570-4-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702111659.25570-1-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
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
index 7c4c8f318ba9..3b408f21fe2e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -718,6 +718,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD] __section(.init.data);
+extern pgd_t init_pg_end[] __section(.init.data);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a1c7a4d3b9f3..a8e9432ffa8a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -380,7 +380,7 @@ __create_page_tables:
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
-	adrp	x0, swapper_pg_dir
+	adrp	x0, init_pg_dir
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	mov	x4, PTRS_PER_PGD
@@ -837,7 +837,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
-	adrp	x26, swapper_pg_dir
+	adrp	x26, init_pg_dir
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
index 2dbb2c9f1ec1..a7ab0010ff80 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -628,26 +628,10 @@ static void __init map_kernel(pgd_t *pgdp)
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

