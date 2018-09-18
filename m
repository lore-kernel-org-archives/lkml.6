Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2E5ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C2E2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C2E2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeIRVoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:44:24 -0400
Received: from verein.lst.de ([213.95.11.211]:48675 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729927AbeIRVoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:44:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 22C2B68D73; Tue, 18 Sep 2018 18:11:13 +0200 (CEST)
Date:   Tue, 18 Sep 2018 18:11:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: move swiotlb noncoherent dma support from arm64 to generic code
Message-ID: <20180918161112.GA4713@lst.de>
References: <20180917153826.28052-1-hch@lst.de> <d6a4f58e-975f-e7dc-d622-d56760710a92@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a4f58e-975f-e7dc-d622-d56760710a92@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 02:28:42PM +0100, Robin Murphy wrote:
> On 17/09/18 16:38, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series starts with various swiotlb cleanups, then adds support for
>> non-cache coherent devices to the generic swiotlb support, and finally
>> switches arm64 to use the generic code.
>
> I think there's going to be an issue with the embedded folks' grubby hack 
> in arm64's mem_init() which skips initialising SWIOTLB at all with 
> sufficiently little DRAM. I've been waiting for 
> dma-direct-noncoherent-merge so that I could fix that case to swizzle in 
> dma_direct_ops and avoid swiotlb_dma_ops entirely.

I wait for your review of dma-direct-noncoherent-merge to put it
into dma-mapping for-next..

That being said one thing I'm investigating is to eventually further
merge dma_direct_ops and swiotlb_ops - the reason for that beeing that
I want to remove the indirect calls for the common direct mapping case,
and if we don't merge them that will get complicated.  Note that
swiotlb will generally just work if you don't initialize the buffer
as long as we never see a physical address large enough to cause bounce
buffering.

>
>> Given that this series depends on patches in the dma-mapping tree, or
>> pending for it I've also published a git tree here:
>>
>>      git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent
>
> However, upon sitting down to eagerly write that patch I've just 
> boot-tested the above branch as-is for a baseline and discovered a rather 
> more significant problem: arch_dma_alloc() is recursing back into 
> __swiotlb_alloc() and blowing the stack. Not good :(

Oops, I messed up when renaming things.  Try this patch on top:

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 83e597101c6a..c75c721eb74e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -955,7 +955,7 @@ void *__swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 */
 	gfp |= __GFP_NOWARN;
 
-	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	vaddr = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 	if (!vaddr)
 		vaddr = swiotlb_alloc_buffer(dev, size, dma_handle, attrs);
 	return vaddr;
@@ -973,7 +973,7 @@ void __swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
 	if (!swiotlb_free_buffer(dev, size, dma_addr))
-		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
+		dma_direct_free_pages(dev, size, vaddr, dma_addr, attrs);
 }
 
 static void swiotlb_free(struct device *dev, size_t size, void *vaddr,
