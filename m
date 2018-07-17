Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F162ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CD9208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Dv6RER4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD9208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeGQEzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:55:15 -0400
Received: from ozlabs.org ([203.11.71.1]:37161 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbeGQEzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:55:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 41V6cj4JGzz9s4V; Tue, 17 Jul 2018 14:24:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1531801477;
        bh=5RimgVeYcZFptkUhq4bYy3VPYwhLVyHNfWy59GP1lVI=;
        h=From:To:Cc:Subject:Date:From;
        b=Dv6RER4/YVeycDu0CnQczkBKmo/mr3cFLcYqQx/NJJ7gpj8bMrR8CwDHgZvUntZjp
         9/EtZ7J4lpeH3TwoxouBnhPdfV1EX6+rwOCHMiL8Wh9scs+c0tpQWLqT+pt8xyt0Fq
         Na0N0Sd5eA2sfSsz4nh3mnHVFT2s4S2nYRNJc+OE=
From:   David Gibson <david@gibson.dropbear.id.au>
To:     aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] powerpc/hugetlbpage: Rmove unhelpful HUGEPD_*_SHIFT macros
Date:   Tue, 17 Jul 2018 14:24:30 +1000
Message-Id: <20180717042430.15395-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HUGEPD_*_SHIFT macros are always defined to be PGDIR_SHIFT and
PUD_SHIFT, and have to have those values to work properly.  They once used
to have different values, but that was really only because they were used
to mean different things in different contexts.

6fa50483 "powerpc/mm/hugetlb: initialize the pagetable cache correctly for
hugetlb" removed that double meaning, but left the now useless constants.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/mm/hugetlbpage.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8a9a49c13865..acbbaabdaaf8 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -117,15 +117,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	return 0;
 }
 
-/*
- * These macros define how to determine which level of the page table holds
- * the hpdp.
- */
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-#define HUGEPD_PGD_SHIFT PGDIR_SHIFT
-#define HUGEPD_PUD_SHIFT PUD_SHIFT
-#endif
-
 /*
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
@@ -174,13 +165,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 		}
 	}
 #else
-	if (pshift >= HUGEPD_PGD_SHIFT) {
+	if (pshift >= PGDIR_SHIFT) {
 		ptl = &mm->page_table_lock;
 		hpdp = (hugepd_t *)pg;
 	} else {
 		pdshift = PUD_SHIFT;
 		pu = pud_alloc(mm, pg, addr);
-		if (pshift >= HUGEPD_PUD_SHIFT) {
+		if (pshift >= PUD_SHIFT) {
 			ptl = pud_lockptr(mm, pu);
 			hpdp = (hugepd_t *)pu;
 		} else {
@@ -695,9 +686,9 @@ static int __init hugetlbpage_init(void)
 		else
 			pdshift = PMD_SHIFT;
 #else
-		if (shift < HUGEPD_PUD_SHIFT)
+		if (shift < PUD_SHIFT)
 			pdshift = PMD_SHIFT;
-		else if (shift < HUGEPD_PGD_SHIFT)
+		else if (shift < PGDIR_SHIFT)
 			pdshift = PUD_SHIFT;
 		else
 			pdshift = PGDIR_SHIFT;
-- 
2.17.1

