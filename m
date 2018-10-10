Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1591FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54D12087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aQA3aFW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54D12087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJKCnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:43:40 -0400
Received: from mail.efficios.com ([167.114.142.138]:32840 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJKCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:39 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A37A1183B6E;
        Wed, 10 Oct 2018 15:20:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id TSTY1x-0fJit; Wed, 10 Oct 2018 15:20:06 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 25D16183B5E;
        Wed, 10 Oct 2018 15:20:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 25D16183B5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199206;
        bh=AM6ze3X0kmmhVIgh8pJVYDD0j6At2CyA49LBJH3hcV8=;
        h=From:To:Date:Message-Id;
        b=aQA3aFW8AzCPh6wHxSQf3H7Vw9GUOW5efxWoRBe7Z1w3ZqU/96dFb+eNeuzi1FuOC
         yZwkShJjAqYPKnnxY0O24NbmFbvB0Wf2+6CHkVWIq+zPYf4zPPHuV+2qF4KOMJ3umF
         X7L/9XMAtveBpb3/QSSwCR2Asfdid189qWTXPclDAKi2eoQhWB2OIZqjPLI5Sfr/mv
         dGu++MaABHUt0k+EypIU8okS0fMNUDpIjIOt6rgCBOOXRMrGYb48EOw5FejeqP6pqB
         AeNxXVIh4aLTpiwCqgSAfguvhS46D19NrOjhj4xLgxj290NCO9ulG/4Zw4Tww1Pf3G
         JxDaxbW73hs9g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 3Z3X1cTx8lUD; Wed, 10 Oct 2018 15:20:06 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 1429A183B4D;
        Wed, 10 Oct 2018 15:20:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.21 03/16] sched: Implement push_task_to_cpu (v2)
Date:   Wed, 10 Oct 2018 15:19:23 -0400
Message-Id: <20181010191936.7495-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement push_task_to_cpu(), which moves the task received as argument
to the destination cpu's runqueue. It only does so if the CPU is within
the CPU allowed mask of the task and if the CPU is active. If the CPU is
not part of the allowed mask, -EINVAL is returned. If the CPU is not
active, -EBUSY is returned.

It does not change the CPU allowed mask, and can therefore be used
within applications which rely on owning the sched_setaffinity() state.

It does not pin the task to the destination CPU, which means that the
scheduler may choose to move the task away from that CPU before the
task executes. Code invoking push_task_to_cpu() must be prepared to
retry in that case.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org

---
Change since v1:
- Return -EBUSY if CPU is not active.
---
 kernel/sched/core.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  9 +++++++++
 2 files changed, 51 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad97f3ba5ec5..ee302988b342 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1036,6 +1036,48 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_curr_task(rq, p);
 }
 
+int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	int ret = 0;
+
+	rq = task_rq_lock(p, &rf);
+	update_rq_clock(rq);
+
+	if (!cpumask_test_cpu(dest_cpu, &p->cpus_allowed)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!cpumask_test_cpu(dest_cpu, cpu_active_mask)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (task_cpu(p) == dest_cpu)
+		goto out;
+
+	if (task_running(rq, p) || p->state == TASK_WAKING) {
+		struct migration_arg arg = { p, dest_cpu };
+		/* Need help from migration thread: drop lock and wait. */
+		task_rq_unlock(rq, p, &rf);
+		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+		tlb_migrate_finish(p->mm);
+		return 0;
+	} else if (task_on_rq_queued(p)) {
+		/*
+		 * OK, since we're going to drop the lock immediately
+		 * afterwards anyway.
+		 */
+		rq = move_queued_task(rq, &rf, p, dest_cpu);
+	}
+out:
+	task_rq_unlock(rq, p, &rf);
+
+	return ret;
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 455fa330de04..27ad25780204 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1340,6 +1340,15 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 #endif
 }
 
+#ifdef CONFIG_SMP
+int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu);
+#else
+static inline int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu)
+{
+	return 0;
+}
+#endif
+
 /*
  * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
  */
-- 
2.11.0

