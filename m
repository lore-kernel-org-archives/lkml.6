Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE06BC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAD120870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfBBHIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:08:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfBBHIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:08:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A6467F7B1;
        Sat,  2 Feb 2019 07:08:13 +0000 (UTC)
Received: from xz-x1 (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9BB5C20D;
        Sat,  2 Feb 2019 07:08:10 +0000 (UTC)
Date:   Sat, 2 Feb 2019 15:08:08 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Message-ID: <20190202070808.GB1011@xz-x1>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
 <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com>
 <20190131075941.GB25119@xz-x1>
 <926c28c2-66a0-8068-f7bc-2d8f9ce9f0ad@arm.com>
 <20190201035121.GF25119@xz-x1>
 <21af01ee-39b7-4b30-479b-3c97b4d2867a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21af01ee-39b7-4b30-479b-3c97b4d2867a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 02 Feb 2019 07:08:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:46:00AM +0000, Jean-Philippe Brucker wrote:
> On 01/02/2019 03:51, Peter Xu wrote:
> > On Thu, Jan 31, 2019 at 12:25:40PM +0000, Jean-Philippe Brucker wrote:
> >> On 31/01/2019 07:59, Peter Xu wrote:
> >>> On Wed, Jan 30, 2019 at 12:27:40PM +0000, Jean-Philippe Brucker wrote:
> >>>> Hi Peter,
> >>>
> >>> Hi, Jean,
> >>>
> >>>>
> >>>> On 30/01/2019 05:57, Peter Xu wrote:
> >>>>> AMD IOMMU driver is using the clear_flush_young() to do cache flushing
> >>>>> but that's actually already covered by invalidate_range().  Remove the
> >>>>> extra notifier and the chunks.
> >>>>
> >>>> Aren't uses of clear_flush_young() and invalidate_range() orthogonal? If
> >>>> I understood correctly, when doing reclaim the kernel clears the young
> >>>> bit from the PTE. This requires flushing secondary TLBs (ATCs), so that
> >>>> new accesses from devices will go through the IOMMU, set the young bit
> >>>> again and the kernel can accurately track page use. I didn't see
> >>>> invalidate_range() being called by rmap or vmscan in this case, but
> >>>> might just be missing it.
> >>>>
> >>>> Two MMU notifiers are used for the young bit, clear_flush_young() and
> >>>> clear_young(). I believe the former should invalidate ATCs so that DMA
> >>>> accesses participate in PTE aging. Otherwise the kernel can't know that
> >>>> the device is still using entries marked 'old'. The latter,
> >>>> clear_young() is exempted from invalidating the secondary TLBs by
> >>>> mmu_notifier.h and the IOMMU driver doesn't need to implement it.
> >>>
> >>> Yes I agree most of your analysis, but IMHO the problem is that the
> >>> AMD IOMMU is not really participating in the PTE aging after all.
> >>> Please have a look at mn_clear_flush_young() below at [1] - it's
> >>> always returning zero, no matter whether the page has been accessed by
> >>> device or not.  A real user of it could be someone like KVM (please
> >>> see kvm_mmu_notifier_clear_flush_young) where we'll try to lookup the
> >>> shadow PTEs and do test-and-clear on that, then return the result to
> >>> the core mm.  That's why I think currently the AMD driver was only
> >>> trying to use that as a way to do an extra flush however IMHO it's
> >>> redundant.
> >>
> >> Yes, in IOMMU drivers clear_flush_young() doesn't do the clear, only the
> >> flush, since the level-1 page table is shared with the CPU. But removing
> >> the flush gets you in the following situation:
> >>
> >>   (1) Devices wants to access $addr, sends ATS query, the IOMMU sets PTE
> >> young and the entry is cached in the ATC.
> >>
> >>   (2) The CPU does ptep_clear_flush_young_notify(), clears young,
> >> notices that the page is being used.
> >>
> >>   (3) Device accesses $addr again. Given that we didn't invalidate the
> >> ATC in (2) it accesses the page directly, without going through the IOMMU.
> >>
> >>   (4) CPU does ptep_clear_flush_young_notify() again, the PTE doesn't
> >> have the young bit, which means the page isn't being used and can be
> >> reclaimed.
> >>
> >> That's not accurate since the page is being used by the device. At step
> >> (2) we should invalidate the ATC, so that (3) fetches the PTE again and
> >> marks it young.
> >>
> >> I can agree that the clear_flush_young() notifier is too brutal for this
> >> purpose, since we send spurious ATC invalidation even when the PTE
> >> wasn't young (and ATC inv is expensive). There should be another MMU
> >> notifier "flush_young()" that is called by
> >> ptep_clear_flush_young_notify() only when the page was actually young.
> >> But for the moment it's the best we have to avoid the situation above.
> >>
> >> I don't know enough about mm to understand exactly how the
> >> page_referenced() information is used, but I believe the problem is only
> >> about accuracy and not correctness. So applying this patch might not
> >> break anything (after all, intel-svm.c never implemented the notifier)
> >> but I think I'll keep the notifier in my SVA rework [1].
> > 
> > I see your point.  I'm not an expert of mm either, but I'd say AFAIU
> > this happens in CPU TLB too.  Please have a look at
> > ptep_clear_flush_young():
> > 
> > int ptep_clear_flush_young(struct vm_area_struct *vma,
> > 			   unsigned long address, pte_t *ptep)
> > {
> > 	/*
> > 	 * On x86 CPUs, clearing the accessed bit without a TLB flush
> > 	 * doesn't cause data corruption. [ It could cause incorrect
> > 	 * page aging and the (mistaken) reclaim of hot pages, but the
> > 	 * chance of that should be relatively low. ]
> > 	 *
> > 	 * So as a performance optimization don't flush the TLB when
> > 	 * clearing the accessed bit, it will eventually be flushed by
> > 	 * a context switch or a VM operation anyway. [ In the rare
> > 	 * event of it not getting flushed for a long time the delay
> > 	 * shouldn't really matter because there's no real memory
> > 	 * pressure for swapout to react to. ]
> > 	 */
> > 	return ptep_test_and_clear_young(vma, address, ptep);
> > }
> 
> Aha I see. The arm64 version of ptep_clear_flush_young() does invalidate
> the TLB if the PTE was young (perhaps because we don't invalidate the
> TLB on context switch). For SVA I would have liked to simply invalidate
> the ATC whenever the CPU invalidates its TLB, but that falls apart if
> archs are doing different things...
> 
> > So maybe it is a tradeoff between performance and accuracy.  IMHO the
> > IOMMU cache flushing might affect the performance even more than CPU
> > TLB flushing if the invalidation command takes a long time to run
> > (e.g., amd_iommu_flush_page is far slower than a TLB flush
> > instruction, locks to take, queue commands, explicit wait for the
> > invalidation to happen, etc.) so it can potentially even drag down the
> > mm young bit access as a whole not to mention the future cache misses
> > from the device side.
> > 
> > Even if you really want to make the young bit accurate for the SVA
> > work, IMHO you may still want to implement the lightweight version of
> > clear_young() too otherwise it might be inaccurate again in idle page
> > tracking.
> 
> Yes there is another conversation about this on the new idle_pages
> proposal [1], which would never send any ATC invalidation. I'm not sure
> what we should do about it - making clear_young() flush the IOTLB seems
> way too expensive there as well, we'll probably want something more
> selective.
> 
> > Another thing to mention is that disregarding the discussion about
> > young bit - IMO you should probably don't need the change_pte() which
> > I'm more confident with.
> 
> I haven't dug too much into change_pte() yet, but I'll keep that in
> mind, thanks!

Glad to have the discussion with you!  Note that besides the one that
was attached along with the same series, there's another patch to
remove the last (besides KVM) change_pte() usage here in Power:

  https://lkml.org/lkml/2019/1/31/259

Andrea has a longer reply there which might be far better than my
commit messages.  Please feel free to have a look too.

Thanks,

> 
> Jean
> 
> [1] https://patchwork.kernel.org/cover/10743133/#22446425

-- 
Peter Xu
