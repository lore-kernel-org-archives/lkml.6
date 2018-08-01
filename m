Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E12208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E12208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbeHASUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:20:06 -0400
Received: from foss.arm.com ([217.140.101.70]:44826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390500AbeHASUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:20:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDDAC80D;
        Wed,  1 Aug 2018 09:33:33 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13DD93F5BA;
        Wed,  1 Aug 2018 09:33:31 -0700 (PDT)
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stefan Agner <stefan@agner.ch>, Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>
References: <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
 <20180727140448.GA29001@lst.de> <20180728165820.GA5731@roeck-us.net>
 <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
 <39fa11ce4b7dd151d98868f375baf818@agner.ch>
 <0e893142-a5db-d119-6eb3-f849db6b5d04@arm.com>
 <f67628ad-4cae-96cd-d0c4-3b2f7d12a822@roeck-us.net>
 <4ce17098-850f-3bb0-b977-8d7932e74e06@arm.com>
 <20180731154353.GA29601@roeck-us.net>
 <10c2ca4d-d587-2705-2802-b6df3dc72fd4@arm.com>
 <20180731173859.GA17007@roeck-us.net>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9f32010e-3bcb-2153-dac3-996e9d1b1e9b@arm.com>
Date:   Wed, 1 Aug 2018 17:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731173859.GA17007@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/18 18:38, Guenter Roeck wrote:
> On Tue, Jul 31, 2018 at 04:58:41PM +0100, Robin Murphy wrote:
>> On 31/07/18 16:43, Guenter Roeck wrote:
>>> On Tue, Jul 31, 2018 at 03:09:34PM +0100, Robin Murphy wrote:
>>>>> Please note that sparc images still generate the warning (next-20180731).
>>>>
>>>> Ugh, OK, any ideas what sparc does to create these platform devices that
>>>> isn't of_platform_device_create_pdata() and has somehow grown an implicit
>>>> dependency on of_dma_configure() since 4.12? I'm looking, but nothing jumps
>>>> out...
>>>>
>>>
>>> I suspect it might be of_device_register(), called from
>>> 	arch/sparc/kernel/of_device_64.c:scan_one_device()
>>> 	arch/sparc/kernel/of_device_32.c:scan_one_device()
>>
>> Right, that's as far as I got as well, so I'm struggling to see how these
>> things ever got DMA masks set before the of_dma_configure() call moved out
>> of of_platform_device_create_pdata(), or why it wasn't a problem prior to
>> the generic dma_ops rework if they didn't :/
>>
> Ah, ok. No idea, sorry. All I know is that the messages were first seen
> with next-20180727.

OK, I spent this afternoon wrangling toolchains and QEMU to boot an 
instrumented 4.11 kernel, and the answer is that the warnings are 
arguably correct. These masks have indeed never been set where they 
should have been, but then the sbus_dma_ops don't reference them anyway.

The coherent mask WARN_ON *should* have started appearing in 4.16 with 
205e1b7f51e4("dma-mapping: warn when there is no coherent_dma_mask"), 
but happened to be hidden by the inadvertent side-effect of the prior 
dma_configure() change. Since there's seemingly no actual regression of 
functionality, I'm inclined to leave this in the hands of whoever cares 
about sparc32.

Robin.
