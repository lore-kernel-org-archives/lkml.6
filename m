Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8294C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C66217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nyZoUC2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfAXQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:05:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50622 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfAXQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:05:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0OG4mps002436;
        Thu, 24 Jan 2019 10:04:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548345888;
        bh=BCiUGJ76FVPLlqs/ynT2170pf/jt5Dr/DMLhgOg+y7I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nyZoUC2j8PTb1RrsBBXlkSoLyhTHWrKcjiNTtBCYKigfQlqG9L6mabX2+eAAKVo84
         QYkAJ83AvD8psthJmh/bLBPNJIfAR48lMJ7jGdQuEpVpfbWEIrnNcEe0LNyBlld2bj
         K7gEBCMV+lkTshgGODbu2g8+/ty4Iae+CSocuz4I=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0OG4m3d066042
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 10:04:48 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 10:04:48 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 10:04:47 -0600
Received: from [172.22.107.202] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0OG4kA7027675;
        Thu, 24 Jan 2019 10:04:46 -0600
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
 <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com>
 <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com>
 <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
 <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
 <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
 <CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com>
 <d24949d2-3736-0e6f-99ae-b8550d53a828@ti.com>
 <20190123171153.ql25gyg6sma4fpqb@DESKTOP-E1NTVVP.localdomain>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <af5c22b2-0d9e-4bd1-6fdd-1a3880890916@ti.com>
Date:   Thu, 24 Jan 2019 10:04:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123171153.ql25gyg6sma4fpqb@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 11:11 AM, Brian Starkey wrote:
> Hi Andrew,
> 
> On Wed, Jan 23, 2019 at 10:51:24AM -0600, Andrew F. Davis wrote:
>> On 1/22/19 11:33 AM, Sumit Semwal wrote:
>>> Hello everyone,
>>>
>>> Sincere apologies for chiming in a bit late here, but was off due to
>>> some health issues.
>>>
>>
>> Hope you are feeling better friend :)
>>
>> Looks like this email was a bit broken and you replied again, the
>> responses are a little different in each email, so I'd like to respond
>> to bits of both, I'll fix up the formatting.
>>
>>> Also, adding Daniel Vetter to the mix, since he has been one of the
>>> core guys who shaped up dma-buf as it is today.
>>>
>>> On Tue, 22 Jan 2019 at 02:51, Andrew F. Davis <afd@ti.com> wrote:
>>>>
>>>> On 1/21/19 5:22 AM, Brian Starkey wrote:
>>
>> [snip]
>>
>>>>>
>>>>> Actually I meant in the kernel, in exporters. I haven't seen anyone
>>>>> using the API as it was intended (defer allocation until first map,
>>>>> migrate between different attachments, etc.). Mostly, backing storage
>>>>> seems to get allocated at the point of export, and device mappings are
>>>>> often held persistently (e.g. the DRM prime code maps the buffer at
>>>>> import time, and keeps it mapped: drm_gem_prime_import_dev).
>>>>>
>>>>
>>>
>>> So I suppose some clarification on the 'intended use' part of dma-buf
>>> about deferred allocation is due, so here it is: (Daniel, please feel
>>> free to chime in with your opinion here)
>>>
>>>  - dma-buf was of course designed as a framework to help intelligent
>>> exporters to defer allocation until first map, and be able to migrate
>>> backing storage if required etc. At the same time, it is not a
>>> _requirement_ from any exporter, so exporters so far have just used it
>>> as a convenient mechanism for zero-copy.
>>> - ION is one of the few dma-buf exporters in kernel, which satisfies a
>>> certain set of expectations from its users.
>>>
>>
>> The issue here is that Ion is blocking the ability to late allocate, it
>> expects its heaps to have the memory ready at allocation time. My point
>> being if the DMA-BUFs intended design was to allow this then Ion should
>> respect that and also allow the same from its heap exporters.
>>
>>>> I haven't either, which is a shame as it allows for some really useful
>>>> management strategies for shared memory resources. I'm working on one
>>>> such case right now, maybe I'll get to be the first to upstream one :)
>>>>
>>> That will be a really good thing! Though perhaps we ought to think if
>>> for what you're trying to do, is ION the right place, or should you
>>> have a device-specific exporter, available to users via dma-buf apis?
>>>
>>
>> I'm starting to question if Ion is the right place myself..
>>
>> At a conceptual level I don't believe userspace should be picking the
>> backing memory type. This is because the right type of backing memory
>> for a task will change from system to system. The kernel should abstract
>> away these hardware differences from userspace as much as it can to
>> allow portable code.
>>
>> For instance a device may need a contiguous buffer on one system but the
>> same device on another may have some IOMMU. So which type of memory do
>> we allocate? Same issue for cacheability and other properties.
>>
>> What we need is a central allocator with full system knowledge to do the
>> choosing for us. It seems many agree with the above and I take
>> inspiration from your cenalloc patchset. The thing I'm not sure about is
>> letting the device drivers set their constraints, because they also
>> don't have the full system integration details. For cases where devices
>> are behind an IOMMU it is easy enough for the device to know, but what
>> about when we have external MMUs out on the bus for anyone to use (I'm
>> guessing you remember TILER..).
>>
>> I would propose the central allocator keep per-system knowledge (or
>> fetch it from DT, or if this is considered policy then userspace) which
>> it can use to directly check the attached devices and pick the right memory.
>>
>> Anyway the central system allocator could handle 90% of cases I can
>> think of, and this is where Ion comes back in, the other cases would
>> still require the program to manually pick the right memory (maybe for
>> performance reasons, etc.).
>>
>> So my vision is to have Ion as the the main front-end for DMA-BUF
>> allocations, and expose the central allocator through it (maybe as a
>> default heap type that can be populated on a per-system basis), but also
>> have other individual heap types exported for the edge cases where
>> manual selection is needed like we do now.
>>
>> Hence why Ion should allow direct control of the dma_buf_ops from the
>> heaps, so we can build central allocators as Ion heaps.
>>
>> If I'm off into the weeds here and you have some other ideas I'm all ears.
>>
> 
> This is a topic I've gone around a few times. The crux of it is, as
> you know, a central allocator is Really Hard. I don't know what you've
> seen/done so far in this area, so please forgive me if this is old hat
> to you.
> 

I'm very new to all this, so any pointers to history in this area are
appreciated.

> Android's platform-specific Gralloc module actually does a pretty good
> job, and because it's platform-specific, it can be simple. That does
> have a certain appeal to it over something generic but complex.
> 
> It seems that generic gets insanely complicated really quickly -
> picking out "compatible" is hard enough, but improving that to pick
> out "optimal" is ... well, I've not seen any good proposals for that.
> 

I quickly found out the extent of how complicated this can get. I
originally wanted a generic central allocator, but to be complete it
would have to handle every one of everyones uses, so just not going to
happen. So I refocused on simply a central allocator, it didn't need to
be generic and can be made specifically for each given system of ours.
Even that quickly ran into objections when proposed internally, there
will always be edge use-cases that require manual selection of
allocation type (due to performance and resource partitioning). Now I'm
at an optional central allocator plus the standard allocator heaps
provided by Ion, the system specific central allocator being also
exported by Ion for simplicity.

So all I want is to find is "compatible" when needed, leave "optimal"
selection up to the applications that need it.

> In case you didn't come across it already, the effort which seems to
> have gained the most "air-time" recently is
> https://github.com/cubanismo/allocator, which is still a userspace
> module (perhaps some concepts from there could go into the kernel?),
> but makes some attempts at generic constraint solving. It's also not
> really moving anywhere at the moment.
> 

Very interesting, I'm going to have to stare at this for a bit.

Thanks,
Andrew

> Cheers,
> -Brian
> 
>> Andrew
>>
>>>>> I wasn't aware that CPU access before first device access was
>>>>> considered an abuse of the API - it seems like a valid thing to want
>>>>> to do.
>>>>>
>>>>
>>>> That's just it, I don't know if it is an abuse of API, I'm trying to get
>>>> some clarity on that. If we do want to allow early CPU access then that
>>>> seems to be in contrast to the idea of deferred allocation until first
>>>> device map, what is supposed to backing the buffer if no devices have
>>>> attached or mapped yet? Just some system memory followed by migration on
>>>> the first attach to the proper backing? Seems too time wasteful to be
>>>> have a valid use.
>>>>
>>>> Maybe it should be up to the exporter if early CPU access is allowed?
>>>>
>>>> I'm hoping someone with authority over the DMA-BUF framework can clarify
>>>> original intentions here.
>>>
>>> I don't think dma-buf as a framework stops early CPU access, and the
>>> exporter can definitely decide on that by implementing
>>> begin_cpu_access / end_cpu_access operations to not allow early CPU
>>> access, if it so desires.
>>>
