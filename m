Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeDYFPP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:15:15 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39222 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDYFPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:15:13 -0400
X-Google-Smtp-Source: AIpwx4+fB3YbQ2nfuxTkIPgd7XQ/L253ECcqk+cFZz/Uawppo62ez6G89Fo1vLyq0Yy7Izhh/6xWJQ==
Date: Wed, 25 Apr 2018 10:45:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
        c@hirez.programming.kicks-ass.net
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180425051509.aohopadqw7q5urbd@vireshk-i7>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
 <20180424123523.GF4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424123523.GF4064@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-18, 14:35, Peter Zijlstra wrote:
> In any case, if there not going to be conflicts here, this all looks
> good.

Thanks Peter.

I also had another patch and wasn't sure if that would be the right
thing to do. The main purpose of this is to avoid calling
sync_entity_load_avg() unnecessarily.

+++ b/kernel/sched/fair.c
@@ -6196,9 +6196,6 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 {
        int new_cpu = cpu;
 
-       if (!cpumask_intersects(sched_domain_span(sd), &p->cpus_allowed))
-               return prev_cpu;
-
        while (sd) {
                struct sched_group *group;
                struct sched_domain *tmp;
@@ -6652,15 +6649,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
        if (unlikely(sd)) {
                /* Slow path */
 
-               /*
-                * We're going to need the task's util for capacity_spare_wake
-                * in find_idlest_group. Sync it up to prev_cpu's
-                * last_update_time.
-                */
-               if (!(sd_flag & SD_BALANCE_FORK))
-                       sync_entity_load_avg(&p->se);
+               if (!cpumask_intersects(sched_domain_span(sd), &p->cpus_allowed)) {
+                       new_cpu = prev_cpu;
+               } else {
+                       /*
+                        * We're going to need the task's util for
+                        * capacity_spare_wake in find_idlest_group. Sync it up
+                        * to prev_cpu's last_update_time.
+                        */
+                       if (!(sd_flag & SD_BALANCE_FORK))
+                               sync_entity_load_avg(&p->se);
 
-               new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
+                       new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
+               }
        } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
                /* Fast path */

-- 
viresh
