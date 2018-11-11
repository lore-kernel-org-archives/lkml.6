Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA18AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A626F2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="B8OdPjaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626F2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeKLD6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:58:32 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:44859 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeKLD6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:58:32 -0500
Received: by mail-pf1-f179.google.com with SMTP id b81-v6so2671300pfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 10:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgMWYHJGewlEaaFvNqV3WhyncUDrW5qmMNARt3zyqGk=;
        b=B8OdPjaDxVD0kDoKdiZZY6ghLHQoCRDp0n6vEdCxZT0LpCDJvurdPXp3r5/O/NI8rQ
         uyE36H/aiqFJ1WJQ6q8OJWLBu39L/WXjYZ1jMxBkb2guEGnbV/ROtgf5uw/EkO9zQJRa
         NqQec1Y33cNtLWNqxYOg2NvEbcbrV8jf23bD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgMWYHJGewlEaaFvNqV3WhyncUDrW5qmMNARt3zyqGk=;
        b=YLw/Sb6Whz3hq3ZgFN4iB58Bbr76vdKu6w8T6Vfl84eX6MuuJP3dsWNAHU0Uft3/ZZ
         mAJsDE5shmNG61dyozcDirxgzrvyAh/czyHZp0kzzETtzgvaRAIj6HVoQcDcnCw1+iZG
         n/sntW8sFft4EAzZmG/ZicRo0/97069ZVWspFlgaNfMvfl41DyB91FT3zfJmSX+PKwKI
         AFIgwRXgB16LSdGKvj7dyfwt6hokM65Q8ncSXlm+o6aHhnYSiCjTM1XArE9JeD3Mdeab
         W0PC3mQo6cn2OAZhwS4JjcbCQyP65Xv0xMgu9GZ+0RtR3QADwJ8wRz4SkHDV2FoozQpz
         vBcg==
X-Gm-Message-State: AGRZ1gJGsN3rTEtaw0rjYC7EJIHqt96UMUNzgaR1ROb3EXT7xnI5mNHO
        EdgrTFGgWnb4LIh3P7WpzoCxKg==
X-Google-Smtp-Source: AJdET5eF+kExXx0YSYHt9OCr9KlNNJWChDB4UxDnuZUsNvAZ0NI/9s9ifCWKtf6DvaYMsa/VuZUU5w==
X-Received: by 2002:a63:907:: with SMTP id 7-v6mr14617384pgj.121.1541959758142;
        Sun, 11 Nov 2018 10:09:18 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 123sm11442922pgd.75.2018.11.11.10.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 10:09:17 -0800 (PST)
Date:   Sun, 11 Nov 2018 10:09:16 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Message-ID: <20181111180916.GA25327@google.com>
References: <20181110214659.GA96924@google.com>
 <20181110230436.GL4170@linux.ibm.com>
 <20181111030925.GA182908@google.com>
 <20181111042210.GN4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111042210.GN4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 08:22:10PM -0800, Paul E. McKenney wrote:
> On Sat, Nov 10, 2018 at 07:09:25PM -0800, Joel Fernandes wrote:
> > On Sat, Nov 10, 2018 at 03:04:36PM -0800, Paul E. McKenney wrote:
> > > On Sat, Nov 10, 2018 at 01:46:59PM -0800, Joel Fernandes wrote:
> > > > Hi Paul and everyone,
> > > > 
> > > > I was tracing/studying the RCU code today in paul/dev branch and noticed that
> > > > for dyntick-idle CPUs, the RCU GP thread is clearing the rnp->qsmask
> > > > corresponding to the leaf node for the idle CPU, and reporting a QS on their
> > > > behalf.
> > > > 
> > > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 792 0 dti
> > > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 801 2 dti
> > > > rcu_sched-10    [003]    40.008041: rcu_quiescent_state_report: rcu_sched 805 5>0 0 0 3 0
> > > > 
> > > > That's all good but I was wondering if we can do better for the idle CPUs if
> > > > we can some how not set the qsmask of the node in the first place. Then no
> > > > reporting would be needed of quiescent state is needed for idle CPUs right?
> > > > And we would also not need to acquire the rnp lock I think.
> > > > 
> > > > At least for a single node tree RCU system, it seems that would avoid needing
> > > > to acquire the lock without complications. Anyway let me know your thoughts
> > > > and happy to discuss this at the hallways of the LPC as well for folks
> > > > attending :)
> > > 
> > > We could, but that would require consulting the rcu_data structure for
> > > each CPU while initializing the grace period, thus increasing the number
> > > of cache misses during grace-period initialization and also shortly after
> > > for any non-idle CPUs.  This seems backwards on busy systems where each
> > 
> > When I traced, it appears to me that rcu_data structure of a remote CPU was
> > being consulted anyway by the rcu_sched thread. So it seems like such cache
> > miss would happen anyway whether it is during grace-period initialization or
> > during the fqs stage? I guess I'm trying to say, the consultation of remote
> > CPU's rcu_data happens anyway.
> 
> Hmmm...
> 
> The rcu_gp_init() function does access an rcu_data structure, but it is
> that of the current CPU, so shouldn't involve a communications cache miss,
> at least not in the common case.
> 
> Or are you seeing these cross-CPU rcu_data accesses in rcu_gp_fqs() or
> functions that it calls?  In that case, please see below.

Yes, it was rcu_implicit_dynticks_qs called from rcu_gp_fqs.

> > > CPU will with high probability report its own quiescent state before three
> > > jiffies pass, in which case the cache misses on the rcu_data structures
> > > would be wasted motion.
> > 
> > If all the CPUs are busy and reporting their QS themselves, then I think the
> > qsmask is likely 0 so then rcu_implicit_dynticks_qs (called from
> > force_qs_rnp) wouldn't be called and so there would no cache misses on
> > rcu_data right?
> 
> Yes, but assuming that all CPUs report their quiescent states before
> the first call to rcu_gp_fqs().  One exception is when some CPU is
> looping in the kernel for many milliseconds without passing through a
> quiescent state.  This is because for recent kernels, cond_resched()
> is not a quiescent state until the grace period is something like 100
> milliseconds old.  (For older kernels, cond_resched() was never an RCU
> quiescent state unless it actually scheduled.)
> 
> Why wait 100 milliseconds?  Because otherwise the increase in
> cond_resched() overhead shows up all too well, causing 0day test robot
> to complain bitterly.  Besides, I would expect that in the common case,
> CPUs would be executing usermode code.

Makes sense. I was also wondering about this other thing you mentioned about
waiting for 3 jiffies before reporting the idle CPU's quiescent state. Does
that mean that even if a single CPU is dyntick-idle for a long period of
time, then the minimum grace period duration would be atleast 3 jiffies? In
our mobile embedded devices, jiffies is set to 3.33ms (HZ=300) to keep power
consumption low. Not that I'm saying its an issue or anything (since IIUC if
someone wants shorter grace periods, they should just use expedited GPs), but
it sounds like it would be shorter GP if we just set the qsmask early on some
how and we can manage the overhead of doing so.

> Ah, did you build with NO_HZ_FULL, boot with nohz_full CPUs, and then run
> CPU-bound usermode workloads on those CPUs?  Such CPUs would appear to
> be idle from an RCU perspective.  But these CPUs would never touch their
> rcu_data structures, so they would likely remain in the RCU grace-period
> kthread's cache.  So this should work well also.  Give or take that other
> work would likely eject them from the cache, but in that case they would
> be capacity cache misses rather than the aforementioned communications
> cache misses.  Not that this distinction matters to whoever is measuring
> performance.  ;-)

Ah ok :-) I had booted with !CONFIG_NO_HZ_FULL for this test.

> > Anyway it was just an idea that popped up when I was going through traces :)
> > Thanks for the discussion and happy to discuss further or try out anything.
> 
> Either way, I do appreciate your going through this.  People have found
> RCU bugs this way, one of which involved RCU uselessly calling a particular
> function twice in quick succession.  ;-)
 
Thanks.  It is my pleasure and happy to help :) I'll keep digging into it.

 - Joel

