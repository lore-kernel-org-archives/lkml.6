Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BD8222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRo5bPbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbfBMOkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:40:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390684AbfBMOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VR4hOcRIJE5nvd9WG8ErdD7kw0njcUqaZiFFYD0Af1c=; b=rRo5bPbAoityizAzOoc4He1/2
        g878QIXS3PwYXX6/Y8nrL+quskiCadBPbFLcx/oNLwsSBw44T5cjO2+mEy6ouIs7208sxk9erG+OH
        tZ68ZUoXu97JtwM5CtkSKpFmFvCo5U6zz2zyVXCrGiI11K/FH5szq74861f/gBkBkBVjEsLJ0Jilx
        J/N3IAzLU10pCTCNga6GL/93OZWV91W1Z8tXWK432qn2ebNHBbAEBsQpsdwp38pjUnIBdrMYWv48B
        LazQkUFpBQgSB+kdqwBmxwBfx4mvwVqh1XTDPE5APMuZIc54ADL2lvG0VRb98Uvb2alddRsOCSni4
        fxo7gayWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtvhi-00018v-Go; Wed, 13 Feb 2019 14:40:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCA2422BBEBE6; Wed, 13 Feb 2019 15:40:00 +0100 (CET)
Date:   Wed, 13 Feb 2019 15:40:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, catalin.marinas@arm.com, james.morse@arm.com,
        hpa@zytor.com, valentin.schneider@arm.com
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213144000.GX32494@hirez.programming.kicks-ass.net>
References: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213141712.GV32494@hirez.programming.kicks-ass.net>
 <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:24:34PM +0000, Julien Thierry wrote:
> On 13/02/2019 14:17, Peter Zijlstra wrote:
> > On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
> >>> This; how is getting preempted fundamentally different from scheduling
> >>> ourselves?
> >>
> >> The difference is because getting preempted in the sequence above is
> >> triggered off the back of an interrupt. On arm64, and I think also on x86,
> >> the user access state (SMAP or PAN) is saved and restored across exceptions
> >> but not across context switch. Consequently, taking an irq in a
> >> user_access_{begin,end} section and then scheduling is fine, but calling
> >> schedule directly within such a section is not.
> > 
> > So how's this then:
> > 
> > 	if (user_access_begin()) {
> > 
> > 		preempt_disable();
> > 
> > 		<IRQ>
> > 			set_need_resched();
> > 		</IRQ no preempt>
> > 
> > 		preempt_enable()
> > 		  __schedule();
> > 
> > 		user_access_end();
> > 	}
> > 
> > That _should_ work just fine but explodes with the proposed nonsense.
> 
> AFAICT, This does not work properly because when you schedule out this
> task, you won't be saving the EFLAGS.AF/PSTATE.PAN bit on the stack, and

EFLAGS.AC, but yes.

> next time you schedule the task back in, it might no longer have the
> correct flag value (so an unsafe_get/put_user() will fail even though
> you haven't reached user_access_end()).

/me looks at __switch_to_asm() and there is indeed a distinct lack of
pushing and popping EFLAGS :/

> One solution is to deal with this in task switching code, but so far
> I've been told that calling schedule() in such a context is not expected
> to be supported.

Well, per the above it breaks the preemption model. And I hates that.

And the added WARN doesn't even begin to cover it, since you'd have to
actually hit the preempt_enable() reschedule for it trigger.

So far, all 6 in-tree users are indeed free of dodgy code, but *groan*.
