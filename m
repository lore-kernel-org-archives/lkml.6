Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134AEC282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD5214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBJAi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 19:38:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44451 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBJAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 19:38:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so8287962qte.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 16:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6pt6kjIbglC64cZC4M0oP0E6itDrEv52AswOm0vRac=;
        b=Q9JnbWedP8tP2Kt/SnktfKq3scPacDyG5i8u/jmZ1Sxb9OCr8afB2FH8x5vE1RQQqA
         OYPUgkEglcpadKe0RVnB+sqA7JPeloyiaCM3EwoXjRuVpyDjq9Uxev73ilR+Nzfhj8sB
         oZcvkaA073RpiERma0bI7XrUOzi/XB0y+rStNXL2jpOG55Q8GpYuwz0+uzM/bKif1qmO
         CzBau4IcfxbsiAKymEI9TdqNj66CG/oN64/OBaTo7u1QEnApHTWCKgN5KpXEbziiO3UW
         rtlEEc84w2/mEVxibeboB+rz65g5RV0db33z/uCj2mD66/paIqRa41HJZxCxjB+qfMpy
         lNeA==
X-Gm-Message-State: AHQUAuYJ7AV/Ey0RW6Y/LEVQRVwppXrksnIur/OYuLxIpPUih9H0tJzF
        qcH2kMrYTO1XIm+8OrxHK60Ebw==
X-Google-Smtp-Source: AHgI3IYx/2udpgg7EOfoYUX7DQ1PnbzhexXlcXXUmtsMYjJOV18gCVqP+MVux+4Q4uygmcNbJPodYQ==
X-Received: by 2002:ac8:3855:: with SMTP id r21mr14649385qtb.91.1549759135614;
        Sat, 09 Feb 2019 16:38:55 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id k66sm6398236qkc.25.2019.02.09.16.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 16:38:54 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:38:51 -0500
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
Message-ID: <20190209192104-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
 <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
 <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com>
 <20190208163601-mutt-send-email-mst@kernel.org>
 <CAKgT0UcKkS2RsZj28sB3SzMyX9_VrMtZTd+aGYD_FPJn_DA4UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcKkS2RsZj28sB3SzMyX9_VrMtZTd+aGYD_FPJn_DA4UA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:05:09PM -0800, Alexander Duyck wrote:
> On Fri, Feb 8, 2019 at 1:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 08, 2019 at 03:41:55PM -0500, Nitesh Narayan Lal wrote:
> > > >> I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
> > > >> However I am still thinking about a workload which I can use to test its
> > > >> effectiveness.
> > > > You might want to look at doing something like min(MAX_ORDER - 1,
> > > > HUGETLB_PAGE_ORDER). I know for x86 a 2MB page is the upper limit for
> > > > THP which is the most likely to be used page size with the guest.
> > > Sure, thanks for the suggestion.
> >
> > Given current hinting in balloon is MAX_ORDER I'd say
> > share code. If you feel a need to adjust down the road,
> > adjust both of them with actual testing showing gains.
> 
> Actually I'm left kind of wondering why we are even going through
> virtio-balloon for this?

Just look at what does it do.

It improves memory overcommit if guests are cooperative, and it does
this by giving the hypervisor addresses of pages which it can discard.

It's just *exactly* like the balloon with all the same limitations.

> It seems like this would make much more sense
> as core functionality of KVM itself for the specific architectures
> rather than some side thing.

Well same as balloon: whether it's useful to you at all
would very much depend on your workloads.

This kind of cooperative functionality is good for co-located
single-tenant VMs. That's pretty niche.  The core things in KVM
generally don't trust guests.


> In addition this could end up being
> redundant when you start getting into either the s390 or PowerPC
> architectures as they already have means of providing unused page
> hints.

Interesting. Is there host support in kvm?


> I have a set of patches I proposed that add similar functionality via
> a KVM hypercall for x86 instead of doing it as a part of a Virtio
> device[1].  I'm suspecting the overhead of doing things this way is
> much less then having to make multiple madvise system calls from QEMU
> back into the kernel.

Well whether it's a virtio device is orthogonal to whether it's an
madvise call, right? You can build vhost-pagehint and that can
handle requests in a VQ within balloon and do it
within host kernel directly.

virtio rings let you pass multiple pages so it's really hard to
say which will win outright - maybe it's more important
to coalesce exits.

Nitesh, how about trying same tests and reporting performance?


> One other concern that has been pointed out with my patchset that
> would likely need to be addressed here as well is what do we do about
> other hypervisors that decide to implement page hinting. We probably
> should look at making this KVM/QEMU specific code run through the
> paravirtual infrastructure instead of trying into the x86 arch code
> directly.
> 
> [1] https://lkml.org/lkml/2019/2/4/903


So virtio is a paravirtual interface, that's an argument for
using it then.

In any case pls copy the Cc'd crowd on future version of your patches.

-- 
MST
