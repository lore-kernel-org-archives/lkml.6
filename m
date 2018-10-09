Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAE1214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jAjkCpyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAE1214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJIWPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:15:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeJIWO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hnxHqf1AfuWny81VWMegGHEz50fSMVPDlsdkhd5JvH4=; b=jAjkCpyEN0dQl4Aw/hNXICk+a7
        Ka916XnA40l6D1pFbME8MB6z6+Hj00ECJLJbGc6DUpnXb6LWyXufnKgkeqAEpvtca1VR+p9fkN45h
        JLqDOR6i1UGLydVKsdXX+BW6JUvp2F4xi6IbdBA/VVAAQAdLN7fSYvdWtp3u6bsZ5GGRLirOM22BR
        ad1COFZNVGTw/Z4Rvnj7MWspA15sAtrbDJq5jsEiXHpIsGM/MGVmgYJPUfLzRIULVUZ9CT1NCoZ4C
        t/AidAg3cGOzQPAcfvpZZa9+N6G4KjIPUvPWo0o0lBFItY6omYC99+zqiO3CrVwTXdEuStKHoTUdN
        iEW7y58A==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tS7-0001Zh-W2; Tue, 09 Oct 2018 14:57:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] fore200e: don't use GFP_DMA
Date:   Tue,  9 Oct 2018 16:57:19 +0200
Message-Id: <20181009145720.32578-7-hch@lst.de>
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

The driver properly uses the DMA mapping API, so it should not
pointlessly dip into the GFP_DMA pool, which is only 16MB on x86.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/atm/fore200e.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 86be269500a9..7eda1a8c3d8c 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -184,7 +184,7 @@ fore200e_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk, int size, i
     chunk->alloc_size = size + alignment;
     chunk->direction  = direction;
 
-    chunk->alloc_addr = kzalloc(chunk->alloc_size, GFP_KERNEL | GFP_DMA);
+    chunk->alloc_addr = kzalloc(chunk->alloc_size, GFP_KERNEL);
     if (chunk->alloc_addr == NULL)
 	return -ENOMEM;
 
@@ -1527,7 +1527,7 @@ fore200e_send(struct atm_vcc *vcc, struct sk_buff *skb)
     }
     
     if (tx_copy) {
-	data = kmalloc(tx_len, GFP_ATOMIC | GFP_DMA);
+	data = kmalloc(tx_len, GFP_ATOMIC);
 	if (data == NULL) {
 	    if (vcc->pop) {
 		vcc->pop(vcc, skb);
@@ -1664,7 +1664,7 @@ fore200e_getstats(struct fore200e* fore200e)
     u32                     stats_dma_addr;
 
     if (fore200e->stats == NULL) {
-	fore200e->stats = kzalloc(sizeof(struct stats), GFP_KERNEL | GFP_DMA);
+	fore200e->stats = kzalloc(sizeof(struct stats), GFP_KERNEL);
 	if (fore200e->stats == NULL)
 	    return -ENOMEM;
     }
@@ -1966,7 +1966,7 @@ static int fore200e_irq_request(struct fore200e *fore200e)
 
 static int fore200e_get_esi(struct fore200e *fore200e)
 {
-    struct prom_data* prom = kzalloc(sizeof(struct prom_data), GFP_KERNEL | GFP_DMA);
+    struct prom_data* prom = kzalloc(sizeof(struct prom_data), GFP_KERNEL);
     int ok, i;
 
     if (!prom)
-- 
2.19.0

