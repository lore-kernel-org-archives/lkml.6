Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE67C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151DB21771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151DB21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeHHSeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbeHHSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:33:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1F021A5B;
        Wed,  8 Aug 2018 16:13:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fnR5A-0002WJ-L1; Wed, 08 Aug 2018 12:13:08 -0400
Message-Id: <20180808161308.553990716@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 Aug 2018 11:55:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [RFC][PATCH 11/24] tools/lib/traceevent, tools/perf: Rename traceevent_* APIs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "traceevent_". This changes
APIs: traceevent_host_bigendian, traceevent_load_plugins and traceevent_unload_plugins

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.h  | 8 ++++----
 tools/lib/traceevent/event-plugin.c | 8 ++++----
 tools/perf/util/trace-event.c       | 6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index a68591c8dec3..97abeaced9c3 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -435,9 +435,9 @@ struct plugin_list;
 
 #define INVALID_PLUGIN_LIST_OPTION	((char **)((unsigned long)-1))
 
-struct plugin_list *traceevent_load_plugins(struct tep_handle *pevent);
-void traceevent_unload_plugins(struct plugin_list *plugin_list,
-			       struct tep_handle *pevent);
+struct plugin_list *tep_load_plugins(struct tep_handle *pevent);
+void tep_unload_plugins(struct plugin_list *plugin_list,
+			struct tep_handle *pevent);
 char **traceevent_plugin_list_options(void);
 void traceevent_plugin_free_options_list(char **list);
 int traceevent_plugin_add_options(const char *name,
@@ -597,7 +597,7 @@ __data2host8(struct tep_handle *pevent, unsigned long long data)
 	__data2host8(pevent, __val);				\
 })
 
-static inline int traceevent_host_bigendian(void)
+static inline int tep_host_bigendian(void)
 {
 	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4 };
 	unsigned int val;
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index 8c91c8f0abd9..39859cee7712 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -264,10 +264,10 @@ void traceevent_plugin_remove_options(struct tep_plugin_option *options)
  * @s: the trace_seq descripter to write to
  * @prefix: The prefix string to add before listing the option name
  * @suffix: The suffix string ot append after the option name
- * @list: The list of plugins (usually returned by traceevent_load_plugins()
+ * @list: The list of plugins (usually returned by tep_load_plugins()
  *
  * Writes to the trace_seq @s the list of plugins (files) that is
- * returned by traceevent_load_plugins(). Use @prefix and @suffix for formating:
+ * returned by tep_load_plugins(). Use @prefix and @suffix for formating:
  * @prefix = "  ", @suffix = "\n".
  */
 void traceevent_print_plugins(struct trace_seq *s,
@@ -431,7 +431,7 @@ load_plugins(struct tep_handle *pevent, const char *suffix,
 }
 
 struct plugin_list*
-traceevent_load_plugins(struct tep_handle *pevent)
+tep_load_plugins(struct tep_handle *pevent)
 {
 	struct plugin_list *list = NULL;
 
@@ -440,7 +440,7 @@ traceevent_load_plugins(struct tep_handle *pevent)
 }
 
 void
-traceevent_unload_plugins(struct plugin_list *plugin_list, struct tep_handle *pevent)
+tep_unload_plugins(struct plugin_list *plugin_list, struct tep_handle *pevent)
 {
 	tep_plugin_unload_func func;
 	struct plugin_list *list;
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 679c93644a08..3102e8be81f5 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -31,7 +31,7 @@ int trace_event__init(struct trace_event *t)
 	struct tep_handle *pevent = tep_alloc();
 
 	if (pevent) {
-		t->plugin_list = traceevent_load_plugins(pevent);
+		t->plugin_list = tep_load_plugins(pevent);
 		t->pevent  = pevent;
 	}
 
@@ -40,7 +40,7 @@ int trace_event__init(struct trace_event *t)
 
 static int trace_event__init2(void)
 {
-	int be = traceevent_host_bigendian();
+	int be = tep_host_bigendian();
 	struct tep_handle *pevent;
 
 	if (trace_event__init(&tevent))
@@ -65,7 +65,7 @@ int trace_event__register_resolver(struct machine *machine,
 
 void trace_event__cleanup(struct trace_event *t)
 {
-	traceevent_unload_plugins(t->plugin_list, t->pevent);
+	tep_unload_plugins(t->plugin_list, t->pevent);
 	tep_free(t->pevent);
 }
 
-- 
2.18.0


