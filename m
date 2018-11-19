Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFEBC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921DA2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921DA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeKTCOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:14:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60154 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbeKTCOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:14:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A053015AB;
        Mon, 19 Nov 2018 07:50:41 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48DA43F575;
        Mon, 19 Nov 2018 07:50:40 -0800 (PST)
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory
 size
To:     Ramon Fried <ramon.fried@gmail.com>, benh@kernel.crashing.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, hch@lst.de, linux@roeck-us.net
References: <20180927223539.28449-1-hch@lst.de>
 <20180927223539.28449-6-hch@lst.de>
 <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
 <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
 <CA+Kvs9kPtTZavq91NXs-7edVO5Fxp8gPO=FD35i9_izAdGMkKw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bb76b9a1-dc3a-2357-a871-291d68703776@arm.com>
Date:   Mon, 19 Nov 2018 15:50:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+Kvs9kPtTZavq91NXs-7edVO5Fxp8gPO=FD35i9_izAdGMkKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 14:18, Ramon Fried wrote:
> On Tue, Oct 9, 2018 at 8:02 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>>
>> On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
>>>> -        * Because 32-bit DMA masks are so common we expect every architecture
>>>> -        * to be able to satisfy them - either by not supporting more physical
>>>> -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>>>> -        * architecture needs to use an IOMMU instead of the direct mapping.
>>>> -        */
>>>> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
>>>> +       u64 min_mask;
>>>> +
>>>> +       if (IS_ENABLED(CONFIG_ZONE_DMA))
>>>> +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
>>>> +       else
>>>> +               min_mask = DMA_BIT_MASK(32);
>>>> +
>>>> +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
>>>> +
>>>> +       if (mask >= phys_to_dma(dev, min_mask))
>>>>                   return 0;
>>>> -#endif
>>>>           return 1;
>>>>    }
>>>
>>> So I believe I have run into the same issue that Guenter reported. On
>>> an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
>>> all probe attempts for various devices were failing with -EIO errors.
>>>
>>> I believe the last mask check should be "if (mask < phys_to_dma(dev,
>>> min_mask))" not a ">=" check.
>>
>> Right, that test is backwards. I needed to change it here too (powermac
>> with the rest of the powerpc series).
>>
>> Cheers,
>> Ben.
>>
>>
> 
> Hi, I'm working on a MIPS64 soc with PCIe root complex on it, and it
> appears that this series of patches are causing all PCI drivers that
> request 64bit mask to fail with -5.
> It's broken in 4.19. However, I just checked, it working on master.
> We may need to backport a couple of patches to 4.19. I'm not sure
> though which patches should be backported as there were at least 10
> patches resolving this dma_direct area recently.
> Christoph, Robin.
> Can we ask Greg to backport all these changes ? What do you think ?

As far as I'm aware, the only real issue in 4.19 was my subtle breakage 
around setting bus_dma_mask - that's fixed by 6778be4e5209, which 
according to my inbox got picked up by autosel for 4.19 stable last week.

Robin.
