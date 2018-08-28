Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F98C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC882088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC882088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeH1VEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:04:36 -0400
Received: from foss.arm.com ([217.140.101.70]:42836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbeH1VEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:04:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BD2580D;
        Tue, 28 Aug 2018 10:11:59 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E23C33F5BD;
        Tue, 28 Aug 2018 10:11:57 -0700 (PDT)
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     Tyler Baicar <baicar.tyler@gmail.com>
Cc:     Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, Borislav Petkov <bp@alien8.de>,
        mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <CABo9ajAvo-bskhrM8h95Y9D4U88zFUZfVW_HTMLK3o_5Q1VSUw@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <bcb1b461-76ee-7d9b-2b35-d575ec608027@arm.com>
Date:   Tue, 28 Aug 2018 18:11:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABo9ajAvo-bskhrM8h95Y9D4U88zFUZfVW_HTMLK3o_5Q1VSUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tyler,

On 24/08/18 16:14, Tyler Baicar wrote:
> On Fri, Aug 24, 2018 at 5:48 AM, James Morse <james.morse@arm.com> wrote:
>> On 23/08/18 16:46, Tyler Baicar wrote:
>>> On Thu, Aug 23, 2018 at 5:29 AM James Morse <james.morse@arm.com> wrote:
>>>> On 19/07/18 19:36, Tyler Baicar wrote:
>>>>> This seems pretty hacky to me, so if anyone has other suggestions please share
>>>>> them.
>>>>
>>>> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE should provide
>>>> the information necessary to identify the failing FRU". As EDAC has three
>>>> 'levels', these are what they should correspond to for ghes-edac.
>>>>
>>>> I assume NODE means rack/chassis in some distributed system. Lets ignore it as
>>>> it doesn't seem to map to anything in the SMBIOS table.
>>>
>>> I believe NODE should map to socket number for multi-socket systems.
>>
>> Isn't the Memory Array Structure still unique in a multi-socket system? If so
>> the node isn't telling us anything new.

> Yes, the Memory Array structure in SMBIOS is still unique, but the NODE value
> is needed in NODE, CARD, MODULE because the CARD number here typically
> maps to channel number which each socket has their own channel numbers.

/me flinches at 'typically'.

Okay, so the hierarchy applies to the numbers, not the handles.
How come there isn't a node handle?

I think we should ignore the extra hierarchy. The module/devices/dimms are the
only replaceable part, and we don't know if the firmware will provide the
information.


>> Do sockets show up in the SMBIOS table? We would need to know how many there are
>> in advance. For arm systems the cpu topology from PPTT is the best bet for this
>> information, but what do we do if that table is missing? (also, does firmware
>> count from 1 or 0?) I suspect we can't use this field unless we know what the
>> range of values is going to be in advance.
> 
> An Fan mentioned in his response, what the customers really care about
> is mapping to
> a particular DIMM since that is what they can replace. To do this, the
> Memory Device
> handle should be enough since those are all unique regardless of
> Memory Array handle
> and which socket the DIMM is on. The Firmware I've worked with counts
> from 0, but I'm
> not sure if that is required.

If the spec doesn't say, its difficult to know the range of values until we've
seen one of the limits.


> That won't matter if we just use the Memory Device handle.

I agree.


>>> I think the proper way to get this working would be to use these handles. We can
>>> avoid populating this layer information and instead have a mapping of type 17
>>> index number (how edac is numbering the DIMMs today) to the handle number.
>>
>> Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
>> EDAC_MC_LAYER_SLOT is for?
> 
> The problem with the layer reporting is that you need to know all the
> layer information as Fan mentioned.

I haven't spotted what requires this, there seems to be a bit of a mix of
numbers-of-layers and what order they go in. thunderx_edac.c just uses SLOT.
I think we can get away with using EDAC_MC_LAYER_ALL_MEM, sized by num_dimms
(which ghes-edac already does).

Providing extra topology may not be useful unless the firmware populates this
information. What do we do if we export card+module, but then firmware only
populates the module-handle?


> SoCs can support multiple board combinations (ie
> 1DPC vs. 2DPC)
> and there is no standardized way of knowing whether you are booted on a 1DPC or
> 2DPC board.
> 
>>> Then we will need a new function to increment the counter based on the handle
>>> number rather than this layer information. Is that how you are envisioning it?
>>
>> I'm not familiar with edac's internals, so I didn't have any particular vision!
>>
>> Isn't the problem that ghes_edac_report_mem_error() does this:
>> |       e->top_layer = -1;
>> |       e->mid_layer = -1;
>> |       e->low_layer = -1;
> 
> The other problem is that the sysfs nodes are all setup with a single
> layer representing
> all of the memory on the board.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/edac/ghes_edac.c#L469
> 
> So the DIMM counters exposed in sysfs are all under a single memory
> controller and just
> numbered from 0 to n-1 based on the order in which the type 17 SMBIOS
> entries show up
> in the DMI walk.

User-space depending on the dmi walk order makes me nervous. Doing this gives
you per-dimm counters, if user-space needs to know which physical-dimm/slot that
is, we'd need a way of matching it with one of the smbios location strings.


>> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
>> read what it does with this information yet).
>>
>> ghes_edac_report_mem_error() does check CPER_MEM_VALID_MODULE_HANDLE, and if its
>> set, it uses the handle to find the bank/device strings and prints them out.
> 
> Yes, I think this is where we need to add support to increment the
> count based on that module handle.

If layer[0] is EDAC_MC_LAYER_ALL_MEM, sized for num_dimm, don't we just put the
dimm number in e->top_layer and flip e->enable_per_layer_report?


>> Naively I thought we could generate some index during ghes_edac_count_dimms(),
>> and use this as e->${whichever}_layer. I hoped there would be something we could
>> already use as the index, but I can't spot it, so this will be more than the
>> one-liner I was hoping for!
> 
> We could use what ghes_edac_register does by setting up a single layer
> with all memory and
> then keep a map of which module handle maps to which index into that
> layer. From that it would
> be easy to increment the proper sysfs exposed DIMM counters using the
> single layer

Yes, I think this is what we should do!


Thanks,

James
