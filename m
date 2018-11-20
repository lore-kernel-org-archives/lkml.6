Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CECFC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D33213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wvyEHrLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D33213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeKUHNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:13:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33612 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKUHNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:13:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so2016622plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wbfxnty6r01cTHG1D7CDCmF9dra0Fg9suHKL4jcE16A=;
        b=wvyEHrLnz/ToFDudjOH8g3NMxf+PkEaUxBIOnUpVOP6RMRutxTaHGOFx7/Mv8atHN/
         4z5gSnm4vrRjd9m0hvG/Ea4rflHDCUTFUpvisUE6IYPuhGhxHlqJi9X9moxTfR7KFU7u
         Ry2p/Xn46CczBF49Y774Ov3B5jwyUDfUsCqqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wbfxnty6r01cTHG1D7CDCmF9dra0Fg9suHKL4jcE16A=;
        b=VFLtm+b/5xYUb2SWAw/wdAzxod3/GG7FkYHQMBnfcGNR2YDz9JrIU/qIBuafv37vY/
         ohJAcxt9g/0piHyjEtKnoB9fsV4+4RAAaucwxZYLIrlZc2HTsdn+CsKNw++MXZtkkRkL
         SB/+5+KjYSRhcrYKxaPi3OtmpsB00EY/+c5kWZSY/SY34jwHtl4xT0I4W8DJjrn9Tvm5
         9l+iePwtCJY8JL5+yd4WTFdoAlVNnrBaRqYL2AfgE9w6YS+IEojtWvpOH4Gnra8F8CMP
         Dik0XfcyTWRULkow8BNGlBDfHwPLQpjwIpezX8T7mHZADHLjsqKhqyk4cBwleyal73Tn
         grZg==
X-Gm-Message-State: AA+aEWbDQJOXPGZ+sRfjYsBKwPXOs4t3xg9IGODIDuskVHq9gxY6J4gw
        0l6g1/a2FCgN2kOecu5LHaCymg==
X-Google-Smtp-Source: AFSGD/V2v0Li2fv3KtyF6UPB0E4KZLN1mN0etzfLX5WMgVlq3LJLBZj3QNBwfS3q+P6xssQQJMSV6A==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr3255254pgc.89.1542746565507;
        Tue, 20 Nov 2018 12:42:45 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h17-v6sm62766019pfj.125.2018.11.20.12.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 12:42:44 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:42:43 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Message-ID: <20181120204243.GA22801@google.com>
References: <20181110214659.GA96924@google.com>
 <20181110230436.GL4170@linux.ibm.com>
 <20181111030925.GA182908@google.com>
 <20181111042210.GN4170@linux.ibm.com>
 <20181111180916.GA25327@google.com>
 <20181111183618.GY4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111183618.GY4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:36:18AM -0800, Paul E. McKenney wrote:
> On Sun, Nov 11, 2018 at 10:09:16AM -0800, Joel Fernandes wrote:
> > On Sat, Nov 10, 2018 at 08:22:10PM -0800, Paul E. McKenney wrote:
> > > On Sat, Nov 10, 2018 at 07:09:25PM -0800, Joel Fernandes wrote:
> > > > On Sat, Nov 10, 2018 at 03:04:36PM -0800, Paul E. McKenney wrote:
> > > > > On Sat, Nov 10, 2018 at 01:46:59PM -0800, Joel Fernandes wrote:
> > > > > > Hi Paul and everyone,
> > > > > > 
> > > > > > I was tracing/studying the RCU code today in paul/dev branch and noticed that
> > > > > > for dyntick-idle CPUs, the RCU GP thread is clearing the rnp->qsmask
> > > > > > corresponding to the leaf node for the idle CPU, and reporting a QS on their
> > > > > > behalf.
> > > > > > 
> > > > > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 792 0 dti
> > > > > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 801 2 dti
> > > > > > rcu_sched-10    [003]    40.008041: rcu_quiescent_state_report: rcu_sched 805 5>0 0 0 3 0
> > > > > > 
> > > > > > That's all good but I was wondering if we can do better for the idle CPUs if
> > > > > > we can some how not set the qsmask of the node in the first place. Then no
> > > > > > reporting would be needed of quiescent state is needed for idle CPUs right?
> > > > > > And we would also not need to acquire the rnp lock I think.
> > > > > > 
> > > > > > At least for a single node tree RCU system, it seems that would avoid needing
> > > > > > to acquire the lock without complications. Anyway let me know your thoughts
> > > > > > and happy to discuss this at the hallways of the LPC as well for folks
> > > > > > attending :)
> > > > > 
> > > > > We could, but that would require consulting the rcu_data structure for
> > > > > each CPU while initializing the grace period, thus increasing the number
> > > > > of cache misses during grace-period initialization and also shortly after
> > > > > for any non-idle CPUs.  This seems backwards on busy systems where each
> > > > 
> > > > When I traced, it appears to me that rcu_data structure of a remote CPU was
> > > > being consulted anyway by the rcu_sched thread. So it seems like such cache
> > > > miss would happen anyway whether it is during grace-period initialization or
> > > > during the fqs stage? I guess I'm trying to say, the consultation of remote
> > > > CPU's rcu_data happens anyway.
> > > 
> > > Hmmm...
> > > 
> > > The rcu_gp_init() function does access an rcu_data structure, but it is
> > > that of the current CPU, so shouldn't involve a communications cache miss,
> > > at least not in the common case.
> > > 
> > > Or are you seeing these cross-CPU rcu_data accesses in rcu_gp_fqs() or
> > > functions that it calls?  In that case, please see below.
> > 
> > Yes, it was rcu_implicit_dynticks_qs called from rcu_gp_fqs.
> > 
> > > > > CPU will with high probability report its own quiescent state before three
> > > > > jiffies pass, in which case the cache misses on the rcu_data structures
> > > > > would be wasted motion.
> > > > 
> > > > If all the CPUs are busy and reporting their QS themselves, then I think the
> > > > qsmask is likely 0 so then rcu_implicit_dynticks_qs (called from
> > > > force_qs_rnp) wouldn't be called and so there would no cache misses on
> > > > rcu_data right?
> > > 
> > > Yes, but assuming that all CPUs report their quiescent states before
> > > the first call to rcu_gp_fqs().  One exception is when some CPU is
> > > looping in the kernel for many milliseconds without passing through a
> > > quiescent state.  This is because for recent kernels, cond_resched()
> > > is not a quiescent state until the grace period is something like 100
> > > milliseconds old.  (For older kernels, cond_resched() was never an RCU
> > > quiescent state unless it actually scheduled.)
> > > 
> > > Why wait 100 milliseconds?  Because otherwise the increase in
> > > cond_resched() overhead shows up all too well, causing 0day test robot
> > > to complain bitterly.  Besides, I would expect that in the common case,
> > > CPUs would be executing usermode code.
> > 
> > Makes sense. I was also wondering about this other thing you mentioned about
> > waiting for 3 jiffies before reporting the idle CPU's quiescent state. Does
> > that mean that even if a single CPU is dyntick-idle for a long period of
> > time, then the minimum grace period duration would be atleast 3 jiffies? In
> > our mobile embedded devices, jiffies is set to 3.33ms (HZ=300) to keep power
> > consumption low. Not that I'm saying its an issue or anything (since IIUC if
> > someone wants shorter grace periods, they should just use expedited GPs), but
> > it sounds like it would be shorter GP if we just set the qsmask early on some
> > how and we can manage the overhead of doing so.
> 
> First, there is some autotuning of the delay based on HZ:
> 
> #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
> 
> So at HZ=300, you should be seeing a two-jiffy delay rather than the
> usual HZ=1000 three-jiffy delay.  Of course, this means that the delay
> is 6.67ms rather than the usual 3ms, but the theory is that lower HZ
> rates often mean slower instruction execution and thus a desire for
> lower RCU overhead.  There is further autotuning based on number of
> CPUs, but this does not kick in until you have 256 CPUs on your system,
> and I bet that smartphones aren't there yet.  Nevertheless, check out
> RCU_JIFFIES_FQS_DIV for more info on this.
> 
> But you can always override this autotuning using the following kernel
> boot paramters:
> 
> rcutree.jiffies_till_first_fqs
> rcutree.jiffies_till_next_fqs

Slightly related, I was just going through your patch in the dev branch "doc:
Now jiffies_till_sched_qs solicits from cond_resched()".

If I understand correctly, what you're trying to do is set
rcu_data.rcu_urgent_qs if you've not heard from the CPU long enough from
rcu_implicit_dynticks_qs.

Then in the other paths, you are reading this value and similuating a dyntick
idle transition even though you may not be really going into dyntick-idle.
Actually in the scheduler-tick, you are also using it to set NEED_RESCHED
appropriately.

Did I get it right so far?

I was thinking if we could simplify rcu_note_context_switch (the parts that
call rcu_momentary_dyntick_idle), if we did the following in
rcu_implicit_dynticks_qs.

Since we already call rcu_qs in rcu_note_context_switch, that would clear the
rdp->cpu_no_qs flag. Then there should be no need to call
rcu_momentary_dyntick_idle from rcu_note_context switch.

I think this would simplify cond_resched as well.  Could this avoid the need
for having an rcu_all_qs at all? Hopefully I didn't some Tasks-RCU corner cases..

Basically for some background, I was thinking can we simplify the code that
calls "rcu_momentary_dyntick_idle" since we already register a qs in other
ways (like by resetting cpu_no_qs).

I should probably start drawing some pictures to make sense of everything,
but do let me know if I have a point ;-) Thanks for your time.

- Joel

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c818e0c91a81..5aa0259c014d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1063,7 +1063,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
+	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap) || !rdp->cpu_no_qs.b.norm) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
