Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015A0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD5A20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD5A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeLEXte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbeLEXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74926214DB;
        Wed,  5 Dec 2018 23:48:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu7-0000H7-Hh; Wed, 05 Dec 2018 18:48:31 -0500
Message-Id: <20181205234831.444571549@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 20/30] tracing: Lock event_mutex before synth_event_mutex
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

synthetic event is using synth_event_mutex for protecting
synth_event_list, and event_trigger_write() path acquires
locks as below order.

event_trigger_write(event_mutex)
  ->trigger_process_regex(trigger_cmd_mutex)
    ->event_hist_trigger_func(synth_event_mutex)

On the other hand, synthetic event creation and deletion paths
call trace_add_event_call() and trace_remove_event_call()
which acquires event_mutex. In that case, if we keep the
synth_event_mutex locked while registering/unregistering synthetic
events, its dependency will be inversed.

To avoid this issue, current synthetic event is using a 2 phase
process to create/delete events. For example, it searches existing
events under synth_event_mutex to check for event-name conflicts, and
unlocks synth_event_mutex, then registers a new event under event_mutex
locked. Finally, it locks synth_event_mutex and tries to add the
new event to the list. But it can introduce complexity and a chance
for name conflicts.

To solve this simpler, this introduces trace_add_event_call_nolock()
and trace_remove_event_call_nolock() which don't acquire
event_mutex inside. synthetic event can lock event_mutex before
synth_event_mutex to solve the lock dependency issue simpler.

Link: http://lkml.kernel.org/r/154140844377.17322.13781091165954002713.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h     |  2 ++
 kernel/trace/trace_events.c      | 34 ++++++++++++++++++++++++++------
 kernel/trace/trace_events_hist.c | 24 ++++++++++------------
 3 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4130a5497d40..3aa05593a53f 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -529,6 +529,8 @@ extern int trace_event_raw_init(struct trace_event_call *call);
 extern int trace_define_field(struct trace_event_call *call, const char *type,
 			      const char *name, int offset, int size,
 			      int is_signed, int filter_type);
+extern int trace_add_event_call_nolock(struct trace_event_call *call);
+extern int trace_remove_event_call_nolock(struct trace_event_call *call);
 extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f94be0c2827b..a3b157f689ee 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2305,11 +2305,11 @@ __trace_early_add_new_event(struct trace_event_call *call,
 struct ftrace_module_file_ops;
 static void __add_event_to_tracers(struct trace_event_call *call);
 
-/* Add an additional event_call dynamically */
-int trace_add_event_call(struct trace_event_call *call)
+int trace_add_event_call_nolock(struct trace_event_call *call)
 {
 	int ret;
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	mutex_lock(&trace_types_lock);
 
 	ret = __register_event(call, NULL);
@@ -2317,6 +2317,16 @@ int trace_add_event_call(struct trace_event_call *call)
 		__add_event_to_tracers(call);
 
 	mutex_unlock(&trace_types_lock);
+	return ret;
+}
+
+/* Add an additional event_call dynamically */
+int trace_add_event_call(struct trace_event_call *call)
+{
+	int ret;
+
+	mutex_lock(&event_mutex);
+	ret = trace_add_event_call_nolock(call);
 	mutex_unlock(&event_mutex);
 	return ret;
 }
@@ -2366,17 +2376,29 @@ static int probe_remove_event_call(struct trace_event_call *call)
 	return 0;
 }
 
-/* Remove an event_call */
-int trace_remove_event_call(struct trace_event_call *call)
+/* no event_mutex version */
+int trace_remove_event_call_nolock(struct trace_event_call *call)
 {
 	int ret;
 
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	mutex_lock(&trace_types_lock);
 	down_write(&trace_event_sem);
 	ret = probe_remove_event_call(call);
 	up_write(&trace_event_sem);
 	mutex_unlock(&trace_types_lock);
+
+	return ret;
+}
+
+/* Remove an event_call */
+int trace_remove_event_call(struct trace_event_call *call)
+{
+	int ret;
+
+	mutex_lock(&event_mutex);
+	ret = trace_remove_event_call_nolock(call);
 	mutex_unlock(&event_mutex);
 
 	return ret;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eb908ef2ecec..1670c65389fe 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -912,7 +912,7 @@ static int register_synth_event(struct synth_event *event)
 	call->data = event;
 	call->tp = event->tp;
 
-	ret = trace_add_event_call(call);
+	ret = trace_add_event_call_nolock(call);
 	if (ret) {
 		pr_warn("Failed to register synthetic event: %s\n",
 			trace_event_name(call));
@@ -936,7 +936,7 @@ static int unregister_synth_event(struct synth_event *event)
 	struct trace_event_call *call = &event->call;
 	int ret;
 
-	ret = trace_remove_event_call(call);
+	ret = trace_remove_event_call_nolock(call);
 
 	return ret;
 }
@@ -1013,12 +1013,10 @@ static void add_or_delete_synth_event(struct synth_event *event, int delete)
 	if (delete)
 		free_synth_event(event);
 	else {
-		mutex_lock(&synth_event_mutex);
 		if (!find_synth_event(event->name))
 			list_add(&event->list, &synth_event_list);
 		else
 			free_synth_event(event);
-		mutex_unlock(&synth_event_mutex);
 	}
 }
 
@@ -1030,6 +1028,7 @@ static int create_synth_event(int argc, char **argv)
 	int i, consumed = 0, n_fields = 0, ret = 0;
 	char *name;
 
+	mutex_lock(&event_mutex);
 	mutex_lock(&synth_event_mutex);
 
 	/*
@@ -1102,8 +1101,6 @@ static int create_synth_event(int argc, char **argv)
 		goto err;
 	}
  out:
-	mutex_unlock(&synth_event_mutex);
-
 	if (event) {
 		if (delete_event) {
 			ret = unregister_synth_event(event);
@@ -1113,10 +1110,13 @@ static int create_synth_event(int argc, char **argv)
 			add_or_delete_synth_event(event, ret);
 		}
 	}
+	mutex_unlock(&synth_event_mutex);
+	mutex_unlock(&event_mutex);
 
 	return ret;
  err:
 	mutex_unlock(&synth_event_mutex);
+	mutex_unlock(&event_mutex);
 
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
@@ -1127,12 +1127,10 @@ static int create_synth_event(int argc, char **argv)
 
 static int release_all_synth_events(void)
 {
-	struct list_head release_events;
 	struct synth_event *event, *e;
 	int ret = 0;
 
-	INIT_LIST_HEAD(&release_events);
-
+	mutex_lock(&event_mutex);
 	mutex_lock(&synth_event_mutex);
 
 	list_for_each_entry(event, &synth_event_list, list) {
@@ -1142,16 +1140,14 @@ static int release_all_synth_events(void)
 		}
 	}
 
-	list_splice_init(&event->list, &release_events);
-
-	mutex_unlock(&synth_event_mutex);
-
-	list_for_each_entry_safe(event, e, &release_events, list) {
+	list_for_each_entry_safe(event, e, &synth_event_list, list) {
 		list_del(&event->list);
 
 		ret = unregister_synth_event(event);
 		add_or_delete_synth_event(event, !ret);
 	}
+	mutex_unlock(&synth_event_mutex);
+	mutex_unlock(&event_mutex);
 
 	return ret;
 }
-- 
2.19.1


