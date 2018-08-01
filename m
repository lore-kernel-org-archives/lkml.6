Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1409EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51D020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51D020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbeHAT6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:58:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405727AbeHATIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C31EC10CD;
        Wed,  1 Aug 2018 17:04:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 220/336] dma-direct: try reallocation with GFP_DMA32 if possible
Date:   Wed,  1 Aug 2018 18:49:15 +0200
Message-Id: <20180801165037.492644640@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit de7eab301de78869322104ea13e124c936ad3e1f ]

As the recent swiotlb bug revealed, we seem to have given up the direct
DMA allocation too early and felt back to swiotlb allocation.  The reason
is that swiotlb allocator expected that dma_direct_alloc() would try
harder to get pages even below 64bit DMA mask with GFP_DMA32, but the
function doesn't do that but only deals with GFP_DMA case.

This patch adds a similar fallback reallocation with GFP_DMA32 as we've
done with GFP_DMA.  The condition is that the coherent mask is smaller
than 64bit (i.e. some address limitation), and neither GFP_DMA nor
GFP_DMA32 is set beforehand.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/dma-direct.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -84,6 +84,13 @@ again:
 		__free_pages(page, page_order);
 		page = NULL;
 
+		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
+		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&
+		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
+			gfp |= GFP_DMA32;
+			goto again;
+		}
+
 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
 		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
 		    !(gfp & GFP_DMA)) {


