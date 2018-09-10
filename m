Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EEC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2130320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2130320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeIJVBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:01:31 -0400
Received: from foss.arm.com ([217.140.101.70]:60068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeIJVBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:01:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF80418A;
        Mon, 10 Sep 2018 09:06:43 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8603F557;
        Mon, 10 Sep 2018 09:06:42 -0700 (PDT)
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20180910060533.27172-1-hch@lst.de>
 <20180910060533.27172-3-hch@lst.de>
 <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
 <20180910154747.GA23578@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
Date:   Mon, 10 Sep 2018 17:06:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910154747.GA23578@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 16:47, Christoph Hellwig wrote:
>>> --- a/kernel/dma/Kconfig
>>> +++ b/kernel/dma/Kconfig
>>> @@ -13,6 +13,9 @@ config NEED_DMA_MAP_STATE
>>>    config ARCH_DMA_ADDR_T_64BIT
>>>    	def_bool 64BIT || PHYS_ADDR_T_64BIT
>>>    +config ARCH_HAS_DMA_COHERENCE_H
>>> +	bool
>>
>> This seems a little crude - is it unbearably churny to make an
>> asm-generic/dma-coherence.h implementation for everyone else?
> 
> The case of having something else than the per-device flag is rather
> odd, and I hope we don't grow any new user in addition to mips.
> 
> In fact I'm already thinking of ways to get rid of it for mips by
> e.g. iterating over all devices and just setting dma_coherent,
> but for now I wanted to solve the more urgen issues and tackle this
> later, as this unification blocks a few other things

Ah, somehow I started thinking that arm(64) would need to implement 
their own as well, but I see the point now. In that case, TBH I'd be 
quite happy with just a simple #ifdef CONFIG_MIPS in 
linux/dma-noncoherent.h - plus then it looks even more like something 
nobody else is expected to do.

>> Nits aside, this otherwise looks sane to me for factoring out the
>> equivalent Xen and arm64 DMA ops cases.
> 
> Like this? :)
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent

Man, that's going to take me a *lot* of time to pick through. All those 
horrendous subtleties that I barely remember!

Robin.
