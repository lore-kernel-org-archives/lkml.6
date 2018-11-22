Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADFC04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7CF206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7CF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406512AbeKWEcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:32:45 -0500
Received: from foss.arm.com ([217.140.101.70]:54956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404497AbeKWEcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:32:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E90CB1DC8;
        Thu, 22 Nov 2018 09:52:19 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671553F5A0;
        Thu, 22 Nov 2018 09:52:17 -0800 (PST)
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux@armlinux.org.uk
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
Date:   Thu, 22 Nov 2018 17:52:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 17:09, Linus Torvalds wrote:
> On Thu, Nov 22, 2018 at 9:07 AM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>>
>> I'm afraid that won't work very well - 32 bit platforms with 64-bit
>> addresses (LPAE) would have dma_addr_t as a 64-bit value, which
>> wouldn't fit into an unsigned long.
> 
> Good point. So we'd have to have a special IS_DMA_ERR() function that
> takes a dma_addr_t and checks the same "is it the top 4095 values".
> 
> Because I'd still prefer to allow people to return the _actual_ error,
> and to have "return -Exyz" as the error case. That part still DTRT
> even with dma_addr_t.

Unfortunately, with things like the top-down IOVA allocator, and 32-bit 
systems in general, "the top 4095" values may well still be valid 
addresses - we're relying on a 1-byte mapping of the very top byte of 
memory/IOVA space being sufficiently ridiculous that no real code would 
ever do that, but even a 4-byte mapping of the top 4 bytes is within the 
realms of the plausible (I've definitely seen the USB layer make 8-byte 
mappings from any old offset within a page, for example).

Thus we'd have to go with the extra complication of detecting and 
carving out problematic memory maps in those corner cases as Russell 
alluded to, for the sake of better error reporting in places where, in 
the majority of cases, there's not really all that many ways to go 
wrong. Off the top of my head, I guess:

-EINVAL if the address is outside the device's DMA mask (and there is no 
IOMMU or bounce buffer).

-ENOSPC if there is an IOMMU or bounce buffer, but no free IOVA/buffer 
space currently.

-ESOMETHINGWENTWRONGWITHIOMMUPAGETABLES or similar, because it's not 
like the caller can treat that as anything other than an opaque failure 
anyway.

The only immediate benefit I can see is that we could distinguish cases 
like the first which can never possibly succeed, and thus callers could 
actually give up instead of doing what various subsystems currently do 
and retry the exact same mapping indefinitely on the apparent assumption 
that errors must be transient.

Robin.
