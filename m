Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FAAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA5E206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfBXNWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfBXNWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:22:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47DF9C057F40;
        Sun, 24 Feb 2019 13:22:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F030F6017E;
        Sun, 24 Feb 2019 13:22:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] x86/mm/KASLR: Only build one PUD entry of area for real mode trampoline
Date:   Sun, 24 Feb 2019 21:22:30 +0800
Message-Id: <20190224132231.4878-2-bhe@redhat.com>
In-Reply-To: <20190224132231.4878-1-bhe@redhat.com>
References: <20190224132231.4878-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 24 Feb 2019 13:22:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code builds identity mapping for real mode treampoline by
borrowing page tables from the direct mapping section if KASLR is
enabled. It will copy present entries of the first PUD table in 4-level
paging mode, or the first P4D table in 5-level paging mode.

However, there's only a very small area under low 1 MB reserved
for real mode trampoline in reserve_real_mode(). Makes no sense
to build up so large area of mapping for it. Since the randomization
granularity in 4-level is 1 GB, and 512 GB in 5-level, only copying
one PUD entry is enough.

Hence, only copy one PUD entry of area where physical address 0
resides. And this is preparation for later changing the randomization
granularity of 5-level paging mode from 512 GB to 1 GB.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 72 ++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 754b5da91d43..6b2a06c36b6f 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -226,74 +226,58 @@ void __init kernel_randomize_memory(void)
 
 static void __meminit init_trampoline_pud(void)
 {
-	unsigned long paddr, paddr_next;
+	unsigned long paddr, vaddr;
 	pgd_t *pgd;
-	pud_t *pud_page, *pud_page_tramp;
-	int i;
 
+	p4d_t *p4d_page, *p4d_page_tramp, *p4d, *p4d_tramp;
+	pud_t *pud_page, *pud_page_tramp, *pud, *pud_tramp;
+
+
+	p4d_page_tramp = alloc_low_page();
 	pud_page_tramp = alloc_low_page();
 
 	paddr = 0;
+	vaddr = (unsigned long)__va(paddr);
 	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
 
-	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
-		pud_t *pud, *pud_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
+	if (pgtable_l5_enabled()) {
+		p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
+		p4d = p4d_page + p4d_index(vaddr);
 
-		pud_tramp = pud_page_tramp + pud_index(paddr);
+		pud_page = (pud_t *) p4d_page_vaddr(*p4d);
 		pud = pud_page + pud_index(vaddr);
-		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
-
-		*pud_tramp = *pud;
-	}
-
-	set_pgd(&trampoline_pgd_entry,
-		__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
-}
-
-static void __meminit init_trampoline_p4d(void)
-{
-	unsigned long paddr, paddr_next;
-	pgd_t *pgd;
-	p4d_t *p4d_page, *p4d_page_tramp;
-	int i;
 
-	p4d_page_tramp = alloc_low_page();
+		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
+		pud_tramp = pud_page_tramp + pud_index(paddr);
 
-	paddr = 0;
-	pgd = pgd_offset_k((unsigned long)__va(paddr));
-	p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
+		*pud_tramp = *pud;
 
-	for (i = p4d_index(paddr); i < PTRS_PER_P4D; i++, paddr = paddr_next) {
-		p4d_t *p4d, *p4d_tramp;
-		unsigned long vaddr = (unsigned long)__va(paddr);
+		set_p4d(p4d_tramp,
+			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
-		p4d = p4d_page + p4d_index(vaddr);
-		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
+		set_pgd(&trampoline_pgd_entry,
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+	} else {
+		pud_page = (pud_t *) pgd_page_vaddr(*pgd);
+		pud = pud_page + pud_index(vaddr);
 
-		*p4d_tramp = *p4d;
+		pud_tramp = pud_page_tramp + pud_index(paddr);
+		*pud_tramp = *pud;
+		set_pgd(&trampoline_pgd_entry,
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
 	}
-
-	set_pgd(&trampoline_pgd_entry,
-		__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
 }
 
 /*
- * Create PGD aligned trampoline table to allow real mode initialization
- * of additional CPUs. Consume only 1 low memory page.
+ * Create PUD aligned trampoline table to allow real mode initialization
+ * of additional CPUs. Consume only 1 or 2 low memory pages.
  */
 void __meminit init_trampoline(void)
 {
-
 	if (!kaslr_memory_enabled()) {
 		init_trampoline_default();
 		return;
 	}
 
-	if (pgtable_l5_enabled())
-		init_trampoline_p4d();
-	else
-		init_trampoline_pud();
+	init_trampoline_pud();
 }
-- 
2.17.2

