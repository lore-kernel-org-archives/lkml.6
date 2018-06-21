Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070A5C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC36A22421
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUW3s9pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC36A22421
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeFUVc4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:32:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933962AbeFUV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u4pWhv/Ox/6vMdukP9HQnAGQXeBsSLLtCnwBKGoq2GQ=; b=XUW3s9pFjzZ8uvOrslZPfk+j5
        VohCz8aDrwdeiLEhWQcGRzIIhJjcjzr6xjd3Wvyg02dV0TLdf+grz8ONMAg3y2b4wjrb04bEWBW70
        I7JLyipi7mr56+q7Xp0gAVQXuPrXD93OMg3MqLG73NKcTrdQ+huwBHy9rkiOPgi9JfHkJ0PqwgFjY
        6Li+FZZVuMrn4xCm5EetXF/EILy83ikPwm2CtofdI0ZAFI4V4JWrS9kPzWWzfRUPlZsVxM961YUcH
        O8nmUVFCiWV7ZD6+zZ8hzNMb1gRoraOLi2t6JISZq3qaKk2PM4vNJVxVbBwaTRpBuZ9ULL2Y1VQeR
        2Jqz9lOXg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78f-0001br-87; Thu, 21 Jun 2018 21:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA API
Date:   Thu, 21 Jun 2018 14:28:22 -0700
Message-Id: <20180621212835.5636-14-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc_range is the perfect fit for this use case.  Eliminates
a custom spinlock, a call to ida_pre_get and a local check for the
allocated ID exceeding a maximum.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 arch/powerpc/mm/mmu_context_book3s64.c | 44 +++-----------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index f3d4b4a0e561..5a0cf2cc8ba0 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -26,48 +26,16 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
-static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
 static int alloc_context_id(int min_id, int max_id)
 {
-	int index, err;
-
-again:
-	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
-		return -ENOMEM;
-
-	spin_lock(&mmu_context_lock);
-	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
-	spin_unlock(&mmu_context_lock);
-
-	if (err == -EAGAIN)
-		goto again;
-	else if (err)
-		return err;
-
-	if (index > max_id) {
-		spin_lock(&mmu_context_lock);
-		ida_remove(&mmu_context_ida, index);
-		spin_unlock(&mmu_context_lock);
-		return -ENOMEM;
-	}
-
-	return index;
+	return ida_alloc_range(&mmu_context_ida, min_id, max_id, GFP_KERNEL);
 }
 
 void hash__reserve_context_id(int id)
 {
-	int rc, result = 0;
-
-	do {
-		if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
-			break;
-
-		spin_lock(&mmu_context_lock);
-		rc = ida_get_new_above(&mmu_context_ida, id, &result);
-		spin_unlock(&mmu_context_lock);
-	} while (rc == -EAGAIN);
+	int result = ida_alloc_range(&mmu_context_ida, id, id, GFP_KERNEL);
 
 	WARN(result != id, "mmu: Failed to reserve context id %d (rc %d)\n", id, result);
 }
@@ -172,9 +140,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 
 void __destroy_context(int context_id)
 {
-	spin_lock(&mmu_context_lock);
-	ida_remove(&mmu_context_ida, context_id);
-	spin_unlock(&mmu_context_lock);
+	ida_free(&mmu_context_ida, context_id);
 }
 EXPORT_SYMBOL_GPL(__destroy_context);
 
@@ -182,13 +148,11 @@ static void destroy_contexts(mm_context_t *ctx)
 {
 	int index, context_id;
 
-	spin_lock(&mmu_context_lock);
 	for (index = 0; index < ARRAY_SIZE(ctx->extended_id); index++) {
 		context_id = ctx->extended_id[index];
 		if (context_id)
-			ida_remove(&mmu_context_ida, context_id);
+			ida_free(&mmu_context_ida, context_id);
 	}
-	spin_unlock(&mmu_context_lock);
 }
 
 static void pte_frag_destroy(void *pte_frag)
-- 
2.17.1

