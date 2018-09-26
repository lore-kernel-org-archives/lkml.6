Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB61C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DB5214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JAUZDEpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DB5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeIZSHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeIZSHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WaLjinVEspX0O+0lLuyjlJBGguoL7I8ZRB9m9FveuTs=; b=JAUZDEpVN1a7aakroh+E8gNgii
        Y7gvDl/yidhk8qNXrRuRKMorNEl1Wy08pNzMRNIcG4dz78hAhENWJhR8rMAK34JlEFyK+fbJ2lC6T
        sH4ISC17a+6T4fmBcb/A2ty0gSvS32cTLg3OYReiE9Z1ObwMBjxDFsPUyZMe0JnuL2EW7aBB6cLkS
        ObK7td3D0/PPYXvspU2El5Paj/AC7s6mEOe8/u1U7KytCrv9z88aM7JVDqU1F21nHGUkr0eVH6io4
        kz+HumdQ57Q3bZSvf2HzpVLh796U13lvgScXPhoMndasUrQlYJj9iLn5zcFV/s8GgABFeHRk8Susg
        uiX1zidQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oy-00063O-8J; Wed, 26 Sep 2018 11:54:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C990E206F1838; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114801.468888082@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 18/18] asm-generic/tlb: Remove tlb_table_flush()
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no external users of this API (nor should there be); remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    1 -
 mm/mmu_gather.c           |   34 +++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -174,7 +174,6 @@ struct mmu_table_batch {
 #define MAX_TABLE_BATCH		\
 	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
 
-extern void tlb_table_flush(struct mmu_gather *tlb);
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
 #endif
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,22 +91,6 @@ bool __tlb_remove_page_size(struct mmu_g
 
 #endif /* HAVE_MMU_GATHER_NO_GATHER */
 
-static void tlb_flush_mmu_free(struct mmu_gather *tlb)
-{
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb_table_flush(tlb);
-#endif
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
-	tlb_batch_pages_flush(tlb);
-#endif
-}
-
-void tlb_flush_mmu(struct mmu_gather *tlb)
-{
-	tlb_flush_mmu_tlbonly(tlb);
-	tlb_flush_mmu_free(tlb);
-}
-
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 
 /*
@@ -159,7 +143,7 @@ static void tlb_remove_table_rcu(struct
 	free_page((unsigned long)batch);
 }
 
-void tlb_table_flush(struct mmu_gather *tlb)
+static void tlb_table_flush(struct mmu_gather *tlb)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
 
@@ -191,6 +175,22 @@ void tlb_remove_table(struct mmu_gather
 
 #endif /* CONFIG_HAVE_RCU_TABLE_FREE */
 
+static void tlb_flush_mmu_free(struct mmu_gather *tlb)
+{
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb_table_flush(tlb);
+#endif
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+	tlb_batch_pages_flush(tlb);
+#endif
+}
+
+void tlb_flush_mmu(struct mmu_gather *tlb)
+{
+	tlb_flush_mmu_tlbonly(tlb);
+	tlb_flush_mmu_free(tlb);
+}
+
 /**
  * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
  * @tlb: the mmu_gather structure to initialize


