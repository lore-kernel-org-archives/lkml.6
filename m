Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0219DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A1721871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfADIxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:53:20 -0500
Received: from verein.lst.de ([213.95.11.211]:38601 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfADIxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:53:20 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E2B4768D93; Fri,  4 Jan 2019 09:53:18 +0100 (CET)
Date:   Fri, 4 Jan 2019 09:53:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: crash in gart_unmap_page() with master snapshot (commit
 e1ef035d272e)
Message-ID: <20190104085318.GA15939@lst.de>
References: <20190102083854.GA28932@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102083854.GA28932@unicorn.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

can you try the patch below?

---
From 6b22ae23a1971646dacc8a0ad313a6329a04cf98 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 4 Jan 2019 09:50:33 +0100
Subject: x86/amd_gart: fix unmapping of non-GART mappings

In many cases we don't have to create a GART mapping at all, which
also means there is nothing to unmap.  Fix the range check that was
incorrectly modified when removing the mapping_error method.

Fixes: 9e8aa6b546 ("x86/amd_gart: remove the mapping_error dma_map_ops method")
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/amd_gart_64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index e0ff3ac8c127..2c0aa34af69c 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -256,7 +256,15 @@ static void gart_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	int npages;
 	int i;
 
-	if (dma_addr == DMA_MAPPING_ERROR ||
+	if (WARN_ON_ONCE(dma_addr == DMA_MAPPING_ERROR))
+		return;
+
+	/*
+	 * This driver will not always use a GART mapping, but might have
+	 * created a direct mapping instead.  If that is the case there is
+	 * nothing to unmap here.
+	 */
+	if (dma_addr < iommu_bus_base ||
 	    dma_addr >= iommu_bus_base + iommu_size)
 		return;
 
-- 
2.20.1

