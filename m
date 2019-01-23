Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39202C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101B9218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfAWSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:36:28 -0500
Received: from foss.arm.com ([217.140.101.70]:45826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfAWSg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:36:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0774EBD;
        Wed, 23 Jan 2019 10:36:26 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63B683F237;
        Wed, 23 Jan 2019 10:36:25 -0800 (PST)
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
To:     Rui Zhao <ruizhao@microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel <linux-kernel@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "okaya@kernel.org" <okaya@kernel.org>
References: <20190118162324.17123-1-sashal@kernel.org>
 <0866a996-49f7-1498-4653-20232bef2f46@arm.com>
 <MW2PR2101MB09701C705250DAC025AFC251B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
Date:   Wed, 23 Jan 2019 18:36:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB09701C705250DAC025AFC251B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 23/01/2019 00:42, Rui Zhao wrote:
> On Monday, January 21, 2019 9:09 AM, James Morse wrote:
>> It would be good if we can make this generic, so it works on all platforms with
>> a DMC520, possibly along with other components. (e.g. the a15 L2 driver posted
>> recently).
>>
>> This will mostly be getting the DT right, as we can refactor the code when a
>> second user comes along, but can't change the DT format.

> Agreed. It'd be good if we can move all platform specific settings to DT such
> that a second user can update the code and won't break the DT for original
> device. I'll think about the DT format to make it more generic.

When the time comes, could you post a dt-binding as the first patch? These add
the documentation under Documentation/device-tree/bindings, and need to be CC'd
to the DT folks.


>> The TRM describes 'a set of interrupts', which ones does the binding anticipate
>> are wired up for this? There are separate status bits for corrected and
>> uncorrected, and one pair for dram versus ram. (not sure what this corresponds
>> with).

>> Do we care about the link-error interrupt?

> Will add ram interrupts handling, and make it configurable in DT.

I don't think the code needs to change, we just need to make it clear these are
the dram interrupts, and they are different numbers.
This means someone can add the ram interrupts later, and not have to
disambiguate them to keep your platform going.

(its this stuff that the binding document describes)


> Could you please
> share a bit more info on link-error interrupt? TRM doesn't have detailed info about
> it.

I only have the TRM too! The section titled 'RAS' on page 2-23 talks about 'link
error protection', so it might be relevant so someone. We don't care about this
now, but if someone does in the future, we will need to have a way of adding it
to the DT.

> Would like to know what's the impact if this error happens, and how to fit it
> with current reporting in EDAC core.

At a guess the interrupt triggers when link_err_count increases. (link_err has
an overflow bit, so the interrupt must be related to a counter).

If we could associate a link with a layer in edac, we could report errors
against that point. But I've no idea how 'links' correspond with 'ranks and banks'!


>>> +     layers[1].type = EDAC_MC_LAYER_CHANNEL;
>>> +     layers[1].size = DMC520_EDAC_CHANS;
>>> +     layers[1].is_virt_csrow = false;

>> If you can read the rank count, why hard code the bank?
> 
>> (which is what I assume channels corresponds to ... although this has confused
>> me before [0]).

> I misunderstood what channel meant. For bank, we can read config from the register.

Its an assumption. Channel seems to be an overloaded term with different meanings.
Fortunately edac drivers get to pick what their layers mean. It looks like all
this controls is the names that come out of sysfs.

rank/bank are part of the address decoding, as we can read both sizes I think it
makes sense to use both as it should further localise the error.


>>> +     mci->scrub_cap = SCRUB_HW_SRC;
>>> +     mci->scrub_mode = SCRUB_NONE;

>> Is this saying the device supports error scrubbing, but its disabled?
>> Do we know that?

>> Can the user try and turn it on? (I can't find anything that reads this!)

> We don’t want to change what’s already configured.

I don't think we could if we wanted to. This thing has 'READY' and 'CONFIG'
modes, the scrubbing can only be written to in 'CONFIG' mode. I'm willing to bet
we need it to be in 'READY' to be executing the kernel from dram.


> Will change scrub_mode to HW.

Do we know its enabled? This is something firmware has to set up, someone else's
platform may do it differently.

I think should read one of the scrub control registers to find out if its turned on.

But, I can't find what uses this value ...


>>> +     /* Enable interrupts */
>>> +     dmc520_write_reg(edac,
>>> +                      DRAM_ECC_INT_CE_MASK | DRAM_ECC_INT_UE_MASK,
>>> +                      REG_OFFSET_INTERRUPT_CONTROL);

>> What if they were enabled before? (e.g. enabled by firmware, the bootloader or
>> kdump). If they're already enabled, can we race with the interrupt handler on
>> another CPU and get double reporting of the error counter?

> We don't expect interrupts to be enabled by firmware or bootloader if this driver
> is enabled.

What about a previous instance of this driver? Linux supports kexec, kdump and
hibernate, all of which cause us to inherit a slightly used platform.


> If firmware enables it, they're suppose to handle the interrupt.

Ah, so you still have resident firmware!
How come your firmware trusts linux not to turn off the memory controller?!
These things are usually protected by trust zone so the OS can't pull the memory
from under firmware's feet.


Thanks,

James
