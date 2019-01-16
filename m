Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684EDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387BB206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZkGKv7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404494AbfAPNpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:45:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730798AbfAPNp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6eRszGOnJ1la1Azov4nEHV7IY0vmubqaDui3/+NiF6U=; b=EZkGKv7aDXNdtvxPxhslpN+vY
        nZehewa6PyWX8aekEsbok7HQIphwutkcHVms608br0btw/Ada9mo+s8Ry1mDVApWmbLnclo2yVXEN
        gvinI8zt1gKF4QhvKz6Ltd9DlhdYP+X1NuFASjBYAyd02ybVw+Ni+GzvlbFfzdhDqWORAm78v3x/d
        A78tS7gJ0tLPPA/+FtcnUt0vO/rSFi0J+U4H0WHhz6M8LZr6+1mAWDCwqTB3AjwcyS+HrujQud50z
        ydaFhqzoyGRiP/8iqUUMU9j1POIoj1gEHgZrU44/n7jD181XT5oiDfd3c5uAfRFLYyamRhROQ3sDh
        i9GP4FctA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjlVT-0001u3-3t; Wed, 16 Jan 2019 13:45:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A7082019521E; Wed, 16 Jan 2019 14:45:21 +0100 (CET)
Date:   Wed, 16 Jan 2019 14:45:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: preempt_schedule_irq() loop question
Message-ID: <20190116134521.GG10803@hirez.programming.kicks-ass.net>
References: <cc989920-a13b-d53b-db83-1584a7f53edc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc989920-a13b-d53b-db83-1584a7f53edc@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:50:42PM +0000, Valentin Schneider wrote:
> Hi,
> 
> I've been wandering around preempt_schedule_irq() in sched/core.c, and
> got curious regarding how the arch code calls it.
> 
> The main part of preempt_schedule_irq() is:
> 
>     do {
> 	    preempt_disable();
> 	    local_irq_enable();
> 	    __schedule(true);
> 	    local_irq_disable();
> 	    sched_preempt_enable_no_resched();
>     } while (need_resched());
> 
> Yet all the arch entry.S I looked at (I stopped after arm64, arm, x86_32,
> MIPS, powerpc) wrap the call to preempt_schedule_irq() in another
> 
>     do { ... } while (need_resched())
> 
> For instance, this is what's done in arm64:
> 
>     1:	bl	preempt_schedule_irq		// irq en/disable is done inside
> 	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
> 	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
> 
> 
> I naively thought this could be attributed to something like
> preempt_schedule_irq() historically not having an inner loop, but it seems
> to have been there since the beginning of time (or at least up to the point
> where the git history stops).
> 
> I don't see why we need to have these nested loops - AFAICT the one in
> preempt_schedule_irq() would suffice. What am I missing?

I think you're quite right; but I wasn't doing kernel work back when rml
added the preemptible bits. Ingo, do you have any recollections that far
back?
