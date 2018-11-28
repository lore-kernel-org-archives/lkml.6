Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD59CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD920660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDD920660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeK1WsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:48:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9679 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbeK1WsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:48:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434f4q0Gzyz9v0B1;
        Wed, 28 Nov 2018 12:46:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RUKxz_ISEySv; Wed, 28 Nov 2018 12:46:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434f4p6vNqz9v09s;
        Wed, 28 Nov 2018 12:46:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C0CB8B867;
        Wed, 28 Nov 2018 12:46:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yQ1O-Qh54ehg; Wed, 28 Nov 2018 12:46:35 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA3C38B853;
        Wed, 28 Nov 2018 12:46:35 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CE5D969B1B; Wed, 28 Nov 2018 11:46:35 +0000 (UTC)
Message-Id: <ea7525741284e8d5ae18d284d55b231d8b94fb01.1543405086.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543405086.git.christophe.leroy@c-s.fr>
References: <cover.1543405086.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 07/16] powerpc/mm: add helpers to get/set
 mm.context->pte_frag
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 11:46:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to handle pte_fragment functions with single fragment
without adding pte_frag in all mm_context_t, this patch creates
two helpers which do nothing on platforms using a single fragment.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable.h | 31 +++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-frag.c     |  8 ++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 1c49ca31dcfe..74810bba45d2 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -110,6 +110,37 @@ void mark_initmem_nx(void);
 static inline void mark_initmem_nx(void) { }
 #endif
 
+/*
+ * When used, PTE_FRAG_NR is defined in subarch pgtable.h
+ * so we are sure it is included when arriving here.
+ */
+#ifndef PTE_FRAG_NR
+#define PTE_FRAG_NR		1
+#define PTE_FRAG_SIZE_SHIFT	PAGE_SHIFT
+#define PTE_FRAG_SIZE		(1UL << PTE_FRAG_SIZE_SHIFT)
+#endif
+
+#if PTE_FRAG_NR != 1
+static inline void *pte_frag_get(mm_context_t *ctx)
+{
+	return ctx->pte_frag;
+}
+
+static inline void pte_frag_set(mm_context_t *ctx, void *p)
+{
+	ctx->pte_frag = p;
+}
+#else
+static inline void *pte_frag_get(mm_context_t *ctx)
+{
+	return NULL;
+}
+
+static inline void pte_frag_set(mm_context_t *ctx, void *p)
+{
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 7544d0d7177d..af23a587f019 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -38,7 +38,7 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 		return NULL;
 
 	spin_lock(&mm->page_table_lock);
-	ret = mm->context.pte_frag;
+	ret = pte_frag_get(&mm->context);
 	if (ret) {
 		pte_frag = ret + PTE_FRAG_SIZE;
 		/*
@@ -46,7 +46,7 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 		 */
 		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
 			pte_frag = NULL;
-		mm->context.pte_frag = pte_frag;
+		pte_frag_set(&mm->context, pte_frag);
 	}
 	spin_unlock(&mm->page_table_lock);
 	return (pte_t *)ret;
@@ -86,9 +86,9 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 	 * the allocated page with single fragement
 	 * count.
 	 */
-	if (likely(!mm->context.pte_frag)) {
+	if (likely(!pte_frag_get(&mm->context))) {
 		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
-		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
+		pte_frag_set(&mm->context, ret + PTE_FRAG_SIZE);
 	}
 	spin_unlock(&mm->page_table_lock);
 
-- 
2.13.3

