Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F45C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DDF208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H9tdzDSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DDF208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbeGKMii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:38:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40061 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbeGKMii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:38:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so17998998wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vy/znrlxEfUXuHHbItneU72QjqNItQdIxpXDzdHF0tk=;
        b=H9tdzDSXdyTiXzS3ezo7QjsEwRQANAKgVUYFHwwCS2ZXTB/CpLUz7LxtAMRCHameWC
         RcxEqhYbWPbPe843STBhSQj0Dp2Wf0uQ7cIlE5U7EP3jW8zVAC0akcuZt3qlRDil2EtS
         N0jvQw4Au1h0opgHtKdFChnQAsbuvE5ny5Iig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vy/znrlxEfUXuHHbItneU72QjqNItQdIxpXDzdHF0tk=;
        b=ibCE7JJbmFkxaT1HKQiXo1oHuAXU+B232Awdx9aYSwsm1kcsn+9bqLk8wA0/dUMvYm
         8DlzYjVfUv3v/C0Bm7Ubuq37rsCoo1nbhlIJVJc5ktrS2ePs+a+f/mm/XGLDJqQIH6jg
         xFXp9tisWPZ72+ASzK3Ubm5CNU1lN5AEMx8uGkaCirQ3uiZQRJygCw/lor5m3YAH+2vy
         3AwgXNiTKyLGXTj3Cgtb8104lmIBZE5338spVc5N7wCG+PDkQJeUsHWg4jZCHpl67rcT
         R8IrFhuRxVququ+8gNzOVJJEBQj8lZFwp2dY9N14nlIQJYiCbcBe8dDDLiVZu+mGlUDx
         jnsA==
X-Gm-Message-State: APt69E2NX5fSqjJo5H8+zrePDkbOZupuzqO5BHPFq71hwR53B3pq1m/v
        I4v2BF9Wz55h2J5yM9UpyCX0TQ==
X-Google-Smtp-Source: AAOMgpc90ju3wXX/ydcPJBrmXEI5J/kuTHxBHk83+YJrEHWf/pblPGJYINXj3iU4gR370CjxCexH5g==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr19454699wro.263.1531312468306;
        Wed, 11 Jul 2018 05:34:28 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r17-v6sm18961118wrt.44.2018.07.11.05.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:34:27 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:34:21 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711123421.GA9673@andrea>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711094310.GA13963@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:43:11AM +0100, Will Deacon wrote:
> On Tue, Jul 10, 2018 at 11:38:21AM +0200, Andrea Parri wrote:
> > On Mon, Jul 09, 2018 at 04:01:57PM -0400, Alan Stern wrote:
> > > More than one kernel developer has expressed the opinion that the LKMM
> > > should enforce ordering of writes by locking.  In other words, given
> > 
> > I'd like to step back on this point: I still don't have a strong opinion
> > on this, but all this debating made me curious about others' opinion ;-)
> > I'd like to see the above argument expanded: what's the rationale behind
> > that opinion? can we maybe add references to actual code relying on that
> > ordering? other that I've been missing?
> > 
> > I'd extend these same questions to the "ordering of reads" snippet below
> > (and discussed since so long...).
> > 
> > 
> > > the following code:
> > > 
> > > 	WRITE_ONCE(x, 1);
> > > 	spin_unlock(&s):
> > > 	spin_lock(&s);
> > > 	WRITE_ONCE(y, 1);
> > > 
> > > the stores to x and y should be propagated in order to all other CPUs,
> > > even though those other CPUs might not access the lock s.  In terms of
> > > the memory model, this means expanding the cumul-fence relation.
> > > 
> > > Locks should also provide read-read (and read-write) ordering in a
> > > similar way.  Given:
> > > 
> > > 	READ_ONCE(x);
> > > 	spin_unlock(&s);
> > > 	spin_lock(&s);
> > > 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> > > 
> > > the load of x should be executed before the load of (or store to) y.
> > > The LKMM already provides this ordering, but it provides it even in
> > > the case where the two accesses are separated by a release/acquire
> > > pair of fences rather than unlock/lock.  This would prevent
> > > architectures from using weakly ordered implementations of release and
> > > acquire, which seems like an unnecessary restriction.  The patch
> > > therefore removes the ordering requirement from the LKMM for that
> > > case.
> > 
> > IIUC, the same argument could be used to support the removal of the new
> > unlock-rf-lock-po (we already discussed riscv .aq/.rl, it doesn't seem
> > hard to imagine an arm64 LDAPR-exclusive, or the adoption of ctrl+isync
> > on powerpc).  Why are we effectively preventing their adoption?  Again,
> > I'd like to see more details about the underlying motivations...
> > 
> > 
> > > 
> > > All the architectures supported by the Linux kernel (including RISC-V)
> > > do provide this ordering for locks, albeit for varying reasons.
> > > Therefore this patch changes the model in accordance with the
> > > developers' wishes.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > ---
> > > 
> > > v.2: Restrict the ordering to lock operations, not general release
> > > and acquire fences.
> > 
> > This is another controversial point, and one that makes me shivering ...
> > 
> > I have the impression that we're dismissing the suggestion "RMW-acquire
> > at par with LKR" with a bit of rush.  So, this patch is implying that:
> > 
> > 	while (cmpxchg_acquire(&s, 0, 1) != 0)
> > 		cpu_relax();
> > 
> > is _not_ a valid implementation of spin_lock()! or, at least, it is not
> > when paired with an smp_store_release(). Will was anticipating inserting
> > arch hooks into the (generic) qspinlock code,  when we know that similar
> > patterns are spread all over in (q)rwlocks, mutexes, rwsem, ... (please
> > also notice that the informal documentation is currently treating these
> > synchronization mechanisms equally as far as "ordering" is concerned...).
> > 
> > This distinction between locking operations and "other acquires" appears
> > to me not only unmotivated but also extremely _fragile (difficult to use
> > /maintain) when considering the analysis of synchronization mechanisms
> > such as those mentioned above or their porting for new arch.
> 
> The main reason for this is because developers use spinlocks all of the
> time, including in drivers. It's less common to use explicit atomics and
> extremely rare to use explicit acquire/release operations. So let's make
> locks as easy to use as possible, by giving them the strongest semantics
> that we can whilst remaining a good fit for the instructions that are
> provided by the architectures we support.

Simplicity is the eye of the beholder.  From my POV (LKMM maintainer), the
simplest solution would be to get rid of rfi-rel-acq and unlock-rf-lock-po
(or its analogous in v3) all together:

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 59b5cbe6b6240..bc413a6839a2d 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -38,7 +38,6 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -60,7 +59,7 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi) | rfi-rel-acq
+let to-r = addr | (dep ; rfi)
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
 let ppo = to-r | to-w | fence

Among other things, this would immediately:

  1) Enable RISC-V to use their .aq/.rl annotations _without_ having to
     "worry" about tso or release/acquire fences; IOW, this will permit
     a partial revert of:

       0123f4d76ca6 ("riscv/spinlock: Strengthen implementations with fences")
       5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")

  2) Resolve the above mentioned controversy (the inconsistency between
     - locking operations and atomic RMWs on one side, and their actual
     implementation in generic code on the other), thus enabling the use
     of LKMM _and_ its tools for the analysis/reviewing of the latter.


> 
> If you want to extend this to atomic rmws, go for it, but I don't think
> it's nearly as important and there will still be ways to implement locks
> with insufficient ordering guarantees if you want to.

I don't want to "implement locks with insufficient ordering guarantees"
(w.r.t. LKMM).  ;-)

  Andrea


> 
> Will
