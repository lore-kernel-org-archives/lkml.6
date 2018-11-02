Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F700C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB47020831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IWB/SPtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB47020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeKBPVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:21:24 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43579 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbeKBPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:21:23 -0400
Received: by mail-pf1-f173.google.com with SMTP id h4-v6so517278pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ckz429BTphdL9ntHQ0KzdWmQlyjNehXE327QwgpOKRs=;
        b=IWB/SPtMGm6LiHtU4WZW95xTNhnVl7O8Ww859ffvPUH54j19QbdIb5NmRaSysew0fK
         KED5wWuNbhrmjzUQFcZNNW7vURjwbuIdNgf7nkpENQrFEY6qvQW8N010A/CfvP8HeL6G
         Y9a3Iv7fCM16QEZXIh5RjYum1V5D4I1Mbxgy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ckz429BTphdL9ntHQ0KzdWmQlyjNehXE327QwgpOKRs=;
        b=S35jB5rQan4C8jHX9yryj1B/nsCtQ6A4Dzr4U2VWhf0XvgfFwha6/UT1mKV4+OdLWR
         CP5fQ8bdBPFNLHiiD626pyR9He+S062AO4l00CSDWrPhOR0lA3smBEAV3vNfBAObL8ie
         tNmNzxOC3aWlC2uQLYzgVIEaQwcCIC0B+XZqwD4ADxsqj1m/IvP+kZLVxSWH/BSV7XJ7
         zO2Ter14F8L6SAnlQTKTo41i1fzrOVeHez75VD9Ms+Otc02WTGMqY41L+xtbZU4c96WK
         ZXI/baDy+lz6z1WAAib18YPTbUZmet6yphcDllvgfvooXloQruOxjjrYJJ4NC+8qTXg1
         tiAQ==
X-Gm-Message-State: AGRZ1gL9IQacfDIbp5hX5LOhDAdk5Yg7DEvwtZ04uJIHMpUwuo5nQuQI
        Gn3TPcpbU5wkUAO4HyPwXvDfpf3uq+g=
X-Google-Smtp-Source: AJdET5dq3IKF9/rI4Rkz5xCLstcc7lBeZi93qYxPIauo1Hg/pe7v9SE+qLgIkcZRviJxrw4tdpzPeQ==
X-Received: by 2002:a62:5cc4:: with SMTP id q187-v6mr10534731pfb.47.1541139321386;
        Thu, 01 Nov 2018 23:15:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id s14-v6sm17925534pgk.39.2018.11.01.23.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 23:15:20 -0700 (PDT)
Date:   Thu, 1 Nov 2018 23:15:18 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Message-ID: <20181102061518.GA22191@google.com>
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
 <20181031011119.GF224709@google.com>
 <20181031181748.GG4170@linux.ibm.com>
 <20181101050019.GA45865@google.com>
 <20181101161307.GO4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101161307.GO4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 09:13:07AM -0700, Paul E. McKenney wrote:
> > > > BTW I do want to discuss about this smp_mb patch above with you at LPC if you
> > > > had time, even though we are removing it from the documentation. I thought
> > > > about it a few times, and I was not able to fully appreciate the need for the
> > > > barrier (that is even assuming that complete() etc did not do the right
> > > > thing).  Specifically I was wondering same thing Peter said in the above
> > > > thread I think that - if that rcu_read_unlock() triggered all the spin
> > > > locking up the tree of nodes, then why is that locking not sufficient to
> > > > prevent reads from the read-side section from bleeding out? That would
> > > > prevent the reader that just unlocked from seeing anything that happens
> > > > _after_ the synchronize_rcu.
> > > 
> > > Actually, I recall an smp_mb() being added, but am not seeing it anywhere
> > > relevant to wait_for_completion().  So I might need to add the smp_mb()
> > > to synchronize_rcu() and remove the patch (retaining the typo fix).  :-/
> > 
> > No problem, I'm glad atleast the patch resurfaced the topic of the potential
> > issue :-)
> 
> And an smp_mb() is needed in Tree RCU's __wait_rcu_gp().  This is
> because wait_for_completion() might get a "fly-by" wakeup, which would
> mean no ordering for code naively thinking that it was ordered after a
> grace period.

Makes sense.

> > > The short form answer is that anything before a grace period on any CPU
> > > must be seen by any CPU as being before anything on any CPU after that
> > > same grace period.  This guarantee requires a rather big hammer.
> > > 
> > > But yes, let's talk at LPC!
> > 
> > Sounds great, looking forward to discussing this.
> 
> Would it make sense to have an RCU-implementation BoF?

Yes, I would very much like that. I also spoke with my colleage Daniel
Colascione and he said he would be interested too.

I think it would make sense also to combine it with other memory-ordering
topics like the memory model and rseq/cpu-opv things that Mathieu was doing
(if it makes sense to combine). But yes, I am definitely interested in an
RCU-implementation BoF session.

> > > > Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> > > > me that the RCU reader-sections are virtually extended both forward and
> > > > backward and whereever it ends, those paths do heavy-weight synchronization
> > > > that should be sufficient to prevent memory ordering issues (such as those
> > > > you mentioned in the Requierments document). That is exactly why we don't
> > > > need explicit barriers during rcu_read_unlock. If I recall I asked you why
> > > > those are not needed. So that answer made sense, but then now on going
> > > > through the 'Memory Ordering' document, I see that you mentioned there is
> > > > reliance on the locking. Is that reliance on locking necessary to maintain
> > > > ordering then?
> > > 
> > > There is a "network" of locking augmented by smp_mb__after_unlock_lock()
> > > that implements the all-to-all memory ordering mentioned above.  But it
> > > also needs to handle all the possible complete()/wait_for_completion()
> > > races, even those assisted by hypervisor vCPU preemption.
> > 
> > I see, so it sounds like the lock network is just a partial solution. For
> > some reason I thought before that complete() was even called on the CPU
> > executing the callback, all the CPUs would have acquired and released a lock
> > in the "lock network" atleast once thus ensuring the ordering (due to the
> > fact that the quiescent state reporting has to travel up the tree starting
> > from the leaves), but I think that's not necessarily true so I see your point
> > now.
> 
> There is indeed a lock that is unconditionally acquired and released by
> wait_for_completion(), but it lacks the smp_mb__after_unlock_lock() that
> is required to get full-up any-to-any ordering.  And unfortunate timing
> (as well as spurious wakeups) allow the interaction to have only normal
> lock-release/acquire ordering, which does not suffice in all cases.
> 
> SRCU and expedited RCU grace periods handle this correctly.  Only the
> normal grace periods are missing the needed barrier.  The probability of
> failure is extremely low in the common case, which involves all sorts
> of synchronization on the wakeup path.  It would be quite strange (but
> not impossible) for the wait_for_completion() exit path to -not- to do
> a full wakeup.  Plus the bug requires a reader before the grace period
> to do a store to some location that post-grace-period code loads from.
> Which is a very rare use case.
> 
> But it still should be fixed.  ;-)
> 
> > Did you feel this will violate condition 1. or condition 2. in "Memory-Barrier
> > Guarantees"? Or both?
> > https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Memory-Barrier%20Guarantees
> 
> Condition 1.  There might be some strange combination of events that
> could also cause it to also violate condition 2, but I am not immediately
> seeing it.

In the previous paragraph, you mentioned the bug "requires a reader before
the GP to do a store". However, condition 1 is really different - it is a
reader holding a reference to a pointer that is used *after* the
synchronize_rcu returns. So that reader's load of the pointer should have
completed by the time GP ends, otherwise the reader can look at kfree'd data.
That's different right?

For condition 2, I analyzed it below, let me know what you think:

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit bf3c11b7b9789283f993d9beb80caaabc4403916
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Thu Nov 1 09:05:02 2018 -0700
> 
>     rcu: Add full memory barrier in __wait_rcu_gp()
>     
>     RCU grace periods have extremely strong any-to-any ordering
>     requirements that are met by placing full barriers in various places
>     in the grace-period computation.  However, normal grace period requests
>     might be subjected to a "fly-by" wakeup in which the requesting process
>     doesn't actually sleep and in which the corresponding CPU is not yet
>     aware that the grace period has ended.  In this case, loads in the code
>     immediately following the synchronize_rcu() call might potentially see
>     values before stores preceding the grace period on other CPUs.
>     
>     This is an unusual use case, because RCU readers normally read.  However,
>     they can do writes, and if they do, we need post-grace-period reads to
>     see those writes.
>     
>     This commit therefore adds an smp_mb() to the end of __wait_rcu_gp().
>     
>     Many thanks to Joel Fernandes for the series of questions leading to me
>     realizing that this bug exists!
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 1971869c4072..74020b558216 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -360,6 +360,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
>  			wait_for_completion(&rs_array[i].completion);
>  		destroy_rcu_head_on_stack(&rs_array[i].head);
>  	}
> +	smp_mb(); /* Provide ordering in case of fly-by wakeup. */
>  }
>  EXPORT_SYMBOL_GPL(__wait_rcu_gp);
>  

The fix looks fine to me. Thanks.

If I understand correctly the wait_for_completion() is an ACQUIRE operation,
and the complete() is a RELEASE operation aka the "MP pattern". The
ACQUIRE/RELEASE semantics allow any writes that happened before the ACQUIRE
to get ordered after it. So that would actually imply it is not strong enough
for ordering purposes during a "fly-by" wake up scenario and would be a
violation of CONDITION 2, I think (not only condition 1 as you said).  This
is because future readers may accidentally see the writes that happened
*before* the synchronize_rcu which is CONDITION 2 in the requirements:
https://goo.gl/8mrDHN  (I had to shortlink it ;))

Cheers,

- Joel
