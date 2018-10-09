Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38166ECDE21
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B8A21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QqbsBxPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B8A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJIWOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:14:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7CvqXiZQkSJiuWcg49/OIaaUtcPQ1ENevvo052wR3dE=; b=QqbsBxPz3WOLX9mo8DIZK1/jS2
        OmPFzPAdxxLBNFcEyoh2eYCxHr0VLL9LU3uiV8G2Vhxw5+JzJ5vslh2z9hNDOwmI+NWEelX8ar9fx
        euISgvuCNwmgh8ZGaNMPtu3g4NfYkyJNIZG6WRLP+okfHzJ24e5InVS/XCUi+CpGeiQ3iuoTqsjKv
        abPglQXccPOHZ9udawe1SsBEk7O1M7lvUQ8rvl7kr0UakBuhksuNvVwwaZDHOv43z5HBdUjXgeZFl
        +BgCMoTC/CrhWqG1bjA566LEJStVLs46PLfXfGUr9WWSoaXU5yM8RpoYQzbQ2sxzVz3ygg6O0ggC3
        XM94K8LA==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tRz-0001Z8-3z; Tue, 09 Oct 2018 14:57:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] fore200e: remove the align_size field of struct chunk
Date:   Tue,  9 Oct 2018 16:57:16 +0200
Message-Id: <20181009145720.32578-4-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009145720.32578-1-hch@lst.de>
References: <20181009145720.32578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for this field, as the only user of it can just use
the local size variable instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/atm/fore200e.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 0b8d2ad8273d..05951550abb8 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -182,7 +182,6 @@ fore200e_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk, int size, i
 	alignment = 0;
 
     chunk->alloc_size = size + alignment;
-    chunk->align_size = size;
     chunk->direction  = direction;
 
     chunk->alloc_addr = kzalloc(chunk->alloc_size, GFP_KERNEL | GFP_DMA);
@@ -194,7 +193,7 @@ fore200e_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk, int size, i
     
     chunk->align_addr = chunk->alloc_addr + offset;
 
-    chunk->dma_addr = fore200e->bus->dma_map(fore200e, chunk->align_addr, chunk->align_size, direction);
+    chunk->dma_addr = fore200e->bus->dma_map(fore200e, chunk->align_addr, size, direction);
     
     return 0;
 }
@@ -740,7 +739,7 @@ static void fore200e_sba_dma_sync_for_device(struct fore200e *fore200e, u32 dma_
 static int fore200e_sba_dma_chunk_alloc(struct fore200e *fore200e, struct chunk *chunk,
 					int size, int nbr, int alignment)
 {
-	chunk->alloc_size = chunk->align_size = size * nbr;
+	chunk->alloc_size = size * nbr;
 
 	/* returned chunks are page-aligned */
 	chunk->alloc_addr = dma_alloc_coherent(fore200e->dev, chunk->alloc_size,
-- 
2.19.0

