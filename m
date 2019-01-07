Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B919C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D366B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="K1q9rjXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfAGQLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:11:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42271 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfAGQL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:11:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so350673plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t2eEqpoIDFvDG2gAO/fqfzYdvBoxxIkAd2CWhpFMFaE=;
        b=K1q9rjXHYg/XE/gYjtrKRPXFj2vv+NgpkDNWFCPt0FYOROE3IN/vc/V38JtDYXDryO
         wUZuCo7mRDTty67q70n29YIzOsbnZgN1Jmfxh5DtiXFGTBakfxzPFk55n5RZ15K29ZNd
         x/VlMl4MvFbnilVcC7enJyqpEcMhwlIZfUVqVB+YZ6V6oeX/dgDpip15PFYSBJSWI3rY
         v+9goMMgNuwpiDiLP8g4Hl8jioFVAZc84j5P8CcWM4dhvOw5QzDbFghNjqnL4Bb2oFEM
         79GR4MytTX4Ce6nWixQ+cXmQn3OalLIgx/ix0ov2x8lj5MHjqiSgMVXlKmjY4qoI8pyL
         rDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t2eEqpoIDFvDG2gAO/fqfzYdvBoxxIkAd2CWhpFMFaE=;
        b=k0Fb8XHu2QQZwnIZmix4+U4CkNdQwuyAP7JYXFcwwkkl6SSpl3wAfa4MC/eg8JBkvd
         GC/17ADC3DScAlGoW11fMHoJKDYaLE27Yt8IWMUGh+ogDxDpvyz60cBvWMoVOjhl7XGr
         RBqA0ciZNcOBk99J3gIZkd+GM2OxADR1ymHAGCiv2oRd/RShnxUbxqoPAtJc6WoW/Dpc
         gd6tM1tg3r/C2aOrS9zuQeG31/wazcgN1N+3/kSnmpEU9jqDNjAV1hH99/LCokdN4Vpf
         CMQsccLlGKwZz8mIr18cUvjXyWO0uhboq08OJn7oQs3+Co8JG2TT1wtYM1sHXzLGmTv9
         bJtA==
X-Gm-Message-State: AJcUukc4tCi9jOlb/Or0yzBHIdegxopxxvvH6F1U1jMxSjdwBcdG74yE
        ptHnNbMS/d9onqQSDT1UYVO4lQ==
X-Google-Smtp-Source: ALg8bN4rv79GPRCMZZRRUYzTPZUTJRiPCBKRvB+SoPWGOw9W/9hS/LCTjOsk5w2dK8fNTCDnM6Wk7Q==
X-Received: by 2002:a17:902:b093:: with SMTP id p19mr61640077plr.135.1546877487094;
        Mon, 07 Jan 2019 08:11:27 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.214])
        by smtp.gmail.com with ESMTPSA id a10sm93243512pfi.138.2019.01.07.08.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:11:26 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 4/5] RISC-V: Move setup_vm() to mm/init.c
Date:   Mon,  7 Jan 2019 21:40:46 +0530
Message-Id: <20190107161047.10516-5-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107161047.10516-1-anup@brainfault.org>
References: <20190107161047.10516-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

The setup_vm() is responsible for setting up initial
page table hence should be placed in mm/init.c.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/setup.c | 49 --------------------------------------
 arch/riscv/mm/init.c      | 50 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 49a13b98e13f..e9c7f1a6db5a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -102,55 +102,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
-pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned_bss;
-pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
-#endif
-
-asmlinkage void __init setup_vm(void)
-{
-	extern char _start;
-	uintptr_t i;
-	uintptr_t pa = (uintptr_t) &_start;
-	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
-
-	va_pa_offset = PAGE_OFFSET - pa;
-	pfn_base = PFN_DOWN(pa);
-
-	/* Sanity check alignment and size */
-	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
-	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
-		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
-			__pgprot(_PAGE_TABLE));
-	trampoline_pmd[0] = pfn_pmd(PFN_DOWN(pa), prot);
-
-	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
-		swapper_pg_dir[o] =
-			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
-				__pgprot(_PAGE_TABLE));
-	}
-	for (i = 0; i < ARRAY_SIZE(swapper_pmd); i++)
-		swapper_pmd[i] = pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
-#else
-	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
-		pfn_pgd(PFN_DOWN(pa), prot);
-
-	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
-		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
-		swapper_pg_dir[o] =
-			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
-	}
-#endif
-}
-
 void __init parse_dtb(unsigned int hartid, void *dtb)
 {
 	early_init_dt_scan(__va(dtb));
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d0965979ee70..b487f76d6060 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -102,3 +102,53 @@ void __init setup_bootmem(void)
 				  &memblock.memory, 0);
 	}
 }
+
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
+pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned_bss;
+pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+#endif
+
+asmlinkage void __init setup_vm(void)
+{
+	extern char _start;
+	size_t o;
+	uintptr_t i;
+	uintptr_t pa = (uintptr_t) &_start;
+	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
+
+	va_pa_offset = PAGE_OFFSET - pa;
+	pfn_base = PFN_DOWN(pa);
+
+	/* Sanity check alignment and size */
+	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
+	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
+		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
+			__pgprot(_PAGE_TABLE));
+	trampoline_pmd[0] = pfn_pmd(PFN_DOWN(pa), prot);
+
+	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
+		o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+		swapper_pg_dir[o] =
+			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
+				__pgprot(_PAGE_TABLE));
+	}
+	for (i = 0; i < ARRAY_SIZE(swapper_pmd); i++)
+		swapper_pmd[i] = pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
+#else
+	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
+		pfn_pgd(PFN_DOWN(pa), prot);
+
+	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
+		o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+		swapper_pg_dir[o] =
+			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
+	}
+#endif
+}
-- 
2.17.1

