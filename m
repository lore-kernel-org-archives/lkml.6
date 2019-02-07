Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A75CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D112086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfBGTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:02:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfBGTCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:02:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90D8010FA7;
        Thu,  7 Feb 2019 19:02:00 +0000 (UTC)
Received: from redhat.com (ovpn-123-55.rdu2.redhat.com [10.10.123.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id EC60060BE0;
        Thu,  7 Feb 2019 19:01:43 +0000 (UTC)
Date:   Thu, 7 Feb 2019 14:01:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com,
        david@redhat.com, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and
 report free pages
Message-ID: <20190207135511-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 07 Feb 2019 19:02:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:43:44AM -0800, Alexander Duyck wrote:
> On Tue, Feb 5, 2019 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Feb 05, 2019 at 04:54:03PM -0500, Nitesh Narayan Lal wrote:
> > >
> > > On 2/5/19 3:45 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Feb 04, 2019 at 03:18:53PM -0500, Nitesh Narayan Lal wrote:
> > > >> This patch enables the kernel to scan the per cpu array and
> > > >> compress it by removing the repetitive/re-allocated pages.
> > > >> Once the per cpu array is completely filled with pages in the
> > > >> buddy it wakes up the kernel per cpu thread which re-scans the
> > > >> entire per cpu array by acquiring a zone lock corresponding to
> > > >> the page which is being scanned. If the page is still free and
> > > >> present in the buddy it tries to isolate the page and adds it
> > > >> to another per cpu array.
> > > >>
> > > >> Once this scanning process is complete and if there are any
> > > >> isolated pages added to the new per cpu array kernel thread
> > > >> invokes hyperlist_ready().
> > > >>
> > > >> In hyperlist_ready() a hypercall is made to report these pages to
> > > >> the host using the virtio-balloon framework. In order to do so
> > > >> another virtqueue 'hinting_vq' is added to the balloon framework.
> > > >> As the host frees all the reported pages, the kernel thread returns
> > > >> them back to the buddy.
> > > >>
> > > >> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > > >
> > > > This looks kind of like what early iterations of Wei's patches did.
> > > >
> > > > But this has lots of issues, for example you might end up with
> > > > a hypercall per a 4K page.
> > > > So in the end, he switched over to just reporting only
> > > > MAX_ORDER - 1 pages.
> > > You mean that I should only capture/attempt to isolate pages with order
> > > MAX_ORDER - 1?
> > > >
> > > > Would that be a good idea for you too?
> > > Will it help if we have a threshold value based on the amount of memory
> > > captured instead of the number of entries/pages in the array?
> >
> > This is what Wei's patches do at least.
> 
> So in the solution I had posted I was looking more at
> HUGETLB_PAGE_ORDER and above as the size of pages to provide the hints
> on [1]. The advantage to doing that is that you can also avoid
> fragmenting huge pages which in turn can cause what looks like a
> memory leak as the memory subsystem attempts to reassemble huge
> pages[2]. In my mind a 2MB page makes good sense in terms of the size
> of things to be performing hints on as anything smaller than that is
> going to just end up being a bunch of extra work and end up causing a
> bunch of fragmentation.

Yes MAX_ORDER-1 is 4M. So not a lot of difference on x86.

The idea behind keying off MAX_ORDER is that CPU hugepages isn't
the only reason to avoid fragmentation, there's other
hardware that benefits from linear physical addresses.
And there are weird platforms where HUGETLB_PAGE_ORDER exceeds
MAX_ORDER - 1. So from that POV keying it off MAX_ORDER
makes more sense.


> The only issue with limiting things on an arbitrary boundary like that
> is that you have to hook into the buddy allocator to catch the cases
> where a page has been merged up into that range.
> 
> [1] https://lkml.org/lkml/2019/2/4/903
> [2] https://blog.digitalocean.com/transparent-huge-pages-and-alternative-memory-allocators/
