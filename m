Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43925C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BEC20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KyYIqhRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BEC20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeKCHX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:23:28 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:41732 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:23:28 -0400
Received: by mail-pg1-f182.google.com with SMTP id k13so1541900pga.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gbPc+WDYcHmcG0BS2O1Hg5yDqoE6lYVMfinsv+wlGuo=;
        b=KyYIqhRTpDlJOxquIgJaJ3ZZ+UBP5hy25HyNo0qZ1oLa/Hhpp1m0qsuCyDOghfBFVJ
         MlT/aEt4wec5Ko+wYfJdVhNswqFglMi7h6j7moaQ4/2EgOPHw9OXF5EinDWNSNLpzm9J
         m5bqHV7PpCC6uV/k70V6NzQ/Cjz65Ga4GdIaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gbPc+WDYcHmcG0BS2O1Hg5yDqoE6lYVMfinsv+wlGuo=;
        b=c4ZFep3WZA0/ZRASt8UEulavJuySl3iTeT/dFbp7GA9L1AU1x2LL1kfOFr8gExwv9+
         hWQ7zxwlUNqcBd2EPnOHlhju0j+gUAaXvgPgxhJ4WGjRetGiI1e4w0MOO267Xap2+MLA
         2Xw0iKv6NkEp80iMpbla+Jh+6OaPXjfmg4x3nDv4q5f7TmUM96TfeAbGNYP3mLdRe54O
         6q8PTAFe2okoRd42/MPneXKwEcj2d8QbYe4O4cfCTZ9BVfLFprrPCS9KIuY815sNICIy
         aLGeHbA1AsIoibaEeox5t/4lsipybfh1P+Cgpl94cVwnxyahWWtFYjRmw0Q/Nd+5n/NA
         zzgg==
X-Gm-Message-State: AGRZ1gKhQhxTiCkQHtxXgSVgmryYEgh5I9J1XU4785zUA+6jVzzyXH+n
        l0Q3ydYW0kFKxeFa+BkEvKmDgudqkKA=
X-Google-Smtp-Source: AJdET5dJSukifff12wwOU3lXS6BOK0P3Um7n/3Tics9gTk7OuOK/8fJ0ydtsMiUrdEqj/Cf6i/7iJA==
X-Received: by 2002:a65:64d5:: with SMTP id t21-v6mr12706474pgv.428.1541196872451;
        Fri, 02 Nov 2018 15:14:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id j187-v6sm45910992pfc.39.2018.11.02.15.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 15:14:31 -0700 (PDT)
Date:   Fri, 2 Nov 2018 15:14:29 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Message-ID: <20181102221429.GB99294@google.com>
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
 <20181031011119.GF224709@google.com>
 <20181031181748.GG4170@linux.ibm.com>
 <20181101050019.GA45865@google.com>
 <20181101161307.GO4170@linux.ibm.com>
 <20181102061518.GA22191@google.com>
 <20181102200000.GC4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102200000.GC4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 01:00:00PM -0700, Paul E. McKenney wrote:
[..] 
> > I think it would make sense also to combine it with other memory-ordering
> > topics like the memory model and rseq/cpu-opv things that Mathieu was doing
> > (if it makes sense to combine). But yes, I am definitely interested in an
> > RCU-implementation BoF session.
> 
> There is an LKMM kernel summit track presentation.  I believe that
> Mathieu's rseq/cpu-opv would be a good one as well, but Mathieu needs
> to lead this up and it should be a separate BoF.  Please do feel free
> to reach out to him.  I am sure that he would be particularly interested
> in potential uses of rseq and especially cpu-opv.

Cool! Looking forward to LKMM talk and I'll keep in mind to reach out to
Mathieu about rseq usecases.

> > > > > > Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> > > > > > me that the RCU reader-sections are virtually extended both forward and
> > > > > > backward and whereever it ends, those paths do heavy-weight synchronization
> > > > > > that should be sufficient to prevent memory ordering issues (such as those
> > > > > > you mentioned in the Requierments document). That is exactly why we don't
> > > > > > need explicit barriers during rcu_read_unlock. If I recall I asked you why
> > > > > > those are not needed. So that answer made sense, but then now on going
> > > > > > through the 'Memory Ordering' document, I see that you mentioned there is
> > > > > > reliance on the locking. Is that reliance on locking necessary to maintain
> > > > > > ordering then?
> > > > > 
> > > > > There is a "network" of locking augmented by smp_mb__after_unlock_lock()
> > > > > that implements the all-to-all memory ordering mentioned above.  But it
> > > > > also needs to handle all the possible complete()/wait_for_completion()
> > > > > races, even those assisted by hypervisor vCPU preemption.
> > > > 
> > > > I see, so it sounds like the lock network is just a partial solution. For
> > > > some reason I thought before that complete() was even called on the CPU
> > > > executing the callback, all the CPUs would have acquired and released a lock
> > > > in the "lock network" atleast once thus ensuring the ordering (due to the
> > > > fact that the quiescent state reporting has to travel up the tree starting
> > > > from the leaves), but I think that's not necessarily true so I see your point
> > > > now.
> > > 
> > > There is indeed a lock that is unconditionally acquired and released by
> > > wait_for_completion(), but it lacks the smp_mb__after_unlock_lock() that
> > > is required to get full-up any-to-any ordering.  And unfortunate timing
> > > (as well as spurious wakeups) allow the interaction to have only normal
> > > lock-release/acquire ordering, which does not suffice in all cases.
> > > 
> > > SRCU and expedited RCU grace periods handle this correctly.  Only the
> > > normal grace periods are missing the needed barrier.  The probability of
> > > failure is extremely low in the common case, which involves all sorts
> > > of synchronization on the wakeup path.  It would be quite strange (but
> > > not impossible) for the wait_for_completion() exit path to -not- to do
> > > a full wakeup.  Plus the bug requires a reader before the grace period
> > > to do a store to some location that post-grace-period code loads from.
> > > Which is a very rare use case.
> > > 
> > > But it still should be fixed.  ;-)
> > > 
> > > > Did you feel this will violate condition 1. or condition 2. in "Memory-Barrier
> > > > Guarantees"? Or both?
> > > > https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Memory-Barrier%20Guarantees
> > > 
> > > Condition 1.  There might be some strange combination of events that
> > > could also cause it to also violate condition 2, but I am not immediately
> > > seeing it.
> > 
> > In the previous paragraph, you mentioned the bug "requires a reader before
> > the GP to do a store". However, condition 1 is really different - it is a
> > reader holding a reference to a pointer that is used *after* the
> > synchronize_rcu returns. So that reader's load of the pointer should have
> > completed by the time GP ends, otherwise the reader can look at kfree'd data.
> > That's different right?
> 
> More specifically, the fix prevents a prior reader's -store- within its
> critical section to be seen as happening after a load that follows the
> end of the grace period.  So I stand by Condition 1.  ;-)
> And again, a store within an RCU read-side critical section is a bit
> on the strange side, but this sort of thing is perfectly legal and
> is used, albeit rather rarely.

Cool :) I never thought about condition 1 this way but good to know that's
possible :)

> > For condition 2, I analyzed it below, let me know what you think:
> > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit bf3c11b7b9789283f993d9beb80caaabc4403916
> > > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > > Date:   Thu Nov 1 09:05:02 2018 -0700
> > > 
> > >     rcu: Add full memory barrier in __wait_rcu_gp()
> > >     
> > >     RCU grace periods have extremely strong any-to-any ordering
> > >     requirements that are met by placing full barriers in various places
> > >     in the grace-period computation.  However, normal grace period requests
> > >     might be subjected to a "fly-by" wakeup in which the requesting process
> > >     doesn't actually sleep and in which the corresponding CPU is not yet
> > >     aware that the grace period has ended.  In this case, loads in the code
> > >     immediately following the synchronize_rcu() call might potentially see
> > >     values before stores preceding the grace period on other CPUs.
> > >     
> > >     This is an unusual use case, because RCU readers normally read.  However,
> > >     they can do writes, and if they do, we need post-grace-period reads to
> > >     see those writes.
> > >     
> > >     This commit therefore adds an smp_mb() to the end of __wait_rcu_gp().
> > >     
> > >     Many thanks to Joel Fernandes for the series of questions leading to me
> > >     realizing that this bug exists!
> > >     
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > 
> > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > index 1971869c4072..74020b558216 100644
> > > --- a/kernel/rcu/update.c
> > > +++ b/kernel/rcu/update.c
> > > @@ -360,6 +360,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
> > >  			wait_for_completion(&rs_array[i].completion);
> > >  		destroy_rcu_head_on_stack(&rs_array[i].head);
> > >  	}
> > > +	smp_mb(); /* Provide ordering in case of fly-by wakeup. */
> > >  }
> > >  EXPORT_SYMBOL_GPL(__wait_rcu_gp);
> > >  
https://cs.corp.google.com/piper///depot/google3/base/percpu.cc?type=cs&q=%22rseq%22+restart&sq=package:piper+file://depot/google3+-file:google3/experimental&g=0&l=247> > 
> > The fix looks fine to me. Thanks.
> > 
> > If I understand correctly the wait_for_completion() is an ACQUIRE operation,
> > and the complete() is a RELEASE operation aka the "MP pattern". The
> > ACQUIRE/RELEASE semantics allow any writes that happened before the ACQUIRE
> > to get ordered after it. So that would actually imply it is not strong enough
> > for ordering purposes during a "fly-by" wake up scenario and would be a
> > violation of CONDITION 2, I think (not only condition 1 as you said).  This
> > is because future readers may accidentally see the writes that happened
> > *before* the synchronize_rcu which is CONDITION 2 in the requirements:
> > https://goo.gl/8mrDHN  (I had to shortlink it ;))
> 
> I do appreciate the shorter link.  ;-)
> 
> A write happening before the grace period is ordered by the grace period's
> network of strong barriers, so the fix does not matter in that case.

I was talking about the acquire/release pairs in the calls to spin_lock and
spin_unlock in wait_for_completion, not in the grace period network of rnp locks.
Does that make sense?

I thought that during a "fly-by" wake up, that network of strong barriers
doesn't really trigger and that that's the problematic scenario. Did I miss
something?  I was talking about the acquire/release pair in
wait_for_completion during that fly-by scenario.

> Also, the exact end of the grace period is irrelevant for Condition 2,
> it is instead the beginning of the grace period compared to the beginning
> of later RCU read-side critical sections.
> 
> Not saying that Condition 2 cannot somehow happen without the memory
> barrier, just saying that it will take quite a bit more creativity to
> find a relevant scenario.
> 
> Please see below for the updated patch, containing only the typo fix.
> Please let me know if I messed anything up.

Looks good to me, thanks!

 - Joel


