Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC49C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F53C20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PaQidjXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F53C20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeKEVdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:33:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5rS0xiyMH4HNjcljf/4KEL+mWycOdMsxBQWtxbGfDlE=; b=PaQidjXtYXfidp777Pn9L6HJP
        3OXULkAH50MesA+ObBhW9CBnY6RrVriP2yXlwuqkJnFxmg1CNWrgtecrqJmlzlIF8NzzW0WVzd+wx
        DpjPVmiZOea3fezS2bFJxShUymlmPEPH8MgKjQY/s914c/gV4RvtaFjr8YD37ldvShyLGgV9eCnbM
        qv+d5CJY232JOU8hR+rqebgd9coyT5l1TwfnT8iTDKYzQeg3EXGiW1pjMRNArCWB1BmKYSLkL6Y/u
        17n0+li+owrwn2izr3kuX/IfuLN7EdNGbT62rml0eQQ0DZNte6XklTNt+8Ik9Jc3Tm2f/+D1ldZNe
        Si8g2kJ/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdln-0001Os-9t; Mon, 05 Nov 2018 12:14:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EEFB2029F9FF; Mon,  5 Nov 2018 13:14:13 +0100 (CET)
Date:   Mon, 5 Nov 2018 13:14:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Message-ID: <20181105121413.GC22431@hirez.programming.kicks-ass.net>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
 <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
 <20181101145257.GD3178@hirez.programming.kicks-ass.net>
 <5BDC140F.6060303@intel.com>
 <20181105093413.GO3178@hirez.programming.kicks-ass.net>
 <5BE02725.3010707@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BE02725.3010707@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 07:19:01PM +0800, Wei Wang wrote:
> On 11/05/2018 05:34 PM, Peter Zijlstra wrote:
> > On Fri, Nov 02, 2018 at 05:08:31PM +0800, Wei Wang wrote:
> > > On 11/01/2018 10:52 PM, Peter Zijlstra wrote:
> > > > > @@ -723,6 +724,9 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
> > > > >    	sched->max_weight	= wmax;
> > > > >    	sched->max_gp		= gpmax;
> > > > >    	sched->constraints	= constraints;
> > > > > +#ifdef CONFIG_CPU_SUP_INTEL
> > > > > +	sched->state.used[0]	= cpuc->intel_ctrl_guest_mask;
> > > > > +#endif
> > > > NAK.  This completely undermines the whole purpose of event scheduling.
> > > > 
> > > Hi Peter,
> > > 
> > > Could you share more details how it would affect the host side event
> > > scheduling?
> > Not all counters are equal; suppose you have one of those chips that can
> > only do PEBS on counter 0, and then hand out 0 to the guest for some
> > silly event. That means nobody can use PEBS anymore.
> 
> Thanks for sharing your point.
> 
> In this example (assume PEBS can only work with counter 0), how would the
> existing approach (i.e. using host event to emulate) work?
> For example, guest wants to use PEBS, host also wants to use PEBS or other
> features that only counter 0 fits, I think either guest or host will not
> work then.

The answer for PEBS is really simple; PEBS does not virtualize (Andi
tried and can tell you why; IIRC it has something to do with how the
hardware asks for a Linear Address instead of a Physical Address). So
the problem will not arrise.

But there are certainly constrained events that will result in the same
problem.

The traditional approach of perf on resource contention is to share it;
you get only partial runtime and can scale up the events given the
runtime metrics provided.

We also have perf_event_attr::pinned, which is normally only available
to root, in which case we'll end up marking any contending event to an
error state.

Neither are ideal for MSR level emulation.

> With the register level virtualization approach, we could further support
> that case: if guest requests to use a counter which host happens to be
> using, we can let host and guest both be satisfied by supporting counter
> context switching on guest/host switching. In this case, both guest and host
> can use counter 0. (I think this is actually a policy selection, the current
> series chooses to be guest first, we can further change it if necessary)

That can only work if the host counter has
perf_event_attr::exclude_guest=1, any counter without that must also
count when the guest is running.

(and, IIRC, normal perf tool events do not have that set by default)

> > > Would you have any suggestions?
> > I would suggest not to use virt in the first place of course ;-)
> > 
> > But whatever you do; you have to keep using host events to emulate the
> > guest PMU. That doesn't mean you can't improve things; that code is
> > quite insane from what you told earlier.
> 
> I agree that the host event emulation is a functional approach, but it may
> not be an effective one (also got complaints from people about today's perf
> in the guest).
> We actually have similar problems when doing network virtualization. The
> more effective approach tends to be the one that bypasses the host network
> stack. Both the network stack and perf stack seem to be too heavy to be used
> as part of the emulation.

The thing is; you cannot do blind pass-through of the PMU, some of its
features simply do not work in a guest. Also, the host perf driver
expects certain functionality that must be respected.

Those are the constraints you have to work with.

Back when we all started down this virt rathole, I proposed people do
paravirt perf, where events would be handed to the host kernel and let
the host kernel do its normal thing. But people wanted to do the MSR
based thing because of !linux guests.

Now I don't care about virt much, but I care about !linux guests even
less.
