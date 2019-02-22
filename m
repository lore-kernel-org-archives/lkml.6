Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6D820651
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QmvmGV4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfBVOLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:11:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48042 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfBVOLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Env7SzcD+2JiH9wlj6A1wtmyekfAP+V3cKGvXrTS4wk=; b=QmvmGV4N+6XPewqT6mpKK0lS4
        o3SWP8DrdgCiCZf7Fbyd1mwl9B6m06IYMTcsBgvH01Jh4nGDN89ARGgWmvJV+WUkCgHz5nNfp/loY
        /culqbrU4Krfx/qVQnrk58eTJ2O7Rxa9LTWzVidF0Do546SGETzQ2a/mJLeM0BABdHA2zBOp5L3eq
        DhV0PjO8pGw5N7NmzHXEAj4OOFDxzDylAbHv1rqGMJ/aEQ1uP6hsAjJq/HEPvtYWhbRVcpHqcy7ZT
        ez4iR8Z1YLfVodZ89ZjiUvLTSVUaGu80vNpL2ZD11JnD/ORFFfqTBtiMYe3ynFViCnveD5+kP2+/M
        Hi5oCo2zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxBXC-0003Eq-En; Fri, 22 Feb 2019 14:10:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A36EB2871C0A8; Fri, 22 Feb 2019 15:10:35 +0100 (CET)
Date:   Fri, 22 Feb 2019 15:10:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg Kerr <greg@kerrnel.com>
Cc:     Greg Kerr <kerrnel@google.com>, mingo@kernel.org,
        tglx@linutronix.de, Paul Turner <pjt@google.com>,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190222141035.GZ32494@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <CAJGSLMt_X97Ux=1YiZcXWXvBy4n=ExO=2yAJhfbvxDh+wnWPvQ@mail.gmail.com>
 <20190220094255.GE32494@hirez.programming.kicks-ass.net>
 <20190220183355.GA213003@kerrnel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220183355.GA213003@kerrnel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:33:55AM -0800, Greg Kerr wrote:
> > On Tue, Feb 19, 2019 at 02:07:01PM -0800, Greg Kerr wrote:

> Using cgroups could imply that a privileged user is meant to create and
> track all the core scheduling groups. It sounds like you picked cgroups
> out of ease of prototyping and not the specific behavior?

Yep. Where a prtcl() patch would've been similarly simple, the userspace
part would've been more annoying. The cgroup thing I can just echo into.

> > As it happens; there is actually a bug in that very cgroup patch that
> > can cause undesired scheduling. Try spotting and fixing that.
> > 
> This is where I think the high level properties of core scheduling are
> relevant. I'm not sure what bug is in the existing patch, but it's hard
> for me to tell if the existing code behaves correctly without answering
> questions, such as, "Should processes from two separate parents be
> allowed to co-execute?"

Sure, why not.

The bug is that we set the cookie and don't force a reschedule. This
then allows the existing task selection to continue; which might not
adhere to the (new) cookie constraints.

It is a transient state though; as soon as we reschedule this gets
corrected automagically.

A second bug is that we leak the cgroup tag state on destroy.

A third bug would be that it is not hierarchical -- but that this point
meh.

> > Another question is if we want to be L1TF complete (and how strict) or
> > not, and if so, build the missing pieces (for instance we currently
> > don't kick siblings on IRQ/trap/exception entry -- and yes that's nasty
> > and horrible code and missing for that reason).
> >
> I assumed from the beginning that this should be safe across exceptions.
> Is there a mitigating reason that it shouldn't?

I'm not entirely sure what you mean; so let me expound -- L1TF is public
now after all.

So the basic problem is that a malicious guest can read the entire L1,
right? L1 is shared between SMT. So if one sibling takes a host
interrupt and populates L1 with host data, that other thread can read
it from the guest.

This is why my old patches (which Tim has on github _somewhere_) also
have hooks in irq_enter/irq_exit.

The big question is of course; if any data touched by interrupts is
worth the pain.

> > So first; does this provide what we need? If that's sorted we can
> > bike-shed on uapi/abi.

> I agree on not bike shedding about the API, but can we agree on some of
> the high level properties? For example, who generates the core
> scheduling ids, what properties about them are enforced, etc.?

It's an opaque cookie; the scheduler really doesn't care. All it does is
ensure that tasks match or force idle within a core.

My previous patches got the cookie from a modified
preempt_notifier_register/unregister() which passed the vcpu->kvm
pointer into it from vcpu_load/put.

This auto-grouped VMs. It was also found to be somewhat annoying because
apparently KVM does a lot of userspace assist for all sorts of nonsense
and it would leave/re-join the cookie group for every single assist.
Causing tons of rescheduling.

I'm fine with having all these interfaces, kvm, prctl and cgroup, and I
don't care about conflict resolution -- that's the tedious part of the
bike-shed :-)

The far more important questions are if there's enough workloads where
this can be made useful or not. If not, none of that interface crud
matters one whit, we can file these here patches in the bit-bucket and
happily go spend out time elsewhere.
