Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeBLTRM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:17:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47710 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeBLTRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:17:10 -0500
Subject: Re: [PATCH 2/2] arm64: dts: juno: Describe the full GICv2m region
To: Marc Zyngier <marc.zyngier@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180207143255.17003-1-marc.zyngier@arm.com>
 <20180207143255.17003-3-marc.zyngier@arm.com>
 <d10fa874-1de2-1b95-dae1-42a336b98fa2@arm.com>
 <a0707972-f984-7aea-98fb-8cd8382f8287@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e66f71b8-fd0f-c7a5-dcc3-852d44898276@arm.com>
Date: Mon, 12 Feb 2018 19:17:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a0707972-f984-7aea-98fb-8cd8382f8287@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/18 18:27, Marc Zyngier wrote:
> Hi Sudeep,
> 
> On 12/02/18 18:17, Sudeep Holla wrote:
>>
>>
>> On 07/02/18 14:32, Marc Zyngier wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>>
>>> Juno's GICv2m implementation consists of four frames providing 32
>>> interrupts each. Since it is possible to plug in enough PCIe endpoints
>>> to consume more than 32 MSIs, and the driver already has a bodge to
>>> handle multiple frames, let's expose the other three as well.
>>>
>>
>> Change on it own looks good. So if you want to merge via your tree:
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Let me know if you decide not to take it via your tree and you want me
>> to send it to arm-soc.
> 
> If this would usually go via arm-soc, feel free to take it via this
> route. I'll drop the patch from my tree.
> 
>> On the side note I just noticed the Juno TRM[1] has 64k for each of
>> these MSI frames(page 3-24 section 3.3.5 Application memory map summary)
>>
>> I am not sure if TRM is wrong. This patch is just copying the 4k size
>> from frame 0 which got added with initial Juno DTS.
> 
> I can't see why the TRM would be wrong. This is actually consistent with
> the expected practice of aligning all devices on a 64kB boundary and
> size so that you don't get any nasty surprise when passing the device to
> a VM (*cough* GIC400 *cough*).
> 
> Robin, any chance you could check this?

Well, the engineering spec for the v2m widget does claim that only the 
bottom 12 bits of AxADDR are used, but on the other hand it also implies 
that the "real" endpoint here is a single monolithic block of 4 such 
widgets, so a third truth is that there is only a single 256KB region...

As usual, I've completely forgotten about virtualisation when it comes 
to hardware :) On reflection I do of course appreciate that whilst 60KB 
of RAZ/WI space isn't significant in terms of "a device", it is rather 
more so in terms of "not a device" - if the only reasonable way to 
communicate that is to describe the v2m devices each owning 64KB, then 
I'm quite happy for you to fix up the patch that way if you want.

Robin.
