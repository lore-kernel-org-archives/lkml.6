Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23E1C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07D826079
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kJ1i9yNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07D826079
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934566AbeF0OPf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:15:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54462 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeF0OPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:15:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so5991043wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CUu61x+orOtUos0C63QerdxbPAQ+9zVgePFOVkpbqmc=;
        b=kJ1i9yNWErgxt0KSP5kHiQ3Ixxg2sdZ7wBSRBpop6/vp+40F+fFxUmyyBZva0kbJDq
         K+JT1sicsMrJEh7uMeKVtexORIp5QFlstz6SJLFhv9z6N8+veIsKnAbp8V0WiKM8kGAq
         eMKmbUcpHYHW9btfb7vW+V5hTyzYG9sM0aLCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUu61x+orOtUos0C63QerdxbPAQ+9zVgePFOVkpbqmc=;
        b=IKY/Km7G546Ql3y8yOOYYKwHHvLazZt8k1FQTO825tvS9dTRsGb2ZSUlrr8ynpNIZn
         BTFCXdsu/lnrZ7LJJfcR6kwBmECmuRlzL2BoOyOSbwdNWp0f2SEHIpwdQrLLDQO5QyQm
         sEEmHknhiPhYWR4/4JADc5eq0iSiuLoMY38rrXXk4gZ55Cgqm2s8iqvT2PMyYJfGFX2v
         eTvgPwyM+2VV1/DOE8tVCg6z2ddHhL5or11EKsCscFe9mzRGyY5Ls5TC1pLmM/FVxntR
         a7lMRur+b1EDI9fUSTCPoLnvlME39htlZs366uhHOekcjXGglyyvjN7B6Ns0fsXmfn9G
         iM/Q==
X-Gm-Message-State: APt69E1j6mO4A65u7G7hjJJCzDbA9NFByJEzRNt5bhR/ESE9VznAMb+L
        s9BfgCB3EGW4oKU/HIcutZoIfg==
X-Google-Smtp-Source: AAOMgpecX1lSCTXLqojea2Dpxt8udsxfY3ei6gCgEdDeUyY0f8HjetDcp1a42BZ3qYR9A+T9cb1/pw==
X-Received: by 2002:a1c:bf0c:: with SMTP id p12-v6mr4944165wmf.120.1530108930722;
        Wed, 27 Jun 2018 07:15:30 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id p10-v6sm2952277wmc.17.2018.06.27.07.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 07:15:29 -0700 (PDT)
Date:   Wed, 27 Jun 2018 16:15:22 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180627141522.GA10533@andrea>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625123121.GY2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So I'm not actually sure how many people rely on the RCsc transitive
> smp_mb() here. People certainly rely on the RELEASE semantics, and the
> code itself requires the store->load ordering, together that gives us
> the smp_mb() because that's simply the only barrier we have.
> 
> And looking at smp_mb__after_spinlock() again, we really only need the
> RCsc thing for rq->lock, not for the wakeups. The wakeups really only
> need that RCpc RELEASE + store->load thing (which we don't have).
> 
> So yes, smp_mb(), however the below still makes more sense to me, or am
> I just being obtuse again?

While trying to integrate these remarks into v1 and looking again at the
comment before smp_mb__after_spinlock(), I remembered a discussion where
Boqun suggested some improvements for this comment: so I wrote the commit
reported at the end of this email.

This raises the following two issues:

 1) First, the problem of integrating the resulting comment into v1,
    where I've been talking about _full_ barriers associated to the
    wakeups fuctions but where these are actually implemented as:
    
       spin_lock(s);
       smp_mb__after_spinlock();

 2) Second, the problem of formalizing the requirements described in
    that comment (remark: informally, the LKMM currently states that
    the sequence "spin_lock(s); smp_mb__after_spinlock();" generates
    a full barrier; in particular, this sequence orders
    
       {STORE,LOAD} -> {STORE,LOAD}

    according to the current LKMM).

For (1), I could simply replace each occurrence of "executes a full memory
barrier" with "execute the sequence spin_lock(s); smp_mb__after_spinlock()";
I haven't really thought about (2) yet, but please notice that something as
simple as

   let mb = [...]  |
            ([W] ; po? ; [LKW] ; fencerel(After-spinlock) ; [R])

would _not_ guarantee "RCsc transitivity" ...

A different approach (that could solve both problems at once) would be to
follow the current formalization in LKMM and to modify the comment before
smp_mb__after_spinlock() accordingly (say, informally, "it's required that
that spin_lock(); smp_mb__after_spinlock() provides a full barrier").

Thoughts?

  Andrea

From c3648d5022bedcd356198efa65703e01541cbd3f Mon Sep 17 00:00:00 2001
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Date: Wed, 27 Jun 2018 10:53:30 +0200
Subject: [PATCH 2/3] locking: Fix comment for smp_mb__after_spinlock()

Boqun reported that the snippet described in the header comment for
smp_mb__after_spinlock() can be misleading, because acquire/release
chains already provide us with the underlying guarantee (due to the
A-cumulativity of release).

This commit fixes the comment following Boqun's example in [1].

It's worth noting here that LKMM maintainers are currently actively
debating whether to enforce RCsc transitivity of locking operations
"by definition" [2]; should the guarantee be enforced in the future,
the requirement for smp_mb__after_spinlock() could be simplified to
include only the STORE->LOAD ordering requirement.

[1] http://lkml.kernel.org/r/20180312085600.aczjkpn73axzs2sb@tardis
[2] http://lkml.kernel.org/r/Pine.LNX.4.44L0.1711271553490.1424-100000@iolanthe.rowland.org
    http://lkml.kernel.org/r/Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org

Reported-and-Suggested-by: Boqun Feng <<boqun.feng@gmail.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
---
 include/linux/spinlock.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1e8a464358384..c74828fe8d75c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -121,22 +121,22 @@ do {								\
  *
  *   - it must ensure the critical section is RCsc.
  *
- * The latter is important for cases where we observe values written by other
- * CPUs in spin-loops, without barriers, while being subject to scheduling.
+ * The latter requirement guarantees that stores from two critical sections
+ * in different CPUs are ordered even outside the critical sections.  As an
+ * example illustrating this property, consider the following snippet:
  *
- * CPU0			CPU1			CPU2
+ * CPU0			CPU1				CPU2
  *
- *			for (;;) {
- *			  if (READ_ONCE(X))
- *			    break;
- *			}
- * X=1
- *			<sched-out>
- *						<sched-in>
- *						r = X;
+ * spin_lock(s);	spin_lock(s);			r2 = READ_ONCE(Y);
+ * WRITE_ONCE(X, 1);	smp_mb__after_spinlock();	smp_rmb();
+ * spin_unlock(s);	r1 = READ_ONCE(X);		r3 = READ_ONCE(X);
+ *			WRITE_ONCE(Y, 1);
+ *			spin_unlock(s);
  *
- * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
- * we get migrated and CPU2 sees X==0.
+ * Without RCsc transitivity, it is allowed that CPU0's critical section
+ * precedes CPU1's critical section (r1=1) and that CPU2 observes CPU1's
+ * store to Y (r2=1) while it does not observe CPU0's store to X (r3=0),
+ * despite the presence of the smp_rmb().
  *
  * Since most load-store architectures implement ACQUIRE with an smp_mb() after
  * the LL/SC loop, they need no further barriers. Similarly all our TSO
-- 
2.7.4

