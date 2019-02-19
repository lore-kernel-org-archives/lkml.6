Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3891C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F70B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfBSWRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:17:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36773 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfBSWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:17:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so24845343qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z2Z+lpO8HZ6jlB7OoQM3hrLYDeJtdKTChovy+cPVcYs=;
        b=tAX4NUdDMi2Vn44BavNLxQzHE50UUidUSkHsEI/mVNuQbVEpAMGgZWMvZNZFkZ/0b7
         mWWR2e5AOu4sZHd5gqCy1AFSh7jShceM9bNijWBRx1ElyZCoeP8b1CG8w0wiQ6jp4E7C
         OMrFOfz432sdCe802BHxzHO0ci69AasUSoy1jEFFGpeBnHQK4IvsCUWgRgkfzWyZ2noD
         q6ZuosrKy/hzH0s1Y40K58J/OpCj3e/Y5ccAyCfdRiCOc2hEpT/Vqp0N/MyDBB+9VgBG
         TjJALToCOLYxcesszfpfzoFLguuwQoNsRsW5KhGDEWlRyFogK91HKVUKtVSt2y7VuvrN
         2Q1A==
X-Gm-Message-State: AHQUAubtKzE1AQV0z71ZemSRzxANR+On9M9e6PqkMnYxDnemDQOLqzwK
        FhXZ10vm9Pp9tBL8J2blhUQBvQ==
X-Google-Smtp-Source: AHgI3IbTZk/3i6B3Rk20jakxbzmeq9gm5PkSxfNrLxmFVA+H7sPc44ik7qzYaZ9T4uhsV499nvEpmw==
X-Received: by 2002:a0c:ad19:: with SMTP id u25mr23544080qvc.14.1550614629274;
        Tue, 19 Feb 2019 14:17:09 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id z42sm5991956qta.28.2019.02.19.14.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:17:08 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:17:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
Message-ID: <20190219170446-mutt-send-email-mst@kernel.org>
References: <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
 <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
 <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
 <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
 <eadcb5c5-2252-80f4-e396-0d2bbbd53694@redhat.com>
 <CAKgT0Uc5CXZLUAqR8G4=aMmsfu2SMHfvGUjwPBmDCPT839Q-rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uc5CXZLUAqR8G4=aMmsfu2SMHfvGUjwPBmDCPT839Q-rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:57:14PM -0800, Alexander Duyck wrote:
> On Tue, Feb 19, 2019 at 10:32 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > >>> This essentially just ends up being another trade-off of CPU versus
> > >>> memory though. Assuming we aren't using THP we are going to take a
> > >>> penalty in terms of performance but could then free individual pages
> > >>> less than HUGETLB_PAGE_ORDER, but the CPU utilization is going to be
> > >>> much higher in general even without the hinting. I figure for x86 we
> > >>> probably don't have too many options since if I am not mistaken
> > >>> MAX_ORDER is just one or two more than HUGETLB_PAGE_ORDER.
> > >>
> > >> THP is an implementation detail in the hypervisor. Yes, it is the common
> > >> case on x86. But it is e.g. not available on s390x yet. And we also want
> > >> this mechanism to work on s390x (e.g. for nested virtualization setups
> > >> as discussed).
> > >>
> > >> If we e.g. report any granularity after merging was done in the buddy,
> > >> we could end up reporting everything from page size up to MAX_SIZE - 1,
> > >> the hypervisor could ignore hints below a certain magic number, if it
> > >> makes its life easier.
> > >
> > > For each architecture we can do a separate implementation of what to
> > > hint on. We already do that for bare metal so why would we have guests
> > > do the same type of hinting in the virtualization case when there are
> > > fundamental differences in page size and features in each
> > > architecture?
> > >
> > > This is another reason why I think the hypercall approach is a better
> > > idea since each architecture is likely going to want to handle things
> > > differently and it would be a pain to try and sort that all out in a
> > > virtio driver.
> >
> > I can't follow. We are talking about something as simple as a minimum
> > page granularity here that can easily be configured. Nothing that
> > screams for different implementations. But I get your point, we could
> > tune for different architectures.
> 
> I was thinking about the guest side of things. Basically if we need to
> define different page orders for different architectures then we start
> needing to do architecture specific includes. Then if we throw in
> stuff like the fact that the first level of KVM can make use of the
> host style hints then that is another thing that will be a difference
> int he different architectures.

Sorry didn't catch this one. What are host style hints?

> I'm just worried this stuff is going
> to start adding up to a bunch of "#ifdef" cruft if we are trying to do
> this as a virtio driver.

I agree we want to avoid that.

And by comparison, if it's up to host or if it's tied to logic within
guest (such as MAX_PAGE_ORDER as suggested by Linus) as opposed to CPU
architecture, then virtio is easier as you can re-use config space and
feature bits to negotiate host/guest capabilities. Doing hypercalls for
that would add lots of hypercalls.

I CC'd Wei Wang who implemented host-driven hints in the balloon right
now. Wei I wonder - could you try changing from MAX_PAGE_ORDER to
HUGETLB_PAGE_ORDER? Does this affect performance for you at all? Thanks!


> > >
> > >>>
> > >>> As far as fragmentation my thought is that we may want to look into
> > >>> adding support to the guest for prioritizing defragmentation on pages
> > >>> lower than THP size. Then that way we could maintain the higher
> > >>> overall performance with or without the hinting since shuffling lower
> > >>> order pages around between guests would start to get expensive pretty
> > >>> quick.
> > >>
> > >> My take would be, design an interface/mechanism that allows any kind of
> > >> granularity. You can than balance between cpu overead and space shifting.
> > >
> > > The problem with using "any kind of granularity" is that in the case
> > > of memory we are already having problems with 4K pages being deemed
> > > too small of a granularity to be useful for anything and making
> > > operations too expensive.
> >
> > No, sorry, s390x does it. And via batch reporting it could work. Not
> > saying we should do page granularity, but "to be useful for anything" is
> > just wrong.
> 
> Yeah, I was engaging in a bit of hyperbole. I have had a headache this
> morning so I am a bit cranky.
> 
> So I am assuming the batching is the reason why you also have a
> arch_alloc_page then for the s390 so that you can abort the hint if a
> page is reallocated before the hint is processed then? I just want to
> confirm so that my understanding of this is correct.
> 
> If that is the case I would be much happier with an asynchronous page
> hint setup as this doesn't deprive the guest of memory while waiting
> on the hint. The current logic in the patches from Nitesh has the
> pages unavailable to the guest while waiting on the hint and that has
> me somewhat concerned as it is going to hurt cache locality as it will
> guarantee that we cannot reuse the same page if we are doing a cycle
> of alloc and free for the same page size.
> > >
> > > I'm open to using other page orders for other architectures. Nothing
> > > says we have to stick with THP sized pages for all architectures. I
> > > have just been focused on x86 and this seems like the best fit for the
> > > balance between CPU and freeing of memory for now on that
> > > architecture.
> > >
> > >> I feel like repeating myself, but on s390x hinting is done on page
> > >> granularity, and I have never heard somebody say "how can I turn it off,
> > >> this is slowing down my system too much.". All we know is that one
> > >> hypercall per free is most probably not acceptable. We really have to
> > >> play with the numbers.
> > >
> > > My thought was we could look at doing different implementations for
> > > other architectures such as s390 and powerPC. Odds are the
> > > implementations would be similar but have slight differences where
> > > appropriate such as what order we should start hinting on, or if we
> > > bypass the hypercall/virtio-balloon for a host native approach if
> > > available.
> > >
> > >> I tend to like an asynchronous reporting approach as discussed in this
> > >> thread, we would have to see if Nitesh could get it implemented.
> > >
> > > I agree it would be great if it could work. However I have concerns
> > > given that work on this patch set dates back to 2017, major issues
> > > such as working around device assignment have yet to be addressed, and
> > > it seems like most of the effort is being focused on things that in my
> > > opinion are being over-engineered for little to no benefit.
> >
> > I can understand that you are trying to push your solution. I would do
> > the same. Again, I don't like a pure synchronous approach that works on
> > one-element-at-a-time. Period. Other people might have other opinions.
> > This is mine - luckily I don't have anything to say here :)
> >
> > MST also voted for an asynchronous solution if we can make it work.
> > Nitesh made significant improvements since the 2017. Complicated stuff
> > needs time. No need to rush. People have been talking about free page
> > hinting since 2006. I talked to various people that experimented with
> > bitmap based solutions two years ago.
> 
> Now that I think I have a better understanding of how the s390x is
> handling this I'm beginning to come around to the idea of an
> asynchronous setup. The one thing that has been bugging me about the
> asynchronous approach is the fact that the pages are not available to
> the guest while waiting on the hint to be completed. If we can do
> something like an arch_alloc_page and that would abort the hint and
> allow us to keep the page available while waiting on the hint that
> would be my preferred way of handling this.
> 
> > So much to that, if you think your solution is the way to go, please
> > follow up on it. Nitesh seems to have decided to look into the
> > asynchronous approach you also called "great if it could work". As long
> > as we don't run into elementary blockers there, to me it all looks like
> > we are making progress, which is good. If we find out asynchronous
> > doesn't work, synchronous is the only alternative.
> 
> I plan to follow up in the next week or so.
> 
> > And just so you don't get me wrong: Thanks for looking and working on
> > this. And thanks for sharing your opinions and insights! However making
> > a decision about going your way at this point does not seem reasonable
> > to me. We have plenty of time.
> 
> I appreciate the feedback. Sorry if I seemed a bit short. As I
> mentioned I've had a headache most of the morning which hasn't really
> helped my mood.
> 
> Thanks.
> 
> - Alex


-- 
MST
