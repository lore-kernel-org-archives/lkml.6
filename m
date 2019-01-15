Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1515AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC3A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ubd5J4tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfAORrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:47:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37280 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfAORrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:47:12 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FHl1tN127688;
        Tue, 15 Jan 2019 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547574421;
        bh=m3ffrchsjFw/CtjPHEdLpRqKb106oSrJ/3tnGRHD0uQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ubd5J4tMjx0+Kbgv4M08H/Lpdcxk72oDRtrBVOED68qtM64+vhUZl5NWYBps2LZoJ
         0KuIBn5s2Qjcmn6+AqcFl+ril4vtLT8qtgX5x5QhxLBgZ6HOct1wzzOPBsMAHwDhDb
         9jczE0F2LrDcS6Lcv2piLRrUVnuTHgCTaS4EBRdY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FHl14b040609
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 11:47:01 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 11:47:01 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 11:47:01 -0600
Received: from [172.22.120.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FHl0sd030830;
        Tue, 15 Jan 2019 11:47:00 -0600
Subject: Re: [PATCH 00/14] Misc ION cleanups and adding unmapped heap
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20190111180523.27862-1-afd@ti.com>
 <3b0d05e1-d437-801b-1c41-97d55f9ac10f@redhat.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <80a0888f-6780-884c-6571-86a1ba5d55cc@ti.com>
Date:   Tue, 15 Jan 2019 11:47:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3b0d05e1-d437-801b-1c41-97d55f9ac10f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 8:39 PM, Laura Abbott wrote:
> On 1/11/19 10:05 AM, Andrew F. Davis wrote:
>> Hello all,
>>
>> This is a set of (hopefully) non-controversial cleanups for the ION
>> framework and current set of heaps. These were found as I start to
>> familiarize myself with the framework to help in whatever way I
>> can in getting all this up to the standards needed for de-staging.
>>
>> I would like to get some ideas of what is left to work on to get ION
>> out of staging. Has there been some kind of agreement on what ION should
>> eventually end up being? To me it looks like it is being whittled away at
>> to it's most core functions. To me that is looking like being a DMA-BUF
>> user-space front end, simply advertising available memory backings in a
>> system and providing allocations as DMA-BUF handles. If this is the case
>> then it looks close to being ready to me at least, but I would love to
>> hear any other opinions and concerns.
>>
> 
> Yes, at this point the only functionality that people are really
> depending on is the ability to allocate a dma_buf easily from userspace.
> 
>> Back to this patchset, the last patch may be a bit different than the
>> others, it adds an unmapped heaps type and creation helper. I wanted to
>> get this in to show off another heap type and maybe some issues we may
>> have with the current ION framework. The unmapped heap is used when the
>> backing memory should not (or cannot) be touched. Currently this kind
>> of heap is used for firewalled secure memory that can be allocated like
>> normal heap memory but only used by secure devices (OP-TEE, crypto HW,
>> etc). It is basically just copied from the "carveout" heap type with the
>> only difference being it is not mappable to userspace and we do not clear
>> the memory (as we should not map it either). So should this really be a
>> new heap type? Or maybe advertised as a carveout heap but with an
>> additional allocation flag? Perhaps we do away with "types" altogether
>> and just have flags, coherent/non-coherent, mapped/unmapped, etc.
>>
>> Maybe more thinking will be needed afterall..
>>
> 
> So the cleanup looks okay (I need to finish reviewing) but I'm not a
> fan of adding another heaptype without solving the problem of adding
> some sort of devicetree binding or other method of allocating and
> placing Ion heaps. That plus uncached buffers are one of the big
> open problems that need to be solved for destaging Ion. See
> https://lore.kernel.org/lkml/20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain/
> 
> for some background on that problem.
> 

I'm under the impression that adding heaps like carveouts/chunk will be
rather system specific and so do not lend themselves well to a universal
DT style exporter. For instance a carveout memory space can be reported
by a device at runtime, then the driver managing that device should go
and use the carveout heap helpers to export that heap. If this is the
case then I'm not sure it is a problem for the ION core framework to
solve, but rather the users of it to figure out how best to create the
various heaps. All Ion needs to do is allow exporting and advertising
them IMHO.

Thanks for the background thread link, I've been looking for some info
on current status of all this and "ion" is a bit hard to search the
lists for. The core reason for posting this cleanup series is to throw
my hat into the ring of all this Ion work and start getting familiar
with the pending issues. The last two patches are not all that important
to get in right now.

In that thread you linked above, it seems we may have arrived at a
similar problem for different reasons. I think the root issue is the Ion
core makes too many assumptions about the heap memory. My proposal would
be to allow the heap exporters more control over the DMA-BUF ops, maybe
even going as far as letting them provide their own complete struct
dma_buf_ops.

Let me give an example where I think this is going to be useful. We have
the classic constraint solving problem on our SoCs. Our SoCs are full of
various coherent and non-coherent devices, some require contiguous
memory allocations, others have in-line IOMMUs so can operate on
non-contiguous, etc..

DMA-BUF has a solution designed in for this we can use, namely
allocation at map time after all the attachments have come in. The
checking of each attached device to find the right backing memory is
something the DMA-BUF exporter has to do, and so this SoC specific logic
would have to be added to each exporting framework (DRM, V4L2, etc),
unless we have one unified system exporter everyone uses, Ion.

Then each system can define one (maybe typeless) heap, the correct
backing type is system specific anyway, so let the system specific
backing logic in the unified system exporter heap handle picking that.
To allow that heaps need direct control of dma_buf_ops.

Direct heap control of dma_buf_ops also fixes the cache/non-cache issue,
and my unmapped memory issue, each heap type handles the quirks of its
backing storage in its own way, instead of trying to find some one size
fits all memory operations like we are doing now.

We can provide helpers for the simple heap types still, but with this
much of the heavy lifting moves out of the Ion core framework making it
much more simple, something I think it will need for de-staging.

Anyway, I might be completely off base in my direction here, just let me
know :)

Thanks,
Andrew

> Thanks,
> Laura
> 
>> Thanks,
>> Andrew
>>
>> Andrew F. Davis (14):
>>    staging: android: ion: Add proper header information
>>    staging: android: ion: Remove empty ion_ioctl_dir() function
>>    staging: android: ion: Merge ion-ioctl.c into ion.c
>>    staging: android: ion: Remove leftover comment
>>    staging: android: ion: Remove struct ion_platform_heap
>>    staging: android: ion: Fixup some white-space issues
>>    staging: android: ion: Sync comment docs with struct ion_buffer
>>    staging: android: ion: Remove base from ion_carveout_heap
>>    staging: android: ion: Remove base from ion_chunk_heap
>>    staging: android: ion: Remove unused headers
>>    staging: android: ion: Allow heap name to be null
>>    staging: android: ion: Declare helpers for carveout and chunk heaps
>>    staging: android: ion: Do not sync CPU cache on map/unmap
>>    staging: android: ion: Add UNMAPPED heap type and helper
>>
>>   drivers/staging/android/ion/Kconfig           |  10 ++
>>   drivers/staging/android/ion/Makefile          |   3 +-
>>   drivers/staging/android/ion/ion-ioctl.c       |  98 --------------
>>   drivers/staging/android/ion/ion.c             |  93 +++++++++++--
>>   drivers/staging/android/ion/ion.h             |  87 ++++++++-----
>>   .../staging/android/ion/ion_carveout_heap.c   |  19 +--
>>   drivers/staging/android/ion/ion_chunk_heap.c  |  25 ++--
>>   drivers/staging/android/ion/ion_cma_heap.c    |   6 +-
>>   drivers/staging/android/ion/ion_heap.c        |   8 +-
>>   drivers/staging/android/ion/ion_page_pool.c   |   2 +-
>>   drivers/staging/android/ion/ion_system_heap.c |   8 +-
>>   .../staging/android/ion/ion_unmapped_heap.c   | 123 ++++++++++++++++++
>>   drivers/staging/android/uapi/ion.h            |   3 +
>>   13 files changed, 307 insertions(+), 178 deletions(-)
>>   delete mode 100644 drivers/staging/android/ion/ion-ioctl.c
>>   create mode 100644 drivers/staging/android/ion/ion_unmapped_heap.c
>>
> 
