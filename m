Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEBAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0122146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391598AbfBMTJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:09:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfBMTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:09:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 527A97FD6C;
        Wed, 13 Feb 2019 19:09:04 +0000 (UTC)
Received: from redhat.com (ovpn-124-19.rdu2.redhat.com [10.10.124.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E15261000239;
        Wed, 13 Feb 2019 19:08:51 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:08:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190213140734-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B52A@shsmsx102.ccr.corp.intel.com>
 <62b43699-f548-e0da-c944-80702ceb7202@redhat.com>
 <20190213121000-mutt-send-email-mst@kernel.org>
 <a0035ddf-c871-b4e5-ca56-61da5c192dac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0035ddf-c871-b4e5-ca56-61da5c192dac@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 13 Feb 2019 19:09:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:59:24PM +0100, David Hildenbrand wrote:
> >>>
> >>>> Nitesh uses MADV_FREE here (as far as I recall :) ), to only mark pages as
> >>>> candidates for removal and if the host is low on memory, only scanning the
> >>>> guest page tables is sufficient to free up memory.
> >>>>
> >>>> But both points might just be an implementation detail in the example you
> >>>> describe.
> >>>
> >>> Yes, it is an implementation detail. I think DONTNEED would be easier
> >>> for the first step.
> >>>
> >>>>
> >>>>>
> >>>>> In above 2), get_free_page_hints clears the bits which indicates that those
> >>>> pages are not ready to be used by the guest yet. Why?
> >>>>> This is because 3) will unmap the underlying physical pages from EPT.
> >>>> Normally, when guest re-visits those pages, EPT violations and QEMU page
> >>>> faults will get a new host page to set up the related EPT entry. If guest uses
> >>>> that page before the page gets unmapped (i.e. right before step 3), no EPT
> >>>> violation happens and the guest will use the same physical page that will be
> >>>> unmapped and given to other host threads. So we need to make sure that
> >>>> the guest free page is usable only after step 3 finishes.
> >>>>>
> >>>>> Back to arch_alloc_page(), it needs to check if the allocated pages
> >>>>> have "1" set in the bitmap, if that's true, just clear the bits. Otherwise, it
> >>>> means step 2) above has happened and step 4) hasn't been reached. In this
> >>>> case, we can either have arch_alloc_page() busywaiting a bit till 4) is done
> >>>> for that page Or better to have a balloon callback which prioritize 3) and 4)
> >>>> to make this page usable by the guest.
> >>>>
> >>>> Regarding the latter, the VCPU allocating a page cannot do anything if the
> >>>> page (along with other pages) is just being freed by the hypervisor.
> >>>> It has to busy-wait, no chance to prioritize.
> >>>
> >>> I meant this:
> >>> With this approach, essentially the free pages have 2 states:
> >>> ready free page: the page is on the free list and it has "1" in the bitmap
> >>> non-ready free page: the page is on the free list and it has "0" in the bitmap
> >>> Ready free pages are those who can be allocated to use.
> >>> Non-ready free pages are those who are in progress of being reported to
> >>> host and the related EPT mapping is about to be zapped. 
> >>>
> >>> The non-ready pages are inserted into the report_vq and waiting for the
> >>> host to zap the mappings one by one. After the mapping gets zapped
> >>> (which means the backing host page has been taken away), host acks to
> >>> the guest to mark the free page as ready free page (set the bit to 1 in the bitmap).
> >>
> >> Yes, that's how I understood your approach. The interesting part is
> >> where somebody finds a buddy page and wants to allocate it.
> >>
> >>>
> >>> So the non-ready free page may happen to be used when they are waiting in
> >>> the report_vq to be handled by the host to zap the mapping, balloon could
> >>> have a fast path to notify the host:
> >>> "page 0x1000 is about to be used, don’t zap the mapping when you get
> >>> 0x1000 from the report_vq"  /*option [1] */
> >>
> >> This requires coordination and in any case there will be a scenario
> >> where you have to wait for the hypervisor to eventually finish a madv
> >> call. You can just try to make that scenario less likely.
> >>
> >> What you propose is synchronous in the worst case. Getting pages of the
> >> buddy makes it possible to have it done completely asynchronous. Nobody
> >> allocating a page has to wait.
> >>
> >>>
> >>> Or
> >>>
> >>> "page 0x1000 is about to be used, please zap the mapping NOW, i.e. do 3) and 4) above,
> >>> so that the free page will be marked as ready free page and the guest can use it".
> >>> This option will generate an extra EPT violation and QEMU page fault to get a new host
> >>> page to back the guest ready free page.
> >>
> >> Again, coordination with the hypervisor while allocating a page. That is
> >> to be avoided in any case.
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Using bitmaps to record free page hints don't need to take the free pages
> >>>> off the buddy list and return them later, which needs to go through the long
> >>>> allocation/free code path.
> >>>>>
> >>>>
> >>>> Yes, but it means that any process is able to get stuck on such a page for as
> >>>> long as it takes to report the free pages to the hypervisor and for it to call
> >>>> madvise(pfn_start, DONTNEED) on any such page.
> >>>
> >>> This only happens when the guest thread happens to get allocated on a page which is
> >>> being reported to the host. Using option [1] above will avoid this.
> >>
> >> I think getting pages out of the buddy system temporarily is the only
> >> way we can avoid somebody else stumbling over a page currently getting
> >> reported by the hypervisor. Otherwise, as I said, there are scenarios
> >> where a allocating VCPU has to wait for the hypervisor to finish the
> >> "freeing" task. While you can try to "speedup" that scenario -
> >> "hypervisor please prioritize" you cannot avoid it. There will be busy
> >> waiting.
> > 
> > Right - there has to be waiting. But it does not have to be busy -
> > if you can defer page use until interrupt, that's one option.
> > Further if you are ready to exit to hypervisor it does not have to be
> > busy waiting.  In particular right now virtio does not have a capability
> > to stop queue processing by device.  We could add that if necessary.  In
> > that case, you would stop queue and detach buffers.  It is already
> > possible by reseting the balloon.  Naturally there is no magic - you
> > exit to hypervisor and block there. It's not all that great
> > in that VCPU does not run at all. But it is not busy waiting.
> 
> Of course, you can always yield to the hypervisor and not call it busy
> waiting. From the guest point of view, it is busy waiting. The VCPU is
> to making progress. If I am not wrong, one can easily construct examples
> where all VCPUs in the guest are waiting for the hypervisor to
> madv(dontneed) pages. I don't like that approach
> 
> Especially if temporarily getting pages out of the buddy resolves these
> issues and seems to work.

Well hypervisor can send a singla and interrupt the dontneed work.
But yes I prefer not blocking the VCPU too.

I also prefer MADV_FREE generally.

> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
