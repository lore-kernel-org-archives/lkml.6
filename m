Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0334C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2793F20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="zoI++yZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2793F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbeGaUoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:44:14 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59984 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbeGaUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:44:14 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 438EA5C0556;
        Tue, 31 Jul 2018 21:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533063750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbl/SA6v3k6q+9dTZ+6/yz4lpoSL0LHTQbuFQHrp4I0=;
        b=zoI++yZr5Xs+3GDeqxlM+HDri2fp4ykTxYPhWY9eMBPWzJR7H0hdfRFLMaNHgBj8FXIdIe
        ptdHh/DnohI8upLQnyAleDqve5fO/8SrA3jbJHpnXrpYgNzlJdGD4KERnu6rLM46DF3gPf
        ZVtz88vrh74tLhs+AB4CR2DCXanRUfM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 21:02:30 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
In-Reply-To: <892f9d14-e6fd-7b1b-d07b-af0be6e623fa@arm.com>
References: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com>
 <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
 <20180727140448.GA29001@lst.de> <20180728165820.GA5731@roeck-us.net>
 <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
 <39fa11ce4b7dd151d98868f375baf818@agner.ch>
 <0e893142-a5db-d119-6eb3-f849db6b5d04@arm.com>
 <4339e35944851cc105ddfba03e1b990b@agner.ch>
 <892f9d14-e6fd-7b1b-d07b-af0be6e623fa@arm.com>
Message-ID: <df43c5200c3c3fb48d2fe09feab92a50@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.2018 18:29, Robin Murphy wrote:
> On 31/07/18 16:53, Stefan Agner wrote:
>> On 31.07.2018 14:32, Robin Murphy wrote:
>>> On 31/07/18 09:19, Stefan Agner wrote:
>>>> On 30.07.2018 16:38, Robin Murphy wrote:
>>>>> On 28/07/18 17:58, Guenter Roeck wrote:
>>>>>> On Fri, Jul 27, 2018 at 04:04:48PM +0200, Christoph Hellwig wrote:
>>>>>>> On Fri, Jul 27, 2018 at 03:18:14PM +0200, Krzysztof Kozlowski wrote:
>>>>>>>> On 27 July 2018 at 15:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On today's next, the bisect pointed commit
>>>>>>>>> ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d as fault for my boot failures
>>>>>>>>> with NFSv4 root on Toradex Colibri VF50 (Iris carrier board).
>>>>>>>>>
>>>>>>>>> Author: Robin Murphy <robin.murphy@arm.com>
>>>>>>>>> Date:   Mon Jul 23 23:16:12 2018 +0100
>>>>>>>>>        OF: Don't set default coherent DMA mask
>>>>>>>>>
>>>>>>>>> Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
>>>>>>>>> with DMA) on Iris Carrier.
>>>>>>>>>
>>>>>>>>> It looks like problem with Freescale Ethernet driver:
>>>>>>>>> [   15.458477] fsl-edma 40018000.dma-controller: coherent DMA mask is unset
>>>>>>>>> [   15.465284] fsl-lpuart 40027000.serial: Cannot prepare cyclic DMA
>>>>>>>>> [   15.472086] Root-NFS: no NFS server address
>>>>>>>>> [   15.476359] VFS: Unable to mount root fs via NFS, trying floppy.
>>>>>>>>> [   15.484228] VFS: Cannot open root device "nfs" or
>>>>>>>>> unknown-block(2,0): error -6
>>>>>>>>> [   15.491664] Please append a correct "root=" boot option; here are
>>>>>>>>> the available partitions:
>>>>>>>>> [   15.500188] 0100           16384 ram0
>>>>>>>>> [   15.500200]  (driver?)
>>>>>>>>> [   15.506406] Kernel panic - not syncing: VFS: Unable to mount root
>>>>>>>>> fs on unknown-block(2,0)
>>>>>>>>> [   15.514747] ---[ end Kernel panic - not syncing: VFS: Unable to
>>>>>>>>> mount root fs on unknown-block(2,0) ]---
>>>>>>>>>
>>>>>>>>> Attached - defconfig and full boot log.
>>>>>>>>>
>>>>>>>>> Any hints?
>>>>>>>>> Let me know if you need any more information.
>>>>>>>>
>>>>>>>> My Exynos boards also fail to boot on missing network:
>>>>>>>> https://krzk.eu/#/builders/21/builds/799/steps/10/logs/serial0
>>>>>>>>
>>>>>>>> As expected there are plenty of "DMA mask not set" warnings... and
>>>>>>>> later dwc3 driver fails with:
>>>>>>>>        dwc3: probe of 12400000.dwc3 failed with error -12
>>>>>>>> which is probably the answer why LAN attached to USB is not present.
>>>>>>>
>>>>>>> Looks like all the drivers failed to set a dma mask and were lucky.
>>>>>>
>>>>>> I would call it a serious regression. Also, no longer setting a default
>>>>>> coherent DMA mask is a quite substantial behavioral change, especially
>>>>>> if and since the code worked just fine up to now.
>>>>>
>>>>> To reiterate, that particular side-effect was an unintentional
>>>>> oversight, and I was simply (un)lucky enough that none of the drivers
>>>>> I did test depended on that default mask. Sorry for the blip; please
>>>>> check whether it's now fixed in next-20180730 as it should be.
>>>>>
>>>>
>>>> Just for my understanding:
>>>>
>>>> Your first patch ("OF: Don't set default coherent DMA mask") sounded
>>>> like that *not* setting default coherent DMA mask was intentionally.
>>>> Since the commit message reads: "...the bus code has not initialised any
>>>> default value" that was assuming that all bus code sets a default DMA
>>>> mask which wasn't the case for "simple-bus".
>>>
>>> Yes, reading the patches in the order they were written is perhaps a
>>> little unclear, but hopefully the order in which they are now applied
>>> makes more sense.
>>>
>>>> So I guess that is what ("of/platform: Initialise default DMA masks")
>>>> makes up for in the typical device tree case ("simple-bus")?
>>>
>>> Indeed, I'd missed the fact that the now-out-of-place-looking
>>> initialisation in of_dma_configure() still actually belonged to
>>> of_platform_device_create_pdata() - that patch should make the
>>> assumptions of "OF: Don't set default coherent DMA mask" true again,
>>> even for OF-platform devices.
>>>
>>>> Now, since almost all drivers are inside a soc "simple-bus" and DMA mask
>>>> is set again, can/should we rely on the coherent DMA mask set?
>>>>
>>>> Or is the expectation still that this is set on driver level too?
>>>
>>> Ideally, we'd like all drivers to explicitly request their masks as
>>> the documentation in DMA-API-HOWTO.txt recommends, if only to ensure
>>> DMA is actually possible - there can be systems where even the default
>>> 32-bit mask is no good - but clearly we're a little way off trying to
>>> enforce that just yet.
>>
>> In the FEC driver case, there is an integrated DMA (uDMA). It has
>> alignment restrictions, but can otherwise address the full 32-bit range.
>>
>> So something like this should do it right?
>>
>> 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))) {
>> 		dev_warn(dev, "No suitable DMA available\n");
>> 		return -ENODEV;
>> 	}
>>
> 
> Yup, precisely.
> 
>> However, that, as far as I understand, still requires that the bus set
>> up dma_mask properly.
>>
>> Should I be using dma_coerce_mask_and_coherent?
> 
> AFAICS for FEC, the ColdFire instances have statically-set masks, the
> i.MX boardfiles get them set via platform+device_register_full(), and
> now that the bug-which-never-should-have-been is fixed the DT-based
> instances should be fine too, so you should be good to go. In general
> I'd say that the dma_coerce_mask*() routines are only really for
> generic interface drivers like *HCI where they don't really know what
> the underlying device is and it may be on any old random bus. Drivers
> for specific IP blocks normally only have one or two known buses to
> deal with, so in most cases it's more reasonable to make the bus code
> well-behaved if it isn't already.

Got it, with your patch the underlying bus of the DT case is well
behaving again.

Will send a patch which makes use of dma_set_mask_and_coherent.

Thanks for your clarification!

--
Stefan
