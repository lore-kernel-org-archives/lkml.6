Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C00C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FA32083D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FA32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbeGKLm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732645AbeGKLm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:42:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 862F2AD82;
        Wed, 11 Jul 2018 11:39:00 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mips: Fix mips_dma_map_sg by using correct dma mapping function
Date:   Wed, 11 Jul 2018 13:38:51 +0200
Message-Id: <20180711113852.2734-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sg list elements could cover more than one page of data. Therefore
using plat_map_dma_mem_page() doesn't work for platforms, which have
IOMMU functionality hidden behind plat_map_dma_XXX functions.

Fixes: e36863a550da ("MIPS: HIGHMEM DMA on noncoherent MIPS32 processors")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/mm/dma-default.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index f9fef0028ca2..2718185a3d38 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -288,8 +288,8 @@ static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
 		sg->dma_length = sg->length;
 #endif
-		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
-				  sg->offset;
+		sg->dma_address = plat_map_dma_mem(dev, sg_virt(sg),
+						   sg->length);
 	}
 
 	return nents;
-- 
2.13.7

