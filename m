Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD6FC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590242177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XJCcbq/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfA1WHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:07:33 -0500
Received: from mail.efficios.com ([167.114.142.138]:59266 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfA1WHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:07:32 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 02336B5129;
        Mon, 28 Jan 2019 17:07:31 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id mGuANfzHZQGj; Mon, 28 Jan 2019 17:07:30 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 14538B5125;
        Mon, 28 Jan 2019 17:07:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 14538B5125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548713250;
        bh=4i9gHC6mzIhOhNC9SpQ9y0NhUZbNoVEBdTrxi8zOQWI=;
        h=From:To:Date:Message-Id;
        b=XJCcbq/a6/KwdSZsIv/ZU0wrvT1I+JkzMwDZdoeZg8168inhdScbwDdD8Gnz8jc57
         JsUBTkuS7vYnXPRCz1L8VzCbmMyOne7/jwgCqu8I0P/s+jLorNwK9fbNCc1OY4X1tD
         hin36zYjdIt3LythFCexXzNjkkbqtgsBPbD2Jch4FizjiFRvJZUZoIcBFyZYALxXpA
         Q0OMLeSXXTN0qaN3b0c2bPJcxztvNfRrI+1FU2HkrlOjer5DxTv4RAMgLZ3esxDkuR
         BD3kHKKWv8s0PBy7dMPuqor0XYqHnJBx7vImW4Kq3zyjd+bv/KeAFzqP7I5yow5Puq
         BXjRyJ8srVbow==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id uixpMHszirlh; Mon, 28 Jan 2019 17:07:30 -0500 (EST)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id A064AB5120;
        Mon, 28 Jan 2019 17:07:29 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Subject: [PATCH] Fix: membarrier: racy access to p->mm in membarrier_global_expedited()
Date:   Mon, 28 Jan 2019 17:07:07 -0500
Message-Id: <20190128220707.30774-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn identified a racy access to p->mm in the global expedited
command of the membarrier system call.

The suggested fix is to hold the task_lock() around the accesses to
p->mm and to the mm_struct membarrier_state field to guarantee the
existence of the mm_struct.

Link: https://lore.kernel.org/lkml/CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Tested-by: Jann Horn <jannh@google.com>
CC: Jann Horn <jannh@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Peter Zijlstra (Intel) <peterz@infradead.org>
CC: Ingo Molnar <mingo@kernel.org>
CC: Andrea Parri <parri.andrea@gmail.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Avi Kivity <avi@scylladb.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Dave Watson <davejwatson@fb.com>
CC: David Sehr <sehr@google.com>
CC: H. Peter Anvin <hpa@zytor.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Maged Michael <maged.michael@gmail.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Paul Mackerras <paulus@samba.org>
CC: Russell King <linux@armlinux.org.uk>
CC: Will Deacon <will.deacon@arm.com>
CC: stable@vger.kernel.org # v4.16+
CC: linux-api@vger.kernel.org
---
 kernel/sched/membarrier.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 76e0eaf4654e..305fdcc4c5f7 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -81,12 +81,27 @@ static int membarrier_global_expedited(void)
 
 		rcu_read_lock();
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
-				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
-			if (!fallback)
-				__cpumask_set_cpu(cpu, tmpmask);
-			else
-				smp_call_function_single(cpu, ipi_mb, NULL, 1);
+		/*
+		 * Skip this CPU if the runqueue's current task is NULL or if
+		 * it is a kernel thread.
+		 */
+		if (p && READ_ONCE(p->mm)) {
+			bool mm_match;
+
+			/*
+			 * Read p->mm and access membarrier_state while holding
+			 * the task lock to ensure existence of mm.
+			 */
+			task_lock(p);
+			mm_match = p->mm && (atomic_read(&p->mm->membarrier_state) &
+					     MEMBARRIER_STATE_GLOBAL_EXPEDITED);
+			task_unlock(p);
+			if (mm_match) {
+				if (!fallback)
+					__cpumask_set_cpu(cpu, tmpmask);
+				else
+					smp_call_function_single(cpu, ipi_mb, NULL, 1);
+			}
 		}
 		rcu_read_unlock();
 	}
-- 
2.17.1

