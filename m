Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F276206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F276206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeLDOXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:23:08 -0500
Received: from verein.lst.de ([213.95.11.211]:44022 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLDOXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:06 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E943368BDF; Tue,  4 Dec 2018 15:23:04 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:23:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
Message-ID: <20181204142304.GC2618@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-6-hch@lst.de> <CGME20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7@epcas3p2.samsung.com> <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com> <e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 09:38:02AM +0100, Marek Szyprowski wrote:
> Hi All,
> 
> On 2018-11-30 20:05, Robin Murphy wrote:
> > On 05/11/2018 12:19, Christoph Hellwig wrote:
> >> By using __dma_direct_alloc_pages we can deal entirely with struct page
> >> instead of having to derive a kernel virtual address.
> >
> > Simple enough :)
> >
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> This patch has landed linux-next yesterday and I've noticed that it
> breaks operation of many drivers. The change looked simple, but a stupid
> bug managed to slip into the code. After a short investigation I've
> noticed that __dma_direct_alloc_pages() doesn't set dma_handle and zero
> allocated memory, while dma_direct_alloc_pages() did. The other
> difference is the lack of set_memory_decrypted() handling.
> 
> Following patch fixes the issue, but maybe it would be better to fix it
> in kernel/dma/direct.c:

Thanks for spotting this Marek.  Can you send the patch below with a
signoff and a changelog so that I can queue it up?
