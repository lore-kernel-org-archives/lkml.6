Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeEVGUn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:20:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33921 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeEVGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:20:40 -0400
X-Google-Smtp-Source: AB8JxZpbbqu6i8ay06F9Rj1wCUUElfooftYCYE4JFiNMazvGSi8vpF/90UEdW7lITsb1UxOlqclK/w==
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ibobrik@gmail.com, Cong Wang <xiyou.wangcong@gmail.com>,
        Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/3] sched/fair: add tracepoints for cfs throttle
Date: Mon, 21 May 2018 23:20:17 -0700
Message-Id: <20180522062017.5193-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two sched tracepoints to track
CFS throttle and unthrottle. The use case is to measure
how long each throttle is and to track when a CPU cgroup
is throttled and unthrottled.

Sample output:

     cfs-722   [000] dN.3    51.477702: sched_cfs_throttle: path=/test cpu=0 runtime_remaining=0
  <idle>-0     [000] d.h4    51.536659: sched_cfs_unthrottle: path=/test cpu=0 runtime_remaining=1

Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/trace/events/sched.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index bc01e06bc716..3d9e00972e92 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -570,6 +570,48 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 
 	TP_printk("cpu=%d", __entry->cpu)
 );
+
+#ifdef CONFIG_CFS_BANDWIDTH
+DECLARE_EVENT_CLASS(sched_fair,
+
+	TP_PROTO(struct cfs_rq *cfs_rq),
+
+	TP_ARGS(cfs_rq),
+
+	TP_STRUCT__entry(
+		__field(	s64,		runtime_remaining	)
+		__field(	int,		cpu			)
+		__dynamic_array(char,		cfs_path,
+				cgroup_path(cfs_rq->tg->css.cgroup, NULL, 0) + 1)
+	),
+
+	TP_fast_assign(
+		__entry->runtime_remaining = cfs_rq->runtime_remaining;
+		__entry->cpu = cpu_of(cfs_rq->rq);
+		cgroup_path(cfs_rq->tg->css.cgroup,
+			    __get_dynamic_array(cfs_path),
+			    __get_dynamic_array_len(cfs_path));
+	),
+
+	TP_printk("path=%s cpu=%d runtime_remaining=%lld", __get_str(cfs_path),
+		  __entry->cpu, __entry->runtime_remaining)
+);
+
+DEFINE_EVENT(sched_fair, sched_cfs_throttle,
+
+	TP_PROTO(struct cfs_rq *cfs_rq),
+
+	TP_ARGS(cfs_rq)
+);
+
+DEFINE_EVENT(sched_fair, sched_cfs_unthrottle,
+
+	TP_PROTO(struct cfs_rq *cfs_rq),
+
+	TP_ARGS(cfs_rq)
+);
+#endif /* CONFIG_CFS_BANDWIDTH */
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a13ee006f39..3bcc40f2f272 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4736,6 +4736,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	cfs_rq->throttled = 1;
 	cfs_rq->throttled_clock = rq_clock(rq);
+	trace_sched_cfs_throttle(cfs_rq);
 	raw_spin_lock(&cfs_b->lock);
 	empty = list_empty(&cfs_b->throttled_cfs_rq);
 
@@ -4766,6 +4767,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
 	cfs_rq->throttled = 0;
+	trace_sched_cfs_unthrottle(cfs_rq);
 
 	update_rq_clock(rq);
 
-- 
2.13.0
