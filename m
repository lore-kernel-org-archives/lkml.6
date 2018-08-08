Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D056C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD272177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD272177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeHHU2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbeHHU1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:27:54 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7753021A89;
        Wed,  8 Aug 2018 18:07:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fnSrP-0002WG-H0; Wed, 08 Aug 2018 14:07:03 -0400
Message-Id: <20180808180703.426198047@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 Aug 2018 14:03:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [RFC][PATCH v2 23/24] tools/lib/traceevent: Rename various pevent APIs
References: <20180808180245.352784763@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_reset_function_resolver, pevent_strerror, pevent_list_events,
pevent_event_common_fields, pevent_event_fields, pevent_ref, pevent_unref

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c  | 22 +++++++++++-----------
 tools/lib/traceevent/event-parse.h  | 14 +++++++-------
 tools/lib/traceevent/parse-filter.c |  6 +++---
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 8215e6ff36eb..f723c088acca 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -471,13 +471,13 @@ int tep_set_function_resolver(struct tep_handle *pevent,
 }
 
 /**
- * pevent_reset_function_resolver - reset alternative function resolver
+ * tep_reset_function_resolver - reset alternative function resolver
  * @pevent: handle for the pevent
  *
  * Stop using whatever alternative resolver was set, use the default
  * one instead.
  */
-void pevent_reset_function_resolver(struct tep_handle *pevent)
+void tep_reset_function_resolver(struct tep_handle *pevent)
 {
 	free(pevent->func_resolver);
 	pevent->func_resolver = NULL;
@@ -5630,7 +5630,7 @@ static int events_system_cmp(const void *a, const void *b)
 	return events_id_cmp(a, b);
 }
 
-struct event_format **pevent_list_events(struct tep_handle *pevent, enum event_sort_type sort_type)
+struct event_format **tep_list_events(struct tep_handle *pevent, enum event_sort_type sort_type)
 {
 	struct event_format **events;
 	int (*sort)(const void *a, const void *b);
@@ -5709,13 +5709,13 @@ get_event_fields(const char *type, const char *name,
 }
 
 /**
- * pevent_event_common_fields - return a list of common fields for an event
+ * tep_event_common_fields - return a list of common fields for an event
  * @event: the event to return the common fields of.
  *
  * Returns an allocated array of fields. The last item in the array is NULL.
  * The array must be freed with free().
  */
-struct format_field **pevent_event_common_fields(struct event_format *event)
+struct format_field **tep_event_common_fields(struct event_format *event)
 {
 	return get_event_fields("common", event->name,
 				event->format.nr_common,
@@ -5723,13 +5723,13 @@ struct format_field **pevent_event_common_fields(struct event_format *event)
 }
 
 /**
- * pevent_event_fields - return a list of event specific fields for an event
+ * tep_event_fields - return a list of event specific fields for an event
  * @event: the event to return the fields of.
  *
  * Returns an allocated array of fields. The last item in the array is NULL.
  * The array must be freed with free().
  */
-struct format_field **pevent_event_fields(struct event_format *event)
+struct format_field **tep_event_fields(struct event_format *event)
 {
 	return get_event_fields("event", event->name,
 				event->format.nr_fields,
@@ -6221,8 +6221,8 @@ static const char * const pevent_error_str[] = {
 };
 #undef _PE
 
-int pevent_strerror(struct tep_handle *pevent __maybe_unused,
-		    enum tep_errno errnum, char *buf, size_t buflen)
+int tep_strerror(struct tep_handle *pevent __maybe_unused,
+		 enum tep_errno errnum, char *buf, size_t buflen)
 {
 	int idx;
 	const char *msg;
@@ -6766,7 +6766,7 @@ struct tep_handle *tep_alloc(void)
 	return pevent;
 }
 
-void pevent_ref(struct tep_handle *pevent)
+void tep_ref(struct tep_handle *pevent)
 {
 	pevent->ref_count++;
 }
@@ -6899,7 +6899,7 @@ void tep_free(struct tep_handle *pevent)
 	free(pevent);
 }
 
-void pevent_unref(struct tep_handle *pevent)
+void tep_unref(struct tep_handle *pevent)
 {
 	tep_free(pevent);
 }
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index c41547353b4c..44b7c2d41f9f 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -617,7 +617,7 @@ enum trace_flag_type {
 
 int tep_set_function_resolver(struct tep_handle *pevent,
 			      tep_func_resolver_t *func, void *priv);
-void pevent_reset_function_resolver(struct tep_handle *pevent);
+void tep_reset_function_resolver(struct tep_handle *pevent);
 int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
 int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
 int tep_register_function(struct tep_handle *pevent, char *name,
@@ -724,12 +724,12 @@ void tep_print_fields(struct trace_seq *s, void *data,
 		      int size __maybe_unused, struct event_format *event);
 void tep_event_info(struct trace_seq *s, struct event_format *event,
 		       struct tep_record *record);
-int pevent_strerror(struct tep_handle *pevent, enum tep_errno errnum,
+int tep_strerror(struct tep_handle *pevent, enum tep_errno errnum,
 		    char *buf, size_t buflen);
 
-struct event_format **pevent_list_events(struct tep_handle *pevent, enum event_sort_type);
-struct format_field **pevent_event_common_fields(struct event_format *event);
-struct format_field **pevent_event_fields(struct event_format *event);
+struct event_format **tep_list_events(struct tep_handle *pevent, enum event_sort_type);
+struct format_field **tep_event_common_fields(struct event_format *event);
+struct format_field **tep_event_fields(struct event_format *event);
 
 static inline int tep_get_cpus(struct tep_handle *pevent)
 {
@@ -793,8 +793,8 @@ static inline void tep_set_latency_format(struct tep_handle *pevent, int lat)
 
 struct tep_handle *tep_alloc(void);
 void tep_free(struct tep_handle *pevent);
-void pevent_ref(struct tep_handle *pevent);
-void pevent_unref(struct tep_handle *pevent);
+void tep_ref(struct tep_handle *pevent);
+void tep_unref(struct tep_handle *pevent);
 
 /* access to the internal parser */
 void tep_buffer_init(const char *buf, unsigned long long size);
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 5e3f29736a25..682a50e8b5f7 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -189,7 +189,7 @@ struct event_filter *tep_filter_alloc(struct tep_handle *pevent)
 
 	memset(filter, 0, sizeof(*filter));
 	filter->pevent = pevent;
-	pevent_ref(pevent);
+	tep_ref(pevent);
 
 	return filter;
 }
@@ -1393,7 +1393,7 @@ int tep_filter_strerror(struct event_filter *filter, enum tep_errno err,
 		return 0;
 	}
 
-	return pevent_strerror(filter->pevent, err, buf, buflen);
+	return tep_strerror(filter->pevent, err, buf, buflen);
 }
 
 /**
@@ -1456,7 +1456,7 @@ void tep_filter_reset(struct event_filter *filter)
 
 void tep_filter_free(struct event_filter *filter)
 {
-	pevent_unref(filter->pevent);
+	tep_unref(filter->pevent);
 
 	tep_filter_reset(filter);
 
-- 
2.18.0


