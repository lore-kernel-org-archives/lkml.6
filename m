Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2521FC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA19221473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA19221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLBEJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:09:08 -0500
Received: from verein.lst.de ([213.95.11.211]:56753 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeLBEJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:09:08 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A5A076732A; Sat,  1 Dec 2018 17:56:10 +0100 (CET)
Date:   Sat, 1 Dec 2018 17:56:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dma-direct: provide page based alloc/free helpers
Message-ID: <20181201165610.GA20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-2-hch@lst.de> <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 07:04:41PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> Some architectures support remapping highmem into DMA coherent
>> allocations.  To use the common code for them we need variants of
>> dma_direct_{alloc,free}_pages that do not use kernel virtual addresses.
>
> FWIW it's as much about non-cacheable remapping of lowmem as it is about 
> highmem. Regardless, the diff looks OK to me.

Yes, but as long as you remap lowmem the current interface work ok,
but once you have highmem a kernel virtual address doesn't cut it,
and we need a page struct or physical address.
