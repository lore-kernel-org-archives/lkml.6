Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED27C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1C820834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1C820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLDSvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDSvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:51:24 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C772081C;
        Tue,  4 Dec 2018 18:51:22 +0000 (UTC)
Date:   Tue, 4 Dec 2018 13:51:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 10/12] tracing: Remove orphaned
 trace_add/remove_event_call functions
Message-ID: <20181204135120.02361a89@vmware.local.home>
In-Reply-To: <154140866955.17322.2081425494660638846.stgit@devbox>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
        <154140866955.17322.2081425494660638846.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 18:04:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Remove trace_add_event_call() and trace_remove_event_call()
> functions since those are not used anymore.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Hi Masami,

I've applied the series locally (need to test it) except for this
patch. Honestly, I hate the "_nolock" name, and it makes no sense when

 1) they still grab locks
 2) there's no version without "_nolock"

I added this patch in its place:

-- Steve

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Tue, 4 Dec 2018 13:35:45 -0500
Subject: [PATCH] tracing: Consolidate trace_add/remove_event_call back to the
 nolock functions

The trace_add/remove_event_call_nolock() functions were added to allow
the tace_add/remove_event_call() code be called when the event_mutex
lock was already taken. Now that all callers are done within the
event_mutex, there's no reason to have two different interfaces.

Remove the current wrapper trace_add/remove_event_call()s and rename the
_nolock versions back to the original names.

Link: http://lkml.kernel.org/r/154140866955.17322.2081425494660638846.stgit@devbox

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h     |  2 --
 kernel/trace/trace_events.c      | 30 ++++--------------------------
 kernel/trace/trace_events_hist.c |  6 +++---
 kernel/trace/trace_kprobe.c      |  4 ++--
 kernel/trace/trace_uprobe.c      |  4 ++--
 5 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3aa05593a53f..4130a5497d40 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -529,8 +529,6 @@ extern int trace_event_raw_init(struct trace_event_call *call);
 extern int trace_define_field(struct trace_event_call *call, const char *type,
 			      const char *name, int offset, int size,
 			      int is_signed, int filter_type);
-extern int trace_add_event_call_nolock(struct trace_event_call *call);
-extern int trace_remove_event_call_nolock(struct trace_event_call *call);
 extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a3b157f689ee..bd0162c0467c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2305,7 +2305,8 @@ __trace_early_add_new_event(struct trace_event_call *call,
 struct ftrace_module_file_ops;
 static void __add_event_to_tracers(struct trace_event_call *call);
 
-int trace_add_event_call_nolock(struct trace_event_call *call)
+/* Add an additional event_call dynamically */
+int trace_add_event_call(struct trace_event_call *call)
 {
 	int ret;
 	lockdep_assert_held(&event_mutex);
@@ -2320,17 +2321,6 @@ int trace_add_event_call_nolock(struct trace_event_call *call)
 	return ret;
 }
 
-/* Add an additional event_call dynamically */
-int trace_add_event_call(struct trace_event_call *call)
-{
-	int ret;
-
-	mutex_lock(&event_mutex);
-	ret = trace_add_event_call_nolock(call);
-	mutex_unlock(&event_mutex);
-	return ret;
-}
-
 /*
  * Must be called under locking of trace_types_lock, event_mutex and
  * trace_event_sem.
@@ -2376,8 +2366,8 @@ static int probe_remove_event_call(struct trace_event_call *call)
 	return 0;
 }
 
-/* no event_mutex version */
-int trace_remove_event_call_nolock(struct trace_event_call *call)
+/* Remove an event_call */
+int trace_remove_event_call(struct trace_event_call *call)
 {
 	int ret;
 
@@ -2392,18 +2382,6 @@ int trace_remove_event_call_nolock(struct trace_event_call *call)
 	return ret;
 }
 
-/* Remove an event_call */
-int trace_remove_event_call(struct trace_event_call *call)
-{
-	int ret;
-
-	mutex_lock(&event_mutex);
-	ret = trace_remove_event_call_nolock(call);
-	mutex_unlock(&event_mutex);
-
-	return ret;
-}
-
 #define for_each_event(event, start, end)			\
 	for (event = start;					\
 	     (unsigned long)event < (unsigned long)end;		\
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 21e4954375a1..82e72c48a5a9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -960,7 +960,7 @@ static int register_synth_event(struct synth_event *event)
 	call->data = event;
 	call->tp = event->tp;
 
-	ret = trace_add_event_call_nolock(call);
+	ret = trace_add_event_call(call);
 	if (ret) {
 		pr_warn("Failed to register synthetic event: %s\n",
 			trace_event_name(call));
@@ -969,7 +969,7 @@ static int register_synth_event(struct synth_event *event)
 
 	ret = set_synth_event_print_fmt(call);
 	if (ret < 0) {
-		trace_remove_event_call_nolock(call);
+		trace_remove_event_call(call);
 		goto err;
 	}
  out:
@@ -984,7 +984,7 @@ static int unregister_synth_event(struct synth_event *event)
 	struct trace_event_call *call = &event->call;
 	int ret;
 
-	ret = trace_remove_event_call_nolock(call);
+	ret = trace_remove_event_call(call);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index bdf8c2ad5152..0e0f7b8024fb 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1353,7 +1353,7 @@ static int register_kprobe_event(struct trace_kprobe *tk)
 		kfree(call->print_fmt);
 		return -ENODEV;
 	}
-	ret = trace_add_event_call_nolock(call);
+	ret = trace_add_event_call(call);
 	if (ret) {
 		pr_info("Failed to register kprobe event: %s\n",
 			trace_event_name(call));
@@ -1368,7 +1368,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 	int ret;
 
 	/* tp->event is unregistered in trace_remove_event_call() */
-	ret = trace_remove_event_call_nolock(&tk->tp.call);
+	ret = trace_remove_event_call(&tk->tp.call);
 	if (!ret)
 		kfree(tk->tp.call.print_fmt);
 	return ret;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 4a7b21c891f3..e335576b9411 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1320,7 +1320,7 @@ static int register_uprobe_event(struct trace_uprobe *tu)
 		return -ENODEV;
 	}
 
-	ret = trace_add_event_call_nolock(call);
+	ret = trace_add_event_call(call);
 
 	if (ret) {
 		pr_info("Failed to register uprobe event: %s\n",
@@ -1337,7 +1337,7 @@ static int unregister_uprobe_event(struct trace_uprobe *tu)
 	int ret;
 
 	/* tu->event is unregistered in trace_remove_event_call() */
-	ret = trace_remove_event_call_nolock(&tu->tp.call);
+	ret = trace_remove_event_call(&tu->tp.call);
 	if (ret)
 		return ret;
 	kfree(tu->tp.call.print_fmt);
-- 
2.19.2

