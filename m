Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7A4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7E420652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7E420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbeGKMxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:53:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbeGKMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:53:49 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BCnZhO090220
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:49:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5grburf7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:49:37 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 08:49:20 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 08:49:19 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BCnIo99961764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 12:49:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1E88B2065;
        Wed, 11 Jul 2018 08:49:17 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C5FDB2064;
        Wed, 11 Jul 2018 08:49:17 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.165.42])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 08:49:17 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B834116C2E35; Wed, 11 Jul 2018 05:51:37 -0700 (PDT)
Date:   Wed, 11 Jul 2018 05:51:37 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hillenbrand, Marius" <mhillenb@amazon.com>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180709152632.GX2476@hirez.programming.kicks-ass.net>
 <20180709163432.GV3593@linux.vnet.ibm.com>
 <1531162254.26547.3.camel@infradead.org>
 <20180709203441.GE3593@linux.vnet.ibm.com>
 <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531306663.8759.39.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531306663.8759.39.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071112-2213-0000-0000-000002C914BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009349; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059782; UDB=6.00543937; IPR=6.00837702;
 MB=3.00022102; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 12:49:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071112-2214-0000-0000-00005ACB7E9A
Message-Id: <20180711125137.GL3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:57:43AM +0100, David Woodhouse wrote:
> On Mon, 2018-07-09 at 15:08 -0700, Paul E. McKenney wrote:
> 
> > 
> > And the earlier patch was against my -rcu tree, which won't be all that
> > helpful for v4.15.  Please see below for a lightly tested backport to v4.15.
> > 
> > It should apply to all the releases of interest.  If other backports
> > are needed, please remind me of my woodhouse.v4.15.2018.07.09a tag.
> > 
> >                                                         Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 6361b81827a8f93f582124da385258fc04a38a7f
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Mon Jul 9 13:47:30 2018 -0700
> > 
> >     rcu: Make need_resched() respond to urgent RCU-QS needs
> >     
> >     The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
> >     need for an RCU quiescent state from the force-quiescent-state processing
> >     within the grace-period kthread to context switches and to cond_resched().
> >     Unfortunately, such urgent needs are not communicated to need_resched(),
> >     which is sometimes used to decide when to invoke cond_resched(), for
> >     but one example, within the KVM vcpu_run() function.  As of v4.15, this
> >     can result in synchronize_sched() being delayed by up to ten seconds,
> >     which can be problematic, to say nothing of annoying.
> >     
> >     This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
> >     rcu_check_callbacks(), which is invoked from the scheduling-clock
> >     interrupt handler.  If the current task is not an idle task and is
> >     not executing in usermode, a context switch is forced, and either way,
> >     the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
> >     task is an idle task, then RCU's dyntick-idle code will detect the
> >     quiescent state, so no further action is required.  Similarly, if the
> >     task is executing in usermode, other code in rcu_check_callbacks() and
> >     its called functions will report the corresponding quiescent state.
> >     
> >     Reported-by: David Woodhouse <dwmw2@infradead.org>
> >     Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >     [ paulmck: Backported to v4.15.  Probably applies elsewhere. ]
> 
> Hm, this doesn't appear to work. I'm still seeing latencies of 4-5
> seconds in my testing. In fact, even our old workaround of adding
> rcu_all_qs() into vcpu_enter_guest() didn't properly fix it AFAICT.
> 
> I'm just creating a VM with lots of CPUs, then attaching new devices to
> it to cause the VMM to open more file descriptors, until it hits a
> power of two and invokes expand_fdtable().
> 
> expand_fdtable (512) sync took 10472394964 cycles (3500000 µs).
> expand_fdtable (512) sync took 15298908072 cycles (5100000 µs).

Interesting.  (I am assuming that the guest is printing these messages,
not the host, but please let me know if my assumption is incorrect.)

Are the CPUs saturated?  If so, could you please try booting with
rcutree.kthread_prio=2?  If that prevents the messages from happening,
then I need to put some work into guaranteeing forward progress.
Otherwise, I need to figure out why the setting of rcu_urgent_qs is
being ignored.

I will assume the latter for the moment and see if I can spot the
problem.

							Thanx, Paul


> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -162,8 +162,16 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
>         /* make sure all __fd_install() have seen resize_in_progress
>          * or have finished their rcu_read_lock_sched() section.
>          */
> -       if (atomic_read(&files->count) > 1)
> +       if (atomic_read(&files->count) > 1) {
> +               unsigned long sync_start, sync_end;
> +               unsigned long j_start, j_end;
> +               j_start = jiffies;
> +               sync_start = get_cycles();
>                 synchronize_sched();
> +               sync_end = get_cycles();
> +               j_end = jiffies;
> +               printk("expand_fdtable (%d) sync took %ld cycles (%ld µs).\n", nr, sync_end - sync_start, jiffies_to_usecs(j_end - j_start));
> +       }
>  
>         spin_lock(&files->file_lock);
>         if (!new_fdt)


