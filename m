Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F7BC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D78921477
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qmkodix1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D78921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJMWyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:54:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbeJMWyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ohQ5syK/otETP/Mb0BWb0FhcKVVuuwT6fRAqMl8W+4s=; b=qmkodix1qyB0dqneOvg4qfdTho
        JE2wMoT0niwTOisSSLI7PXDiX1NPoUmSmCbZZeVbJkAr2fLgT4uZXyPOYKeN1dE2UQXzT0QZ+6trM
        gjO3Jo10F5h0uYKsuoC4ilzPLtME9qKNVY2EI18m5A7ilzYC/Yb3tWBQkFjMpOxDyn156ZpQJ46Sd
        W75/vVV/BFyfSD8zKnW/iyqQGA1bvsVAlCNAzlYT7QTHFICXS3/No6HNfPL8ut67W+rLd8s/w2hnQ
        N+/U+kJeCeksz8N1KYJZpJDYrxbddCFHyuCP5l06z/jmzX84oY3BseZw+yRpIb0y8KCAYPj4MkWsP
        wz5ZDLGg==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLfM-00051K-Hn; Sat, 13 Oct 2018 15:17:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] sound: hpios: don't pass GFP_DMA32 to dma_alloc_coherent
Date:   Sat, 13 Oct 2018 17:17:03 +0200
Message-Id: <20181013151707.32210-5-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181013151707.32210-1-hch@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API does its own zone decisions based on the coherent_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/pci/asihpi/hpios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
index 5ef4fe964366..7c91330af719 100644
--- a/sound/pci/asihpi/hpios.c
+++ b/sound/pci/asihpi/hpios.c
@@ -49,7 +49,7 @@ u16 hpios_locked_mem_alloc(struct consistent_dma_area *p_mem_area, u32 size,
 	/*?? any benefit in using managed dmam_alloc_coherent? */
 	p_mem_area->vaddr =
 		dma_alloc_coherent(&pdev->dev, size, &p_mem_area->dma_handle,
-		GFP_DMA32 | GFP_KERNEL);
+		GFP_KERNEL);
 
 	if (p_mem_area->vaddr) {
 		HPI_DEBUG_LOG(DEBUG, "allocated %d bytes, dma 0x%x vma %p\n",
-- 
2.19.1

