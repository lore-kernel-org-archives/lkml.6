Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeBIXHU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:07:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIXHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:07:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1038F6022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, rananta@codeaurora.org
Subject: [PATCH] perf: Add support for creating offline events
Date: Fri,  9 Feb 2018 15:07:00 -0800
Message-Id: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf framework doesn't allow creation of hardware events if
the requested CPU is offline. However, creation of an event
is achievable if the event is attached to the PMU as soon
as the CPU is online again.

So, introducing a feature that could allow to create events
even when the CPU is offline and return a success to the caller.
If, during the time of event creation, the CPU is found offline,
the event is moved to a new state (PERF_EVENT_STATE_DORMANT). As
and when the CPU is know to be woken up (through hotplug notifiers),
all the dormant events would be attached to the PMU (by
perf_install_in_context()). If during the life time of the event,
the CPU hasn't come online, the dormant event would just be freed.

Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
---
 include/linux/perf_event.h |   7 +++
 kernel/events/core.c       | 109 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 84 insertions(+), 32 deletions(-)

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
index f0549e7..66dbccb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2329,6 +2329,19 @@ static int  __perf_install_in_context(void *info)
 	return ret;
 }
 
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+static LIST_HEAD(dormant_event_list);
+static DEFINE_SPINLOCK(dormant_event_list_lock);
+
+static void perf_prepare_install_in_context(struct perf_event *event)
+{
+	spin_lock(&dormant_event_list_lock);
+	event->state = PERF_EVENT_STATE_DORMANT;
+	list_add_tail(&event->dormant_entry, &dormant_event_list);
+	spin_unlock(&dormant_event_list_lock);
+}
+#endif
+
 /*
  * Attach a performance event to a context.
  *
@@ -2353,6 +2366,15 @@ static int  __perf_install_in_context(void *info)
 	smp_store_release(&event->ctx, ctx);
 
 	if (!task) {
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+		struct perf_cpu_context *cpuctx =
+			container_of(ctx, struct perf_cpu_context, ctx);
+
+		if (!cpuctx->online) {
+			perf_prepare_install_in_context(event);
+			return;
+		}
+#endif
 		cpu_function_call(cpu, __perf_install_in_context, event);
 		return;
 	}
@@ -2421,6 +2443,43 @@ static int  __perf_install_in_context(void *info)
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
+	spin_lock(&dormant_event_list_lock);
+	list_for_each_entry_safe(event, tmp, &dormant_event_list,
+						dormant_entry) {
+		if (cpu != event->cpu)
+			continue;
+
+		list_del(&event->dormant_entry);
+		event->state = PERF_EVENT_STATE_INACTIVE;
+		spin_unlock(&dormant_event_list_lock);
+
+		ctx = event->ctx;
+		perf_event__state_init(event);
+
+		mutex_lock(&ctx->mutex);
+		perf_install_in_context(ctx, event, cpu);
+		mutex_unlock(&ctx->mutex);
+
+		spin_lock(&dormant_event_list_lock);
+	}
+	spin_unlock(&dormant_event_list_lock);
+}
+#endif
+
 /*
  * Cross CPU call to enable a performance event
  */
@@ -4202,6 +4261,13 @@ int perf_event_release_kernel(struct perf_event *event)
 	struct perf_event *child, *tmp;
 	LIST_HEAD(free_list);
 
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+	spin_lock(&dormant_event_list_lock);
+	if (event->state == PERF_EVENT_STATE_DORMANT)
+		list_del(&event->dormant_entry);
+	spin_unlock(&dormant_event_list_lock);
+#endif
+
 	/*
 	 * If we got here through err_file: fput(event_file); we will not have
 	 * attached to a context yet.
@@ -4513,6 +4579,15 @@ static bool is_event_hup(struct perf_event *event)
 	struct perf_event_context *ctx;
 	int ret;
 
+#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+	spin_lock(&dormant_event_list_lock);
+	if (event->state == PERF_EVENT_STATE_DORMANT) {
+		spin_unlock(&dormant_event_list_lock);
+		return 0;
+	}
+	spin_unlock(&dormant_event_list_lock);
+#endif
+
 	ctx = perf_event_ctx_lock(event);
 	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
@@ -10161,23 +10236,6 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
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
@@ -10354,21 +10412,6 @@ struct perf_event *
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
@@ -11141,6 +11184,8 @@ int perf_event_init_cpu(unsigned int cpu)
 	}
 	mutex_unlock(&pmus_lock);
 
+	perf_deferred_install_in_context(cpu);
+
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
