Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8730C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95321723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E95321723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeHHSf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbeHHSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:33:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C169621A74;
        Wed,  8 Aug 2018 16:13:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fnR5A-0002Wq-Pt; Wed, 08 Aug 2018 12:13:08 -0400
Message-Id: <20180808161308.702359118@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 Aug 2018 11:56:00 -0400
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
Subject: [RFC][PATCH 12/24] tools/lib/traceevent, tools/perf: Rename enum pevent_flag to enum
 tep_flag
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
pevent_get_page_size API and enum pevent_flag to enum tep_flag

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c  |  2 +-
 tools/lib/traceevent/event-parse.h  | 10 +++++-----
 tools/lib/traceevent/event-plugin.c |  4 ++--
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/util/trace-event-read.c  |  2 +-
 tools/perf/util/trace-event.c       |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 2667c18db27c..cfb86b789da6 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5515,7 +5515,7 @@ void tep_print_event_time(struct tep_handle *pevent, struct trace_seq *s,
 	}
 
 	if (use_usec_format) {
-		if (pevent->flags & PEVENT_NSEC_OUTPUT) {
+		if (pevent->flags & TEP_NSEC_OUTPUT) {
 			usecs = nsecs;
 			p = 9;
 		} else {
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 97abeaced9c3..97deb15f5355 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -373,10 +373,10 @@ enum pevent_func_arg_type {
 	PEVENT_FUNC_ARG_MAX_TYPES
 };
 
-enum pevent_flag {
-	PEVENT_NSEC_OUTPUT		= 1,	/* output in NSECS */
-	PEVENT_DISABLE_SYS_PLUGINS	= 1 << 1,
-	PEVENT_DISABLE_PLUGINS		= 1 << 2,
+enum tep_flag {
+	TEP_NSEC_OUTPUT		= 1,	/* output in NSECS */
+	TEP_DISABLE_SYS_PLUGINS	= 1 << 1,
+	TEP_DISABLE_PLUGINS	= 1 << 2,
 };
 
 #define PEVENT_ERRORS 							      \
@@ -751,7 +751,7 @@ static inline void tep_set_long_size(struct tep_handle *pevent, int long_size)
 	pevent->long_size = long_size;
 }
 
-static inline int pevent_get_page_size(struct tep_handle *pevent)
+static inline int tep_get_page_size(struct tep_handle *pevent)
 {
 	return pevent->page_size;
 }
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index 39859cee7712..c837a73c03e6 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -390,7 +390,7 @@ load_plugins(struct tep_handle *pevent, const char *suffix,
 	char *envdir;
 	int ret;
 
-	if (pevent->flags & PEVENT_DISABLE_PLUGINS)
+	if (pevent->flags & TEP_DISABLE_PLUGINS)
 		return;
 
 	/*
@@ -398,7 +398,7 @@ load_plugins(struct tep_handle *pevent, const char *suffix,
 	 * check that first.
 	 */
 #ifdef PLUGIN_DIR
-	if (!(pevent->flags & PEVENT_DISABLE_SYS_PLUGINS))
+	if (!(pevent->flags & TEP_DISABLE_SYS_PLUGINS))
 		load_plugins_dir(pevent, suffix, PLUGIN_DIR,
 				 load_plugin, data);
 #endif
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 73c073ade71c..b63bca4b0c2a 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1974,7 +1974,7 @@ int cmd_kmem(int argc, const char **argv)
 			goto out_delete;
 		}
 
-		kmem_page_size = pevent_get_page_size(evsel->tp_format->pevent);
+		kmem_page_size = tep_get_page_size(evsel->tp_format->pevent);
 		symbol_conf.use_callchain = true;
 	}
 
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index d970163f0145..3dfc1db6b25b 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -439,7 +439,7 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 
 	pevent = tevent->pevent;
 
-	tep_set_flag(pevent, PEVENT_NSEC_OUTPUT);
+	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
 	tep_set_file_bigendian(pevent, file_bigendian);
 	tep_set_host_bigendian(pevent, host_bigendian);
 
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 3102e8be81f5..58bb72f266f3 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -47,7 +47,7 @@ static int trace_event__init2(void)
 		return -1;
 
 	pevent = tevent.pevent;
-	tep_set_flag(pevent, PEVENT_NSEC_OUTPUT);
+	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
 	tep_set_file_bigendian(pevent, be);
 	tep_set_host_bigendian(pevent, be);
 	tevent_initialized = true;
-- 
2.18.0


