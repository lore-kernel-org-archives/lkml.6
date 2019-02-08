Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB207C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CE120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBHVfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:35:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39998 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfBHVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:35:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so3033064qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARls8l9B1QpFmm4aPfw90cpl5kEhT9Yw7zKI5DeBEkI=;
        b=ap7P8PhyBjivtXm7muaDbboK4whX80GooWu7ulBetVrG9jHNIV6Trydfghsgn77aHS
         HMZ292rxr49a+k0/tzm/iq1FaOAxtAEMvIQWD9wcU1TDhFzxLUvs7s5N6vjCrsCjAymE
         t+15bJz5QQB3ze12i38SVELAlOExDDsLjTxJ7dR1beq4NpNBl5WQgnIJFiXmYxTeZ/H7
         p9nd6nrDJ6MUEemvRG4sKbdWDdzb3PAO0utvxV3RpttET5tip+ie82GT/iS+/S9xJrNK
         n6svktVkPwDSrfXIQdEiSraSqtaF3F53agdL07183Dd/9SlO2rr7V1nvv1zvZ1b7x/zO
         PCgA==
X-Gm-Message-State: AHQUAuYfldWBB4YH6d+HQ67JopKkMW56yFVbO8u9IzL9OMMXXF3+GPKA
        q5Up6k9UYuwoAsd06if3XTERQg==
X-Google-Smtp-Source: AHgI3IYzayvnTvypc3/QCy8C7HXUe2Yfkgt1q0rsg4OEoZwNuHy2JRoAbikUEMUPJTfSAp1PyvRcdw==
X-Received: by 2002:ae9:df02:: with SMTP id t2mr17410377qkf.230.1549661734868;
        Fri, 08 Feb 2019 13:35:34 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id a5sm1119216qtm.16.2019.02.08.13.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 13:35:34 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:35:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, david@redhat.com,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and
 report free pages
Message-ID: <20190208162516-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
 <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:58:47AM -0800, Alexander Duyck wrote:
> On Thu, Feb 7, 2019 at 12:50 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >
> >
> > On 2/7/19 12:43 PM, Alexander Duyck wrote:
> > > On Tue, Feb 5, 2019 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >> On Tue, Feb 05, 2019 at 04:54:03PM -0500, Nitesh Narayan Lal wrote:
> > >>> On 2/5/19 3:45 PM, Michael S. Tsirkin wrote:
> > >>>> On Mon, Feb 04, 2019 at 03:18:53PM -0500, Nitesh Narayan Lal wrote:
> > >>>>> This patch enables the kernel to scan the per cpu array and
> > >>>>> compress it by removing the repetitive/re-allocated pages.
> > >>>>> Once the per cpu array is completely filled with pages in the
> > >>>>> buddy it wakes up the kernel per cpu thread which re-scans the
> > >>>>> entire per cpu array by acquiring a zone lock corresponding to
> > >>>>> the page which is being scanned. If the page is still free and
> > >>>>> present in the buddy it tries to isolate the page and adds it
> > >>>>> to another per cpu array.
> > >>>>>
> > >>>>> Once this scanning process is complete and if there are any
> > >>>>> isolated pages added to the new per cpu array kernel thread
> > >>>>> invokes hyperlist_ready().
> > >>>>>
> > >>>>> In hyperlist_ready() a hypercall is made to report these pages to
> > >>>>> the host using the virtio-balloon framework. In order to do so
> > >>>>> another virtqueue 'hinting_vq' is added to the balloon framework.
> > >>>>> As the host frees all the reported pages, the kernel thread returns
> > >>>>> them back to the buddy.
> > >>>>>
> > >>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > >>>> This looks kind of like what early iterations of Wei's patches did.
> > >>>>
> > >>>> But this has lots of issues, for example you might end up with
> > >>>> a hypercall per a 4K page.
> > >>>> So in the end, he switched over to just reporting only
> > >>>> MAX_ORDER - 1 pages.
> > >>> You mean that I should only capture/attempt to isolate pages with order
> > >>> MAX_ORDER - 1?
> > >>>> Would that be a good idea for you too?
> > >>> Will it help if we have a threshold value based on the amount of memory
> > >>> captured instead of the number of entries/pages in the array?
> > >> This is what Wei's patches do at least.
> > > So in the solution I had posted I was looking more at
> > > HUGETLB_PAGE_ORDER and above as the size of pages to provide the hints
> > > on [1]. The advantage to doing that is that you can also avoid
> > > fragmenting huge pages which in turn can cause what looks like a
> > > memory leak as the memory subsystem attempts to reassemble huge
> > > pages[2]. In my mind a 2MB page makes good sense in terms of the size
> > > of things to be performing hints on as anything smaller than that is
> > > going to just end up being a bunch of extra work and end up causing a
> > > bunch of fragmentation.
> > As per my opinion, in any implementation which page size to store before
> > reporting depends on the allocation pattern of the workload running in
> > the guest.
> 
> I suggest you take a look at item 2 that I had called out in the
> previous email. There are known issues with providing hints smaller
> than THP using MADV_DONTNEED or MADV_FREE. Specifically what will
> happen is that you end up breaking up a higher order transparent huge
> page, backfilling a few holes with other pages, but then the memory
> allocation subsystem attempts to reassemble the larger THP page
> resulting in an application exhibiting behavior similar to a memory
> leak while not actually allocating memory since it is sitting on
> fragments of THP pages.
> 
> Also while I am thinking of it I haven't noticed anywhere that you are
> handling the case of a device assigned to the guest. That seems like a
> spot where we are going to have to stop hinting as well aren't we?

That would be easy for the host to do, way easier than for the guest.

> Otherwise we would need to redo the memory mapping of the guest in the
> IOMMU every time a page is evicted and replaced.

I think that in fact we could in theory make it work.


The reason is that while Linux IOMMU APIs do not allow
this, in fact you can change a mapping just for a single
page within a huge mapping while others are used, as follows:

- create a new set of PTEs
- copy over all PTE mappings except the one
  we are changing
- change the required mapping in the new entry
- atomically update the PMD to point at new PTEs
- flush IOMMU translation cache

similarly for higher levels if there are no PTEs.

So we could come up with something like
        int (*remap)(struct iommu_domain *domain, unsigned long iova,
                   phys_addr_t paddr, size_t size, int prot);

that just tweaks a mapping for a specified range without
breaking others.



> > I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
> > However I am still thinking about a workload which I can use to test its
> > effectiveness.
> 
> You might want to look at doing something like min(MAX_ORDER - 1,
> HUGETLB_PAGE_ORDER).
> I know for x86 a 2MB page is the upper limit for
> THP which is the most likely to be used page size with the guest.

Did you mean max?

I just feel that a good order has much more to do with how
the buddy allocators works than with hardware.

And maybe TRT is to completely disable hinting for when
HUGETLB_PAGE_ORDER > MAX_ORDER since clearly using
buddy allocator for hinting when that breaks huge pages
isn't a good idea.


> > >
> > > The only issue with limiting things on an arbitrary boundary like that
> > > is that you have to hook into the buddy allocator to catch the cases
> > > where a page has been merged up into that range.
> > I don't think, I understood your comment completely. In any case, we
> > have to rely on the buddy for merging the pages.
> > >
> > > [1] https://lkml.org/lkml/2019/2/4/903
> > > [2] https://blog.digitalocean.com/transparent-huge-pages-and-alternative-memory-allocators/
> > --
> > Regards
> > Nitesh
> >
