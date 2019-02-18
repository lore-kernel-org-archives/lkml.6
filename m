Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4605E20661
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfBRUcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:32:03 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46197 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfBRUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:32:02 -0500
Received: by mail-qt1-f174.google.com with SMTP id y20so20610973qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxOkcYT1hPxPrsd41FYLrGuBmt3Uo7mYHZUzA1PaaVw=;
        b=EK1nbo1yRwqNOZu+B1G1UP8gBfpNEvUiFAOAni7aEZix18nossloYcT5ULG8rJ8UOm
         OFRT6MaeJ2xWz5hiXfuFDX1cH0zBWdZojL5JJal4WwNGrBJiaHXspmmO9S8lnUEeP1Gd
         QL14e2Ia2bE/Aup1AMQEKCd3CbK62zNNSMytFWQuXaFWavMVHWWkvRFny87w4CS/hk7M
         bBZB8chsfJgVKFq+OSdYFDPcDo32pfdWm/7WeB8r+C4oCSlRne6N5nJd73QMuupi7zLL
         SSzZF/I3UAAPmZoQWixxLD5kVphev/xH4iC9A/6K2TAUDERIRA2+zEKkQoPlKVJU3SgA
         h8yA==
X-Gm-Message-State: AHQUAuZk8MIVHNC5oVyyPQRO9eTAx+A7R3HPesAXdxyAcBP2tOBFRLBm
        /Zwrg2xAt9rSrXM5vP72CbSZng==
X-Google-Smtp-Source: AHgI3IYkrm2A3hAN0vxnf6TuNaqROpGkY2t02zDq3yexKn0Qaig7yqFd1BLjAMYdEqC5YHIdbC3Z+Q==
X-Received: by 2002:a0c:d968:: with SMTP id t37mr18788905qvj.195.1550521921182;
        Mon, 18 Feb 2019 12:32:01 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id m124sm7165747qkc.16.2019.02.18.12.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:32:00 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:31:57 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
        yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190218152021-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org>
 <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org>
 <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:04:57PM +0100, David Hildenbrand wrote:
> >>>>> So I'm fine with a simple implementation but the interface needs to
> >>>>> allow the hypervisor to process hints in parallel while guest is
> >>>>> running.  We can then fix any issues on hypervisor without breaking
> >>>>> guests.
> >>>>
> >>>> Yes, I am fine with defining an interface that theoretically let's us
> >>>> change the implementation in the guest later.
> >>>> I consider this even a
> >>>> prerequisite. IMHO the interface shouldn't be different, it will be
> >>>> exactly the same.
> >>>>
> >>>> It is just "who" calls the batch freeing and waits for it. And as I
> >>>> outlined here, doing it without additional threads at least avoids us
> >>>> for now having to think about dynamic data structures and that we can
> >>>> sometimes not report "because the thread is still busy reporting or
> >>>> wasn't scheduled yet".
> >>>
> >>> Sorry I wasn't clear. I think we need ability to change the
> >>> implementation in the *host* later. IOW don't rely on
> >>> host being synchronous.
> >>>
> >>>
> >> I actually misread it :) . In any way, there has to be a mechanism to
> >> synchronize.
> >>
> >> If we are going via a bare hypercall (like s390x, like what Alexander
> >> proposes), it is going to be a synchronous interface either way. Just a
> >> bare hypercall, there will not really be any blocking on the guest side.
> > 
> > It bothers me that we are now tied to interface being synchronous. We
> > won't be able to fix it if there's an issue as that would break guests.
> 
> I assume with "fix it" you mean "fix kfree taking longer on every X call"?
> 
> Yes, as I initially wrote, this mimics s390x. That might be good (we
> know it has been working for years) and bad (we are inheriting the same
> problem class, if it exists). And being synchronous is part of the
> approach for now.

BTW on s390 are these hypercalls handled by Linux?

> I tend to focus on the first part (we don't know anything besides it is
> working) while you focus on the second part (there could be a potential
> problem). Having a real problem at hand would be great, then we would
> know what exactly we actually have to fix. But read below.

If we end up doing a hypercall per THP, maybe we could at least
not block with interrupts disabled? Poll in guest until
hypervisor reports its done?  That would already be an
improvement IMHO. E.g. perf within guest will point you
in the right direction and towards disabling hinting.


> > 
> >> Via virtio, I guess it is waiting for a response to a requests, right?
> > 
> > For the buffer to be used, yes. And it could mean putting some pages
> > aside until hypervisor is done with them. Then you don't need timers or
> > tricks like this, you can get an interrupt and start using the memory.
> 
> I am very open to such an approach as long as we can make it work and it
> is not too complicated. (-> simple)
> 
> This would mean for example
> 
> 1. Collect entries to be reported per VCPU in a buffer. Say magic number
> 256/512.
> 
> 2. Once the buffer is full, do crazy "take pages out of the balloon
> action" and report them to the hypervisor via virtio. Let the VCPU
> continue. This will require some memory to store the request. Small
> hickup for the VCPU to kick of the reporting to the hypervisor.
> 
> 3. On interrupt/response, go over the response and put the pages back to
> the buddy.
> 
> (assuming that reporting a bulk of frees is better than reporting every
> single free obviously)
> 
> This could allow nice things like "when OOM gets trigger, see if pages
> are currently being reported and wait until they have been put back to
> the buddy, return "new pages available", so in a real "low on memory"
> scenario, no OOM killer would get involved. This could address the issue
> Wei had with reporting when low on memory.
> 
> Is that something you have in mind?

Yes that seems more future proof I think.

> I assume we would have to allocate
> memory when crafting the new requests. This is the only reason I tend to
> prefer a synchronous interface for now. But if allocation is not a
> problem, great.

There are two main ways to avoid allocation:
1. do not add extra data on top of each chunk passed
2. add extra data but pre-allocate buffers for it

> -- 
> 
> Thanks,
> 
> David / dhildenb
