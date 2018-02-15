Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756550AbeBOXCD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:02:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756495AbeBOXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:01:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A91CD6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
To: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, cme@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, rananta@codeaurora.org, skannan@codeaurora.org
Subject: [PATCH 1/1] perf: Add CPU hotplug support for events
Date: Thu, 15 Feb 2018 15:01:41 -0800
Message-Id: <1518735701-7014-2-git-send-email-rananta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
References: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf framework doesn't allow prevserving CPU events across
CPU hotplugs. The events are scheduled out as and when the
CPU walks offline. Moreover, the framework also doesn't
allow the clients to create events on an offline CPU. As
a result, the clients have to keep on monitoring the CPU
state until it comes back online.

Therefore, introducing the perf framework to support creation
and preserving of (CPU) events for offline CPUs. Through
this, the CPU's online state would be transparent to the
client and it not have to worry about monitoring the CPU's
state. Success would be returned to the client even while
creating the event on an offline CPU. If during the lifetime
of the event the CPU walks offline, the event would be
preserved and would continue to count as soon as (and if) the
CPU comes back online.

Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
---
 include/linux/perf_event.h |   7 +++
 kernel/events/core.c       | 123 +++++++++++++++++++++++++++++++++------------
 2 files changed, 97 insertions(+), 33 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7546822..bc07f16 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -489,6 +489,7 @@ struct perf_addr_filters_head {
  * enum perf_event_state - the states of a event
  */
 enum perf_event_state {
+	PERF_EVENT_STATE_DORMANT	= -5,
 	PERF_EVENT_STATE_DEAD		= -4,
 	PERF_EVENT_STATE_EXIT		= -3,
 	PERF_EVENT_STATE_ERROR		= -2,
@@ -687,6 +688,12 @@ struct perf_event {
 #endif
 
 	struct list_head		sb_list;
+
+	/* Entry into the list that holds the events whose CPUs
+	 * are offline. These events will be removed from the
+	 * list and installed once the CPU wakes up.
+	 */
+	struct list_head		dormant_entry;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 96db9ae..5d0a155 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2329,6 +2329,30 @@ static int  __perf_install_in_context(void *info)
 	return ret;
 }
 
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+static DEFINE_PER_CPU(struct list_head, dormant_event_list);
+static DEFINE_PER_CPU(spinlock_t, dormant_event_list_lock);
+
+static void perf_prepare_install_in_context(struct perf_event *event)
+{
+	int cpu = event->cpu;
+	bool prepare_hp_sched = !READ_ONCE(event->ctx->task);
+
+	if (!prepare_hp_sched)
+		return;
+
+	spin_lock(&per_cpu(dormant_event_list_lock, cpu));
+	if (event->state == PERF_EVENT_STATE_DORMANT)
+		goto out;
+
+	event->state = PERF_EVENT_STATE_DORMANT;
+	list_add_tail(&event->dormant_entry,
+			&per_cpu(dormant_event_list, cpu));
+out:
+	spin_unlock(&per_cpu(dormant_event_list_lock, cpu));
+}
+#endif
+
 /*
  * Attach a performance event to a context.
  *
@@ -2353,6 +2377,15 @@ static int  __perf_install_in_context(void *info)
 	smp_store_release(&event->ctx, ctx);
 
 	if (!task) {
+		struct perf_cpu_context *cpuctx =
+			container_of(ctx, struct perf_cpu_context, ctx);
+
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+		if (!cpuctx->online) {
+			perf_prepare_install_in_context(event);
+			return;
+		}
+#endif
 		cpu_function_call(cpu, __perf_install_in_context, event);
 		return;
 	}
@@ -2421,6 +2454,43 @@ static int  __perf_install_in_context(void *info)
 	raw_spin_unlock_irq(&ctx->lock);
 }
 
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+static void perf_deferred_install_in_context(int cpu)
+{
+	struct perf_event *event, *tmp;
+	struct perf_event_context *ctx;
+
+	/* This function is called twice while coming online. Once for
+	 * CPUHP_PERF_PREPARE and the other for CPUHP_AP_PERF_ONLINE.
+	 * Only during the CPUHP_AP_PERF_ONLINE state, we can confirm
+	 * that CPU PMU is ready and can be installed to.
+	 */
+	if (!cpu_online(cpu))
+		return;
+
+	spin_lock(&per_cpu(dormant_event_list_lock, cpu));
+	list_for_each_entry_safe(event, tmp,
+			&per_cpu(dormant_event_list, cpu), dormant_entry) {
+		if (cpu != event->cpu)
+			continue;
+
+		list_del(&event->dormant_entry);
+		event->state = PERF_EVENT_STATE_INACTIVE;
+		spin_unlock(&per_cpu(dormant_event_list_lock, cpu));
+
+		ctx = event->ctx;
+		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+
+		mutex_lock(&ctx->mutex);
+		perf_install_in_context(ctx, event, cpu);
+		mutex_unlock(&ctx->mutex);
+
+		spin_lock(&per_cpu(dormant_event_list_lock, cpu));
+	}
+	spin_unlock(&per_cpu(dormant_event_list_lock, cpu));
+}
+#endif
+
 /*
  * Cross CPU call to enable a performance event
  */
@@ -4202,6 +4272,15 @@ int perf_event_release_kernel(struct perf_event *event)
 	struct perf_event *child, *tmp;
 	LIST_HEAD(free_list);
 
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+	if (!READ_ONCE(ctx->task)) {
+		spin_lock(&per_cpu(dormant_event_list_lock, event->cpu));
+		if (event->state == PERF_EVENT_STATE_DORMANT)
+			list_del(&event->dormant_entry);
+		spin_unlock(&per_cpu(dormant_event_list_lock, event->cpu));
+	}
+#endif
+
 	/*
 	 * If we got here through err_file: fput(event_file); we will not have
 	 * attached to a context yet.
@@ -10161,23 +10240,6 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 		goto err_locked;
 	}
 
-	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-
-		if (!cpuctx->online) {
-			err = -ENODEV;
-			goto err_locked;
-		}
-	}
-
-
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
 	 * because we need to serialize with concurrent event creation.
@@ -10354,21 +10416,6 @@ struct perf_event *
 		goto err_unlock;
 	}
 
-	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-		if (!cpuctx->online) {
-			err = -ENODEV;
-			goto err_unlock;
-		}
-	}
-
 	if (!exclusive_event_installable(event, ctx)) {
 		err = -EBUSY;
 		goto err_unlock;
@@ -11064,6 +11111,10 @@ static void __init perf_event_init_all_cpus(void)
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
 		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+		spin_lock_init(&per_cpu(dormant_event_list_lock, cpu));
+		INIT_LIST_HEAD(&per_cpu(dormant_event_list, cpu));
+#endif
 	}
 }
 
@@ -11091,8 +11142,10 @@ static void __perf_event_exit_context(void *__info)
 
 	raw_spin_lock(&ctx->lock);
 	ctx_sched_out(ctx, cpuctx, EVENT_TIME);
-	list_for_each_entry(event, &ctx->event_list, event_entry)
+	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
+		perf_prepare_install_in_context(event);
+	}
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -11141,6 +11194,10 @@ int perf_event_init_cpu(unsigned int cpu)
 	}
 	mutex_unlock(&pmus_lock);
 
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+	perf_deferred_install_in_context(cpu);
+#endif
+
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
