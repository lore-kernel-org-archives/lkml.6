Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175ADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49FE21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfBSOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:40:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38797 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:40:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so23345881qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 06:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jodP6HU8/avt2fdAtxPT/EckTuP45flD2r11mBXSCEQ=;
        b=quihBoqXmdMs/mP2y1uFktMrFVcRolRQ99C4Jp6h7fLs8fPPA7tlt3OVkS4ueDihLo
         G6yTflpc7tiPBJBwwsEQ3eZhVUeGGUQ7vjg8tLkIDwSWPh9kDKASsEQoz8nyqVnAqV3O
         RNu48tbEezqZqeCa15m1gPsc+xOUknpYYJIpIhpYcTbqDFdYTp2QNpo3J7803WkfrXUT
         cFHbGCYkxNg93V6KaLLklUmLhMIRCbiK8Q4wwJUdBP5tEhCE+1r0nXz6oiSM/qNT196/
         Fqye0d5+Nwh6yP+5M6Z9i3S2kDVMJ2zr6kbe7oVR4c/UVlsilUA4BrP0X4KOmYOhkSOA
         yIQA==
X-Gm-Message-State: AHQUAuaqGw9wnIWMA4ki0mzRy3GSrFdh8CgctiFFY9TFPhbIRYo9OwH/
        epA8KbB7FaJ1vScFbRvHSqac2w==
X-Google-Smtp-Source: AHgI3IYeQF+Et957sRyG0HE+ueg57ZRY8NpTgTfZlHPtQK7wh1QGesBxmfcbaKg+NtNCPuLDk1U6xQ==
X-Received: by 2002:aed:3ae4:: with SMTP id o91mr23163280qte.251.1550587219613;
        Tue, 19 Feb 2019 06:40:19 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id l12sm7800842qkk.40.2019.02.19.06.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 06:40:18 -0800 (PST)
Date:   Tue, 19 Feb 2019 09:40:16 -0500
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
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190219093000-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
 <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
 <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
 <93c78cb7-5dc9-39ae-83bf-a4d6426b5221@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c78cb7-5dc9-39ae-83bf-a4d6426b5221@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:06:01AM +0100, David Hildenbrand wrote:
> On 19.02.19 00:47, Alexander Duyck wrote:
> > On Mon, Feb 18, 2019 at 9:42 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 18.02.19 18:31, Alexander Duyck wrote:
> >>> On Mon, Feb 18, 2019 at 8:59 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>> On 18.02.19 17:49, Michael S. Tsirkin wrote:
> >>>>> On Sat, Feb 16, 2019 at 10:40:15AM +0100, David Hildenbrand wrote:
> >>>>>> It would be worth a try. My feeling is that a synchronous report after
> >>>>>> e.g. 512 frees should be acceptable, as it seems to be acceptable on
> >>>>>> s390x. (basically always enabled, nobody complains).
> >>>>>
> >>>>> What slips under the radar on an arch like s390 might
> >>>>> raise issues for a popular arch like x86. My fear would be
> >>>>> if it's only a problem e.g. for realtime. Then you get
> >>>>> a condition that's very hard to trigger and affects
> >>>>> worst case latencies.
> >>>>
> >>>> Realtime should never use free page hinting. Just like it should never
> >>>> use ballooning. Just like it should pin all pages in the hypervisor.
> >>>>
> >>>>>
> >>>>> But really what business has something that is supposedly
> >>>>> an optimization blocking a VCPU? We are just freeing up
> >>>>> lots of memory why is it a good idea to slow that
> >>>>> process down?
> >>>>
> >>>> I first want to know that it is a problem before we declare it a
> >>>> problem. I provided an example (s390x) where it does not seem to be a
> >>>> problem. One hypercall ~every 512 frees. As simple as it can get.
> >>>>
> >>>> No trying to deny that it could be a problem on x86, but then I assume
> >>>> it is only a problem in specific setups.
> >>>>
> >>>> I would much rather prefer a simple solution that can eventually be
> >>>> disabled in selected setup than a complicated solution that tries to fit
> >>>> all possible setups. Realtime is one of the examples where such stuff is
> >>>> to be disabled either way.
> >>>>
> >>>> Optimization of space comes with a price (here: execution time).
> >>>
> >>> One thing to keep in mind though is that if you are already having to
> >>> pull pages in and out of swap on the host in order be able to provide
> >>> enough memory for the guests the free page hinting should be a
> >>> significant win in terms of performance.
> >>
> >> Indeed. And also we are in a virtualized environment already, we can
> >> have any kind of sudden hickups. (again, realtime has special
> >> requirements on the setup)
> >>
> >> Side note: I like your approach because it is simple. I don't like your
> >> approach because it cannot deal with fragmented memory. And that can
> >> happen easily.
> >>
> >> The idea I described here can be similarly be an extension of your
> >> approach, merging in a "batched reporting" Nitesh proposed, so we can
> >> report on something < MAX_ORDER, similar to s390x. In the end it boils
> >> down to reporting via hypercall vs. reporting via virtio. The main point
> >> is that it is synchronous and batched. (and that we properly take care
> >> of the race between host freeing and guest allocation)
> > 
> > I'd say the discussion is even simpler then that. My concern is more
> > synchronous versus asynchronous. I honestly think the cost for a
> > synchronous call is being overblown and we are likely to see the fault
> > and zeroing of pages cost more than the hypercall or virtio
> > transaction itself.
> 
> The overhead of page faults and zeroing should be mitigated by
> MADV_FREE, as Andrea correctly stated (thanks!). Then, the call overhead
> (context switch) becomes relevant.
> 
> We have various discussions now :) And I think they are related.
> 
> synchronous versus asynchronous
> batched vs. non-batched
> MAX_ORDER - 1 vs. other/none magic number
> 
> 1. synchronous call without batching on every kfree is bad. The
> interface is fixed to big magic numbers, otherwise we end up having a
> hypercall on every kfree. This is your approach.
> 
> 2. asynchronous calls without batching would most probably have similar
> problems with small granularities as we had when ballooning without
> batching. Just overhead we can avoid.
> 
> 3. synchronous and batched is what s390x does. It can deal with page
> granularity. It is what I initially described in this sub-thread.
> 
> 4. asynchronous and batched. This is the other approach we discussed
> yesterday. If we can get it implemented, I would be interested in
> performance numbers.
> 
> As far as I understood, Michael seems to favor something like 4 (and I
> assume eventually 2 if it is similarly fast). I am a friend of either 3
> or 4.

Well Linus said big granularity is important for linux MM
and not to bother with hinting small sizes.

Alex said cost of a hypercall is drawfed by a pagefault
after alloc. I would be curious whether async pagefault
can help things somehow though.

> > 
> > Also one reason why I am not a fan of working with anything less than
> > PMD order is because there have been issues in the past with false
> > memory leaks being created when hints were provided on THP pages that
> > essentially fragmented them. I guess hugepaged went through and
> > started trying to reassemble the huge pages and as a result there have
> > been apps that ended up consuming more memory than they would have
> > otherwise since they were using fragments of THP pages after doing an
> > MADV_DONTNEED on sections of the page.
> 
> I understand your concerns, but we should not let bugs in the hypervisor
> dictate the design. Bugs are there to be fixed. Interesting read,
> though, thanks!

Right but if we break up a huge page we are then creating
more work for hypervisor to reassemble it.

> -- 
> 
> Thanks,
> 
> David / dhildenb
