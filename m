Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA522C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07662146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07662146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeKVBOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:14:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbeKVBOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:14:40 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALEdW7D025379
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:39:58 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nw8kwtbjp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:39:57 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Nov 2018 14:39:56 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 14:39:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wALEdrla37814410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 14:39:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35AE0B2065;
        Wed, 21 Nov 2018 14:39:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0119AB205F;
        Wed, 21 Nov 2018 14:39:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.19])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Nov 2018 14:39:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EBA0B16C2A1A; Wed, 21 Nov 2018 06:39:52 -0800 (PST)
Date:   Wed, 21 Nov 2018 06:39:52 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Reply-To: paulmck@linux.ibm.com
References: <20181110230436.GL4170@linux.ibm.com>
 <20181111030925.GA182908@google.com>
 <20181111042210.GN4170@linux.ibm.com>
 <20181111180916.GA25327@google.com>
 <20181111183618.GY4170@linux.ibm.com>
 <20181120204243.GA22801@google.com>
 <20181120222813.GE4170@linux.ibm.com>
 <20181121020612.GB60896@google.com>
 <20181121024107.GI4170@linux.ibm.com>
 <20181121043722.GA102501@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121043722.GA102501@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112114-0052-0000-0000-00000359C9F0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010094; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01120693; UDB=6.00581550; IPR=6.00900815;
 MB=3.00024263; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-21 14:39:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112114-0053-0000-0000-00005ED64F61
Message-Id: <20181121143952.GK4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:37:22PM -0800, Joel Fernandes wrote:
> On Tue, Nov 20, 2018 at 06:41:07PM -0800, Paul E. McKenney wrote:
> [...] 
> > > > > I was thinking if we could simplify rcu_note_context_switch (the parts that
> > > > > call rcu_momentary_dyntick_idle), if we did the following in
> > > > > rcu_implicit_dynticks_qs.
> > > > > 
> > > > > Since we already call rcu_qs in rcu_note_context_switch, that would clear the
> > > > > rdp->cpu_no_qs flag. Then there should be no need to call
> > > > > rcu_momentary_dyntick_idle from rcu_note_context switch.
> > > > 
> > > > But does this also work for the rcu_all_qs() code path?
> > > 
> > > Could we not do something like this in rcu_all_qs? as some over-simplified
> > > pseudo code:
> > > 
> > > rcu_all_qs() {
> > >   if (!urgent_qs || !heavy_qs)
> > >      return;
> > > 
> > >   rcu_qs();   // This clears the rdp->cpu_no_qs flags which we can monitor in
> > >               //  the diff in my last email (from rcu_implicit_dynticks_qs)
> > > }
> > 
> > Except that rcu_qs() doesn't necessarily report the quiescent state to
> > the RCU core.  Keeping down context-switch overhead and all that.
> 
> Sure yeah, but I think the QS will be indirectly anyway by the force_qs_rnp()
> path if we detect that rcu_qs() happened on the CPU?

The force_qs_rnp() path won't see anything that has not already been
reported to the RCU core.

> > > > > I think this would simplify cond_resched as well.  Could this avoid the need
> > > > > for having an rcu_all_qs at all? Hopefully I didn't some Tasks-RCU corner cases..
> > > > 
> > > > There is also the code path from cond_resched() in PREEMPT=n kernels.
> > > > This needs rcu_all_qs().  Though it is quite possible that some additional
> > > > code collapsing is possible.
> > > > 
> > > > > Basically for some background, I was thinking can we simplify the code that
> > > > > calls "rcu_momentary_dyntick_idle" since we already register a qs in other
> > > > > ways (like by resetting cpu_no_qs).
> > > > 
> > > > One complication is that rcu_all_qs() is invoked with interrupts
> > > > and preemption enabled, while rcu_note_context_switch() is
> > > > invoked with interrupts disabled.  Also, as you say, Tasks RCU.
> > > > Plus rcu_all_qs() wants to exit immediately if there is nothing to
> > > > do, while rcu_note_context_switch() must unconditionally do rcu_qs()
> > > > -- yes, it could check, but that would be redundant with the checks
> > > 
> > > This immediate exit is taken care off in the above psuedo code, would that
> > > help the cond_resched performance?
> > 
> > It look like you are cautiously edging towards the two wrapper functions
> > calling common code, relying on inlining and simplification.  Why not just
> > try doing it?  ;-)
> 
> Sure yeah. I was more thinking of the ambitious goal of getting rid of the
> complexity and exploring the general design idea, than containing/managing
> the complexity with reducing code duplication. :D
> 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index c818e0c91a81..5aa0259c014d 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -1063,7 +1063,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> > > > >  	 * read-side critical section that started before the beginning
> > > > >  	 * of the current RCU grace period.
> > > > >  	 */
> > > > > -	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
> > > > > +	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap) || !rdp->cpu_no_qs.b.norm) {
> > > > 
> > > > If I am not too confused, this change could cause trouble for
> > > > nohz_full CPUs looping in the kernel.  Such CPUs don't necessarily take
> > > > scheduler-clock interrupts, last I checked, and this could prevent the
> > > > CPU from reporting its quiescent state to core RCU.
> > > 
> > > Would that still be a problem if rcu_all_qs called rcu_qs? Also the above
> > > diff is an OR condition so it is more relaxed than before.
> > 
> > Yes, because rcu_qs() is only guaranteed to capture the quiescent
> > state on the current CPU, not necessarily report it to the RCU core.
> 
> The reporting to the core is necessary to call rcu_report_qs_rnp so that the
> QS information is propogating up the tree, right?
> 
> Wouldn't that reporting be done anyway by:
> 
> force_qs_rnp
>   -> rcu_implicit_dynticks_qs  (which returns 1 because rdp->cpu_no_qs.b.norm
> 				was cleared by rcu_qs() and we detect that
> 				with help of above diff)

Ah.  It is not safe to sample rdp->cpu_no_qs.b.norm off-CPU, and that
is what your patch would do.  This is intentional -- if it were safe to
sample off-CPU, then it would be more expensive to read/update on-CPU.

>   -> rcu_report_qs_rnp is called with mask bit set for corresponding CPU that
>   				has the !rdp->cpu_no_qs.b.norm
> 
> 
> I think that's what I am missing - that why wouldn't the above scheme work.
> The only difference is reporting to the RCU core might invoke pending
> callbacks but I'm not sure if that matters for this. I'll these changes,
> and try tracing it out and study it more.  thanks for the patience,

There are a lot of moving parts and you have not yet gotten to all
of them.  I suggest next taking a look at the relationship between
rcu_check_callbacks() and rcu_process_callbacks(), including the
open_softirq().  These have old names -- they handle the interface
between the CPU and RCU code, among other things.  Including invoking
callbacks, but only for some configurations.  :-/

							Thanx, Paul

