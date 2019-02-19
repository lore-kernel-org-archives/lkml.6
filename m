Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0458820818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p61e+kcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfBSKdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfBSKdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xnijaTD9/LTfaSe8x9OwrOkkSMxAqrZQqnN4cMRi0xo=; b=p61e+kcQCih0IRI1ErTzuM4kht
        Uh20OG4wyZhC/0sjvGGI8snWLIySrUjTH0eXRF/kuCOeStMlOuhb1cSq5ZUzAyLxpXbw/JO+ju5Lq
        AS8Kd2fO9l4QgNBDTG66PEz0pMue0RJ+fmKzJVgQHWSVupOQejCwbVjeHFej+M1v0RZde+2TEDw09
        g2iz5RjFLUxXhGzmP1sET6oLXhDe90E3xcZaJrnsXCKaBk87FyxIfTn76CJuyiyg4MKM1nrsWei0z
        tTlafjMFlfeacNBOmMhsngudoOcFfKjGGkfZefiM4CEZQJrC4sUE55eOIIcbqgIwVpt+yUhrLoseH
        HP65Z8rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hp-0006Zi-Je; Tue, 19 Feb 2019 10:32:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 84DF6285205A5; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.927987010@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:32:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH v6 18/18] asm-generic/tlb: Remove tlb_table_flush()
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no external users of this API (nor should there be); remove it.

Acked-by: Will Deacon <will.deacon@arm.com>
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


