Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7760DC04EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB4E214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB4E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeKLFdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:33:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbeKLFdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:33:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJi8S3047957
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:19 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdvs8ph4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:19 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:44:18 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:44:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJiC7h40108112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:44:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72232B2066;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A72BB205F;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D217F16C5DAA; Sun, 11 Nov 2018 11:44:12 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH tip/core/rcu 18/41] tracing: Replace synchronize_sched() and call_rcu_sched()
Date:   Sun, 11 Nov 2018 11:43:47 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-2213-0000-0000-00000315A7E4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116019; UDB=6.00578733; IPR=6.00896120;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:44:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-2214-0000-0000-00005C386BB6
Message-Id: <20181111194410.6368-18-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that synchronize_rcu() waits for preempt-disable regions of code
as well as RCU read-side critical sections, synchronize_sched() can
be replaced by synchronize_rcu().  Similarly, call_rcu_sched() can be
replaced by call_rcu().  This commit therefore makes these changes.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
---
 include/linux/tracepoint.h         |  2 +-
 kernel/trace/ftrace.c              | 24 ++++++++++++------------
 kernel/trace/ring_buffer.c         | 12 ++++++------
 kernel/trace/trace.c               | 10 +++++-----
 kernel/trace/trace_events_filter.c |  4 ++--
 kernel/trace/trace_kprobe.c        |  2 +-
 kernel/tracepoint.c                |  4 ++--
 7 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 538ba1a58f5b..432080b59c26 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -82,7 +82,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_srcu(&tracepoint_srcu);
-	synchronize_sched();
+	synchronize_rcu();
 }
 #else
 static inline void tracepoint_synchronize_unregister(void)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f536f601bd46..5b4f73e4fd56 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -173,7 +173,7 @@ static void ftrace_sync(struct work_struct *work)
 {
 	/*
 	 * This function is just a stub to implement a hard force
-	 * of synchronize_sched(). This requires synchronizing
+	 * of synchronize_rcu(). This requires synchronizing
 	 * tasks even in userspace and idle.
 	 *
 	 * Yes, function tracing is rude.
@@ -934,7 +934,7 @@ ftrace_profile_write(struct file *filp, const char __user *ubuf,
 			ftrace_profile_enabled = 0;
 			/*
 			 * unregister_ftrace_profiler calls stop_machine
-			 * so this acts like an synchronize_sched.
+			 * so this acts like an synchronize_rcu.
 			 */
 			unregister_ftrace_profiler();
 		}
@@ -1086,7 +1086,7 @@ struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr)
 
 	/*
 	 * Some of the ops may be dynamically allocated,
-	 * they are freed after a synchronize_sched().
+	 * they are freed after a synchronize_rcu().
 	 */
 	preempt_disable_notrace();
 
@@ -1286,7 +1286,7 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
 {
 	if (!hash || hash == EMPTY_HASH)
 		return;
-	call_rcu_sched(&hash->rcu, __free_ftrace_hash_rcu);
+	call_rcu(&hash->rcu, __free_ftrace_hash_rcu);
 }
 
 void ftrace_free_filter(struct ftrace_ops *ops)
@@ -1501,7 +1501,7 @@ static bool hash_contains_ip(unsigned long ip,
  * the ip is not in the ops->notrace_hash.
  *
  * This needs to be called with preemption disabled as
- * the hashes are freed with call_rcu_sched().
+ * the hashes are freed with call_rcu().
  */
 static int
 ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
@@ -4496,7 +4496,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 	if (ftrace_enabled && !ftrace_hash_empty(hash))
 		ftrace_run_modify_code(&probe->ops, FTRACE_UPDATE_CALLS,
 				       &old_hash_ops);
-	synchronize_sched();
+	synchronize_rcu();
 
 	hlist_for_each_entry_safe(entry, tmp, &hhd, hlist) {
 		hlist_del(&entry->hlist);
@@ -5314,7 +5314,7 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		mutex_unlock(&graph_lock);
 
 		/* Wait till all users are no longer using the old hash */
-		synchronize_sched();
+		synchronize_rcu();
 
 		free_ftrace_hash(old_hash);
 	}
@@ -5707,7 +5707,7 @@ void ftrace_release_mod(struct module *mod)
 	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
 		if (mod_map->mod == mod) {
 			list_del_rcu(&mod_map->list);
-			call_rcu_sched(&mod_map->rcu, ftrace_free_mod_map);
+			call_rcu(&mod_map->rcu, ftrace_free_mod_map);
 			break;
 		}
 	}
@@ -5927,7 +5927,7 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 	struct ftrace_mod_map *mod_map;
 	const char *ret = NULL;
 
-	/* mod_map is freed via call_rcu_sched() */
+	/* mod_map is freed via call_rcu() */
 	preempt_disable();
 	list_for_each_entry_rcu(mod_map, &ftrace_mod_maps, list) {
 		ret = ftrace_func_address_lookup(mod_map, addr, size, off, sym);
@@ -6262,7 +6262,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 
 	/*
 	 * Some of the ops may be dynamically allocated,
-	 * they must be freed after a synchronize_sched().
+	 * they must be freed after a synchronize_rcu().
 	 */
 	preempt_disable_notrace();
 
@@ -6433,7 +6433,7 @@ static void clear_ftrace_pids(struct trace_array *tr)
 	rcu_assign_pointer(tr->function_pids, NULL);
 
 	/* Wait till all users are no longer using pid filtering */
-	synchronize_sched();
+	synchronize_rcu();
 
 	trace_free_pid_list(pid_list);
 }
@@ -6580,7 +6580,7 @@ ftrace_pid_write(struct file *filp, const char __user *ubuf,
 	rcu_assign_pointer(tr->function_pids, pid_list);
 
 	if (filtered_pids) {
-		synchronize_sched();
+		synchronize_rcu();
 		trace_free_pid_list(filtered_pids);
 	} else if (pid_list) {
 		/* Register a probe to set whether to ignore the tracing of a task */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 65bd4616220d..4f3247a53259 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1834,7 +1834,7 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 		 * There could have been a race between checking
 		 * record_disable and incrementing it.
 		 */
-		synchronize_sched();
+		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
 			cpu_buffer = buffer->buffers[cpu];
 			rb_check_pages(cpu_buffer);
@@ -3151,7 +3151,7 @@ static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
  * This prevents all writes to the buffer. Any attempt to write
  * to the buffer after this will fail and return NULL.
  *
- * The caller should call synchronize_sched() after this.
+ * The caller should call synchronize_rcu() after this.
  */
 void ring_buffer_record_disable(struct ring_buffer *buffer)
 {
@@ -3253,7 +3253,7 @@ bool ring_buffer_record_is_set_on(struct ring_buffer *buffer)
  * This prevents all writes to the buffer. Any attempt to write
  * to the buffer after this will fail and return NULL.
  *
- * The caller should call synchronize_sched() after this.
+ * The caller should call synchronize_rcu() after this.
  */
 void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu)
 {
@@ -4191,7 +4191,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_prepare);
 void
 ring_buffer_read_prepare_sync(void)
 {
-	synchronize_sched();
+	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_prepare_sync);
 
@@ -4363,7 +4363,7 @@ void ring_buffer_reset_cpu(struct ring_buffer *buffer, int cpu)
 	atomic_inc(&cpu_buffer->record_disabled);
 
 	/* Make sure all commits have finished */
-	synchronize_sched();
+	synchronize_rcu();
 
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
@@ -4496,7 +4496,7 @@ int ring_buffer_swap_cpu(struct ring_buffer *buffer_a,
 		goto out;
 
 	/*
-	 * We can't do a synchronize_sched here because this
+	 * We can't do a synchronize_rcu here because this
 	 * function can be called in atomic context.
 	 * Normally this will be called from the same CPU as cpu.
 	 * If not it's up to the caller to protect this.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ff1c4b20cd0a..51612b4a603f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1681,7 +1681,7 @@ void tracing_reset(struct trace_buffer *buf, int cpu)
 	ring_buffer_record_disable(buffer);
 
 	/* Make sure all commits have finished */
-	synchronize_sched();
+	synchronize_rcu();
 	ring_buffer_reset_cpu(buffer, cpu);
 
 	ring_buffer_record_enable(buffer);
@@ -1698,7 +1698,7 @@ void tracing_reset_online_cpus(struct trace_buffer *buf)
 	ring_buffer_record_disable(buffer);
 
 	/* Make sure all commits have finished */
-	synchronize_sched();
+	synchronize_rcu();
 
 	buf->time_start = buffer_ftrace_now(buf, buf->cpu);
 
@@ -2250,7 +2250,7 @@ void trace_buffered_event_disable(void)
 	preempt_enable();
 
 	/* Wait for all current users to finish */
-	synchronize_sched();
+	synchronize_rcu();
 
 	for_each_tracing_cpu(cpu) {
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
@@ -5398,7 +5398,7 @@ static int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (tr->current_trace->reset)
 		tr->current_trace->reset(tr);
 
-	/* Current trace needs to be nop_trace before synchronize_sched */
+	/* Current trace needs to be nop_trace before synchronize_rcu */
 	tr->current_trace = &nop_trace;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -5412,7 +5412,7 @@ static int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		 * The update_max_tr is called from interrupts disabled
 		 * so a synchronized_sched() is sufficient.
 		 */
-		synchronize_sched();
+		synchronize_rcu();
 		free_snapshot(tr);
 	}
 #endif
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 84a65173b1e9..35f3aa55be85 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1614,7 +1614,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 
 	/*
 	 * The calls can still be using the old filters.
-	 * Do a synchronize_sched() and to ensure all calls are
+	 * Do a synchronize_rcu() and to ensure all calls are
 	 * done with them before we free them.
 	 */
 	tracepoint_synchronize_unregister();
@@ -1845,7 +1845,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	if (filter) {
 		/*
 		 * No event actually uses the system filter
-		 * we can free it without synchronize_sched().
+		 * we can free it without synchronize_rcu().
 		 */
 		__free_filter(system->filter);
 		system->filter = filter;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fec67188c4d2..adc153ab51c0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -333,7 +333,7 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 		 * event_call related objects, which will be accessed in
 		 * the kprobe_trace_func/kretprobe_trace_func.
 		 */
-		synchronize_sched();
+		synchronize_rcu();
 		kfree(link);	/* Ignored if link == NULL */
 	}
 
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index a3be42304485..46f2ab1e08a9 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -92,7 +92,7 @@ static __init int release_early_probes(void)
 	while (early_probes) {
 		tmp = early_probes;
 		early_probes = tmp->next;
-		call_rcu_sched(tmp, rcu_free_old_probes);
+		call_rcu(tmp, rcu_free_old_probes);
 	}
 
 	return 0;
@@ -123,7 +123,7 @@ static inline void release_probes(struct tracepoint_func *old)
 		 * cover both cases. So let us chain the SRCU and sched RCU
 		 * callbacks to wait for both grace periods.
 		 */
-		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
+		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
 	}
 }
 
-- 
2.17.1

