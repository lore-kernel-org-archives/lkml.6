Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6C4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5DA2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5DA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeKUJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:05:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbeKUJFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:05:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAKMXoo3102326
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:34:06 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nvr2gyc83-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:34:06 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Nov 2018 22:34:05 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Nov 2018 22:34:02 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAKMY1K432702518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 22:34:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4459B2068;
        Tue, 20 Nov 2018 22:34:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A573AB2064;
        Tue, 20 Nov 2018 22:34:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 20 Nov 2018 22:34:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4E09816C3640; Tue, 20 Nov 2018 14:34:02 -0800 (PST)
Date:   Tue, 20 Nov 2018 14:34:02 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Reply-To: paulmck@linux.ibm.com
References: <20181110214659.GA96924@google.com>
 <20181110230436.GL4170@linux.ibm.com>
 <20181111030925.GA182908@google.com>
 <20181111042210.GN4170@linux.ibm.com>
 <20181111180916.GA25327@google.com>
 <20181111183618.GY4170@linux.ibm.com>
 <20181120204243.GA22801@google.com>
 <20181120222813.GE4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120222813.GE4170@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112022-0064-0000-0000-000003779A33
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010089; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01120371; UDB=6.00580469; IPR=6.00900493;
 MB=3.00024254; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-20 22:34:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112022-0065-0000-0000-00003B666902
Message-Id: <20181120223402.GA8748@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:28:13PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 20, 2018 at 12:42:43PM -0800, Joel Fernandes wrote:
> > On Sun, Nov 11, 2018 at 10:36:18AM -0800, Paul E. McKenney wrote:
> > > On Sun, Nov 11, 2018 at 10:09:16AM -0800, Joel Fernandes wrote:
> > > > On Sat, Nov 10, 2018 at 08:22:10PM -0800, Paul E. McKenney wrote:
> > > > > On Sat, Nov 10, 2018 at 07:09:25PM -0800, Joel Fernandes wrote:
> > > > > > On Sat, Nov 10, 2018 at 03:04:36PM -0800, Paul E. McKenney wrote:
> > > > > > > On Sat, Nov 10, 2018 at 01:46:59PM -0800, Joel Fernandes wrote:
> > > > > > > > Hi Paul and everyone,
> > > > > > > > 
> > > > > > > > I was tracing/studying the RCU code today in paul/dev branch and noticed that
> > > > > > > > for dyntick-idle CPUs, the RCU GP thread is clearing the rnp->qsmask
> > > > > > > > corresponding to the leaf node for the idle CPU, and reporting a QS on their
> > > > > > > > behalf.
> > > > > > > > 
> > > > > > > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 792 0 dti
> > > > > > > > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 801 2 dti
> > > > > > > > rcu_sched-10    [003]    40.008041: rcu_quiescent_state_report: rcu_sched 805 5>0 0 0 3 0
> > > > > > > > 
> > > > > > > > That's all good but I was wondering if we can do better for the idle CPUs if
> > > > > > > > we can some how not set the qsmask of the node in the first place. Then no
> > > > > > > > reporting would be needed of quiescent state is needed for idle CPUs right?
> > > > > > > > And we would also not need to acquire the rnp lock I think.
> > > > > > > > 
> > > > > > > > At least for a single node tree RCU system, it seems that would avoid needing
> > > > > > > > to acquire the lock without complications. Anyway let me know your thoughts
> > > > > > > > and happy to discuss this at the hallways of the LPC as well for folks
> > > > > > > > attending :)
> > > > > > > 
> > > > > > > We could, but that would require consulting the rcu_data structure for
> > > > > > > each CPU while initializing the grace period, thus increasing the number
> > > > > > > of cache misses during grace-period initialization and also shortly after
> > > > > > > for any non-idle CPUs.  This seems backwards on busy systems where each
> > > > > > 
> > > > > > When I traced, it appears to me that rcu_data structure of a remote CPU was
> > > > > > being consulted anyway by the rcu_sched thread. So it seems like such cache
> > > > > > miss would happen anyway whether it is during grace-period initialization or
> > > > > > during the fqs stage? I guess I'm trying to say, the consultation of remote
> > > > > > CPU's rcu_data happens anyway.
> > > > > 
> > > > > Hmmm...
> > > > > 
> > > > > The rcu_gp_init() function does access an rcu_data structure, but it is
> > > > > that of the current CPU, so shouldn't involve a communications cache miss,
> > > > > at least not in the common case.
> > > > > 
> > > > > Or are you seeing these cross-CPU rcu_data accesses in rcu_gp_fqs() or
> > > > > functions that it calls?  In that case, please see below.
> > > > 
> > > > Yes, it was rcu_implicit_dynticks_qs called from rcu_gp_fqs.
> > > > 
> > > > > > > CPU will with high probability report its own quiescent state before three
> > > > > > > jiffies pass, in which case the cache misses on the rcu_data structures
> > > > > > > would be wasted motion.
> > > > > > 
> > > > > > If all the CPUs are busy and reporting their QS themselves, then I think the
> > > > > > qsmask is likely 0 so then rcu_implicit_dynticks_qs (called from
> > > > > > force_qs_rnp) wouldn't be called and so there would no cache misses on
> > > > > > rcu_data right?
> > > > > 
> > > > > Yes, but assuming that all CPUs report their quiescent states before
> > > > > the first call to rcu_gp_fqs().  One exception is when some CPU is
> > > > > looping in the kernel for many milliseconds without passing through a
> > > > > quiescent state.  This is because for recent kernels, cond_resched()
> > > > > is not a quiescent state until the grace period is something like 100
> > > > > milliseconds old.  (For older kernels, cond_resched() was never an RCU
> > > > > quiescent state unless it actually scheduled.)
> > > > > 
> > > > > Why wait 100 milliseconds?  Because otherwise the increase in
> > > > > cond_resched() overhead shows up all too well, causing 0day test robot
> > > > > to complain bitterly.  Besides, I would expect that in the common case,
> > > > > CPUs would be executing usermode code.
> > > > 
> > > > Makes sense. I was also wondering about this other thing you mentioned about
> > > > waiting for 3 jiffies before reporting the idle CPU's quiescent state. Does
> > > > that mean that even if a single CPU is dyntick-idle for a long period of
> > > > time, then the minimum grace period duration would be atleast 3 jiffies? In
> > > > our mobile embedded devices, jiffies is set to 3.33ms (HZ=300) to keep power
> > > > consumption low. Not that I'm saying its an issue or anything (since IIUC if
> > > > someone wants shorter grace periods, they should just use expedited GPs), but
> > > > it sounds like it would be shorter GP if we just set the qsmask early on some
> > > > how and we can manage the overhead of doing so.
> > > 
> > > First, there is some autotuning of the delay based on HZ:
> > > 
> > > #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
> > > 
> > > So at HZ=300, you should be seeing a two-jiffy delay rather than the
> > > usual HZ=1000 three-jiffy delay.  Of course, this means that the delay
> > > is 6.67ms rather than the usual 3ms, but the theory is that lower HZ
> > > rates often mean slower instruction execution and thus a desire for
> > > lower RCU overhead.  There is further autotuning based on number of
> > > CPUs, but this does not kick in until you have 256 CPUs on your system,
> > > and I bet that smartphones aren't there yet.  Nevertheless, check out
> > > RCU_JIFFIES_FQS_DIV for more info on this.
> > > 
> > > But you can always override this autotuning using the following kernel
> > > boot paramters:
> > > 
> > > rcutree.jiffies_till_first_fqs
> > > rcutree.jiffies_till_next_fqs
> > 
> > Slightly related, I was just going through your patch in the dev branch "doc:
> > Now jiffies_till_sched_qs solicits from cond_resched()".
> > 
> > If I understand correctly, what you're trying to do is set
> > rcu_data.rcu_urgent_qs if you've not heard from the CPU long enough from
> > rcu_implicit_dynticks_qs.
> > 
> > Then in the other paths, you are reading this value and similuating a dyntick
> > idle transition even though you may not be really going into dyntick-idle.
> > Actually in the scheduler-tick, you are also using it to set NEED_RESCHED
> > appropriately.
> > 
> > Did I get it right so far?
> 
> Partially.
> 
> The simulated dyntick-idle transition happens if the grace period extends
> for even longer, so that ->rcu_need_heavy_qs gets set.  Up to that point,
> all that is asked for is a local-to-the-CPU report of a quiescent state.
> 
> > I was thinking if we could simplify rcu_note_context_switch (the parts that
> > call rcu_momentary_dyntick_idle), if we did the following in
> > rcu_implicit_dynticks_qs.
> > 
> > Since we already call rcu_qs in rcu_note_context_switch, that would clear the
> > rdp->cpu_no_qs flag. Then there should be no need to call
> > rcu_momentary_dyntick_idle from rcu_note_context switch.
> 
> But does this also work for the rcu_all_qs() code path?
> 
> > I think this would simplify cond_resched as well.  Could this avoid the need
> > for having an rcu_all_qs at all? Hopefully I didn't some Tasks-RCU corner cases..
> 
> There is also the code path from cond_resched() in PREEMPT=n kernels.
> This needs rcu_all_qs().  Though it is quite possible that some additional
> code collapsing is possible.
> 
> > Basically for some background, I was thinking can we simplify the code that
> > calls "rcu_momentary_dyntick_idle" since we already register a qs in other
> > ways (like by resetting cpu_no_qs).
> 
> One complication is that rcu_all_qs() is invoked with interrupts
> and preemption enabled, while rcu_note_context_switch() is
> invoked with interrupts disabled.  Also, as you say, Tasks RCU.
> Plus rcu_all_qs() wants to exit immediately if there is nothing to
> do, while rcu_note_context_switch() must unconditionally do rcu_qs()
> -- yes, it could check, but that would be redundant with the checks
> within rcu_qs().  The one function traces and the other one doesn't,
> but it would be OK if both traced.  (I hope, anyway:  The cond_resched()
> performance requirements are surprisingly severe.)  Aside from that,
> the two functions are quite similar.

Plus there are two sets of rcu_qs() and rcu_note_context_switch(),
on for PREEMPT=y and the other for PREEMPT=n.  And cond_resched()
is nothingness for PREEMPT=y.  And currently rcu_implicit_dynticks_qs()
needs to work with both sets.

							Thanx, Paul

> It would of course be possible to create a common helper function that
> rcu_all_qs() and rcu_note_context_switch() both became simple wrappers
> for, but it is not clear that this would actually be shorter or simpler.
> 
> > I should probably start drawing some pictures to make sense of everything,
> > but do let me know if I have a point ;-) Thanks for your time.
> 
> This stuff is admittedly a bit fiddly.  Again, it took some serious
> work to avoid cond_resched() performance regressions.
> 
> > - Joel
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c818e0c91a81..5aa0259c014d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1063,7 +1063,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >  	 * read-side critical section that started before the beginning
> >  	 * of the current RCU grace period.
> >  	 */
> > -	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
> > +	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap) || !rdp->cpu_no_qs.b.norm) {
> 
> If I am not too confused, this change could cause trouble for
> nohz_full CPUs looping in the kernel.  Such CPUs don't necessarily take
> scheduler-clock interrupts, last I checked, and this could prevent the
> CPU from reporting its quiescent state to core RCU.
> 
> Or am I missing something here?
> 
> 							Thanx, Paul
> 
> >  		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
> >  		rcu_gpnum_ovf(rnp, rdp);
> >  		return 1;
> > 

