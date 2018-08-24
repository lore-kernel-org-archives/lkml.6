Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1131C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B1F208D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B1F208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeHXNWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:22:19 -0400
Received: from foss.arm.com ([217.140.101.70]:55008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbeHXNWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:22:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58F257A9;
        Fri, 24 Aug 2018 02:48:27 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1DFE3F5A0;
        Fri, 24 Aug 2018 02:48:25 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
Date:   Fri, 24 Aug 2018 10:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tyler,

On 23/08/18 16:46, Tyler Baicar wrote:
> On Thu, Aug 23, 2018 at 5:29 AM James Morse <james.morse@arm.com> wrote:
>> On 19/07/18 19:36, Tyler Baicar wrote:
>>> On 7/19/2018 10:46 AM, James Morse wrote:
>>>> On 19/07/18 15:01, Borislav Petkov wrote:
>>>>> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
>>>>>> Enable per-layer error reporting for ARM systems so that the error
>>>>>> counters are incremented per-DIMM.
>>
>> This 'layer' term seems to be EDAC's artificial view of memory.
>>
> 
> Yes, it's just the terminology that EDAC uses for locating a DIMM.
> 
> "Layer" can mean several things here:
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/edac.h#L318

Aha, its an enum. I thought it was an upper/middle/lower mapping at the whim of
the edac driver.

[...]

>> [re-ordered hunk:]
>>> This seems pretty hacky to me, so if anyone has other suggestions please share
>>> them.
>>
>> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE should provide
>> the information necessary to identify the failing FRU". As EDAC has three
>> 'levels', these are what they should correspond to for ghes-edac.
>>
>> I assume NODE means rack/chassis in some distributed system. Lets ignore it as
>> it doesn't seem to map to anything in the SMBIOS table.
> 
> I believe NODE should map to socket number for multi-socket systems.

Isn't the Memory Array Structure still unique in a multi-socket system? If so
the node isn't telling us anything new.

Do sockets show up in the SMBIOS table? We would need to know how many there are
in advance. For arm systems the cpu topology from PPTT is the best bet for this
information, but what do we do if that table is missing? (also, does firmware
count from 1 or 0?) I suspect we can't use this field unless we know what the
range of values is going to be in advance.

I assumed this node must be a level of information above Card/Memory-Array's
address-space. Somehow the Card handle isn't no long unique, we need the node
number too. If the CPER records were all being pumped at a single agent, (shared
BMC in a blade/chassis thing) then this might matter. I suspect we can ignore it
in linux.


>> The CPER record's card and module numbers are useless to us, as we need to know
>> how many there will be in advance. (does this version of firmware count from 0
>> or 1?)
>>
>> ... but CPER also gives us a 'Card Handle' and 'Module Handle'.
>> 'Module Handle' maps to SMBIOS:17 Memory Device (aka, a DIMM). The Handle is a
>> word-value in the structure, so it doesn't depend on the layout/parse-order of
>> the SMBIOS tables. When we count the DIMMs in edac-ghes we can give them some
>> level-idx, then use the handle to find which level-idx to use for this DIMM.
>>
>> ghes_edac_report_mem_error() already picks up the module-handle, but only uses
>> it to print the bank/device.
>>
>> 'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
>> Structure", which the Memory Device structure also points to.
>> Card then must mean "a collection of memory devices (DIMMs) that operate
>> together to form an address space".
>>
>> This might be what I think of as a memory-controller, or it might be something
>> more complicated. Regardless, the CPER records think its relevant.
>>
>> For the edac:layers, we could walk the DMI table to find these structures, and
>> build the layers from them. If the Memory-array-structures are missing, we can
>> use the existing 1:NUM_DIMMS approach.

> I think the proper way to get this working would be to use these handles. We can
> avoid populating this layer information and instead have a mapping of type 17
> index number (how edac is numbering the DIMMs today) to the handle number.

Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
EDAC_MC_LAYER_SLOT is for?


> Then we will need a new function to increment the counter based on the handle
> number rather than this layer information. Is that how you are envisioning it?

I'm not familiar with edac's internals, so I didn't have any particular vision!

Isn't the problem that ghes_edac_report_mem_error() does this:
|	e->top_layer = -1;
|	e->mid_layer = -1;
|	e->low_layer = -1;

so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
read what it does with this information yet).

ghes_edac_report_mem_error() does check CPER_MEM_VALID_MODULE_HANDLE, and if its
set, it uses the handle to find the bank/device strings and prints them out.

Naively I thought we could generate some index during ghes_edac_count_dimms(),
and use this as e->${whichever}_layer. I hoped there would be something we could
already use as the index, but I can't spot it, so this will be more than the
one-liner I was hoping for!


Thanks,

James
