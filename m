Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D2C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nO6YAoif";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IfIPcAa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfARVoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:44:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfARVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:44:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0EF0E6085C; Fri, 18 Jan 2019 21:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547847839;
        bh=5K6tSgMmEO7Gr/XfCLZdu3AJ9p1igVfUbAktM4jRaNI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nO6YAoifR0hq52iLyoggraCpHlaxntozQHjDi2oluYijoB2y+jeCJqVDZhbr78ycm
         9yMcMZtEDx55dIb9l+lMABcPi3hPJKpqqBB5hMDxRwqnuYRzSdiCVpwkeHpLmMjPTO
         alt93EINVCn9dP4pyOdfcvAgOY6Kj14oQy0uqjcs=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 495486055C;
        Fri, 18 Jan 2019 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547847835;
        bh=5K6tSgMmEO7Gr/XfCLZdu3AJ9p1igVfUbAktM4jRaNI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IfIPcAa6Kd5i0xD4uMrpp1WgZILbZ/z3+SNzN7DQLycTGcUrldp4wS/06VOyI34aT
         XkqSoCHVLqXfChZH9zhMWSZ4gqV+y8L+tlK4moCZgBYKsz/Is4VX6sjB0UPB2ZaKVw
         JSqyYbdvlvocxzWh3w89wbGkE4m/j7IRB41IZENs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 495486055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Fri, 18 Jan 2019 13:43:54 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     "Andrew F. Davis" <afd@ti.com>
cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
In-Reply-To: <678589f7-055f-7a2e-3ade-c0c0aa37aeac@ti.com>
Message-ID: <alpine.DEB.2.10.1901181340590.9328@lmark-linux.qualcomm.com>
References: <20190111180523.27862-1-afd@ti.com> <20190111180523.27862-14-afd@ti.com> <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com> <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com> <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com> <b6cb5596-6beb-73e0-0d8c-d9a13466d626@redhat.com> <99ca0b08-02bd-64fd-d43c-c330f0d11639@ti.com> <alpine.DEB.2.10.1901161441280.10666@lmark-linux.qualcomm.com> <7620534f-b749-76f9-0f53-f73e3f12e9a9@ti.com>
 <alpine.DEB.2.10.1901171700490.12287@lmark-linux.qualcomm.com> <678589f7-055f-7a2e-3ade-c0c0aa37aeac@ti.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2046127808-835268283-1547847835=:9328"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2046127808-835268283-1547847835=:9328
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 18 Jan 2019, Andrew F. Davis wrote:

> On 1/17/19 7:04 PM, Liam Mark wrote:
> > On Thu, 17 Jan 2019, Andrew F. Davis wrote:
> > 
> >> On 1/16/19 4:48 PM, Liam Mark wrote:
> >>> On Wed, 16 Jan 2019, Andrew F. Davis wrote:
> >>>
> >>>> On 1/15/19 1:05 PM, Laura Abbott wrote:
> >>>>> On 1/15/19 10:38 AM, Andrew F. Davis wrote:
> >>>>>> On 1/15/19 11:45 AM, Liam Mark wrote:
> >>>>>>> On Tue, 15 Jan 2019, Andrew F. Davis wrote:
> >>>>>>>
> >>>>>>>> On 1/14/19 11:13 AM, Liam Mark wrote:
> >>>>>>>>> On Fri, 11 Jan 2019, Andrew F. Davis wrote:
> >>>>>>>>>
> >>>>>>>>>> Buffers may not be mapped from the CPU so skip cache maintenance
> >>>>>>>>>> here.
> >>>>>>>>>> Accesses from the CPU to a cached heap should be bracketed with
> >>>>>>>>>> {begin,end}_cpu_access calls so maintenance should not be needed
> >>>>>>>>>> anyway.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >>>>>>>>>> ---
> >>>>>>>>>>   drivers/staging/android/ion/ion.c | 7 ++++---
> >>>>>>>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/staging/android/ion/ion.c
> >>>>>>>>>> b/drivers/staging/android/ion/ion.c
> >>>>>>>>>> index 14e48f6eb734..09cb5a8e2b09 100644
> >>>>>>>>>> --- a/drivers/staging/android/ion/ion.c
> >>>>>>>>>> +++ b/drivers/staging/android/ion/ion.c
> >>>>>>>>>> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct
> >>>>>>>>>> dma_buf_attachment *attachment,
> >>>>>>>>>>         table = a->table;
> >>>>>>>>>>   -    if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> >>>>>>>>>> -            direction))
> >>>>>>>>>> +    if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> >>>>>>>>>> +                  direction, DMA_ATTR_SKIP_CPU_SYNC))
> >>>>>>>>>
> >>>>>>>>> Unfortunately I don't think you can do this for a couple reasons.
> >>>>>>>>> You can't rely on {begin,end}_cpu_access calls to do cache
> >>>>>>>>> maintenance.
> >>>>>>>>> If the calls to {begin,end}_cpu_access were made before the call to
> >>>>>>>>> dma_buf_attach then there won't have been a device attached so the
> >>>>>>>>> calls
> >>>>>>>>> to {begin,end}_cpu_access won't have done any cache maintenance.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> That should be okay though, if you have no attachments (or all
> >>>>>>>> attachments are IO-coherent) then there is no need for cache
> >>>>>>>> maintenance. Unless you mean a sequence where a non-io-coherent device
> >>>>>>>> is attached later after data has already been written. Does that
> >>>>>>>> sequence need supporting?
> >>>>>>>
> >>>>>>> Yes, but also I think there are cases where CPU access can happen before
> >>>>>>> in Android, but I will focus on later for now.
> >>>>>>>
> >>>>>>>> DMA-BUF doesn't have to allocate the backing
> >>>>>>>> memory until map_dma_buf() time, and that should only happen after all
> >>>>>>>> the devices have attached so it can know where to put the buffer. So we
> >>>>>>>> shouldn't expect any CPU access to buffers before all the devices are
> >>>>>>>> attached and mapped, right?
> >>>>>>>>
> >>>>>>>
> >>>>>>> Here is an example where CPU access can happen later in Android.
> >>>>>>>
> >>>>>>> Camera device records video -> software post processing -> video device
> >>>>>>> (who does compression of raw data) and writes to a file
> >>>>>>>
> >>>>>>> In this example assume the buffer is cached and the devices are not
> >>>>>>> IO-coherent (quite common).
> >>>>>>>
> >>>>>>
> >>>>>> This is the start of the problem, having cached mappings of memory that
> >>>>>> is also being accessed non-coherently is going to cause issues one way
> >>>>>> or another. On top of the speculative cache fills that have to be
> >>>>>> constantly fought back against with CMOs like below; some coherent
> >>>>>> interconnects behave badly when you mix coherent and non-coherent access
> >>>>>> (snoop filters get messed up).
> >>>>>>
> >>>>>> The solution is to either always have the addresses marked non-coherent
> >>>>>> (like device memory, no-map carveouts), or if you really want to use
> >>>>>> regular system memory allocated at runtime, then all cached mappings of
> >>>>>> it need to be dropped, even the kernel logical address (area as painful
> >>>>>> as that would be).
> >>>>>>
> >>>>>
> >>>>> I agree it's broken, hence my desire to remove it :)
> >>>>>
> >>>>> The other problem is that uncached buffers are being used for
> >>>>> performance reason so anything that would involve getting
> >>>>> rid of the logical address would probably negate any performance
> >>>>> benefit.
> >>>>>
> >>>>
> >>>> I wouldn't go as far as to remove them just yet.. Liam seems pretty
> >>>> adamant that they have valid uses. I'm just not sure performance is one
> >>>> of them, maybe in the case of software locks between devices or
> >>>> something where there needs to be a lot of back and forth interleaved
> >>>> access on small amounts of data?
> >>>>
> >>>
> >>> I wasn't aware that ARM considered this not supported, I thought it was 
> >>> supported but they advised against it because of the potential performance 
> >>> impact.
> >>>
> >>
> >> Not sure what you mean by "this" being not supported, do you mean mixed
> >> attribute mappings? If so, it will certainly cause problems, and the
> >> problems will change from platform to platform, avoid at all costs is my
> >> understanding of ARM's position.
> >>
> >>> This is after all supported in the DMA APIs and up until now devices have 
> >>> been successfully commercializing with this configurations, and I think 
> >>> they will continue to commercialize with these configurations for quite a 
> >>> while.
> >>>
> >>
> >> Use of uncached memory mappings are almost always wrong in my experience
> >> and are used to work around some bug or because the user doesn't want to
> >> implement proper CMOs. Counter examples welcome.
> >>
> > 
> > Okay, let me first try to clarify what I am referring to, as perhaps I am 
> > misunderstanding the conversation.
> > 
> > In this discussion I was originally referring to a use case with cached 
> > memory being accessed by a non io-cohernet device.
> > 
> > "In this example assume the buffer is cached and the devices are not 
> > IO-coherent (quite common)."	  
> > 
> > to which you did not think was supported:
> > 
> > "This is the start of the problem, having cached mappings of memory 
> > that is also being accessed non-coherently is going to cause issues 
> > one way or another. 
> > "
> > 
> > And I interpreted Laura's comment below as saying she wanted to remove 
> > support in ION for cached memory being accessed by non io-cohernet 
> > devices:
> > "I agree it's broken, hence my desire to remove it :)"
> > 
> > So assuming my understanding above is correct (and you are not talking 
> > about something separate such as removing uncached ION allocation 
> > support).
> > 
> 
> Ah, I think here is where we diverged, I'm assuming Laura's comment to
> be referencing my issue with uncached mappings being handed out without
> first removing all cached mappings of the same memory. Therefore it is
> uncached heaps that are broken.
> 

I am glad that is clarified, but can you then clarify for me your
following statement, I am stil not clear what the problem is then.

In response to:
"In this example assume the buffer is cached and the devices are
not IO-coherent (quite common)."

You said:

"This is the start of the problem, having cached mappings of memory that
is also being accessed non-coherently is going to cause issues one way or 
another. "

> > Then I guess I am not clear why current uses which use cached memory with 
> > non IO-coherent devices are considered to be working around some bug or 
> > are not implementing proper CMOs.
> > 
> > They use CPU cached mappings because that is the most effective way to 
> > access the memory from the CPU side and the devices have an uncached 
> > IOMMU mapping because they don't support IO-coherency, and currenlty in 
> > the CPU they do cache mainteance at the time of dma map and dma umap so
> > to me they are implementing correct CMOs.
> > 
> 
> Fully agree here, using cached mappings and performing CMOs when needed
> is the way to go when dealing with memory. IMHO the *only* time when
> uncached mappings are appropriate is for memory mapped I/O (although it
> looks like video memory was often treated as uncached (wc)).
> 
> >>> It would be really unfortunate if support was removed as I think that 
> >>> would drive clients away from using upstream ION.
> >>>
> >>
> >> I'm not petitioning to remove support, but at very least lets reverse
> >> the ION_FLAG_CACHED flag. Ion should hand out cached normal memory by
> >> default, to get uncached you should need to add a flag to your
> >> allocation command pointing out you know what you are doing.
> >>
> > 
> > You may not be petitioning to remove support for using cached memory with 
> > non io-coherent devices but I interpreted Laura's comment as wanting to do 
> > so, and I had concerns about that.
> > 
> 
> What I would like is for the default memory handed out by Ion to be
> normal cacheable memory, just like is always handed out to users-space.
> DMA-BUF already provides the means to deal with the CMOs required to
> work with non-io-coherent devices so all should be good here.
> 
> If you want Ion to give out uncached memory then I think you should need
> to explicitly state so with an allocation flag. And right now the
> uncached memory you will get back may have other cached mappings (kernel
> lowmem mappings) meaning you will have hard to predict results (on ARM
> at least). 

Yes, I can understand why it would make sense to default to cached memory.

> I just don't see much use for them (uncached mappings of
> regular memory) right now.
>

I can understand why people don't like ION providing uncached support, but 
I have been pushing to keep un-cached support in order to keep the 
performance of Android ION clients on par with the previous version of ION 
until a better solution can be found (either by changing ION or Android).

Basically most ION use cases don't involve any (or very little) CPU access 
so for now by using uncached ION allocations we can avoid the uncessary 
cache maitenance and we are safe if some CPU access is required. Of course 
for use cases involving a lot of CPU access the clients switch over to 
using cached buffers.

 
> >>>>>>> ION buffer is allocated.
> >>>>>>>
> >>>>>>> //Camera device records video
> >>>>>>> dma_buf_attach
> >>>>>>> dma_map_attachment (buffer needs to be cleaned)
> >>>>>>
> >>>>>> Why does the buffer need to be cleaned here? I just got through reading
> >>>>>> the thread linked by Laura in the other reply. I do like +Brian's
> >>>>>> suggestion of tracking if the buffer has had CPU access since the last
> >>>>>> time and only flushing the cache if it has. As unmapped heaps never get
> >>>>>> CPU mapped this would never be the case for unmapped heaps, it solves my
> >>>>>> problem.
> >>>>>>
> >>>>>>> [camera device writes to buffer]
> >>>>>>> dma_buf_unmap_attachment (buffer needs to be invalidated)
> >>>>>>
> >>>>>> It doesn't know there will be any further CPU access, it could get freed
> >>>>>> after this for all we know, the invalidate can be saved until the CPU
> >>>>>> requests access again.
> >>>>>>
> >>>>>>> dma_buf_detach  (device cannot stay attached because it is being sent
> >>>>>>> down
> >>>>>>> the pipeline and Camera doesn't know the end of the use case)
> >>>>>>>
> >>>>>>
> >>>>>> This seems like a broken use-case, I understand the desire to keep
> >>>>>> everything as modular as possible and separate the steps, but at this
> >>>>>> point no one owns this buffers backing memory, not the CPU or any
> >>>>>> device. I would go as far as to say DMA-BUF should be free now to
> >>>>>> de-allocate the backing storage if it wants, that way it could get ready
> >>>>>> for the next attachment, which may change the required backing memory
> >>>>>> completely.
> >>>>>>
> >>>>>> All devices should attach before the first mapping, and only let go
> >>>>>> after the task is complete, otherwise this buffers data needs copied off
> >>>>>> to a different location or the CPU needs to take ownership in-between.
> >>>>>>
> >>>>>
> >>>>> Maybe it's broken but it's the status quo and we spent a good
> >>>>> amount of time at plumbers concluding there isn't a great way
> >>>>> to fix it :/
> >>>>>
> >>>>
> >>>> Hmm, guess that doesn't prove there is not a great way to fix it either.. :/
> >>>>
> >>>> Perhaps just stronger rules on sequencing of operations? I'm not saying
> >>>> I have a good solution either, I just don't see any way forward without
> >>>> some use-case getting broken, so better to fix now over later.
> >>>>
> >>>
> >>> I can see the benefits of Android doing things the way they do, I would 
> >>> request that changes we make continue to support Android, or we find a way 
> >>> to convice them to change, as they are the main ION client and I assume 
> >>> other ION clients in the future will want to do this as well.
> >>>
> >>
> >> Android may be the biggest user today (makes sense, Ion come out of the
> >> Android project), but that can change, and getting changes into Android
> >> will be easier that the upstream kernel once Ion is out of staging.
> >>
> >> Unlike some other big ARM vendors, we (TI) do not primarily build mobile
> >> chips targeting Android, our core offerings target more traditional
> >> Linux userspaces, and I'm guessing others will start to do the same as
> >> ARM tries to push more into desktop, server, and other spaces again.
> >>
> >>> I am concerned that if you go with a solution which enforces what you 
> >>> mention above, and bring ION out of staging that way, it will make it that
> >>> much harder to solve this for Android and therefore harder to get 
> >>> Android clients to move to the upstream ION (and get everybody off their 
> >>> vendor modified Android versions).
> >>>
> >>
> >> That would be an Android problem, reducing functionality in upstream to
> >> match what some evil vendor trees do to support Android is not the way
> >> forward on this. At least for us we are going to try to make all our
> >> software offerings follow proper buffer ownership (including our Android
> >> offering).
> >>
> >>>>>>> //buffer is send down the pipeline
> >>>>>>>
> >>>>>>> // Usersapce software post processing occurs
> >>>>>>> mmap buffer
> >>>>>>
> >>>>>> Perhaps the invalidate should happen here in mmap.
> >>>>>>
> >>>>>>> DMA_BUF_IOCTL_SYNC IOCT with flags DMA_BUF_SYNC_START // No CMO since no
> >>>>>>> devices attached to buffer
> >>>>>>
> >>>>>> And that should be okay, mmap does the sync, and if no devices are
> >>>>>> attached nothing could have changed the underlying memory in the
> >>>>>> mean-time, DMA_BUF_SYNC_START can safely be a no-op as they are.
> >>>>>>
> >>>>>>> [CPU reads/writes to the buffer]
> >>>>>>> DMA_BUF_IOCTL_SYNC IOCTL with flags DMA_BUF_SYNC_END // No CMO since no
> >>>>>>> devices attached to buffer
> >>>>>>> munmap buffer
> >>>>>>>
> >>>>>>> //buffer is send down the pipeline
> >>>>>>> // Buffer is send to video device (who does compression of raw data) and
> >>>>>>> writes to a file
> >>>>>>> dma_buf_attach
> >>>>>>> dma_map_attachment (buffer needs to be cleaned)
> >>>>>>> [video device writes to buffer]
> >>>>>>> dma_buf_unmap_attachment
> >>>>>>> dma_buf_detach  (device cannot stay attached because it is being sent
> >>>>>>> down
> >>>>>>> the pipeline and Video doesn't know the end of the use case)
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>> Also ION no longer provides DMA ready memory, so if you are not
> >>>>>>>>> doing CPU
> >>>>>>>>> access then there is no requirement (that I am aware of) for you to
> >>>>>>>>> call
> >>>>>>>>> {begin,end}_cpu_access before passing the buffer to the device and
> >>>>>>>>> if this
> >>>>>>>>> buffer is cached and your device is not IO-coherent then the cache
> >>>>>>>>> maintenance
> >>>>>>>>> in ion_map_dma_buf and ion_unmap_dma_buf is required.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> If I am not doing any CPU access then why do I need CPU cache
> >>>>>>>> maintenance on the buffer?
> >>>>>>>>
> >>>>>>>
> >>>>>>> Because ION no longer provides DMA ready memory.
> >>>>>>> Take the above example.
> >>>>>>>
> >>>>>>> ION allocates memory from buddy allocator and requests zeroing.
> >>>>>>> Zeros are written to the cache.
> >>>>>>>
> >>>>>>> You pass the buffer to the camera device which is not IO-coherent.
> >>>>>>> The camera devices writes directly to the buffer in DDR.
> >>>>>>> Since you didn't clean the buffer a dirty cache line (one of the
> >>>>>>> zeros) is
> >>>>>>> evicted from the cache, this zero overwrites data the camera device has
> >>>>>>> written which corrupts your data.
> >>>>>>>
> >>>>>>
> >>>>>> The zeroing *is* a CPU access, therefor it should handle the needed CMO
> >>>>>> for CPU access at the time of zeroing.
> >>>>>>
> >>>>>> Andrew
> >>>>>>
> >>>>>>> Liam
> >>>>>>>
> >>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >>>>>>> a Linux Foundation Collaborative Project
> >>>>>>>
> >>>>>
> >>>>
> >>>
> >>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >>> a Linux Foundation Collaborative Project
> >>>
> >>
> > 
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
---2046127808-835268283-1547847835=:9328--
