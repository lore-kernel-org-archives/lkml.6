Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82E5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849902190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pmf+EjiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392543AbfBMPpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:45:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBMPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HdDbBwL10xwWBHY4uWjVzdQtLeyqbXrybLGpZsQT0UM=; b=pmf+EjiXP0Q+miXdMnvJTukG+
        SBVzKFzdcy1FkY2pE6D0dizvTy1+lE633fvRou2Meq7LfU72PE3pTBU5uFac4VjBhSO2L6R3jTE6e
        J0GUvZkAx7o59SnsquPcxZY2QgOWEI87xwt7zxgnWDRW+KqYoOiUwFjztTQBJZyfjbLUQQw4N1v3W
        stPt6jqH2O2hvEs3pkp0W+icxMvVAY8AFfCQ+VNksRf2uDfNHPP7O7DIAdgGLjm5Oufg76AQyfjqG
        839j1yhEFn1AjpLaX/SHev5KJOTmwtA6/JGQoNYuQ2SFCSjEsFLtET3t/FC7SKVUL05UgkOGMFV9p
        82zt5GZkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtwj8-0002Gs-JV; Wed, 13 Feb 2019 15:45:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AFA1202CEF72; Wed, 13 Feb 2019 16:45:32 +0100 (CET)
Date:   Wed, 13 Feb 2019 16:45:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, catalin.marinas@arm.com, james.morse@arm.com,
        hpa@zytor.com, valentin.schneider@arm.com, brgerst@gmail.com,
        jpoimboe@redhat.com, luto@kernel.org, bp@alien8.de,
        dvlasenk@redhat.com, torvalds@linux-foundation.org,
        tglx@linutronix.de
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
References: <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 03:41:45PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 02:39:22PM +0000, Julien Thierry wrote:
> > Hi Peter,
> > 
> > On 13/02/2019 14:25, Peter Zijlstra wrote:
> > > On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
> > >> The difference is because getting preempted in the sequence above is
> > >> triggered off the back of an interrupt. On arm64, and I think also on x86,
> > >> the user access state (SMAP or PAN) is saved and restored across exceptions
> > >> but not across context switch.
> > > 
> > > A quick reading of the SDM seems to suggest the SMAP state is part of
> > > EFLAGS, which is context switched just fine AFAIK.
> > > 
> > I fail to see where this is happening when looking at the switch_to()
> > logic in x86_64.
> 
> Yeah, me too.. we obviously preserve EFLAGS for user context, but for
> kernel-kernel switches we do not seem to preserve it :-(

So I dug around the context switch code a little, and I think we lost it
here:

  0100301bfdf5 ("sched/x86: Rewrite the switch_to() code")

Before that, x86_64 switch_to() read like (much simplified):

	asm volatile ( /* do RSP twiddle */
	  : /* output */
	  : /* input */
	  : "memory", "cc", .... "flags");

(see __EXTRA_CLOBBER)

Which I suppose means that GCC generates the PUSHF/POPF to preserve the
EFLAGS, since we mark those explicitly clobbered.

Before that:

  f05e798ad4c0 ("Disintegrate asm/system.h for X86")

We had explicit PUSHF / POPF in SAVE_CONTEXT / RESTORE_CONTEXT resp.

Now I cannot see how the current code preserves EFLAGS (if indeed it
does), and the changelog doesn't mention this change _AT_ALL_.


For a little bit of context; it turns out that user_access_begin() /
user_access_end() sets EFLAGS.AC and scheduling in between there wrecks
that because we're apparently not saving that anymore.

Now, I'm tempted to add the PUSHF / POPF right back because of this, but
first I suppose we need to figure out if that change was on purpose and
why that went missing from the Changelog.
