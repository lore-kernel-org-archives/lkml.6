Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007ADC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC9320821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBKKWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:22:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfBKKWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:22:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9204BA78;
        Mon, 11 Feb 2019 02:22:44 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6B0B3F557;
        Mon, 11 Feb 2019 02:22:42 -0800 (PST)
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org>
 <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
 <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e64e564-aa6c-4193-1f57-ebf88d6932d5@arm.com>
Date:   Mon, 11 Feb 2019 10:22:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2019 18:55, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Fri, Feb 8, 2019 at 6:55 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 08/02/2019 16:40, Joerg Roedel wrote:
>>> On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
>>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>>> index 8ac10af17c0043a3..d62487d024559620 100644
>>>> --- a/drivers/base/dd.c
>>>> +++ b/drivers/base/dd.c
>>>> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>>>>                       drv->remove(dev);
>>>>
>>>>               device_links_driver_cleanup(dev);
>>>> -            arch_teardown_dma_ops(dev);
>>>>
>>>>               devres_release_all(dev);
>>>> +            arch_teardown_dma_ops(dev);
>>>>               dev->driver = NULL;
>>>>               dev_set_drvdata(dev, NULL);
>>>>               if (dev->pm_domain && dev->pm_domain->dismiss)
>>>
>>> Thanks for the fix! Should it also be tagged for stable and get a Fixes
> 
> FTR, Greg has added it to driver-core-testing, with a CC to stable.

So I see, great!

>>> tag? I know it only triggers with a fix in v5.0-rc, but still...
>>
>> I think so:
>>
>> Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time
>> for platform/amba/pci bus devices")
> 
> Thanks! It won't backport cleanly due to commit dc3c05504d38849f
> ("dma-mapping: remove dma_deconfigure") in v4.20, though.

Ah yes - backports beyond that should simply be a case of moving the 
dma_deconfigure() wrapper in the same manner.

Thanks,
Robin.

>> There aren't many drivers using dmam_alloc_*(), let alone which would
>> also find themselves behind an IOMMU on an Arm system, but it turns out
>> I actually have another one which can reproduce the BUG() with 5.0-rc.
> 
> SATA core uses dmam_alloc_*().
> 
>> I've tried a 4.12 kernel with a bit of instrumentation[1] and sure
>> enough the devres-managed buffer is freed with the wrong ops[2] even
>> then. How it manages not to blow up more catastrophically I have no
>> idea... I guess at best it just leaks the buffers and IOMMU mappings,
>> and at worst quietly frees random other pages instead.
> 
> May depend on the actual ops, and whether CMA is used or not.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
