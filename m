Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D034C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C96217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfBLFQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:16:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfBLFQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:16:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0D2586679;
        Tue, 12 Feb 2019 05:16:42 +0000 (UTC)
Received: from redhat.com (ovpn-120-96.rdu2.redhat.com [10.10.120.96])
        by smtp.corp.redhat.com (Postfix) with SMTP id A057660BE8;
        Tue, 12 Feb 2019 05:16:34 +0000 (UTC)
Date:   Tue, 12 Feb 2019 00:16:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and
 report free pages
Message-ID: <20190212001027-mutt-send-email-mst@kernel.org>
References: <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
 <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
 <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com>
 <20190208163601-mutt-send-email-mst@kernel.org>
 <CAKgT0UcKkS2RsZj28sB3SzMyX9_VrMtZTd+aGYD_FPJn_DA4UA@mail.gmail.com>
 <20190209192104-mutt-send-email-mst@kernel.org>
 <19f6d1f2-9287-6113-07b8-1988907b6108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f6d1f2-9287-6113-07b8-1988907b6108@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 12 Feb 2019 05:16:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:28:31AM +0100, David Hildenbrand wrote:
> On 10.02.19 01:38, Michael S. Tsirkin wrote:
> > On Fri, Feb 08, 2019 at 02:05:09PM -0800, Alexander Duyck wrote:
> >> On Fri, Feb 8, 2019 at 1:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>
> >>> On Fri, Feb 08, 2019 at 03:41:55PM -0500, Nitesh Narayan Lal wrote:
> >>>>>> I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
> >>>>>> However I am still thinking about a workload which I can use to test its
> >>>>>> effectiveness.
> >>>>> You might want to look at doing something like min(MAX_ORDER - 1,
> >>>>> HUGETLB_PAGE_ORDER). I know for x86 a 2MB page is the upper limit for
> >>>>> THP which is the most likely to be used page size with the guest.
> >>>> Sure, thanks for the suggestion.
> >>>
> >>> Given current hinting in balloon is MAX_ORDER I'd say
> >>> share code. If you feel a need to adjust down the road,
> >>> adjust both of them with actual testing showing gains.
> >>
> >> Actually I'm left kind of wondering why we are even going through
> >> virtio-balloon for this?
> > 
> > Just look at what does it do.
> > 
> > It improves memory overcommit if guests are cooperative, and it does
> > this by giving the hypervisor addresses of pages which it can discard.
> > 
> > It's just *exactly* like the balloon with all the same limitations.
> 
> I agree, this belongs to virtio-balloon *unless* we run into real
> problems implementing it via an asynchronous mechanism.
> 
> > 
> >> It seems like this would make much more sense
> >> as core functionality of KVM itself for the specific architectures
> >> rather than some side thing.
> 
> Whatever can be handled in user space and does not have significant
> performance impacts should be handled in user space. If we run into real
> problems with that approach, fair enough. (e.g. vcpu yielding is a good
> example where an implementation in KVM makes sense, not going via QEMU)

Just to note, if we wanted to we could add a special kind of VQ where
e.g. kick yields the VCPU. You don't necessarily need a hypercall for
this. A virtio-cpu, yay!


> > 
> > Well same as balloon: whether it's useful to you at all
> > would very much depend on your workloads.
> > 
> > This kind of cooperative functionality is good for co-located
> > single-tenant VMs. That's pretty niche.  The core things in KVM
> > generally don't trust guests.
> > 
> > 
> >> In addition this could end up being
> >> redundant when you start getting into either the s390 or PowerPC
> >> architectures as they already have means of providing unused page
> >> hints.
> 
> I'd like to note that on s390x the functionality is not provided when
> running nested guests. And there are real problems getting it ever
> supported. (see description below how it works on s390x, the issue for
> nested guests are the bits in the guest -> host page tables we cannot
> support for nested guests).
> 
> Hinting only works for guests running one level under LPAR (with a
> recent machine), but not nested guests.
> 
> (LPAR -> KVM1 works, LPAR - KVM1 -> KVM2 foes not work for the latter)
> 
> So an implementation for s390 would still make sense for this scenario.
> 
> > 
> > Interesting. Is there host support in kvm?
> 
> On s390x there is. It works on page granularity and synchronization
> between guest/host ("don't drop a page in the host while the guest is
> reusing it") is done via special bits in the host->guest page table.
> Instructions in the guest are able to modify these bits. A guest can
> configure a "usage state" of it's backed PTEs. E.g. "unused" or "stable".
> 
> Whenever a page in the guest is freed/reused, the ESSA instruction is
> triggered in the guest. It will modify the page table bits and add the
> guest phyical pfn to a buffer in the host. Once that buffer is full,
> ESSA will trigger an intercept to the hypervisor. Here, all these
> "unused" pages can be zapped.
> 
> Also, when swapping a page out in the hypervisor, if it was masked by
> the guest as unused or logically zero, instead of swapping out the page,
> it can simply be dropped and a fresh zero page can be supplied when the
> guest tries to access it.
> 
> "ESSA" is implemented in KVM in arch/s390/kvm/priv.c:handle_essa().
> 
> So on s390x, it works because the synchronization with the hypervisor is
> directly built into hw vitualization support (guest->host page tables +
> instruction) and ESSA will not intercept on every call (due to the buffer).
> > 
> > 
> >> I have a set of patches I proposed that add similar functionality via
> >> a KVM hypercall for x86 instead of doing it as a part of a Virtio
> >> device[1].  I'm suspecting the overhead of doing things this way is
> >> much less then having to make multiple madvise system calls from QEMU
> >> back into the kernel.
> > 
> > Well whether it's a virtio device is orthogonal to whether it's an
> > madvise call, right? You can build vhost-pagehint and that can
> > handle requests in a VQ within balloon and do it
> > within host kernel directly.
> > 
> > virtio rings let you pass multiple pages so it's really hard to
> > say which will win outright - maybe it's more important
> > to coalesce exits.
> 
> We don't know until we measure it.

So to measure, I think we can start with traces that show how often do
specific workloads allocate/free pages of specific size.  We don't
necessarily need hypercall/host support.  We might want "mm: Add merge
page notifier" so we can count merges.

> -- 
> 
> Thanks,
> 
> David / dhildenb
