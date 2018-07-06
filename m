Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C1BC6778E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E6D240A9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E6D240A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934617AbeGFFwb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:52:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934578AbeGFFw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:26 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DAFC3BA2;
        Fri,  6 Jul 2018 05:52:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 58/61] sched/core: Require cpu_active() in select_task_rq(), for user tasks
Date:   Fri,  6 Jul 2018 07:47:22 +0200
Message-Id: <20180706054714.558088084@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 7af443ee1697607541c6346c87385adab2214743 ]

select_task_rq() is used in a few paths to select the CPU upon which a
thread should be run - for example it is used by try_to_wake_up() & by
fork or exec balancing. As-is it allows use of any online CPU that is
present in the task's cpus_allowed mask.

This presents a problem because there is a period whilst CPUs are
brought online where a CPU is marked online, but is not yet fully
initialized - ie. the period where CPUHP_AP_ONLINE_IDLE <= state <
CPUHP_ONLINE. Usually we don't run any user tasks during this window,
but there are corner cases where this can happen. An example observed
is:

  - Some user task A, running on CPU X, forks to create task B.

  - sched_fork() calls __set_task_cpu() with cpu=X, setting task B's
    task_struct::cpu field to X.

  - CPU X is offlined.

  - Task A, currently somewhere between the __set_task_cpu() in
    copy_process() and the call to wake_up_new_task(), is migrated to
    CPU Y by migrate_tasks() when CPU X is offlined.

  - CPU X is onlined, but still in the CPUHP_AP_ONLINE_IDLE state. The
    scheduler is now active on CPU X, but there are no user tasks on
    the runqueue.

  - Task A runs on CPU Y & reaches wake_up_new_task(). This calls
    select_task_rq() with cpu=X, taken from task B's task_struct,
    and select_task_rq() allows CPU X to be returned.

  - Task A enqueues task B on CPU X's runqueue, via activate_task() &
    enqueue_task().

  - CPU X now has a user task on its runqueue before it has reached the
    CPUHP_ONLINE state.

In most cases, the user tasks that schedule on the newly onlined CPU
have no idea that anything went wrong, but one case observed to be
problematic is if the task goes on to invoke the sched_setaffinity
syscall. The newly onlined CPU reaches the CPUHP_AP_ONLINE_IDLE state
before the CPU that brought it online calls stop_machine_unpark(). This
means that for a portion of the window of time between
CPUHP_AP_ONLINE_IDLE & CPUHP_ONLINE the newly onlined CPU's struct
cpu_stopper has its enabled field set to false. If a user thread is
executed on the CPU during this window and it invokes sched_setaffinity
with a CPU mask that does not include the CPU it's running on, then when
__set_cpus_allowed_ptr() calls stop_one_cpu() intending to invoke
migration_cpu_stop() and perform the actual migration away from the CPU
it will simply return -ENOENT rather than calling migration_cpu_stop().
We then return from the sched_setaffinity syscall back to the user task
that is now running on a CPU which it just asked not to run on, and
which is not present in its cpus_allowed mask.

This patch resolves the problem by having select_task_rq() enforce that
user tasks run on CPUs that are active - the same requirement that
select_fallback_rq() already enforces. This should ensure that newly
onlined CPUs reach the CPUHP_AP_ACTIVE state before being able to
schedule user tasks, and also implies that bringup_wait_for_ap() will
have called stop_machine_unpark() which resolves the sched_setaffinity
issue above.

I haven't yet investigated them, but it may be of interest to review
whether any of the actions performed by hotplug states between
CPUHP_AP_ONLINE_IDLE & CPUHP_AP_ACTIVE could have similar unintended
effects on user tasks that might schedule before they are reached, which
might widen the scope of the problem from just affecting the behaviour
of sched_setaffinity.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180526154648.11635-2-paul.burton@mips.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1573,8 +1573,7 @@ int select_task_rq(struct task_struct *p
 	 * [ this allows ->select_task() to simply return task_cpu(p) and
 	 *   not worry about this generic constraint ]
 	 */
-	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
-		     !cpu_online(cpu)))
+	if (unlikely(!is_cpu_allowed(p, cpu)))
 		cpu = select_fallback_rq(task_cpu(p), p);
 
 	return cpu;


