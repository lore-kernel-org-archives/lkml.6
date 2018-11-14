Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E116DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B077122360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B077122360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbeKOCQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:16:31 -0500
Received: from verein.lst.de ([213.95.11.211]:35916 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbeKOCQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:16:31 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A116768CED; Wed, 14 Nov 2018 17:12:39 +0100 (CET)
Date:   Wed, 14 Nov 2018 17:12:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Message-ID: <20181114161239.GA29462@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de> <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com> <20181109074955.GA27489@lst.de> <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com> <20181114141311.GA26677@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114141311.GA26677@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:13:11PM +0100, Christoph Hellwig wrote:
> Does the patch below make a difference for you?  Assigning an
> address to the S/G list is the only functional difference I could
> spot.  Drivers really should never look at the S/G list on an
> error return, but..

And that was obviously just the second half of the patch, so here
is the full one:

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5731daa09a32..a896f46d0c31 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -786,10 +786,13 @@ swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
 	int i;
 
 	for_each_sg(sgl, sg, nelems, i) {
-		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
+		dma_addr_t dma_addr;
+
+		dma_addr = swiotlb_map_page(dev, sg_page(sg), sg->offset,
 				sg->length, dir, attrs);
-		if (sg->dma_address == DIRECT_MAPPING_ERROR)
+		if (dma_addr == DIRECT_MAPPING_ERROR)
 			goto out_error;
+		sg->dma_address = dma_addr;
 		sg_dma_len(sg) = sg->length;
 	}
 
