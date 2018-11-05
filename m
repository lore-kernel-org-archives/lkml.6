Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7914C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B5E20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9k8z1lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B5E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbeKFCRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbeKFCRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DsieLOHZoqgA0lWjDjlIjN6sVrCoUNxKlEy7y1BKdvE=; b=Y9k8z1lIWS+a98u3nzGZykufu
        9FCbnKZcsXjL0WH8jSXVJToeLpBWEIaavbmZ61M1owIVefwcnGaps/qme1D47Fstt7z7fZYlW/VzZ
        MJJHsMXbPla8FNg68FX1Z9deZUG+c0rK4iDzQBbBzycwSe9YnTqePOX5jLIm0qyeZxNrb4UnTOiFO
        sw8z2qKLLr3N6dQEZcD5cbupT1ADyE+i/wCb4fHytlzSGvO2xVqcJs/yVyuceujZxVQfVKBLt+WJ8
        AiVap3wTFiwF+t1Knc+hB0bGIfUFka1HBBfavi+DpIf5822MaPdanOygr7hi7bVp5PJbyTJV5ROfH
        c+VJVYaqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJiBQ-0007b8-Kw; Mon, 05 Nov 2018 16:57:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E81982029F9FF; Mon,  5 Nov 2018 17:56:57 +0100 (CET)
Date:   Mon, 5 Nov 2018 17:56:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: Re: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Message-ID: <20181105165657.GD22431@hirez.programming.kicks-ass.net>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
 <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
 <20181101145257.GD3178@hirez.programming.kicks-ass.net>
 <5BDC140F.6060303@intel.com>
 <20181105093413.GO3178@hirez.programming.kicks-ass.net>
 <5BE02725.3010707@intel.com>
 <20181105121413.GC22431@hirez.programming.kicks-ass.net>
 <286AC319A985734F985F78AFA26841F73DE3AC8B@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73DE3AC8B@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please; don't send malformed emails like this. Lines wrap at 78 chars.

On Mon, Nov 05, 2018 at 03:37:24PM +0000, Wang, Wei W wrote:
> On Monday, November 5, 2018 8:14 PM, Peter Zijlstra wrote:


> > That can only work if the host counter has perf_event_attr::exclude_guest=1,
> > any counter without that must also count when the guest is running.
> > 
> > (and, IIRC, normal perf tool events do not have that set by default)
> 
> Probably no. Please see Line 81 at
> https://github.com/torvalds/linux/blob/master/tools/perf/util/util.c
> perf_guest by default is false, which makes "attr->exclude_guest = 1"

Then you're in luck. But if the host creates an even that has
exclude_guest=0 set, it should still work.

> > The thing is; you cannot do blind pass-through of the PMU, some of its
> > features simply do not work in a guest. Also, the host perf driver expects
> > certain functionality that must be respected.
> 
> Actually we are not blindly assigning the perf counters. Guest works
> with its own complete perf stack (like the one on the host) which also
> has its own constraints. 

But it knows nothing of the host state.

> The counter is also not passed through to the guest, guest accesses to
> the assigned counter will still exit to the hypervisor, and the
> hypervisor helps update the counter. 

Yes, you have to; because the PMU doesn't properly virtualize, also
because the HV -- linux in our case -- already claimed the PMU.

So the network passthrough case you mentioned simply doesn't apply at
all. Don't bother looking at it for inspiration.

> > Those are the constraints you have to work with.
> > 
> > Back when we all started down this virt rathole, I proposed people do
> > paravirt perf, where events would be handed to the host kernel and let the
> > host kernel do its normal thing. But people wanted to do the MSR based
> > thing because of !linux guests.
> 
> IMHO, it is worthwhile to care more about the real use case. When a
> user gets a virtual machine from a vendor, all he can do is to run
> perf inside the guest. The above contention concerns would not happen,
> because the user wouldn't be able to come to the host to run perf on
> the virtualization software (e.g. ./perf qemu..) and in the meantime
> running perf in the guest to cause the contention.

That's your job. Mine is to make sure that whatever you propose fits in
the existing model and doesn't make a giant mess of things.

And for Linux guests on Linux hosts, paravirt perf still makes the most
sense to me; then you get the host scheduling all the events and
providing the guest with the proper counts/runtimes/state.

> On the other hand, when we improve the user experience of running perf
> inside the guest by reducing the virtualization overhead, that would
> bring real benefits to the real use case.

You can start to improve things by doing a less stupid implementation of
the existing code.
