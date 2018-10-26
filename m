Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC56CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB1A2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB1A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJZQkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:40:24 -0400
Received: from verein.lst.de ([213.95.11.211]:34883 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeJZQkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:40:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 74A4468C38; Fri, 26 Oct 2018 10:04:21 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:04:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] swiotlb: add support for non-coherent DMA
Message-ID: <20181026080421.GA6100@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-10-hch@lst.de> <9ea28547-dd1a-b4bd-2e91-f71e70417e7d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea28547-dd1a-b4bd-2e91-f71e70417e7d@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 06:11:04PM +0100, Robin Murphy wrote:
>>   +	if (!dev_is_dma_coherent(dev) &&
>> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>
> Nit: other parts of the file are already using the "!(...)" style rather 
> than "(...) == 0".

Indeed.  Probably some kind of copy and past error..

> I had a quick play at moving the cache maintenance here out into the 
> callers, which comes out arguably looking perhaps a little cleaner (only +1 
> source line overall, and actually reduces text size by 32 bytes for my 
> build), but sadly I can't really see any way of doing the equivalent for 
> map/unmap short of duplicating the whole 3-line arch_sync_*() block, which 
> just makes for a different readability problem. As you mentioned on patch 
> #7, I guess this really is just one of those things which has no nice 
> solution, so cosmetics aside,

It looks pretty ok, but given that I want to send this version to
Linus for the merge window I don't really dare to touch it.

The master plan for 4.21 is to actually merge swiotlb into dma-direct
and to allow direct calls to dma-direct given how expensive indirect
calls are with spectre, and dma mappings show up badly in various
benchmarks.  I'll see if I can do that in a way following what you've
done.
