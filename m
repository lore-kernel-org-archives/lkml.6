Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9C20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTVV/WXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390720AbfAOVvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:51:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38269 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfAOVvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:51:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so1917912plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 13:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NdJedp0UD2W8veIkEmLgejKEG+swxrNiJK8NG8I/bAA=;
        b=MTVV/WXX4jYAEPk6avZ3vtWixED55Wi3ZTppB2SY5RywAbB+q6rgyQlVJZAkznuoex
         PdMAA62lRCPeE7teV/zSuK12fB7SbnklotQSFQaqkZZv26rs4lLeb+QC8++m1Bgq4r2T
         1NfVbgmaoKfK3CrBmev5d799ifaHBWa1UQqZ8GfiaoC2wLALbvl14SeNIeLD3R7lGtlT
         C3RWiv5otCc6oK+ZDnLgIXTmhSSoKeSu53MfYLQLxqSVOtaQ2IOKIPVrf6Lz0+4hnmnI
         z1k1/izUqIzXWAHFhkENV+E3zokUZ8fwEJDXSTdq8jOq0bw3fQTqFWqlwMQ0is0XrlxH
         RdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NdJedp0UD2W8veIkEmLgejKEG+swxrNiJK8NG8I/bAA=;
        b=cKuvWUn3dSxdlLsdcC2pNV29ymuGkQJH3xWCDAg+tHMEzG9mDMX3jX7qOKgy6zpkyK
         Gd7Veo+wWBQY9F01ydhWrybgxi4i8lfJUJvfCi+fQ8OlM8siyc1q1UL8Rtvlvx/jBG7b
         PuspvPvd5jdOG2L1+q5QPMIw3xdsZssK5btVyKYTVjE71sBTNCWUI9KFQ7zeegt+60jz
         u5CIGzOyAaac6dtGqse7Nu1bF6RDOR0x14lPrb7wo4gVC2wefe9xyZA0LtJcTnGLJRu1
         ifJJ6gRihnPQK5XrJXzDR2PrwS+5+WtdO+odyDi4Xn7itndIbZWz5K/Md1dqmO468tAL
         9rhA==
X-Gm-Message-State: AJcUukffxKygtpfwHIPYBdD0zwTXtplfbqvBFgGQEKjq0w2OragZ8opo
        goQJdLLn2Vq5l4XTMCj1Ioc=
X-Google-Smtp-Source: ALg8bN58TtikPOEi1lNh8yIje+tWz3ztFoVfm/nxsJwqJRtVs7xrbwyO0z6P1Mf6TqIdha4SDnJwhQ==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr6192681plb.325.1547589113395;
        Tue, 15 Jan 2019 13:51:53 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c13sm4722116pfo.121.2019.01.15.13.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 13:51:52 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma-direct: do not allocate a single page from CMA area
Date:   Tue, 15 Jan 2019 13:51:40 -0800
Message-Id: <20190115215140.1545-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to allocate one single page from CMA area. Since
the CMA area has a limited predefined size of space, it might run
out of space in some heavy use case, where there might be quite a
lot CMA pages being allocated for single pages.

This patch tries to skip CMA allocations of single pages and lets
them go through normal page allocations unless the allocation has
a DMA_ATTR_FORCE_CONTIGUOUS attribute. This'd save some resources
in the CMA area for further more CMA allocations, and it can also
reduce CMA fragmentations resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Robin/Christoph,

I have some personal priority to submit this patch. I understand
you might have other plan to clean up the code first. Just would
it be possible for you to review and apply this one if it doesn't
conflict too much? Thanks!

Changelog
v1->v2:
 * Added DMA_ATTR_FORCE_CONTIGUOUS flag check so as to enforce
   CMA allocations if callers specified.
 * Added to the commit message the reduction of fragmentations
   suggested by Robin.

 kernel/dma/direct.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..5d57f99b2edf 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -109,8 +109,14 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 			&phys_mask);
 again:
-	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp)) {
+	/*
+	 * CMA can be used only in the context which permits sleeping.
+	 * Since addresses within one PAGE are always contiguous, skip
+	 * CMA allocation for a single page to save CMA reserved space
+	 * unless DMA_ATTR_FORCE_CONTIGUOUS is flagged.
+	 */
+	if (gfpflags_allow_blocking(gfp) &&
+	    (count > 1 || attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
 		page = dma_alloc_from_contiguous(dev, count, page_order,
 						 gfp & __GFP_NOWARN);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-- 
2.17.1

