Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEPTyD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:54:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32780 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEPTyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:54:02 -0400
X-Google-Smtp-Source: AB8JxZp4WtxvDd9yS4BSQlL10X1hxoIgQQMQ16F/qoGFwySTlStquIBPM7pBDHJU8Cfj422MU44BWg==
From: Mathieu Malaterre <malat@debian.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Mathieu Malaterre <malat@debian.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/debug: Move print_rt_rq and print_dl_rq declarations to kernel/sched/sched.h
Date: Wed, 16 May 2018 21:53:47 +0200
Message-Id: <20180516195348.30426-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 6b55c9654fcc ("sched/debug: Move print_cfs_rq() declaration to
kernel/sched/sched.h"), ‘print_cfs_rq’ prototype was added to
<kernel/sched/sched.h> right next to prototypes for ‘print_cfs_stats’,
‘print_rt_stats’ and ‘print_dl_stats’. Update this previous commit
and also move related prototypes: ‘print_rt_rq’ and ‘print_dl_rq’.
Remove existing extern declarations now that they not needed anymore.

Silence the following gcc warning, triggered at W=1:

  kernel/sched/debug.c:573:6: warning: no previous prototype for ‘print_rt_rq’ [-Wmissing-prototypes]
  kernel/sched/debug.c:603:6: warning: no previous prototype for ‘print_dl_rq’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/sched/deadline.c | 2 --
 kernel/sched/rt.c       | 2 --
 kernel/sched/sched.h    | 5 +++--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 125703d9b25e..1356afd1eeb6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2731,8 +2731,6 @@ bool dl_cpu_busy(unsigned int cpu)
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
-extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
-
 void print_dl_stats(struct seq_file *m, int cpu)
 {
 	print_dl_rq(m, cpu, &cpu_rq(cpu)->dl);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4e885a..ef3c4e6f5345 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2701,8 +2701,6 @@ int sched_rr_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_SCHED_DEBUG
-extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
-
 void print_rt_stats(struct seq_file *m, int cpu)
 {
 	rt_rq_iter_t iter;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..1f0a4bc6a39d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2025,8 +2025,9 @@ extern bool sched_debug_enabled;
 extern void print_cfs_stats(struct seq_file *m, int cpu);
 extern void print_rt_stats(struct seq_file *m, int cpu);
 extern void print_dl_stats(struct seq_file *m, int cpu);
-extern void
-print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
+extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
+extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
+extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
-- 
2.11.0
