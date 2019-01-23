Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB2DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7C32085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v+0hGbpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAWQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:53:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfAWQxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:53:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0NGpQaT083640;
        Wed, 23 Jan 2019 10:51:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548262286;
        bh=Oue4lDgrHgiUEwUpAPAyqRumS+Pijz8Ox6/VtLrFx/g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v+0hGbpErhFtY165I70CMtohgQadtPeMpP4E2b813Ybaf7DFbOARoSrBRplER4qRe
         ryIt51WaqLwwrX8hOtziyiiCR7gSpbp0su4W6UQYTw5dpxkEfbnZBip3U9DfU/GOAF
         lv2z+K1QAERY3WXKcgZolP1PDpox6tFOyGQekMok=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0NGpQjR115502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 10:51:26 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 23
 Jan 2019 10:51:26 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 23 Jan 2019 10:51:26 -0600
Received: from [172.22.97.60] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0NGpPBc012760;
        Wed, 23 Jan 2019 10:51:25 -0600
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
To:     Sumit Semwal <sumit.semwal@linaro.org>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com>
 <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
 <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com>
 <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com>
 <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
 <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
 <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
 <CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <d24949d2-3736-0e6f-99ae-b8550d53a828@ti.com>
Date:   Wed, 23 Jan 2019 10:51:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 11:33 AM, Sumit Semwal wrote:
> Hello everyone,
> 
> Sincere apologies for chiming in a bit late here, but was off due to
> some health issues.
> 

Hope you are feeling better friend :)

Looks like this email was a bit broken and you replied again, the
responses are a little different in each email, so I'd like to respond
to bits of both, I'll fix up the formatting.

> Also, adding Daniel Vetter to the mix, since he has been one of the
> core guys who shaped up dma-buf as it is today.
> 
> On Tue, 22 Jan 2019 at 02:51, Andrew F. Davis <afd@ti.com> wrote:
>>
>> On 1/21/19 5:22 AM, Brian Starkey wrote:

[snip]

>>>
>>> Actually I meant in the kernel, in exporters. I haven't seen anyone
>>> using the API as it was intended (defer allocation until first map,
>>> migrate between different attachments, etc.). Mostly, backing storage
>>> seems to get allocated at the point of export, and device mappings are
>>> often held persistently (e.g. the DRM prime code maps the buffer at
>>> import time, and keeps it mapped: drm_gem_prime_import_dev).
>>>
>>
> 
> So I suppose some clarification on the 'intended use' part of dma-buf
> about deferred allocation is due, so here it is: (Daniel, please feel
> free to chime in with your opinion here)
> 
>  - dma-buf was of course designed as a framework to help intelligent
> exporters to defer allocation until first map, and be able to migrate
> backing storage if required etc. At the same time, it is not a
> _requirement_ from any exporter, so exporters so far have just used it
> as a convenient mechanism for zero-copy.
> - ION is one of the few dma-buf exporters in kernel, which satisfies a
> certain set of expectations from its users.
> 

The issue here is that Ion is blocking the ability to late allocate, it
expects its heaps to have the memory ready at allocation time. My point
being if the DMA-BUFs intended design was to allow this then Ion should
respect that and also allow the same from its heap exporters.

>> I haven't either, which is a shame as it allows for some really useful
>> management strategies for shared memory resources. I'm working on one
>> such case right now, maybe I'll get to be the first to upstream one :)
>>
> That will be a really good thing! Though perhaps we ought to think if
> for what you're trying to do, is ION the right place, or should you
> have a device-specific exporter, available to users via dma-buf apis?
> 

I'm starting to question if Ion is the right place myself..

At a conceptual level I don't believe userspace should be picking the
backing memory type. This is because the right type of backing memory
for a task will change from system to system. The kernel should abstract
away these hardware differences from userspace as much as it can to
allow portable code.

For instance a device may need a contiguous buffer on one system but the
same device on another may have some IOMMU. So which type of memory do
we allocate? Same issue for cacheability and other properties.

What we need is a central allocator with full system knowledge to do the
choosing for us. It seems many agree with the above and I take
inspiration from your cenalloc patchset. The thing I'm not sure about is
letting the device drivers set their constraints, because they also
don't have the full system integration details. For cases where devices
are behind an IOMMU it is easy enough for the device to know, but what
about when we have external MMUs out on the bus for anyone to use (I'm
guessing you remember TILER..).

I would propose the central allocator keep per-system knowledge (or
fetch it from DT, or if this is considered policy then userspace) which
it can use to directly check the attached devices and pick the right memory.

Anyway the central system allocator could handle 90% of cases I can
think of, and this is where Ion comes back in, the other cases would
still require the program to manually pick the right memory (maybe for
performance reasons, etc.).

So my vision is to have Ion as the the main front-end for DMA-BUF
allocations, and expose the central allocator through it (maybe as a
default heap type that can be populated on a per-system basis), but also
have other individual heap types exported for the edge cases where
manual selection is needed like we do now.

Hence why Ion should allow direct control of the dma_buf_ops from the
heaps, so we can build central allocators as Ion heaps.

If I'm off into the weeds here and you have some other ideas I'm all ears.

Andrew

>>> I wasn't aware that CPU access before first device access was
>>> considered an abuse of the API - it seems like a valid thing to want
>>> to do.
>>>
>>
>> That's just it, I don't know if it is an abuse of API, I'm trying to get
>> some clarity on that. If we do want to allow early CPU access then that
>> seems to be in contrast to the idea of deferred allocation until first
>> device map, what is supposed to backing the buffer if no devices have
>> attached or mapped yet? Just some system memory followed by migration on
>> the first attach to the proper backing? Seems too time wasteful to be
>> have a valid use.
>>
>> Maybe it should be up to the exporter if early CPU access is allowed?
>>
>> I'm hoping someone with authority over the DMA-BUF framework can clarify
>> original intentions here.
> 
> I don't think dma-buf as a framework stops early CPU access, and the
> exporter can definitely decide on that by implementing
> begin_cpu_access / end_cpu_access operations to not allow early CPU
> access, if it so desires.
> 
