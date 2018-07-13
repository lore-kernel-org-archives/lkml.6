Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC7C2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UBR5ZlFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC7C2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeGMJVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:21:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43810 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeGMJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:21:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so24390911wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YydtLuK4IEZhkeWGqWCZw9Fb7OUA90PTwqHxFuVTfQ=;
        b=UBR5ZlFNbb0Vz+Y3G2yA1C0HsfcaN4SLwH/cdcRQ1SUL6+M3ETDuqi0gQOCL5OPtlV
         w8zG2BTkZa2XHVfWWj6dAFRiM1RWoP3eeSk5DcnyDpkZn3LtuvRfYN2R592gYVSyfFoE
         E+/0zN33cLHZMAdWaS3pKeZAvZ+C1GAOGqEM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YydtLuK4IEZhkeWGqWCZw9Fb7OUA90PTwqHxFuVTfQ=;
        b=a8qYnX8e4i1aT8/94o1LGJPNFxVWk4QdTzwD5/6EOiASVnP/l+8tDV0DxgcGfqNS/H
         0EU4qVbOoKjwKFaPmZbY5Gb42YyPMoHwfleXYdEb4m2UOp2IAKim1AealfB/+GSSpgJn
         vJzlf6/Auc+zqdN2i3K/muomKhpUQbCfu4OBSwI/wCZ65olX1AEkZQNsjisr80b0OqU+
         J6l+I6bpXccnWuowJcDvM6oqDvcN3RGl6y6Pq8JJXQJI0f9Twzxe9IEsiYgR+yVUmRVV
         GDqOqZDX9kocHQvFBagdAFPVXtUvrioqkXPbjleBeNVkyVYXe6LkjVEqJadUnQdw/5h0
         89vw==
X-Gm-Message-State: AOUpUlHpG0B451wCvcbKxOlSS1FxGT6oNDHwVjQwTlkOK5dhoLLm3IAA
        hJcpp/eC1EbxIU0aZr+686rVpw==
X-Google-Smtp-Source: AAOMgpc4q5Lsv/PsyWYuQFFGFhofsZDb9cbtshyg/TuG2sVj0E5yXsd7shg95hfNX1WKDAWTry84Vw==
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr4490246wri.139.1531472837821;
        Fri, 13 Jul 2018 02:07:17 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id t13-v6sm16591184wrr.74.2018.07.13.02.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 02:07:17 -0700 (PDT)
Date:   Fri, 13 Jul 2018 11:07:11 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Daniel Lustig <dlustig@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180713090637.GA10601@andrea>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 07:05:39PM -0700, Daniel Lustig wrote:
> On 7/12/2018 11:10 AM, Linus Torvalds wrote:
> > On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> The locking pattern is fairly simple and shows where RCpc comes apart
> >> from expectation real nice.
> > 
> > So who does RCpc right now for the unlock-lock sequence? Somebody
> > mentioned powerpc. Anybody else?
> > 
> > How nasty would be be to make powerpc conform? I will always advocate
> > tighter locking and ordering rules over looser ones..
> > 
> >             Linus
> 
> RISC-V probably would have been RCpc if we weren't having this discussion.
> Depending on how we map atomics/acquire/release/unlock/lock, we can end up
> producing RCpc, "RCtso" (feel free to find a better name here...), or RCsc
> behaviors, and we're trying to figure out which we actually need.
> 
> I think the debate is this:
> 
> Obviously programmers would prefer just to have RCsc and not have to figure out
> all the complexity of the other options.  On x86 or architectures with native
> RCsc operations (like ARMv8), that's generally easy enough to get.
> 
> For weakly-ordered architectures that use fences for ordering (including
> PowerPC and sometimes RISC-V, see below), though, it takes extra fences to go
> from RCpc to either "RCtso" or RCsc.  People using these architectures are
> concerned about whether there's a negative performance impact from those extra
> fences.
> 
> However, some scheduler code, some RCU code, and probably some other examples
> already implicitly or explicitly assume unlock()/lock() provides stronger
> ordering than RCpc.  So, we have to decide whether to:
> 1) define unlock()/lock() to enforce "RCtso" or RCsc, insert more fences on
> PowerPC and RISC-V accordingly, and probably negatively regress PowerPC
> 2) leave unlock()/lock() as enforcing only RCpc, fix any code that currently
> assumes something stronger than RCpc is being provided, and hope people don't
> get it wrong in the future
> 3) some mixture like having unlock()/lock() be "RCtso" but smp_store_release()/
> smp_cond_load_acquire() be only RCpc
> 
> Also, FWIW, if other weakly-ordered architectures come along in the future and
> also use any kind of lightweight fence rather than native RCsc operations,
> they'll likely be in the same boat as RISC-V and Power here, in the sense of
> not providing RCsc by default either.
> 
> Is that a fair assessment everyone?

It's for me, thank you!  And as we've seen, there are arguments for each of
the above three choices.  I'm afraid that (despite Linus's statement  ;-)),
my preference would currently go to (2).


> 
> 
> 
> I can also not-so-briefly summarize RISC-V's status here, since I think there's
> been a bunch of confusion about where we're coming from:
> 
> First of all, I promise we're not trying to start a fight about all this :)
> We're trying to understand the LKMM requirements so we know what instructions
> to use.
> 
> With that, the easy case: RISC-V is RCsc if we use AMOs or load-reserved/
> store-conditional, all of which have RCsc .aq and .rl bits:
> 
>   (a) ...
>   amoswap.w.rl x0, x0, [lock]  // unlock()
>   ...
> loop:
>   amoswap.w.aq a0, t1, [lock]  // lock()
>   bnez a0, loop                // lock()
>   (b) ...
> 
> (a) is ordered before (b) here, regardless of (a) and (b).  Likewise for our
> load-reserved/store-conditional instructions, which also have .aq and rl.
> That's similiar to how ARM behaves, and is no problem.  We're happy with that
> too.
> 
> Unfortunately, we don't (currently?) have plain load-acquire or store-release
> opcodes in the ISA.  (That's a different discussion...)  For those, we need
> fences instead.  And that's where it gets messier.
> 
> RISC-V *would* end up providing only RCpc if we use what I'd argue is the most
> "natural" fence-based mapping for store-release operations, and then pair that
> with LR/SC:
> 
>   (a) ...
>   fence rw,w     // unlock()
>   sw x0, [lock]  // unlock()
>   ...
> loop:
>   lr.w.aq a0, [lock]  // lock()
>   sc.w t1, [lock]     // lock()
>   bnez loop           // lock()
>   (b) ...
> 
> However, if (a) and (b) are loads to different addresses, then (a) is not
> ordered before (b) here. One unpaired RCsc operation is not a full fence.
> Clearly "fence rw,w" is not sufficient if the scheduler, RCU, and elsewhere
> depend on "RCtso" or RCsc.
> 
> RISC-V can get back to "RCtso", matching PowerPC, by using a stronger fence:

Or by using a "fence r,rw" in the lock() (without the .aq), as current code
does  ;-) though I'm not sure how the current solution would compare to the
.tso mapping...

  Andrea


> 
>   (a) ...
>   fence.tso      // unlock(), fence.tso == fence rw,w + fence r,r
>   sw x0, [lock]  // unlock()
>   ...
> loop:
>   lr.w.aq a0, [lock]  // lock()
>   sc.w t1, [lock]     // lock()
>   bnez loop           // lock()
>   (b) ...
> 
> (a) is ordered before (b), unless (a) is a store and (b) is a load to a
> different address.
> 
> (Modeling note: this example is why I asked for Alan's v3 patch over the v2
> patch, which I believe would only have worked if the fence.tso were at the end)
> 
> To get full RCsc here, we'd need a fence rw,rw in between the unlock store and
> the lock load, much like PowerPC would I believe need a heavyweight sync:
> 
>   (a) ...
>   fence rw,w     // unlock()
>   sw x0, [lock]  // unlock()
>   ...
>   fence rw,rw    // can attach either to lock() or to unlock()
>   ...
> loop:
>   lr.w.aq a0, [lock]  // lock()
>   sc.w t1, [lock]     // lock()
>   bnez loop           // lock()
>   (b) ...
> 
> In general, RISC-V's fence.tso will suffice wherever PowerPC's lwsync does, and
> RISC-V's fence rw,rw will suffice wherever PowerPC's full sync does.  If anyone
> is claiming RISC-V is suddenly proposing to go weaker than all the other major
> architectures, that's a mischaracterization.
> 
> All in all: if LKMM wants RCsc, we can do it, but it's not free for RISC-V (or
> Power).  If LKMM wants RCtso, we can do that too, and that's in between.  If
> LKMM wants RCpc, we can do that, and it's the fastest of the bunch.  No I don't
> have concrete numbers either...  And RISC-V implementations are going to vary
> pretty widely anyway.
> 
> Hope that helps.  Please correct anything I screwed up or mischaracterized.
> 
> Dan
