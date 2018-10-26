Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B8C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867B02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867B02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJZSge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:36:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40752 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeJZSge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:36:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BD4341;
        Fri, 26 Oct 2018 03:00:06 -0700 (PDT)
Received: from [10.101.215.145] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 058503F6A8;
        Fri, 26 Oct 2018 03:00:04 -0700 (PDT)
Subject: Re: [PATCH 09/10] swiotlb: add support for non-coherent DMA
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-10-hch@lst.de>
 <9ea28547-dd1a-b4bd-2e91-f71e70417e7d@arm.com> <20181026080421.GA6100@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8910e6d-d864-07cd-12f2-551149a66d42@arm.com>
Date:   Fri, 26 Oct 2018 10:59:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026080421.GA6100@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-26 9:04 am, Christoph Hellwig wrote:
> On Mon, Oct 22, 2018 at 06:11:04PM +0100, Robin Murphy wrote:
>>>    +	if (!dev_is_dma_coherent(dev) &&
>>> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>>
>> Nit: other parts of the file are already using the "!(...)" style rather
>> than "(...) == 0".
> 
> Indeed.  Probably some kind of copy and past error..
> 
>> I had a quick play at moving the cache maintenance here out into the
>> callers, which comes out arguably looking perhaps a little cleaner (only +1
>> source line overall, and actually reduces text size by 32 bytes for my
>> build), but sadly I can't really see any way of doing the equivalent for
>> map/unmap short of duplicating the whole 3-line arch_sync_*() block, which
>> just makes for a different readability problem. As you mentioned on patch
>> #7, I guess this really is just one of those things which has no nice
>> solution, so cosmetics aside,
> 
> It looks pretty ok, but given that I want to send this version to
> Linus for the merge window I don't really dare to touch it.
> 
> The master plan for 4.21 is to actually merge swiotlb into dma-direct
> and to allow direct calls to dma-direct given how expensive indirect
> calls are with spectre, and dma mappings show up badly in various
> benchmarks.  I'll see if I can do that in a way following what you've
> done.

Right, if we're going to be coming back here soon to make it efficient, 
there's even less need to worry about how beautiful it is at this point 
when we're just making it functional. I'll save up all my optimisation 
urges for the next round :)

Robin.
