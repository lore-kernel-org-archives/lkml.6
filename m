Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCFAC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C31206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dE9eewrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C31206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJMWzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:55:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeJMWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qH0ObQVGjrg0B0IoShemPZdD1Bg3bhhM1MBPAOHrmKk=; b=dE9eewrgVO23IgOFJYj/l5kJ41
        kYZzP6xjRTWELgufo7IVWkhZEsxrbsHKF0cP9Xy468o8aIJY0jv+UInaYcfDLEVxMg6LwOPGDwije
        3D27m76Fux3yncb6tqkbQ0mkQle+n6OaxkTfqW99EuCqqEWCIh+vcP/3B+rrtBvxAzzadMScg94XV
        LTAFmyYPbMyp6bWDti3IKO081jJdDavGShlfMoip7QlWXC2INy+YswG/HSGv3aQWHjgUfrSwmuFzm
        WuFxe4UvmYZ8Rl5IftGbyBuyDxPsjDtAtqP3SFErd0eV9cML5tqIVveDOPfeV56lawDnpTTLWBNP0
        Y10/NZOw==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLfX-00053t-Lx; Sat, 13 Oct 2018 15:17:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] fsl-diu-fb: don't pass GFP_DMA32 to dmam_alloc_coherent
Date:   Sat, 13 Oct 2018 17:17:07 +0200
Message-Id: <20181013151707.32210-9-hch@lst.de>
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
 drivers/video/fbdev/fsl-diu-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index bc9eb8afc313..6a49fe917bdb 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1697,7 +1697,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	int ret;
 
 	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
-				   &dma_addr, GFP_DMA | __GFP_ZERO);
+				   &dma_addr, GFP_KERNEL | __GFP_ZERO);
 	if (!data)
 		return -ENOMEM;
 	data->dma_addr = dma_addr;
-- 
2.19.1

