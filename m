Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C9120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C9120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeKBIVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:21:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728053AbeKBIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:21:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1NDm5q121119
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 19:16:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng8vrmsj9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:16:21 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 23:16:21 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 23:16:18 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1NGHMO33226842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 23:16:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70643B205F;
        Thu,  1 Nov 2018 23:16:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F3EFB2064;
        Thu,  1 Nov 2018 23:16:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 23:16:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C373916C34AA; Thu,  1 Nov 2018 16:16:17 -0700 (PDT)
Date:   Thu, 1 Nov 2018 16:16:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: rcu: Make ksoftirqd do RCU quiescent states
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110123-0040-0000-0000-0000048B0779
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009968; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111303; UDB=6.00575898; IPR=6.00891394;
 MB=3.00023997; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 23:16:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110123-0041-0000-0000-00000894085E
Message-Id: <20181101231617.GA10882@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=741 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Implementing RCU-bh in terms of RCU-preempt makes the system vulnerable
> to network-based denial-of-service attacks.  This patch therefore
> makes __do_softirq() invoke rcu_bh_qs(), but only when __do_softirq()
> is running in ksoftirqd context.  A wrapper layer in interposed so that
> other calls to __do_softirq() avoid invoking rcu_bh_qs().  The underlying
> function __do_softirq_common() does the actual work.
> 
> The reason that rcu_bh_qs() is bad in these non-ksoftirqd contexts is
> that there might be a local_bh_enable() inside an RCU-preempt read-side
> critical section.  This local_bh_enable() can invoke __do_softirq()
> directly, so if __do_softirq() were to invoke rcu_bh_qs() (which just
> calls rcu_preempt_qs() in the PREEMPT_RT_FULL case), there would be
> an illegal RCU-preempt quiescent state in the middle of an RCU-preempt
> read-side critical section.  Therefore, quiescent states can only happen
> in cases where __do_softirq() is invoked directly from ksoftirqd.

I -think- that the need for this goes away in the current merge window
because RCU-bh is going away.  There might still be an rt-specific need
to disable irqs, though.

							Thanx, Paul

> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Link: http://lkml.kernel.org/r/20111005184518.GA21601@linux.vnet.ibm.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 197088cdb56e..968579b86401 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -244,7 +244,19 @@ void rcu_sched_qs(void)
>  			   this_cpu_ptr(&rcu_sched_data), true);
>  }
>  
> -#ifndef CONFIG_PREEMPT_RT_FULL
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +static void rcu_preempt_qs(void);
> +
> +void rcu_bh_qs(void)
> +{
> +	unsigned long flags;
> +
> +	/* Callers to this function, rcu_preempt_qs(), must disable irqs. */
> +	local_irq_save(flags);
> +	rcu_preempt_qs();
> +	local_irq_restore(flags);
> +}
> +#else
>  void rcu_bh_qs(void)
>  {
>  	RCU_LOCKDEP_WARN(preemptible(), "rcu_bh_qs() invoked with preemption enabled!!!");
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 429a2f144e19..bee9bffeb0ce 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -29,6 +29,7 @@
>  #include <linux/oom.h>
>  #include <linux/sched/debug.h>
>  #include <linux/smpboot.h>
> +#include <linux/jiffies.h>
>  #include <linux/sched/isolation.h>
>  #include <uapi/linux/sched/types.h>
>  #include "../time/tick-internal.h"
> @@ -1407,7 +1408,7 @@ static void rcu_prepare_kthreads(int cpu)
>  
>  #endif /* #else #ifdef CONFIG_RCU_BOOST */
>  
> -#if !defined(CONFIG_RCU_FAST_NO_HZ)
> +#if !defined(CONFIG_RCU_FAST_NO_HZ) || defined(CONFIG_PREEMPT_RT_FULL)
>  
>  /*
>   * Check to see if any future RCU-related work will need to be done
> @@ -1423,7 +1424,9 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>  	*nextevt = KTIME_MAX;
>  	return rcu_cpu_has_callbacks(NULL);
>  }
> +#endif /* !defined(CONFIG_RCU_FAST_NO_HZ) || defined(CONFIG_PREEMPT_RT_FULL) */
>  
> +#if !defined(CONFIG_RCU_FAST_NO_HZ)
>  /*
>   * Because we do not have RCU_FAST_NO_HZ, don't bother cleaning up
>   * after it.
> @@ -1520,6 +1523,8 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
>  	return cbs_ready;
>  }
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
> +
>  /*
>   * Allow the CPU to enter dyntick-idle mode unless it has callbacks ready
>   * to invoke.  If the CPU has callbacks, try to advance them.  Tell the
> @@ -1562,6 +1567,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>  	*nextevt = basemono + dj * TICK_NSEC;
>  	return 0;
>  }
> +#endif /* #ifndef CONFIG_PREEMPT_RT_FULL */
>  
>  /*
>   * Prepare a CPU for idle from an RCU perspective.  The first major task

