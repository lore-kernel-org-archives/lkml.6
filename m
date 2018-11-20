Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBADC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA6920671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA6920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeKTTvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:51:05 -0500
Received: from verein.lst.de ([213.95.11.211]:43951 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeKTTvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:51:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8321F68B02; Tue, 20 Nov 2018 10:22:56 +0100 (CET)
Date:   Tue, 20 Nov 2018 10:22:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>, konrad.wilk@oracle.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Message-ID: <20181120092256.GB7270@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de> <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com> <20181109074955.GA27489@lst.de> <9922f377-ee87-ba36-8d28-26af0f7822e5@arm.com> <ad8ed3ba-12e8-3031-7c66-035b6d9ad6cd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8ed3ba-12e8-3031-7c66-035b6d9ad6cd@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:36:44PM +0000, Robin Murphy wrote:
> OK, having brought my Hikey to life and reproduced John's stall with rc1, 
> what's going on is that at some point dma_map_sg() returns 0, which causes 
> the SCSI/UFS layer to go round in circles repeatedly trying to map the same 
> list(s) equally unsuccessfully.
>
> Why does dma_map_sg() fail? Turns out what we all managed to overlook is 
> that this patch *does* introduce a subtle change in behaviour, in that 
> previously the non-bounced case assigned dev_addr to sg->dma_address 
> without looking at it; now with the swiotlb_map_page() call we check the 
> return value against DIRECT_MAPPING_ERROR regardless of whether it was 
> bounced or not.
>
> Flash back to the other thread when I said "...but I suspect there may well 
> be non-IOMMU platforms where DMA to physical address 0 is a thing :("? I 
> have the 3GB Hikey where all the RAM is below 32 bits so SWIOTLB never ever 
> bounces, but sure enough, guess where that RAM starts...

What is PAGE_OFFSET on that machine?   We usually don't use kernel
virtual address 0 so that we can deal with 0 pointer derferences sanely,
but I guess we can get to physical address 0.

I guess the quick fix would be to move DMA_DIRECT_MAPPING_ERROR to all-F
ASAP..
