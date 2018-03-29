Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeC2Ln6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:43:58 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59048 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeC2L0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:26:17 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 043/109] sched: add do_sched_yield() helper; remove in-kernel call to sched_yield()
Date: Thu, 29 Mar 2018 13:23:20 +0200
Message-Id: <20180329112426.23043-44-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the sched-internal do_sched_yield() helper allows us to get rid of
the sched-internal call to the sys_sched_yield() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7c535eee0a6..8de4919c889a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4892,7 +4892,7 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
  *
  * Return: 0.
  */
-SYSCALL_DEFINE0(sched_yield)
+static void do_sched_yield(void)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -4913,7 +4913,11 @@ SYSCALL_DEFINE0(sched_yield)
 	sched_preempt_enable_no_resched();
 
 	schedule();
+}
 
+SYSCALL_DEFINE0(sched_yield)
+{
+	do_sched_yield();
 	return 0;
 }
 
@@ -4997,7 +5001,7 @@ EXPORT_SYMBOL(__cond_resched_softirq);
 void __sched yield(void)
 {
 	set_current_state(TASK_RUNNING);
-	sys_sched_yield();
+	do_sched_yield();
 }
 EXPORT_SYMBOL(yield);
 
-- 
2.16.3
