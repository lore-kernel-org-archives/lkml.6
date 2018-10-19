Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF07ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BEC21480
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BEC21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJSO7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:59:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16954 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSO7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:59:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42bxVn1hZJz9ttFV;
        Fri, 19 Oct 2018 08:54:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CNw8-ohXJPHT; Fri, 19 Oct 2018 08:54:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42bxVn1Bssz9ttFM;
        Fri, 19 Oct 2018 08:54:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5AAEF8B8E0;
        Fri, 19 Oct 2018 08:54:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eGjLXfmv-rDB; Fri, 19 Oct 2018 08:54:58 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FA408B75B;
        Fri, 19 Oct 2018 08:54:58 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3151C6F496; Fri, 19 Oct 2018 06:54:58 +0000 (UTC)
Message-Id: <7126e8b14b566b756d1fbfa31f09898b35fd8bba.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 03/20] powerpc/mm: Avoid useless lock with single page
 fragments
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Oct 2018 06:54:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in taking the page table lock as pte_frag or
pmd_frag are always NULL when we have only one fragment.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable-book3s64.c | 3 +++
 arch/powerpc/mm/pgtable-frag.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 84ff3403239c..9f78db7c8c2a 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -243,6 +243,9 @@ static pmd_t *get_pmd_from_cache(struct mm_struct *mm)
 {
 	void *pmd_frag, *ret;
 
+	if (PMD_FRAG_NR == 1)
+		return NULL;
+
 	spin_lock(&mm->page_table_lock);
 	ret = mm->context.pmd_frag;
 	if (ret) {
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index d61e7c2a9a79..7544d0d7177d 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -34,6 +34,9 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 {
 	void *pte_frag, *ret;
 
+	if (PTE_FRAG_NR == 1)
+		return NULL;
+
 	spin_lock(&mm->page_table_lock);
 	ret = mm->context.pte_frag;
 	if (ret) {
-- 
2.13.3

