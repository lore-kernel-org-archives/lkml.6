Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8321924073
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fY+9WOUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8321924073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeGEOAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:00:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38182 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753483AbeGEOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:00:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id j33-v6so1238192wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h/JbZiP+wIsOvyD5TdYC5hLlANnSOcQAuvyEFilCimQ=;
        b=fY+9WOUhyyD8cnm/SOq0LB2LmBjL2dFlgfMU8J/u3cqowqBHEWHVatIrzw+ZMN7tuQ
         7IiKEAkb4zIpBzZC97hl2mDfRzCJnb9+WXd9ITiFcMQVay2WR2I5ebQwA9iv3hWmnDi0
         txUEGII6YONgwRyBlhvPX27IhQtlzFRNjxkSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h/JbZiP+wIsOvyD5TdYC5hLlANnSOcQAuvyEFilCimQ=;
        b=mVoif5BOS1j2Jyjz1+ZYKURE4X9LfcQ6POHx9753Ls3cwMRId6Dfs9b35s5hfPWW40
         w/0+/IFEs9ep0cNggoHLoADAWY8BkdVr4INSx2bontJ/7ImeY6TEQlSrHMcoGIMdWm+/
         6Ti53bellaturQlGUfc77YZSisGSNOWjNabWmAsqQuRC4wOkve2UOjwIBn11jWh+7Tfv
         HCzP3yPT3lZqL+oh3GUGh4nHvKlnGchXw/xew+bOUhsje6jvpO/pfZ6rmnDlW4P3EhIb
         nDhhUorirYx7Y3YY3Tp6VUs65uspgjkOsbZkaX3X+MOugIla5AON6aqzuPF7hVC169Ra
         XTtg==
X-Gm-Message-State: APt69E3f68S83xO37mszk2NSi3mox3llVPM8/RRpPQnM2SDuOH66c9nV
        GgYVzf0Vuf/ZicKjbowcvq+L3w==
X-Google-Smtp-Source: AAOMgpdWTQ6vAgx802F+knJujqZQdGF28hG1OFa+9t9Mwu1mQRZ3gfodyy+B0Y2OlT1LyrWLV2fM7A==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr4535348wre.268.1530799235888;
        Thu, 05 Jul 2018 07:00:35 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id l17-v6sm11015148wrh.45.2018.07.05.07.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 07:00:35 -0700 (PDT)
Date:   Thu, 5 Jul 2018 16:00:29 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705140029.GA5346@andrea>
References: <20180625081920.GA5619@andrea>
 <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
 <20180704121103.GB26941@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704121103.GB26941@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:11:04PM +0100, Will Deacon wrote:
> Hi Alan,
> 
> On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> > On Mon, 25 Jun 2018, Andrea Parri wrote:
> > 
> > > On Fri, Jun 22, 2018 at 07:30:08PM +0100, Will Deacon wrote:
> > > > > > I think the second example would preclude us using LDAPR for load-acquire,
> > > 
> > > > I don't think it's a moot point. We want new architectures to implement
> > > > acquire/release efficiently, and it's not unlikely that they will have
> > > > acquire loads that are similar in semantics to LDAPR. This patch prevents
> > > > them from doing so,
> > > 
> > > By this same argument, you should not be a "big fan" of rfi-rel-acq in ppo ;)
> > > consider, e.g., the two litmus tests below: what am I missing?
> > 
> > This is an excellent point, which seems to have gotten lost in the 
> > shuffle.  I'd like to see your comments.
> 
> Yeah, sorry. Loads going on at the moment. You could ask herd instead of me
> though ;)
> 
> > In essence, if you're using release-acquire instructions that only
> > provide RCpc consistency, does store-release followed by load-acquire
> > of the same address provide read-read ordering?  In theory it doesn't
> > have to, because if the value from the store-release is forwarded to
> > the load-acquire then:
> > 
> > 	LOAD A
> > 	STORE-RELEASE X, v
> > 	LOAD-ACQUIRE X
> > 	LOAD B
> > 
> > could be executed by the CPU in the order:
> > 
> > 	LOAD-ACQUIRE X
> > 	LOAD B
> > 	LOAD A
> > 	STORE-RELEASE X, v
> > 
> > thereby accessing A and B out of program order without violating the
> > requirements on the release or the acquire.
> > 
> > Of course PPC doesn't allow this, but should we rule it out entirely?
> 
> This would be allowed if LOAD-ACQUIRE was implemented using LDAPR on Arm.
> I don't think we should be ruling out architectures using RCpc
> acquire/release primitives, because doing so just feels like an artifact of
> most architectures building these out of fences today.
> 
> It's funny really, because from an Arm-perspective I don't plan to stray
> outside of RCsc, but I feel like other weak architectures aren't being
> well represented here. If we just care about x86, Arm and Power (and assume
> that Power doesn't plan to implement RCpc acquire/release instructions)
> then we're good to tighten things up. But I fear that RISC-V should probably
> be more engaged (adding Daniel) and who knows about MIPS or these other
> random architectures popping up on linux-arch.
> 
> > > C MP+fencewmbonceonce+pooncerelease-rfireleaseacquire-poacquireonce
> > > 
> > > {}
> > > 
> > > P0(int *x, int *y)
> > > {
> > > 	WRITE_ONCE(*x, 1);
> > > 	smp_wmb();
> > > 	WRITE_ONCE(*y, 1);
> > > }
> > > 
> > > P1(int *x, int *y, int *z)
> > > {
> > > 	r0 = READ_ONCE(*y);
> > > 	smp_store_release(z, 1);
> > > 	r1 = smp_load_acquire(z);
> > > 	r2 = READ_ONCE(*x);
> > > }
> > > 
> > > exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)
> > > 
> > > 
> > > AArch64 MP+dmb.st+popl-rfilq-poqp
> > > "DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre"
> > > Generator=diyone7 (version 7.49+02(dev))
> > > Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
> > > Com=Rf Fr
> > > Orig=DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre
> > > {
> > > 0:X1=x; 0:X3=y;
> > > 1:X1=y; 1:X3=z; 1:X6=x;
> > > }
> > >  P0          | P1            ;
> > >  MOV W0,#1   | LDR W0,[X1]   ;
> > >  STR W0,[X1] | MOV W2,#1     ;
> > >  DMB ST      | STLR W2,[X3]  ;
> > >  MOV W2,#1   | LDAPR W4,[X3] ;
> > >  STR W2,[X3] | LDR W5,[X6]   ;
> > > exists
> > > (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)
> 
> (you can also run this yourself, since 'Q' is supported in the .cat file
> I contributed to herdtools7)
> 
> Test MP+dmb.sy+popl-rfilq-poqp Allowed
> States 4
> 1:X0=0; 1:X4=1; 1:X5=0;
> 1:X0=0; 1:X4=1; 1:X5=1;
> 1:X0=1; 1:X4=1; 1:X5=0;
> 1:X0=1; 1:X4=1; 1:X5=1;
> Ok
> Witnesses
> Positive: 1 Negative: 3
> Condition exists (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)
> Observation MP+dmb.sy+popl-rfilq-poqp Sometimes 1 3
> Time MP+dmb.sy+popl-rfilq-poqp 0.01
> Hash=61858b7b59a6310d869f99cd05718f96
> 
> > There's also read-write ordering, in the form of the LB pattern:
> > 
> > P0(int *x, int *y, int *z)
> > {
> > 	r0 = READ_ONCE(*x);
> > 	smp_store_release(z, 1);
> > 	r1 = smp_load_acquire(z);
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	r2 = READ_ONCE(*y);
> > 	smp_mp();
> > 	WRITE_ONCE(*x, 1);
> > }
> > 
> > exists (0:r0=1 /\ 1:r2=1)
> 
> The access types are irrelevant to the acquire/release primitives, so yes
> that's also allowed.
> 
> > Would this be allowed if smp_load_acquire() was implemented with LDAPR?
> > If the answer is yes then we will have to remove the rfi-rel-acq and
> > rel-rf-acq-po relations from the memory model entirely.
> 
> I don't understand what you mean by "rfi-rel-acq-po", and I assume you mean
> rel-rfi-acq-po for the other? Sounds like I'm confused here.

[Your reply about 1/2 suggests that you've figured this out now, IAC ...]

"rfi-rel-acq" (as Alan wrote, and as I wrote before my question above...)
is defined and currently used in linux-kernel.cat (and, FWIW, it has been
so since when we upstreamed LKMM).

My point is that, as exemplified by the two tests I reported above, this
relation already prevents you from implementing your acquire with LDAPR;
so my/our question was not "can you run herd7 for me?" but rather "do you
think that changes are needed to the .cat file?".

This question goes back _at least_ to:

  http://lkml.kernel.org/r/1519301990-11766-1-git-send-email-parri.andrea@gmail.com

(see, in part., the "IMPORTANT" note at the bottom of the commit message)
and that discussion later resulted in:

  0123f4d76ca63b ("riscv/spinlock: Strengthen implementations with fences")
  5ce6c1f3535fa8 ("riscv/atomic: Strengthen implementations with fences")

(the latest _draft_ of the RISC-V specification, as pointed out by Daniel,

  https://github.com/riscv/riscv-isa-manual, Appendix A.5

 includes our "Linux mapping", although the currently-recommended mapping
 differs and involves a "fence.tso [+ any acquire, including RCpc .aq]").

My understanding is that your answer to this question is "Yes", but I am
not sure about the "How/Which changes?"; of course, an answer his question
_in the form_ of PATCHes would be appreciated! (but please also consider
that I'll be offline for most of the time until next Monday.)

  Andrea


> 
> Will
