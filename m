Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8852C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808EA20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HLAd4M6H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BgNCTX1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfAVW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:56:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVW4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:56:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 69ED06058E; Tue, 22 Jan 2019 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548197764;
        bh=7BFSJwYn38oHm/TYwXPxgv3rrCfQP5sru03SSjTQSCI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HLAd4M6HJ9eO7fg6NEQ8sT681FbTIFLZN79fOhjrlmB26eJv2yChg6ay4K43Ktcb0
         Qo0x+tsybYyYGrexa60HZiA8BFN7MUO8Ueq3mrHqumYeSQ/fd0UBBS7V7pWwRo5mMV
         CFKNuTuei/xGqBkdYFWKukqP4YTcSbMNSd2Nrfv4=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E772060740;
        Tue, 22 Jan 2019 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548197761;
        bh=7BFSJwYn38oHm/TYwXPxgv3rrCfQP5sru03SSjTQSCI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BgNCTX1VSpefp/89bUUZMyk2RcnnleHD5iWm2cNumMW5N8YK9w7Ww+DUqt6V0cgS6
         pMh5syvH0A32WvAypaZT0hSjKGMSgsGiamrs0HBPiT7BSw5SKc0HwmsRVPzIOekK8v
         chRn42DBZXjQkaZ1/f3gZmn0KO+z+6Ul761OIhCc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E772060740
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Tue, 22 Jan 2019 14:56:00 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Brian Starkey <Brian.Starkey@arm.com>
cc:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
In-Reply-To: <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
Message-ID: <alpine.DEB.2.10.1901221450420.23328@lmark-linux.qualcomm.com>
References: <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com> <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com> <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com> <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com> <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
 <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com> <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com> <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com> <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com> <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com>
 <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Brian Starkey wrote:

> Hi,
> 
> Sorry for being a bit sporadic on this. I was out travelling last week
> with little time for email.
> 
> On Fri, Jan 18, 2019 at 11:16:31AM -0600, Andrew F. Davis wrote:
> > On 1/17/19 7:11 PM, Liam Mark wrote:
> > > On Thu, 17 Jan 2019, Andrew F. Davis wrote:
> > > 
> > >> On 1/16/19 4:54 PM, Liam Mark wrote:
> > >>> On Wed, 16 Jan 2019, Andrew F. Davis wrote:
> > >>>
> > >>>> On 1/16/19 9:19 AM, Brian Starkey wrote:
> > >>>>> Hi :-)
> > >>>>>
> > >>>>> On Tue, Jan 15, 2019 at 12:40:16PM -0600, Andrew F. Davis wrote:
> > >>>>>> On 1/15/19 12:38 PM, Andrew F. Davis wrote:
> > >>>>>>> On 1/15/19 11:45 AM, Liam Mark wrote:
> > >>>>>>>> On Tue, 15 Jan 2019, Andrew F. Davis wrote:
> > >>>>>>>>
> > >>>>>>>>> On 1/14/19 11:13 AM, Liam Mark wrote:
> > >>>>>>>>>> On Fri, 11 Jan 2019, Andrew F. Davis wrote:
> > >>>>>>>>>>
> > >>>>>>>>>>> Buffers may not be mapped from the CPU so skip cache maintenance here.
> > >>>>>>>>>>> Accesses from the CPU to a cached heap should be bracketed with
> > >>>>>>>>>>> {begin,end}_cpu_access calls so maintenance should not be needed anyway.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> > >>>>>>>>>>> ---
> > >>>>>>>>>>>  drivers/staging/android/ion/ion.c | 7 ++++---
> > >>>>>>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
> > >>>>>>>>>>>
> > >>>>>>>>>>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> > >>>>>>>>>>> index 14e48f6eb734..09cb5a8e2b09 100644
> > >>>>>>>>>>> --- a/drivers/staging/android/ion/ion.c
> > >>>>>>>>>>> +++ b/drivers/staging/android/ion/ion.c
> > >>>>>>>>>>> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
> > >>>>>>>>>>>  
> > >>>>>>>>>>>  	table = a->table;
> > >>>>>>>>>>>  
> > >>>>>>>>>>> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> > >>>>>>>>>>> -			direction))
> > >>>>>>>>>>> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> > >>>>>>>>>>> +			      direction, DMA_ATTR_SKIP_CPU_SYNC))
> > >>>>>>>>>>
> > >>>>>>>>>> Unfortunately I don't think you can do this for a couple reasons.
> > >>>>>>>>>> You can't rely on {begin,end}_cpu_access calls to do cache maintenance.
> > >>>>>>>>>> If the calls to {begin,end}_cpu_access were made before the call to 
> > >>>>>>>>>> dma_buf_attach then there won't have been a device attached so the calls 
> > >>>>>>>>>> to {begin,end}_cpu_access won't have done any cache maintenance.
> > >>>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> That should be okay though, if you have no attachments (or all
> > >>>>>>>>> attachments are IO-coherent) then there is no need for cache
> > >>>>>>>>> maintenance. Unless you mean a sequence where a non-io-coherent device
> > >>>>>>>>> is attached later after data has already been written. Does that
> > >>>>>>>>> sequence need supporting? 
> > >>>>>>>>
> > >>>>>>>> Yes, but also I think there are cases where CPU access can happen before 
> > >>>>>>>> in Android, but I will focus on later for now.
> > >>>>>>>>
> > >>>>>>>>> DMA-BUF doesn't have to allocate the backing
> > >>>>>>>>> memory until map_dma_buf() time, and that should only happen after all
> > >>>>>>>>> the devices have attached so it can know where to put the buffer. So we
> > >>>>>>>>> shouldn't expect any CPU access to buffers before all the devices are
> > >>>>>>>>> attached and mapped, right?
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> Here is an example where CPU access can happen later in Android.
> > >>>>>>>>
> > >>>>>>>> Camera device records video -> software post processing -> video device 
> > >>>>>>>> (who does compression of raw data) and writes to a file
> > >>>>>>>>
> > >>>>>>>> In this example assume the buffer is cached and the devices are not 
> > >>>>>>>> IO-coherent (quite common).
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> This is the start of the problem, having cached mappings of memory that
> > >>>>>>> is also being accessed non-coherently is going to cause issues one way
> > >>>>>>> or another. On top of the speculative cache fills that have to be
> > >>>>>>> constantly fought back against with CMOs like below; some coherent
> > >>>>>>> interconnects behave badly when you mix coherent and non-coherent access
> > >>>>>>> (snoop filters get messed up).
> > >>>>>>>
> > >>>>>>> The solution is to either always have the addresses marked non-coherent
> > >>>>>>> (like device memory, no-map carveouts), or if you really want to use
> > >>>>>>> regular system memory allocated at runtime, then all cached mappings of
> > >>>>>>> it need to be dropped, even the kernel logical address (area as painful
> > >>>>>>> as that would be).
> > >>>>>
> > >>>>> Ouch :-( I wasn't aware about these potential interconnect issues. How
> > >>>>> "real" is that? It seems that we aren't really hitting that today on
> > >>>>> real devices.
> > >>>>>
> > >>>>
> > >>>> Sadly there is at least one real device like this now (TI AM654). We
> > >>>> spent some time working with the ARM interconnect spec designers to see
> > >>>> if this was allowed behavior, final conclusion was mixing coherent and
> > >>>> non-coherent accesses is never a good idea.. So we have been working to
> > >>>> try to minimize any cases of mixed attributes [0], if a region is
> > >>>> coherent then everyone in the system needs to treat it as such and
> > >>>> vice-versa, even clever CMO that work on other systems wont save you
> > >>>> here. :(
> > >>>>
> > >>>> [0] https://github.com/ARM-software/arm-trusted-firmware/pull/1553
> > >>>>
> 
> "Never a good idea" - but I think it should still be well defined by
> the ARMv8 ARM (Section B2.8). Does this apply to your system?
> 
> "If the mismatched attributes for a memory location all assign the
> same shareability attribute to a Location that has a cacheable
> attribute, any loss of uniprocessor semantics, ordering, or coherency
> within a shareability domain can be avoided by use of software cache
> management"
> 
> https://developer.arm.com/docs/ddi0487/latest/arm-architecture-reference-manual-armv8-for-armv8-a-architecture-profile
> 
> If the cache is invalidated when switching between access types,
> shouldn't the snoop filters get un-messed-up?
> 
> > >>>>
> > >>>>>>>
> > >>>>>>>> ION buffer is allocated.
> > >>>>>>>>
> > >>>>>>>> //Camera device records video
> > >>>>>>>> dma_buf_attach
> > >>>>>>>> dma_map_attachment (buffer needs to be cleaned)
> > >>>>>>>
> > >>>>>>> Why does the buffer need to be cleaned here? I just got through reading
> > >>>>>>> the thread linked by Laura in the other reply. I do like +Brian's
> > >>>>>>
> > >>>>>> Actually +Brian this time :)
> > >>>>>>
> > >>>>>>> suggestion of tracking if the buffer has had CPU access since the last
> > >>>>>>> time and only flushing the cache if it has. As unmapped heaps never get
> > >>>>>>> CPU mapped this would never be the case for unmapped heaps, it solves my
> > >>>>>>> problem.
> > >>>>>>>
> > >>>>>>>> [camera device writes to buffer]
> > >>>>>>>> dma_buf_unmap_attachment (buffer needs to be invalidated)
> > >>>>>>>
> > >>>>>>> It doesn't know there will be any further CPU access, it could get freed
> > >>>>>>> after this for all we know, the invalidate can be saved until the CPU
> > >>>>>>> requests access again.
> > >>>>>
> > >>>>> We don't have any API to allow the invalidate to happen on CPU access
> > >>>>> if all devices already detached. We need a struct device pointer to
> > >>>>> give to the DMA API, otherwise on arm64 there'll be no invalidate.
> > >>>>>
> > >>>>> I had a chat with a few people internally after the previous
> > >>>>> discussion with Liam. One suggestion was to use
> > >>>>> DMA_ATTR_SKIP_CPU_SYNC in unmap_dma_buf, but only if there's at least
> > >>>>> one other device attached (guarantees that we can do an invalidate in
> > >>>>> the future if begin_cpu_access is called). If the last device
> > >>>>> detaches, do a sync then.
> > >>>>>
> > >>>>> Conversely, in map_dma_buf, we would track if there was any CPU access
> > >>>>> and use/skip the sync appropriately.
> > >>>>>
> > >>>>
> > >>>> Now that I think this all through I agree this patch is probably wrong.
> > >>>> The real fix needs to be better handling in the dma_map_sg() to deal
> > >>>> with the case of the memory not being mapped (what I'm dealing with for
> > >>>> unmapped heaps), and for cases when the memory in question is not cached
> > >>>> (Liam's issue I think). For both these cases the dma_map_sg() does the
> > >>>> wrong thing.
> > >>>>
> > >>>>> I did start poking the code to check out how that would look, but then
> > >>>>> Christmas happened and I'm still catching back up.
> > >>>>>
> > >>>>>>>
> > >>>>>>>> dma_buf_detach  (device cannot stay attached because it is being sent down 
> > >>>>>>>> the pipeline and Camera doesn't know the end of the use case)
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> This seems like a broken use-case, I understand the desire to keep
> > >>>>>>> everything as modular as possible and separate the steps, but at this
> > >>>>>>> point no one owns this buffers backing memory, not the CPU or any
> > >>>>>>> device. I would go as far as to say DMA-BUF should be free now to
> > >>>>>>> de-allocate the backing storage if it wants, that way it could get ready
> > >>>>>>> for the next attachment, which may change the required backing memory
> > >>>>>>> completely.
> > >>>>>>>
> > >>>>>>> All devices should attach before the first mapping, and only let go
> > >>>>>>> after the task is complete, otherwise this buffers data needs copied off
> > >>>>>>> to a different location or the CPU needs to take ownership in-between.
> > >>>>>>>
> > >>>>>
> > >>>>> Yeah.. that's certainly the theory. Are there any DMA-BUF
> > >>>>> implementations which actually do that? I hear it quoted a lot,
> > >>>>> because that's what the docs say - but if the reality doesn't match
> > >>>>> it, maybe we should change the docs.
> > >>>>>
> > >>>>
> > >>>> Do you mean on the userspace side? I'm not sure, seems like Android
> > >>>> might be doing this wrong from what I can gather. From kernel side if
> > >>>> you mean the "de-allocate the backing storage", we will have some cases
> > >>>> like this soon, so I want to make sure userspace is not abusing DMA-BUF
> > >>>> in ways not specified in the documentation. Changing the docs to force
> > >>>> the backing memory to always be allocated breaks the central goal in
> > >>>> having attach/map in DMA-BUF separate.
> 
> Actually I meant in the kernel, in exporters. I haven't seen anyone
> using the API as it was intended (defer allocation until first map,
> migrate between different attachments, etc.). Mostly, backing storage
> seems to get allocated at the point of export, and device mappings are
> often held persistently (e.g. the DRM prime code maps the buffer at
> import time, and keeps it mapped: drm_gem_prime_import_dev).
> 
> I wasn't aware that CPU access before first device access was
> considered an abuse of the API - it seems like a valid thing to want
> to do.
> 
> > >>>>
> > >>>>>>>> //buffer is send down the pipeline
> > >>>>>>>>
> > >>>>>>>> // Usersapce software post processing occurs
> > >>>>>>>> mmap buffer
> > >>>>>>>
> > >>>>>>> Perhaps the invalidate should happen here in mmap.
> > >>>>>>>
> > >>>>>>>> DMA_BUF_IOCTL_SYNC IOCT with flags DMA_BUF_SYNC_START // No CMO since no 
> > >>>>>>>> devices attached to buffer
> > >>>>>>>
> > >>>>>>> And that should be okay, mmap does the sync, and if no devices are
> > >>>>>>> attached nothing could have changed the underlying memory in the
> > >>>>>>> mean-time, DMA_BUF_SYNC_START can safely be a no-op as they are.
> > >>>>>
> > >>>>> Yeah, that's true - so long as you did an invalidate in unmap_dma_buf.
> > >>>>> Liam was saying that it's too painful for them to do that every time a
> > >>>>> device unmaps - when in many cases (device->device, no CPU) it's not
> > >>>>> needed.
> > >>>>
> > >>>> Invalidates are painless, at least compared to a real cache flush, just
> > >>>> set the invalid bit vs actually writing out lines. I thought the issue
> > >>>> was on the map side.
> > >>>>
> > >>>
> > >>> Invalidates aren't painless for us because we have a coherent system cache 
> > >>> so clean lines get written out.
> > >>
> > >> That seems very broken, why would clean lines ever need to be written
> > >> out, that defeats the whole point of having the invalidate separate from
> > >> clean. How do you deal with stale cache lines? I guess in your case this
> > >> is what forces you to have to use uncached memory for DMA-able memory.
> > >>
> > > 
> > > My understanding is that our ARM invalidate is a clean + invalidate, I had 
> > > concerns about the clean lines being written to the the system cache as 
> > > part of the 'clean', but the following 'invalidate' would take care of 
> > > actually invalidating the lines (so nothign broken).
> > > But i am probably wrong on this and it is probably smart enough not to the 
> > > writing of the clean lines.
> > > 
> > 
> > You are correct that for a lot of ARM cores "invalidate" is always a
> > "clean + invalidate". At first I thought this was kinda silly as there
> > is now no way to mark a dirty line invalid without it getting written
> > out first, but if you think about it any dirty cache-line can be written
> > out (cleaned) at anytime anyway, so this doesn't actually change system
> > behavior. You should just not write to memory (make the line dirty)
> > anything you don't want eventually written out.
> > 
> > Point two, it's not just smart enough to not write-out clean lines, it
> > is guaranteed not to write them out by the spec. Otherwise since
> > cache-lines can be randomly filled if those same clean lines got written
> > out on invalidate operations there would be no way to maintain coherency
> > and things would be written over top each other all over the place.
> > 
> > > But regardless, targets supporting a coherent system cache is a legitamate 
> > > configuration and an invalidate on this configuration does have to go to 
> > > the bus to invalidate the system cache (which isn't free) so I dont' think
> > > you can make the assumption that invalidates are cheap so that it is okay 
> > > to do them (even if they are not needed) on every dma unmap.
> > > 
> > 
> > Very true, CMOs need to be broadcast to other coherent masters on a
> > coherent interconnect (and the interconnect itself if it has a cache as
> > well (L3)), so not 100% free, but almost, just the infinitesimal cost of
> > the cache tag check in hardware. If there are no non-coherent devices
> > attached then the CMOs are no-ops, if there are then the data needs to
> > be written out either way, doing it every access like is done with
> > uncached memory (- any write combining) will blow away any saving made
> > from the one less CMO. Either way you lose with uncached mappings of
> > memory. If I'm wrong I would love to know.
> > 
> 
> From what I understand, the current DMA APIs are not equipped to
> handle having coherent and non-coherent devices attached at the same
> time. The buffer is either in "CPU land" or "Device land", there's no
> smaller granule of "Coherent Device land" or "Non-Coherent Device
> land".
> 
> I think if there's devices which are making coherent accesses, and
> devices which are making non-coherent accesses, then we can't support
> them being attached at the same time without some enhancements to the
> APIs.
> 
> > >>> And these invalidates can occur on fairly large buffers.
> > >>>
> > >>> That is why we haven't went with using cached ION memory and "tracking CPU 
> > >>> access" because it only solves half the problem, ie there isn't a way to 
> > >>> safely skip the invalidate (because we can't read the future).
> > >>> Our solution was to go with uncached ION memory (when possible), but as 
> > >>> you can see in other discussions upstream support for uncached memory has
> > >>> its own issues.
> > >>>
> 
> @Liam, in your problematic use-cases, are both devices detached when
> the buffer moves between them?
> 
>  1) dev 1 map, access, unmap
>  2) dev 1 detach
>  3) (maybe) CPU access
>  4) dev 2 attach
>  5) dev 2 map, access
> 
> I still think a pretty pragmatic solution is to use
> DMA_ATTR_SKIP_CPU_SYNC until the last device detaches. That won't work
> if your access sequence looks like above...
> 

Yes the piplelining case in Android looks like the above.

> ...however, if your sequence looks like above, then you probably need
> to keep at least one of the devices attached anyway. 

It would be nice if a device could be kept attached, but that doesn't 
always work very well for an pipelining case as there isn't necessarily a 
good place for someone to know when to detach it.


> Otherwise, per
> the API, the buffer could get migrated after 2)/before 5). That will
> surely hurt a lot more than an invalidate.
> 

You are right, in theory it could but in practice it isn't getting 
migrated.
I understand the theoretical case, but it doesn't sounds clean as well to 
force clients to stay attached when there isn't a very nice way of knowing 
when to have them detach.


> > >>
> > >> Sounds like you need to fix upstream support then, finding a way to drop
> > >> all cacheable mappings of memory you want to make uncached mappings for
> > >> seems to be the only solution.
> > >>
> > > 
> > > I think we can probably agree that there woudln't be a good way to remove 
> > > cached mappings without causing an unacceptable performance degradation 
> > > since it would fragment all the nice 1GB kernel mappings we have.
> > > 
> > > So I am trying to find an alternative solution.
> > > 
> > 
> > I'm not sure there is a better solution. How hard is this solution to
> > implement anyway? The kernel already has to make gaps and cut up that
> > nice 1GB mapping when you make a reserved memory space in the lowmem
> > area, so all the logic is probably already implemented. Just need to
> > allow it to be hooked into from Ion when doing doing the uncached mappings.
> > 
> 
> I haven't looked recently, but I'm not sure the early memblock code
> can be reused as-is at runtime. I seem to remember it makes a bunch of
> assumptions about the fact that it's running "early".
> 
> If CPU uncached mappings of normal system memory is really the way
> forward, I could envisage a heap which maintains a pool of chunks of
> memory which it removed from the kernel mapping. The pool could grow
> (remove more pages from the kernel mapping)/shrink (add them back to
> the kernel mapping) as needed.
> 
> John Reitan implemented a compound-page heap, which used compaction to
> get a pool of 2MB contiguous pages. Something like that would at least
> prevent needing full 4kB granularity when removing things from the
> kernel mapping.
> 
> Even better, could it somehow be restricted to a region which is
> already fragmented? (e.g. the one which was used for the default CMA
> heap)
> 
> Thanks,
> -Brian
> 
> > >>>>>
> > >>>>>>>
> > >>>>>>>> [CPU reads/writes to the buffer]
> > >>>>>>>> DMA_BUF_IOCTL_SYNC IOCTL with flags DMA_BUF_SYNC_END // No CMO since no 
> > >>>>>>>> devices attached to buffer
> > >>>>>>>> munmap buffer
> > >>>>>>>>
> > >>>>>>>> //buffer is send down the pipeline
> > >>>>>>>> // Buffer is send to video device (who does compression of raw data) and 
> > >>>>>>>> writes to a file
> > >>>>>>>> dma_buf_attach
> > >>>>>>>> dma_map_attachment (buffer needs to be cleaned)
> > >>>>>>>> [video device writes to buffer]
> > >>>>>>>> dma_buf_unmap_attachment 
> > >>>>>>>> dma_buf_detach  (device cannot stay attached because it is being sent down 
> > >>>>>>>> the pipeline and Video doesn't know the end of the use case)
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>>> Also ION no longer provides DMA ready memory, so if you are not doing CPU 
> > >>>>>>>>>> access then there is no requirement (that I am aware of) for you to call 
> > >>>>>>>>>> {begin,end}_cpu_access before passing the buffer to the device and if this 
> > >>>>>>>>>> buffer is cached and your device is not IO-coherent then the cache maintenance
> > >>>>>>>>>> in ion_map_dma_buf and ion_unmap_dma_buf is required.
> > >>>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> If I am not doing any CPU access then why do I need CPU cache
> > >>>>>>>>> maintenance on the buffer?
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> Because ION no longer provides DMA ready memory.
> > >>>>>>>> Take the above example.
> > >>>>>>>>
> > >>>>>>>> ION allocates memory from buddy allocator and requests zeroing.
> > >>>>>>>> Zeros are written to the cache.
> > >>>>>>>>
> > >>>>>>>> You pass the buffer to the camera device which is not IO-coherent.
> > >>>>>>>> The camera devices writes directly to the buffer in DDR.
> > >>>>>>>> Since you didn't clean the buffer a dirty cache line (one of the zeros) is 
> > >>>>>>>> evicted from the cache, this zero overwrites data the camera device has 
> > >>>>>>>> written which corrupts your data.
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> The zeroing *is* a CPU access, therefor it should handle the needed CMO
> > >>>>>>> for CPU access at the time of zeroing.
> > >>>>>>>
> > >>>>>
> > >>>>> Actually that should be at the point of the first non-coherent device
> > >>>>> mapping the buffer right? No point in doing CMO if the future accesses
> > >>>>> are coherent.
> > >>>>
> > >>>> I see your point, as long as the zeroing is guaranteed to be the first
> > >>>> access to this buffer then it should be safe.
> > >>>>
> > >>>> Andrew
> > >>>>
> > >>>>>
> > >>>>> Cheers,
> > >>>>> -Brian
> > >>>>>
> > >>>>>>> Andrew
> > >>>>>>>
> > >>>>>>>> Liam
> > >>>>>>>>
> > >>>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > >>>>>>>> a Linux Foundation Collaborative Project
> > >>>>>>>>
> > >>>>
> > >>>
> > >>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > >>> a Linux Foundation Collaborative Project
> > >>>
> > >>
> > > 
> > > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > > a Linux Foundation Collaborative Project
> > > 
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
