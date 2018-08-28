Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028282088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028282088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeH1VC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:02:28 -0400
Received: from foss.arm.com ([217.140.101.70]:42720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeH1VC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:02:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FAFFED1;
        Tue, 28 Aug 2018 10:09:50 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB41C3F5BD;
        Tue, 28 Aug 2018 10:09:48 -0700 (PDT)
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     wufan <wufan@codeaurora.org>
Cc:     'Tyler Baicar' <baicar.tyler@gmail.com>,
        'Tyler Baicar' <tbaicar@codeaurora.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, 'Borislav Petkov' <bp@alien8.de>,
        mchehab@kernel.org,
        'arm-mail-list' <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
 <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
 <000b01d43bb6$f9419b20$ebc4d160$@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <d4ee6d3a-b3ac-2986-40db-8423de7e960a@arm.com>
Date:   Tue, 28 Aug 2018 18:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000b01d43bb6$f9419b20$ebc4d160$@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fan,

On 24/08/18 15:30, wufan wrote:
>> Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
>> EDAC_MC_LAYER_SLOT is for?
> 
> Borislav has explained it in his response. Here let me elaborate a little more.
> To use the layer information you need an accurate way to pinpoint each component
> in the layer and the parent components in the layers above. For example, to use
> EDAC_MC_LAYER_SLOT you also need information for the parent layer say
> EDAC_MC_LAYER_CHANNEL, or another layer on top say EDAC_MC_LAYER_BRANCH.

I haven't spotted anything that forces a particular meaning/topology on these
types. (there are four of them, but only three 'levels')

i3000_edac.c has EDAC_MC_LAYER_CHIP_SELECT then EDAC_MC_LAYER_CHANNEL,
but i5400_edac.c has EDAC_MC_LAYER_BRANCH then EDAC_MC_LAYER_CHANNEL.
pnd2_edac.c agrees that channel comes before slot, but thunderx_edac.c just uses
slot directly....

ghes-edac already describes memory as 'EDAC_MC_LAYER_ALL_MEM', with num_dimms, I
think we just need to get 'the' dimm number. Using the cper-module-handle means
we don't have to worry about firmware's count of dimms being different, as we
both agree its smbios-type-17 we're talking about.


> There
> are no clear ways to get the information from SMBIOS table. In the case of "memory
> channel" we looked at type 37 which has the exact spelling but it was introduced
> to support RamBus and Synclink. Not sure we can readily use it for modern
> architecture concept of "channel/slot". 

I think we should avoid this 'channel' thing as it means different things to
different people!

We can use ghes:card smbios:physical-memory-array as the UEFI spec tells us they
are the same, and we don't actually need to know what they mean.


>  I think it is good enough if we can pin each error to the corresponding DIMM.
> At the end of the day DIMMs are what customer can replace in the memory system
> and that's all that they care about. For the manufacturers of the board/chips
> they have the knowledge to map the specific DIMMs to the upper layer components,
> so they can easily collect error counter data for upper layers. 

I agree.


>> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE
>> should provide the information necessary to identify the failing FRU". As
>> EDAC has three 'levels', these are what they should correspond to for ghes-
>> edac.
>>
>> I assume NODE means rack/chassis in some distributed system. Lets ignore it
>> as it doesn't seem to map to anything in the SMBIOS table.
> 
> How about type 4 "Processor Information"?

As the spec doesn't tell us what the field means, we can't really do anything
other than print the value out.


>> 'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
>> Structure", which the Memory Device structure also points to.
>> Card then must mean "a collection of memory devices (DIMMs) that operate
>> together to form an address space".
>>
>> This might be what I think of as a memory-controller, or it might be
>> something more complicated. Regardless, the CPER records think its relevant.
> 
> Originally I thought "Card" were memory channel. But looking at the definition
> of "Card Handle" in CPER: "... this field contains the SMBIOS handle for the
> Type 16 Memory Array Structure that represents the memory card". So Card is
> memory controller or something similar to that.
> Right now ghes-edac assumes
> one mc. We probably need to map mc(s) to the type 16 instances in SMBIOS table. 

I think we should ignore 'mc's, and just report the dimm numbers.

ghes-edac only cares about the number of dimms today, and this would work on
systems that only describe the dimms in the smbios table.


Thanks,

James
