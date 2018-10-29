Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE63CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6920D2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6920D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeJ3CcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:32:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:7703 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJ3CcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:32:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 10:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="85108363"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007.jf.intel.com with ESMTP; 29 Oct 2018 10:42:33 -0700
Message-ID: <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        yi.z.zhang@linux.intel.com
Date:   Mon, 29 Oct 2018 10:42:33 -0700
In-Reply-To: <20181029172415.GM32673@dhcp22.suse.cz>
References: <98c35e19-13b9-0913-87d9-b3f1ab738b61@linux.intel.com>
         <20181010185242.GP5873@dhcp22.suse.cz>
         <20181011085509.GS5873@dhcp22.suse.cz>
         <6f32f23c-c21c-9d42-7dda-a1d18613cd3c@linux.intel.com>
         <20181017075257.GF18839@dhcp22.suse.cz>
         <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
         <20181029141210.GJ32673@dhcp22.suse.cz>
         <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
         <20181029163528.GL32673@dhcp22.suse.cz>
         <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
         <20181029172415.GM32673@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 18:24 +0100, Michal Hocko wrote:
> On Mon 29-10-18 10:01:28, Alexander Duyck wrote:
> > On Mon, 2018-10-29 at 17:35 +0100, Michal Hocko wrote:
> > > On Mon 29-10-18 08:59:34, Alexander Duyck wrote:
> 
> [...]
> > > > So for example the call "online_pages_range" doesn't invoke the
> > > > online_page_callback unless the first pfn in the range is marked as
> > > > reserved.
> > > 
> > > Yes and there is no fundamental reason to do that. We can easily check
> > > the online status without that.
> > > 
> > > > Another example Dan had pointed out was the saveable_page function in
> > > > kernel/power/snapshot.c.
> > > 
> > > Use pfn_to_online_page there.
> > 
> > Right. Which getting back to my original point, there is a bunch of
> > other changes that need to happen in order for us to make this work.
> 
> Which is a standard process of upstreaming stuff. My main point was that
> the reason why I've added SetPageReserved was a safety net because I
> knew that different code paths would back of on PageReserved while they
> wouldn't on a partially initialized structure. Now that you really want
> to prevent setting this bit for performance reasons then it makes sense
> to revisit that earlier decision and get rid of it rather than build on
> top of it and duplicate and special case the low level hotplug init
> code.

Just to clarify not setting the reserved bit isn't so much a
performance optimization as it is a functional issue. My understanding
is that they cannot get the DAX pages through KVM currently as it
doesn't recognize them as being "online". So in going through and
cleaning up the checks for the reserved bit this problem will likely
solve itself.

> > I am going to end up with yet another patch set to clean up all the
> > spots that are using PageReserved that shouldn't be before I can get
> > to the point of not setting that bit.
> 
> This would be highly appreciated. There are not that many PageReserved
> checks.

Yeah, not many, only about 3 dozen. It should only take me a week or
two to get them all sorted.

> > > > > > > > > Regarding the post initialization required by devm_memremap_pages and
> > > > > > > > > potentially others. Can we update the altmap which is already a way how
> > > > > > > > > to get alternative struct pages by a constructor which we could call
> > > > > > > > > from memmap_init_zone and do the post initialization? This would reduce
> > > > > > > > > the additional loop in the caller while it would still fit the overall
> > > > > > > > > design of the altmap and the core hotplug doesn't have to know anything
> > > > > > > > > about DAX or whatever needs a special treatment.
> > > > > > > > > 
> > > > > > > > > Does that make any sense?
> > > > > > > > 
> > > > > > > > I think the only thing that is currently using the altmap is the ZONE_DEVICE
> > > > > > > > memory init. Specifically I think it is only really used by the
> > > > > > > > devm_memremap_pages version of things, and then only under certain
> > > > > > > > circumstances. Also the HMM driver doesn't pass an altmap. What we would
> > > > > > > > really need is a non-ZONE_DEVICE users of the altmap to really justify
> > > > > > > > sticking with that as the preferred argument to pass.
> > > > > > > 
> > > > > > > I am not aware of any upstream HMM user so I am not sure what are the
> > > > > > > expectations there. But I thought that ZONE_DEVICE users use altmap. If
> > > > > > > that is not generally true then we certainly have to think about a
> > > > > > > better interface.
> > > > > > 
> > > > > > I'm just basing my statement on the use of the move_pfn_range_to_zone call.
> > > > > > The only caller that is actually passing the altmap is devm_memremap_pages
> > > > > > and if I understand things correctly that is only used when we want to stare
> > > > > > the vmmemmap on the same memory that we just hotplugged.
> > > > > 
> > > > > Yes, and that is what I've called as allocator callback earlier.
> > > > 
> > > > I am really not a fan of the callback approach. It just means we will
> > > > have to do everything multiple times in terms of initialization.
> > > 
> > > I do not follow. Could you elaborate?
> > 
> > So there end up being a few different issues with constructors. First
> > in my mind is that it means we have to initialize the region of memory
> > and cannot assume what the constructors are going to do for us. As a
> > result we will have to initialize the LRU pointers, and then overwrite
> > them with the pgmap and hmm_data.
> 
> Why we would do that? What does really prevent you from making a fully
> customized constructor?

It is more an argument of complexity. Do I just pass a single pointer
and write that value, or the LRU values in init, or do I have to pass a
function pointer, some abstracted data, and then call said function
pointer while passing the page and the abstracted data?

> > I am generally not a fan of that as
> > the next patch set I have gets rid of most of the redundancy we already
> > had in the writes where we were memsetting everything to 0, then
> > writing the values, and then taking care of the reserved bit and
> > pgmap/hmm_data fields. Dealing with the init serially like that is just
> > slow.
> > 
> > Another complication is retpoline making function pointers just more
> > expensive in general. I know in the networking area we have been
> > dealing with this for a while as even the DMA ops have been a pain
> > there.
> 
> We use callbacks all over the kernel and in hot paths as well. This is
> far from anything reminding a hot path AFAICT. It can be time consuming
> because we have to touch each and every page but that is a fundamental
> thing to do. We cannot simply batch the large part of the initialization
> to multiple pages at the time.
> 
> Have you measured a potential retpoline overhead to have some actual
> numbers that would confirm this is just too expensive? Or how much of
> performance are we talking about here.

So admittedly my experience is somewhat anecdotal. However I know for
example with XDP in the networking stack we saw some tests drop from
13Mpps to 6Mpps from just the retpoline workaround being turned on. My
concern is us seeing something like that since with the
__init_pageblock function I had introduced I had reduce the memory init
down to a very tight loop, and I am concerned that having to call a
function pointer in the middle of that with the retpoline overhead is
just going to bring the memory initialization to a crawl.

If I have to implement the code to verify the slowdown I will, but I
really feel like it is just going to be time wasted since we have seen
this in other spots within the kernel.

> > > > > > That is why it made more sense to me to just create a ZONE_DEVICE specific
> > > > > > function for handling the page initialization because the one value I do
> > > > > > have to pass is the dev_pagemap in both HMM and memremap case, and that has
> > > > > > the altmap already embedded inside of it.
> > > > > 
> > > > > And I have argued that this is a wrong approach to the problem. If you
> > > > > need a very specific struct page initialization then create a init
> > > > > (constructor) callback.
> > > > 
> > > > The callback solution just ends up being more expensive because we lose
> > > > multiple layers of possible optimization. By putting everything into on
> > > > initization function we are able to let the compiler go through and
> > > > optimize things to the point where we are essentially just doing
> > > > something akin to one bit memcpy/memset where we are able to construct
> > > > one set of page values and write that to every single page we have to
> > > > initialize within a given page block.
> > > 
> > > You are already doing per-page initialization so I fail to see a larger
> > > unit to operate on.
> > 
> > I have a patch that makes it so that we can work at a pageblock level
> > since all of the variables with the exception of only the LRU and page
> > address fields can be precomputed. Doing that is one of the ways I was
> > able to reduce page init to 1/3 to 1/4 of the time it was taking
> > otherwise in the case of deferred page init.
> 
> You still have to call set_page_links for each page. But let's assume we
> can do initialization per larger units. Nothing really prevent to hide
> that into constructor as well.

The set_page_links function actually executes outside of the main loop
in the case of __init_pageblock. With the change of the memset call to
the multiple assignments of 0 the value can be pre-computed per
pageblock and then just written per page. That is why in my latest
version of the patch set I had folded the reserved bit into the
set_page_links function so that it could be either set or unset at
almost no additional cost to the page initialization.

