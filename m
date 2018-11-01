Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE4BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC64320820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC64320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeKBI0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:26:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbeKBI0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:26:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1NKNib121852
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 19:21:38 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ng7d614jf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:21:38 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 23:21:37 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 23:21:35 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1NLYg327066434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 23:21:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CB6EB2066;
        Thu,  1 Nov 2018 23:21:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF390B2064;
        Thu,  1 Nov 2018 23:21:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 23:21:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7016916C34AA; Thu,  1 Nov 2018 16:21:34 -0700 (PDT)
Date:   Thu, 1 Nov 2018 16:21:34 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     a.p.zijlstra@chello.nl, tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: rcu: Frob softirq test
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110123-0068-0000-0000-000003580E5F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009968; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111304; UDB=6.00575899; IPR=6.00891396;
 MB=3.00023997; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 23:21:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110123-0069-0000-0000-00004648637D
Message-Id: <20181101232134.GA11875@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> With RT_FULL we get the below wreckage:

The code that this applies to has itself been fully frobbed as of the
current merge window.  I believe that it should now work in -rt as is,
but who knows?  ;-)

							Thanx, Paul

> [  126.060484] =======================================================
> [  126.060486] [ INFO: possible circular locking dependency detected ]
> [  126.060489] 3.0.1-rt10+ #30
> [  126.060490] -------------------------------------------------------
> [  126.060492] irq/24-eth0/1235 is trying to acquire lock:
> [  126.060495]  (&(lock)->wait_lock#2){+.+...}, at: [<ffffffff81501c81>] rt_mutex_slowunlock+0x16/0x55
> [  126.060503]
> [  126.060504] but task is already holding lock:
> [  126.060506]  (&p->pi_lock){-...-.}, at: [<ffffffff81074fdc>] try_to_wake_up+0x35/0x429
> [  126.060511]
> [  126.060511] which lock already depends on the new lock.
> [  126.060513]
> [  126.060514]
> [  126.060514] the existing dependency chain (in reverse order) is:
> [  126.060516]
> [  126.060516] -> #1 (&p->pi_lock){-...-.}:
> [  126.060519]        [<ffffffff810afe9e>] lock_acquire+0x145/0x18a
> [  126.060524]        [<ffffffff8150291e>] _raw_spin_lock_irqsave+0x4b/0x85
> [  126.060527]        [<ffffffff810b5aa4>] task_blocks_on_rt_mutex+0x36/0x20f
> [  126.060531]        [<ffffffff815019bb>] rt_mutex_slowlock+0xd1/0x15a
> [  126.060534]        [<ffffffff81501ae3>] rt_mutex_lock+0x2d/0x2f
> [  126.060537]        [<ffffffff810d9020>] rcu_boost+0xad/0xde
> [  126.060541]        [<ffffffff810d90ce>] rcu_boost_kthread+0x7d/0x9b
> [  126.060544]        [<ffffffff8109a760>] kthread+0x99/0xa1
> [  126.060547]        [<ffffffff81509b14>] kernel_thread_helper+0x4/0x10
> [  126.060551]
> [  126.060552] -> #0 (&(lock)->wait_lock#2){+.+...}:
> [  126.060555]        [<ffffffff810af1b8>] __lock_acquire+0x1157/0x1816
> [  126.060558]        [<ffffffff810afe9e>] lock_acquire+0x145/0x18a
> [  126.060561]        [<ffffffff8150279e>] _raw_spin_lock+0x40/0x73
> [  126.060564]        [<ffffffff81501c81>] rt_mutex_slowunlock+0x16/0x55
> [  126.060566]        [<ffffffff81501ce7>] rt_mutex_unlock+0x27/0x29
> [  126.060569]        [<ffffffff810d9f86>] rcu_read_unlock_special+0x17e/0x1c4
> [  126.060573]        [<ffffffff810da014>] __rcu_read_unlock+0x48/0x89
> [  126.060576]        [<ffffffff8106847a>] select_task_rq_rt+0xc7/0xd5
> [  126.060580]        [<ffffffff8107511c>] try_to_wake_up+0x175/0x429
> [  126.060583]        [<ffffffff81075425>] wake_up_process+0x15/0x17
> [  126.060585]        [<ffffffff81080a51>] wakeup_softirqd+0x24/0x26
> [  126.060590]        [<ffffffff81081df9>] irq_exit+0x49/0x55
> [  126.060593]        [<ffffffff8150a3bd>] smp_apic_timer_interrupt+0x8a/0x98
> [  126.060597]        [<ffffffff81509793>] apic_timer_interrupt+0x13/0x20
> [  126.060600]        [<ffffffff810d5952>] irq_forced_thread_fn+0x1b/0x44
> [  126.060603]        [<ffffffff810d582c>] irq_thread+0xde/0x1af
> [  126.060606]        [<ffffffff8109a760>] kthread+0x99/0xa1
> [  126.060608]        [<ffffffff81509b14>] kernel_thread_helper+0x4/0x10
> [  126.060611]
> [  126.060612] other info that might help us debug this:
> [  126.060614]
> [  126.060615]  Possible unsafe locking scenario:
> [  126.060616]
> [  126.060617]        CPU0                    CPU1
> [  126.060619]        ----                    ----
> [  126.060620]   lock(&p->pi_lock);
> [  126.060623]                                lock(&(lock)->wait_lock);
> [  126.060625]                                lock(&p->pi_lock);
> [  126.060627]   lock(&(lock)->wait_lock);
> [  126.060629]
> [  126.060629]  *** DEADLOCK ***
> [  126.060630]
> [  126.060632] 1 lock held by irq/24-eth0/1235:
> [  126.060633]  #0:  (&p->pi_lock){-...-.}, at: [<ffffffff81074fdc>] try_to_wake_up+0x35/0x429
> [  126.060638]
> [  126.060638] stack backtrace:
> [  126.060641] Pid: 1235, comm: irq/24-eth0 Not tainted 3.0.1-rt10+ #30
> [  126.060643] Call Trace:
> [  126.060644]  <IRQ>  [<ffffffff810acbde>] print_circular_bug+0x289/0x29a
> [  126.060651]  [<ffffffff810af1b8>] __lock_acquire+0x1157/0x1816
> [  126.060655]  [<ffffffff810ab3aa>] ? trace_hardirqs_off_caller+0x1f/0x99
> [  126.060658]  [<ffffffff81501c81>] ? rt_mutex_slowunlock+0x16/0x55
> [  126.060661]  [<ffffffff810afe9e>] lock_acquire+0x145/0x18a
> [  126.060664]  [<ffffffff81501c81>] ? rt_mutex_slowunlock+0x16/0x55
> [  126.060668]  [<ffffffff8150279e>] _raw_spin_lock+0x40/0x73
> [  126.060671]  [<ffffffff81501c81>] ? rt_mutex_slowunlock+0x16/0x55
> [  126.060674]  [<ffffffff810d9655>] ? rcu_report_qs_rsp+0x87/0x8c
> [  126.060677]  [<ffffffff81501c81>] rt_mutex_slowunlock+0x16/0x55
> [  126.060680]  [<ffffffff810d9ea3>] ? rcu_read_unlock_special+0x9b/0x1c4
> [  126.060683]  [<ffffffff81501ce7>] rt_mutex_unlock+0x27/0x29
> [  126.060687]  [<ffffffff810d9f86>] rcu_read_unlock_special+0x17e/0x1c4
> [  126.060690]  [<ffffffff810da014>] __rcu_read_unlock+0x48/0x89
> [  126.060693]  [<ffffffff8106847a>] select_task_rq_rt+0xc7/0xd5
> [  126.060696]  [<ffffffff810683da>] ? select_task_rq_rt+0x27/0xd5
> [  126.060701]  [<ffffffff810a852a>] ? clockevents_program_event+0x8e/0x90
> [  126.060704]  [<ffffffff8107511c>] try_to_wake_up+0x175/0x429
> [  126.060708]  [<ffffffff810a95dc>] ? tick_program_event+0x1f/0x21
> [  126.060711]  [<ffffffff81075425>] wake_up_process+0x15/0x17
> [  126.060715]  [<ffffffff81080a51>] wakeup_softirqd+0x24/0x26
> [  126.060718]  [<ffffffff81081df9>] irq_exit+0x49/0x55
> [  126.060721]  [<ffffffff8150a3bd>] smp_apic_timer_interrupt+0x8a/0x98
> [  126.060724]  [<ffffffff81509793>] apic_timer_interrupt+0x13/0x20
> [  126.060726]  <EOI>  [<ffffffff81072855>] ? migrate_disable+0x75/0x12d
> [  126.060733]  [<ffffffff81080a61>] ? local_bh_disable+0xe/0x1f
> [  126.060736]  [<ffffffff81080a70>] ? local_bh_disable+0x1d/0x1f
> [  126.060739]  [<ffffffff810d5952>] irq_forced_thread_fn+0x1b/0x44
> [  126.060742]  [<ffffffff81502ac0>] ? _raw_spin_unlock_irq+0x3b/0x59
> [  126.060745]  [<ffffffff810d582c>] irq_thread+0xde/0x1af
> [  126.060748]  [<ffffffff810d5937>] ? irq_thread_fn+0x3a/0x3a
> [  126.060751]  [<ffffffff810d574e>] ? irq_finalize_oneshot+0xd1/0xd1
> [  126.060754]  [<ffffffff810d574e>] ? irq_finalize_oneshot+0xd1/0xd1
> [  126.060757]  [<ffffffff8109a760>] kthread+0x99/0xa1
> [  126.060761]  [<ffffffff81509b14>] kernel_thread_helper+0x4/0x10
> [  126.060764]  [<ffffffff81069ed7>] ? finish_task_switch+0x87/0x10a
> [  126.060768]  [<ffffffff81502ec4>] ? retint_restore_args+0xe/0xe
> [  126.060771]  [<ffffffff8109a6c7>] ? __init_kthread_worker+0x8c/0x8c
> [  126.060774]  [<ffffffff81509b10>] ? gs_change+0xb/0xb
> 
> Because irq_exit() does:
> 
> void irq_exit(void)
> {
>     account_system_vtime(current);
>     trace_hardirq_exit();
>     sub_preempt_count(IRQ_EXIT_OFFSET);
>     if (!in_interrupt() && local_softirq_pending())
> 	    invoke_softirq();
> 
>     ...
> }
> 
> Which triggers a wakeup, which uses RCU, now if the interrupted task has
> t->rcu_read_unlock_special set, the rcu usage from the wakeup will end
> up in rcu_read_unlock_special(). rcu_read_unlock_special() will test
> for in_irq(), which will fail as we just decremented preempt_count
> with IRQ_EXIT_OFFSET, and in_sering_softirq(), which for
> PREEMPT_RT_FULL reads:
> 
> int in_serving_softirq(void)
> {
>     int res;
> 
>     preempt_disable();
>     res = __get_cpu_var(local_softirq_runner) == current;
>     preempt_enable();
>     return res;
> }
> 
> Which will thus also fail, resulting in the above wreckage.
> 
> The 'somewhat' ugly solution is to open-code the preempt_count() test
> in rcu_read_unlock_special().
> 
> Also, we're not at all sure how ->rcu_read_unlock_special gets set
> here... so this is very likely a bandaid and more thought is required.
> 
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 564e3927e7b0..429a2f144e19 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -524,7 +524,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  	}
>  
>  	/* Hardware IRQ handlers cannot block, complain if they get here. */
> -	if (in_irq() || in_serving_softirq()) {
> +	if (preempt_count() & (HARDIRQ_MASK | SOFTIRQ_OFFSET)) {
>  		lockdep_rcu_suspicious(__FILE__, __LINE__,
>  				       "rcu_read_unlock() from irq or softirq with blocking in critical section!!!\n");
>  		pr_alert("->rcu_read_unlock_special: %#x (b: %d, enq: %d nq: %d)\n",

