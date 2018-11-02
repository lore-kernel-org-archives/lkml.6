Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92293C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275AA2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WOMysAyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275AA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeKCIs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:48:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeKCIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:48:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA2NcYoW061584;
        Fri, 2 Nov 2018 23:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=E4Xymk16xsMn47omNyH+DLoNEH/JMCZDBKO5kfjl0SM=;
 b=WOMysAyVNTloDqOr1Mi1A2hCtYBUWVnk3pOttzZIKS0dpILGoT9I7uhgXJ//+PHzwTKC
 kqrn+JZDyM89nDdwUpNeNOzV7Uef+E2S69bL4qNI6g3ZyVRNj3Et6O2pE0hKgiG2OnvD
 lgAchTuKBTk1KqLYJNZCJkR+FdxlWJuRM8NMvWispf+dIaVzVGl2kOFbKeS6ovfP0J5W
 m3YRytc4e5zY/mmTgcM+Kp+Zw7tHTT/9FIhF5ymq1ee/wmeM5s+50T9LsuF6Kzis03BK
 3Rw9x+eZHukuYhKrYO4guLXd+FFENs3Eq4eO5k3Z9sjQ1uhprNoJXHkP4lb9A6m3hgHb iQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nducmnr9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 23:38:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA2Ncbrl017735
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 23:38:37 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA2NcafD027055;
        Fri, 2 Nov 2018 23:38:36 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Nov 2018 16:38:36 -0700
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <aaa9cfea-d5f9-06a3-242f-05a1f3f9e7c8@oracle.com>
Date:   Fri, 2 Nov 2018 16:39:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9065 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/22/18 7:59 AM, Steve Sistare wrote:
> When a CPU has no more CFS tasks to run, and idle_balance() fails to
> find a task, then attempt to steal a task from an overloaded CPU in the
> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
> identify candidates.  To minimize search time, steal the first migratable
> task that is found when the bitmap is traversed.  For fairness, search
> for migratable tasks on an overloaded CPU in order of next to run.
>
> This simple stealing yields a higher CPU utilization than idle_balance()
> alone, because the search is cheap, so it may be called every time the CPU
> is about to go idle.  idle_balance() does more work because it searches
> widely for the busiest queue, so to limit its CPU consumption, it declines
> to search if the system is too busy.  Simple stealing does not offload the
> globally busiest queue, but it is much better than running nothing at all.
>
> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
> reduce cache contention vs the usual bitmap when many threads concurrently
> set, clear, and visit elements.
>
Is the bitmask saving much? I tried a simple stealing that just starts
searching the domain from the current cpu and steals a thread from the
first cpu that has more than one runnable thread. It seems to perform
similar to your patch.

hackbench on X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
                 baseline        %stdev  patch %stdev
1(40 tasks)     0.5524          2.36    0.5522 (0.045%) 3.82
2(80 tasks)     0.6482          11.4    0.7241 (-11.7%) 20.34
4(160 tasks)    0.9756          0.95    0.8276 (15.1%) 5.8
8(320 tasks)    1.7699          1.62    1.6655 (5.9%) 1.57
16(640 tasks)   3.1018          0.77    2.9858 (3.74%) 1.4
32(1280 tasks)  5.565           0.62    5.3388 (4.1%) 0.72

X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
Oracle database OLTP, logging _enabled_

Users %speedup
20 1.2
40 -0.41
60 0.83
80 2.37
100 1.54
120 3.0
140 2.24
160 1.82
180 1.94
200 2.23
220 1.49

Below is the patch (not in best shape)

----------->8--------------------

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f808ddf..1690451 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3540,6 +3540,7 @@ static inline unsigned long cfs_rq_load_avg(struct 
cfs_rq *cfs_rq)
  }

  static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
+static int my_idle_balance(struct rq *this_rq, struct rq_flags *rf);

  static inline unsigned long task_util(struct task_struct *p)
  {
@@ -6619,6 +6620,8 @@ done: __maybe_unused;

  idle:
         new_tasks = idle_balance(rq, rf);
+       if (new_tasks == 0)
+               new_tasks = my_idle_balance(rq, rf);

         /*
          * Because idle_balance() releases (and re-acquires) rq->lock, 
it is
@@ -8434,6 +8437,75 @@ static int should_we_balance(struct lb_env *env)
         return balance_cpu == env->dst_cpu;
  }

+int get_best_cpu(int this_cpu, struct sched_domain *sd)
+{
+       struct rq *this_rq, *rq;
+       int i;
+       int best_cpu = -1;
+
+       this_rq = cpu_rq(this_cpu);
+       for_each_cpu_wrap(i, sched_domain_span(sd), this_cpu) {
+               if (this_rq->nr_running > 0)
+                       return (-1);
+               if (i == this_cpu)
+                       continue;
+               rq = cpu_rq(i);
+               if (rq->nr_running <= 1)
+                       continue;
+               best_cpu = i;
+               break;
+       }
+       return (best_cpu);
+}
+static int my_load_balance(int this_cpu, struct rq *this_rq,
+                          struct sched_domain *sd, enum cpu_idle_type idle)
+{
+       int ld_moved = 0;
+       struct rq *busiest;
+       unsigned long flags;
+       struct task_struct *p = NULL;
+       struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
+       int best_cpu;
+
+       struct lb_env env = {
+               .sd             = sd,
+               .dst_cpu        = this_cpu,
+               .dst_rq         = this_rq,
+               .dst_grpmask    = sched_group_span(sd->groups),
+               .idle           = idle,
+               .cpus           = cpus,
+               .tasks          = LIST_HEAD_INIT(env.tasks),
+       };
+
+       if (idle == CPU_NEWLY_IDLE)
+               env.dst_grpmask = NULL;
+
+       cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
+
+       best_cpu = get_best_cpu(this_cpu, sd);
+
+       if (best_cpu >= 0)
+               busiest = cpu_rq(best_cpu);
+       else
+               goto out;
+
+       env.src_cpu = busiest->cpu;
+       env.src_rq = busiest;
+       raw_spin_lock_irqsave(&busiest->lock, flags);
+
+       p = detach_one_task(&env);
+       raw_spin_unlock(&busiest->lock);
+       if (p) {
+               attach_one_task(this_rq, p);
+               ld_moved++;
+       }
+       local_irq_restore(flags);
+
+out:
+       return ld_moved;
+}
+
  /*
   * Check this_cpu to ensure it is balanced within domain. Attempt to move
   * tasks if there is an imbalance.
@@ -9369,6 +9441,71 @@ static inline bool nohz_idle_balance(struct rq 
*this_rq, enum cpu_idle_type idle
  static inline void nohz_newidle_balance(struct rq *this_rq) { }
  #endif /* CONFIG_NO_HZ_COMMON */

+
+static int my_idle_balance(struct rq *this_rq, struct rq_flags *rf)
+{
+       int this_cpu = this_rq->cpu;
+       struct sched_domain *sd;
+       int pulled_task = 0;
+       int level;
+
+       /*
+        * We must set idle_stamp _before_ calling idle_balance(), such 
that we
+        * measure the duration of idle_balance() as idle time.
+        */
+       this_rq->idle_stamp = rq_clock(this_rq);
+
+       rq_unpin_lock(this_rq, rf);
+
+       /*
+        * Drop the rq->lock, but keep IRQ/preempt disabled.
+        */
+       raw_spin_unlock(&this_rq->lock);
+
+       rcu_read_lock();
+
+       level = 0;
+       for_each_domain(this_cpu, sd) {
+               if (level++ > 1)
+                       break;
+
+               if (!(sd->flags & SD_LOAD_BALANCE))
+                       continue;
+
+               if (sd->flags & SD_BALANCE_NEWIDLE)
+                       pulled_task = my_load_balance(this_cpu, this_rq,
+                                                     sd, CPU_NEWLY_IDLE);
+
+               /*
+                * Stop searching for tasks to pull if there are
+                * now runnable tasks on this rq.
+                */
+               if (pulled_task || this_rq->nr_running > 0)
+                       break;
+       }
+       rcu_read_unlock();
+
+       raw_spin_lock(&this_rq->lock);
+
+       /*
+        * While browsing the domains, we released the rq lock, a task could
+        * have been enqueued in the meantime. Since we're not going idle,
+        * pretend we pulled a task.
+        */
+       if (this_rq->cfs.h_nr_running && !pulled_task)
+               pulled_task = 1;
+out:
+       /* Is there a task of a high priority class? */
+       if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+               pulled_task = -1;
+
+       if (pulled_task)
+               this_rq->idle_stamp = 0;
+
+       rq_repin_lock(this_rq, rf);
+       return pulled_task;
+}
+
  /*
   * idle_balance is called by schedule() if this_cpu is about to become
   * idle. Attempts to pull tasks from other CPUs.

