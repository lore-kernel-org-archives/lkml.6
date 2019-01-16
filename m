Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10370205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vTG5h6bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405118AbfAPQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:05:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42792 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405107AbfAPQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:05:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GG5C35101414;
        Wed, 16 Jan 2019 10:05:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547654713;
        bh=gkv5/5jSqhEnIF+Ml+FXiEFPM4XUzdWLBMl/Es/80Oc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vTG5h6bXhCMDBCRCWg/0l3vlzLXZIUvdLyzqYdre3mQBp1shHycZx5yXUN1IbTr8q
         Fdr7HlLxqpPqY2hTDPIKO2qgDtwiMeQXVoEk4nmZQJEMEwMnGKmCNBKjmQnj8NO/c0
         lif4U6w2Z8GXnXyG7nCYU6jI55x3qxIqdWQjLqWY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GG5CVZ093647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 10:05:12 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 10:05:12 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 10:05:12 -0600
Received: from [172.22.93.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GG5B73002032;
        Wed, 16 Jan 2019 10:05:12 -0600
Subject: Re: [PATCH 00/14] Misc ION cleanups and adding unmapped heap
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20190111180523.27862-1-afd@ti.com>
 <3b0d05e1-d437-801b-1c41-97d55f9ac10f@redhat.com>
 <80a0888f-6780-884c-6571-86a1ba5d55cc@ti.com>
 <54438c88-cad6-534d-64a5-f43e7b74f3bb@redhat.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <f6d7f02d-791b-2095-4e94-8c323b6cefe9@ti.com>
Date:   Wed, 16 Jan 2019 10:05:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <54438c88-cad6-534d-64a5-f43e7b74f3bb@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 12:58 PM, Laura Abbott wrote:
> On 1/15/19 9:47 AM, Andrew F. Davis wrote:
>> On 1/14/19 8:39 PM, Laura Abbott wrote:
>>> On 1/11/19 10:05 AM, Andrew F. Davis wrote:
>>>> Hello all,
>>>>
>>>> This is a set of (hopefully) non-controversial cleanups for the ION
>>>> framework and current set of heaps. These were found as I start to
>>>> familiarize myself with the framework to help in whatever way I
>>>> can in getting all this up to the standards needed for de-staging.
>>>>
>>>> I would like to get some ideas of what is left to work on to get ION
>>>> out of staging. Has there been some kind of agreement on what ION
>>>> should
>>>> eventually end up being? To me it looks like it is being whittled
>>>> away at
>>>> to it's most core functions. To me that is looking like being a DMA-BUF
>>>> user-space front end, simply advertising available memory backings in a
>>>> system and providing allocations as DMA-BUF handles. If this is the
>>>> case
>>>> then it looks close to being ready to me at least, but I would love to
>>>> hear any other opinions and concerns.
>>>>
>>>
>>> Yes, at this point the only functionality that people are really
>>> depending on is the ability to allocate a dma_buf easily from userspace.
>>>
>>>> Back to this patchset, the last patch may be a bit different than the
>>>> others, it adds an unmapped heaps type and creation helper. I wanted to
>>>> get this in to show off another heap type and maybe some issues we may
>>>> have with the current ION framework. The unmapped heap is used when the
>>>> backing memory should not (or cannot) be touched. Currently this kind
>>>> of heap is used for firewalled secure memory that can be allocated like
>>>> normal heap memory but only used by secure devices (OP-TEE, crypto HW,
>>>> etc). It is basically just copied from the "carveout" heap type with
>>>> the
>>>> only difference being it is not mappable to userspace and we do not
>>>> clear
>>>> the memory (as we should not map it either). So should this really be a
>>>> new heap type? Or maybe advertised as a carveout heap but with an
>>>> additional allocation flag? Perhaps we do away with "types" altogether
>>>> and just have flags, coherent/non-coherent, mapped/unmapped, etc.
>>>>
>>>> Maybe more thinking will be needed afterall..
>>>>
>>>
>>> So the cleanup looks okay (I need to finish reviewing) but I'm not a
>>> fan of adding another heaptype without solving the problem of adding
>>> some sort of devicetree binding or other method of allocating and
>>> placing Ion heaps. That plus uncached buffers are one of the big
>>> open problems that need to be solved for destaging Ion. See
>>> https://lore.kernel.org/lkml/20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain/
>>>
>>>
>>> for some background on that problem.
>>>
>>
>> I'm under the impression that adding heaps like carveouts/chunk will be
>> rather system specific and so do not lend themselves well to a universal
>> DT style exporter. For instance a carveout memory space can be reported
>> by a device at runtime, then the driver managing that device should go
>> and use the carveout heap helpers to export that heap. If this is the
>> case then I'm not sure it is a problem for the ION core framework to
>> solve, but rather the users of it to figure out how best to create the
>> various heaps. All Ion needs to do is allow exporting and advertising
>> them IMHO.
>>
> 
> I think it is a problem for the Ion core framework to take care of.
> Ion is useless if you don't actually have the heaps. Nobody has
> actually gotten a full Ion solution end-to-end with a carveout heap
> working in mainline because any proposals have been rejected. I think
> we need at least one example in mainline of how creating a carveout
> heap would work.

In our evil vendor trees we have several examples. The issue being that
Ion is still staging and attempts for generic DT heap definitions
haven't seemed to go so well. So for now we just keep it specific to our
platforms until upstream makes a direction decision.

> 
>> Thanks for the background thread link, I've been looking for some info
>> on current status of all this and "ion" is a bit hard to search the
>> lists for. The core reason for posting this cleanup series is to throw
>> my hat into the ring of all this Ion work and start getting familiar
>> with the pending issues. The last two patches are not all that important
>> to get in right now.
>>
>> In that thread you linked above, it seems we may have arrived at a
>> similar problem for different reasons. I think the root issue is the Ion
>> core makes too many assumptions about the heap memory. My proposal would
>> be to allow the heap exporters more control over the DMA-BUF ops, maybe
>> even going as far as letting them provide their own complete struct
>> dma_buf_ops.
>>
>> Let me give an example where I think this is going to be useful. We have
>> the classic constraint solving problem on our SoCs. Our SoCs are full of
>> various coherent and non-coherent devices, some require contiguous
>> memory allocations, others have in-line IOMMUs so can operate on
>> non-contiguous, etc..
>>
>> DMA-BUF has a solution designed in for this we can use, namely
>> allocation at map time after all the attachments have come in. The
>> checking of each attached device to find the right backing memory is
>> something the DMA-BUF exporter has to do, and so this SoC specific logic
>> would have to be added to each exporting framework (DRM, V4L2, etc),
>> unless we have one unified system exporter everyone uses, Ion.
>>
> 
> That's how dmabuf is supposed to work in theory but in practice we
> also have the case of userspace allocates memory, mmaps, and then
> a device attaches to it. The issue is we end up having to do work
> and make decisions before all devices are actually attached.
> 

That just seems wrong, DMA-BUF should be used for, well, DMA-able
buffers.. Userspace should not be using these buffers without devices
attached, otherwise why not use a regular buffer. If you need to fill
the buffer then you should attach/map it first so the DMA-BUF exporter
can pick the appropriate backing memory first.

Maybe a couple more rules on the ordering of DMA-BUF operations are
needed to prevent having to deal with all these non-useful permutations.

Sumit? ^^

>> Then each system can define one (maybe typeless) heap, the correct
>> backing type is system specific anyway, so let the system specific
>> backing logic in the unified system exporter heap handle picking that.
>> To allow that heaps need direct control of dma_buf_ops.
>>
>> Direct heap control of dma_buf_ops also fixes the cache/non-cache issue,
>> and my unmapped memory issue, each heap type handles the quirks of its
>> backing storage in its own way, instead of trying to find some one size
>> fits all memory operations like we are doing now.
>>
> 
> I don't think this is an issue of one-size fits all. We have flags
> to differentiate between cached and uncached paths, the issue is
> that doing the synchronization for uncached buffers is difficult.
> 

It is difficult, hence why letting an uncached heap exporter do all the
heavy work, instead of trying to deal with all these cases in the Ion
core framework.

> I'm just not sure how an extra set of dma_buf ops actually solves
> the problem of needing to synchronize alias mappings.
> 

It doesn't solve it, it just moves the work out of the framework. There
are going to be a lot more interesting problems than this with some
types heaps we will have in the future, dealing with all the logic in
the framework core is not going to scale.

Thanks,
Andrew

> Thanks,
> Laura
> 
>> We can provide helpers for the simple heap types still, but with this
>> much of the heavy lifting moves out of the Ion core framework making it
>> much more simple, something I think it will need for de-staging.
>>
>> Anyway, I might be completely off base in my direction here, just let me
>> know :)
>>
> 
