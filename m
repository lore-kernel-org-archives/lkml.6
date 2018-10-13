Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C6C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C81F206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pDZBu+4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C81F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJMWy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:54:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeJMWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e1yvJYNep1THwrAkDEjv/oFZB/ZP1sXXao85vjBf4xY=; b=pDZBu+4OHXoUWcn6aI3vexvg65
        KoVfbO4XZVKzTW+/H0kgUjQkvRkWhg31t6FAxzcPZuVrjQpcbSfGAW41kyoMlsAWTPLGiy/+ZhIAl
        l7LHwmnJvoz2TN7aDmgTzu0Br0hdg1YS6/oMUTE3eJg1Y8x+stmMyojqvAy0271S+4axj2JypC7iO
        RgcKt8oOjIZ+zzdEn8UlkJ+XN5M/bD1prAFoNPyOIm9Bxo8AlyN8cSKHw5jVxlyGyUowA9Y8nR2r3
        op0YlnPQ07EirjVb8T4Z4bKigfEUGnPyEoZXASJWBz5VIPeQXwIM8SNEZMlD9pu0RRTHybsRec+B/
        AZycX66w==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLfR-00052p-ST; Sat, 13 Oct 2018 15:17:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
Date:   Sat, 13 Oct 2018 17:17:05 +0200
Message-Id: <20181013151707.32210-7-hch@lst.de>
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
 drivers/gpu/drm/sti/sti_gdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index c32de6cbf061..cdf0a1396e00 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -517,7 +517,7 @@ static void sti_gdp_init(struct sti_gdp *gdp)
 	/* Allocate all the nodes within a single memory page */
 	size = sizeof(struct sti_gdp_node) *
 	    GDP_NODE_PER_FIELD * GDP_NODE_NB_BANK;
-	base = dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL | GFP_DMA);
+	base = dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL);
 
 	if (!base) {
 		DRM_ERROR("Failed to allocate memory for GDP node\n");
-- 
2.19.1

