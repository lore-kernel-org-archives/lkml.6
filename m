Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4175AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1807121A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfBKQD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:03:29 -0500
Received: from verein.lst.de ([213.95.11.211]:58109 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbfBKQD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:03:26 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 54EBB68DD6; Mon, 11 Feb 2019 17:03:25 +0100 (CET)
Date:   Mon, 11 Feb 2019 17:03:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/19] dma-iommu: fix and refactor iommu_dma_mmap
Message-ID: <20190211160325.GC27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-7-hch@lst.de> <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 03:02:23PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> The current iommu_dma_mmap code does not properly handle memory from the
>> page allocator that hasn't been remapped, which can happen in the rare
>> case of allocations for a coherent device that aren't allowed to block.
>>
>> Fix this by replacing iommu_dma_mmap with a slightly tweaked copy of
>> dma_common_mmap with special handling for the remapped array of
>> pages allocated from __iommu_dma_alloc.
>
> If there's an actual bugfix here, can we make that before all of the other 
> code movement? If it's at all related to other reports of weird mmap 
> behaviour it might warrant backporting, and either way I'm finding it 
> needlessly tough to follow what's going on in this patch :(

The bug fix is to handle non-vmalloc pages.  I'll see if I can do
a smaller and more bandaid-y fix first.
