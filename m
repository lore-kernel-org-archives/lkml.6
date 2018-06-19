Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19848C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CF320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966745AbeFSP6c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:58:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966578AbeFSP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:58:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JFtwkx084317
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:58:30 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jq3g0m8jh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:58:30 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 11:58:29 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 11:58:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JFwO2K15073772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 15:58:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2934B2067;
        Tue, 19 Jun 2018 11:58:13 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 811C2B2064;
        Tue, 19 Jun 2018 11:58:13 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 11:58:13 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AA6E016C0880; Tue, 19 Jun 2018 09:00:24 -0700 (PDT)
Date:   Tue, 19 Jun 2018 09:00:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH 1/2] rcu: Assign higher priority to RCU threads if its
 rcutorture
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180619062215.221564-1-joel@joelfernandes.org>
 <20180619063421.GA221670@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619063421.GA221670@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061915-0072-0000-0000-000003719A30
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009220; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049301; UDB=6.00537646; IPR=6.00828274;
 MB=3.00021741; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 15:58:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061915-0073-0000-0000-0000486A9FBC
Message-Id: <20180619160024.GI3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:34:21PM -0700, Joel Fernandes wrote:
> On Mon, Jun 18, 2018 at 11:22:14PM -0700, Joel Fernandes wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > rcutorture boost tests fail even with CONFIG_RCU_BOOST set because
> > rcutorture's threads are equal priority to the default RCU kthreads (RT
> > class with priority of 1).
> 
> Sorry for the weird subject line, I meant "rcu: Assign higher prio if
> rcutorture is built into kernel". I have included the patch with the subject
> line fixed up below (if you prefer to take that instead).
> 
> Also one question, incase rcutorture is a module, we can't raise the priority
> of the kthreads because it would be too late to do at module load time. In
> this case, do you have any ideas on what we can do? I was thinking we can
> access the kernel command line from within rcutorture module and check if
> 'rcutree.kthread_prio' was passed. And if it is and isn't sufficiently high,
> then we avoid testing boost feature at all (and print a nice message telling
> the user about the issue).

I do like the idea of checking and printing the message in this case.

Another alternative would be to allow rcutree.kthread_prio to be changed
at runtime.  But one caution: rcutree.kthread_prio applies to a number
of kthreads, not just the boost kthreads, so this approach might have
some unwelcome side-effects.

> OTOH, we can just let rcutorture module loaders fail the test if you feel
> very few automation tests do the module loading way of rcutorture and so a
> boost test failure there is tolerable. For me, I will likely be running
> rcutorture only as a built-in so I am Ok with not special casing it within
> rcutorture.

I don't know of anyone using the module-loading approach.  Probably
someone somewhere does it from time to time, though.

							Thanx, Paul

> thanks!
> 
>  - Joel
> 
> -----8<---------
> 
> >From 8cb7c2ac98e510abac35fdf2419a3212a587095a Mon Sep 17 00:00:00 2001
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Mon, 18 Jun 2018 15:13:10 -0700
> Subject: [PATCH 1/2] rcu: Assign higher prio if rcutorture is built into kernel
> 
> rcutorture boost tests fail even with CONFIG_RCU_BOOST set because
> rcutorture's threads are equal priority to the default RCU kthreads (RT
> class with priority of 1).
> 
> This patch checks if RCU torture is built into the kernel and if so,
> assigns a higher priority to the RCU threads. With this the rcutorture
> boost tests pass.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index deb2508be923..a141d6314622 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -171,7 +171,7 @@ static void rcu_report_exp_rdp(struct rcu_state *rsp,
>  static void sync_sched_exp_online_cleanup(int cpu);
> 
>  /* rcuc/rcub kthread realtime priority */
> -static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
> +static int kthread_prio;
>  module_param(kthread_prio, int, 0644);
> 
>  /* Delay in jiffies for grace-period initialization delays, debug only. */
> @@ -3884,12 +3884,16 @@ static int __init rcu_spawn_gp_kthread(void)
>  	struct task_struct *t;
> 
>  	/* Force priority into range. */
> -	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
> +	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 2
> +	    && IS_BUILTIN(CONFIG_RCU_TORTURE_TEST))
> +		kthread_prio = 2;
> +	else if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
>  		kthread_prio = 1;
>  	else if (kthread_prio < 0)
>  		kthread_prio = 0;
>  	else if (kthread_prio > 99)
>  		kthread_prio = 99;
> +
>  	if (kthread_prio != kthread_prio_in)
>  		pr_alert("rcu_spawn_gp_kthread(): Limited prio to %d from %d\n",
>  			 kthread_prio, kthread_prio_in);
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 

