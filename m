Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82167C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA2D2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA2D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeH2Coa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeH2Coa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:44:30 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6422087A;
        Tue, 28 Aug 2018 22:50:40 +0000 (UTC)
Date:   Tue, 28 Aug 2018 18:50:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] tools lib traceevent, perf tools: Split trace-seq related
 APIs in a separate header file
Message-ID: <20180828185038.2dcb2743@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, all its APIs should be
defined in corresponding header files.  This patch splits trace-seq related
APIs in a separate header file: trace-seq.h

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c         |  1 +
 tools/lib/traceevent/event-parse.h         | 46 ++-----------------------
 tools/lib/traceevent/event-plugin.c        |  1 +
 tools/lib/traceevent/plugin_function.c     |  1 +
 tools/lib/traceevent/plugin_hrtimer.c      |  1 +
 tools/lib/traceevent/plugin_jbd2.c         |  1 +
 tools/lib/traceevent/plugin_kmem.c         |  1 +
 tools/lib/traceevent/plugin_kvm.c          |  1 +
 tools/lib/traceevent/plugin_mac80211.c     |  1 +
 tools/lib/traceevent/plugin_sched_switch.c |  1 +
 tools/lib/traceevent/plugin_scsi.c         |  1 +
 tools/lib/traceevent/plugin_xen.c          |  1 +
 tools/lib/traceevent/trace-seq.c           |  2 ++
 tools/lib/traceevent/trace-seq.h           | 55 ++++++++++++++++++++++++++++++
 tools/perf/util/trace-event.h              |  1 +
 15 files changed, 71 insertions(+), 44 deletions(-)
 create mode 100644 tools/lib/traceevent/trace-seq.h

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index ce1e20227c64..70a42bec6931 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -24,6 +24,7 @@
 #include <netinet/in.h>
 #include "event-parse.h"
 #include "event-utils.h"
+#include "trace-seq.h"
 
 static const char *input_buf;
 static unsigned long long input_buf_ptr;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 44b7c2d41f9f..fa665c66bfa4 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -26,17 +26,12 @@
 #include <regex.h>
 #include <string.h>
 
+#include "trace-seq.h"
+
 #ifndef __maybe_unused
 #define __maybe_unused __attribute__((unused))
 #endif
 
-/* ----------------------- trace_seq ----------------------- */
-
-
-#ifndef TRACE_SEQ_BUF_SIZE
-#define TRACE_SEQ_BUF_SIZE 4096
-#endif
-
 #ifndef DEBUG_RECORD
 #define DEBUG_RECORD 0
 #endif
@@ -59,43 +54,6 @@ struct tep_record {
 #endif
 };
 
-enum trace_seq_fail {
-	TRACE_SEQ__GOOD,
-	TRACE_SEQ__BUFFER_POISONED,
-	TRACE_SEQ__MEM_ALLOC_FAILED,
-};
-
-/*
- * Trace sequences are used to allow a function to call several other functions
- * to create a string of data to use (up to a max of PAGE_SIZE).
- */
-
-struct trace_seq {
-	char			*buffer;
-	unsigned int		buffer_size;
-	unsigned int		len;
-	unsigned int		readpos;
-	enum trace_seq_fail	state;
-};
-
-void trace_seq_init(struct trace_seq *s);
-void trace_seq_reset(struct trace_seq *s);
-void trace_seq_destroy(struct trace_seq *s);
-
-extern int trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
-	__attribute__ ((format (printf, 2, 3)));
-extern int trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
-	__attribute__ ((format (printf, 2, 0)));
-
-extern int trace_seq_puts(struct trace_seq *s, const char *str);
-extern int trace_seq_putc(struct trace_seq *s, unsigned char c);
-
-extern void trace_seq_terminate(struct trace_seq *s);
-
-extern int trace_seq_do_fprintf(struct trace_seq *s, FILE *fp);
-extern int trace_seq_do_printf(struct trace_seq *s);
-
-
 /* ----------------------- pevent ----------------------- */
 
 struct tep_handle;
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index f17e25097e1e..ec16a103c0cc 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -15,6 +15,7 @@
 #include <dirent.h>
 #include "event-parse.h"
 #include "event-utils.h"
+#include "trace-seq.h"
 
 #define LOCAL_PLUGIN_DIR ".traceevent/plugins"
 
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugin_function.c
index 424747475d37..2919042e7dc2 100644
--- a/tools/lib/traceevent/plugin_function.c
+++ b/tools/lib/traceevent/plugin_function.c
@@ -23,6 +23,7 @@
 
 #include "event-parse.h"
 #include "event-utils.h"
+#include "trace-seq.h"
 
 static struct func_stack {
 	int size;
diff --git a/tools/lib/traceevent/plugin_hrtimer.c b/tools/lib/traceevent/plugin_hrtimer.c
index b43bfec565d8..29b608076ea0 100644
--- a/tools/lib/traceevent/plugin_hrtimer.c
+++ b/tools/lib/traceevent/plugin_hrtimer.c
@@ -23,6 +23,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 static int timer_expire_handler(struct trace_seq *s,
 				struct tep_record *record,
diff --git a/tools/lib/traceevent/plugin_jbd2.c b/tools/lib/traceevent/plugin_jbd2.c
index 45a9acd19640..a5e34135dd6a 100644
--- a/tools/lib/traceevent/plugin_jbd2.c
+++ b/tools/lib/traceevent/plugin_jbd2.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #define MINORBITS	20
 #define MINORMASK	((1U << MINORBITS) - 1)
diff --git a/tools/lib/traceevent/plugin_kmem.c b/tools/lib/traceevent/plugin_kmem.c
index 73966b05abce..a7a162575e2c 100644
--- a/tools/lib/traceevent/plugin_kmem.c
+++ b/tools/lib/traceevent/plugin_kmem.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 static int call_site_handler(struct trace_seq *s, struct tep_record *record,
 			     struct event_format *event, void *context)
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 1d0d15906225..a0dfd3d0f197 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -23,6 +23,7 @@
 #include <stdint.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #ifdef HAVE_UDIS86
 
diff --git a/tools/lib/traceevent/plugin_mac80211.c b/tools/lib/traceevent/plugin_mac80211.c
index de50a5316203..0b7779444b63 100644
--- a/tools/lib/traceevent/plugin_mac80211.c
+++ b/tools/lib/traceevent/plugin_mac80211.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #define INDENT 65
 
diff --git a/tools/lib/traceevent/plugin_sched_switch.c b/tools/lib/traceevent/plugin_sched_switch.c
index eecb4bd95c11..582d3be2849b 100644
--- a/tools/lib/traceevent/plugin_sched_switch.c
+++ b/tools/lib/traceevent/plugin_sched_switch.c
@@ -22,6 +22,7 @@
 #include <string.h>
 
 #include "event-parse.h"
+#include "trace-seq.h"
 
 static void write_state(struct trace_seq *s, int val)
 {
diff --git a/tools/lib/traceevent/plugin_scsi.c b/tools/lib/traceevent/plugin_scsi.c
index 5ec346f6b842..4eba25cc1431 100644
--- a/tools/lib/traceevent/plugin_scsi.c
+++ b/tools/lib/traceevent/plugin_scsi.c
@@ -3,6 +3,7 @@
 #include <string.h>
 #include <inttypes.h>
 #include "event-parse.h"
+#include "trace-seq.h"
 
 typedef unsigned long sector_t;
 typedef uint64_t u64;
diff --git a/tools/lib/traceevent/plugin_xen.c b/tools/lib/traceevent/plugin_xen.c
index b2acbd6e9c86..bc0496e4c296 100644
--- a/tools/lib/traceevent/plugin_xen.c
+++ b/tools/lib/traceevent/plugin_xen.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include "event-parse.h"
+#include "trace-seq.h"
 
 #define __HYPERVISOR_set_trap_table			0
 #define __HYPERVISOR_mmu_update				1
diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index e3bac4543d3b..8ff1d55954d1 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2009 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
  */
+#include "trace-seq.h"
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/lib/traceevent/trace-seq.h b/tools/lib/traceevent/trace-seq.h
new file mode 100644
index 000000000000..d68ec69f8d1a
--- /dev/null
+++ b/tools/lib/traceevent/trace-seq.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
+ *
+ */
+
+#ifndef _TRACE_SEQ_H
+#define _TRACE_SEQ_H
+
+#include <stdarg.h>
+#include <stdio.h>
+
+/* ----------------------- trace_seq ----------------------- */
+
+#ifndef TRACE_SEQ_BUF_SIZE
+#define TRACE_SEQ_BUF_SIZE 4096
+#endif
+
+enum trace_seq_fail {
+	TRACE_SEQ__GOOD,
+	TRACE_SEQ__BUFFER_POISONED,
+	TRACE_SEQ__MEM_ALLOC_FAILED,
+};
+
+/*
+ * Trace sequences are used to allow a function to call several other functions
+ * to create a string of data to use (up to a max of PAGE_SIZE).
+ */
+
+struct trace_seq {
+	char			*buffer;
+	unsigned int		buffer_size;
+	unsigned int		len;
+	unsigned int		readpos;
+	enum trace_seq_fail	state;
+};
+
+void trace_seq_init(struct trace_seq *s);
+void trace_seq_reset(struct trace_seq *s);
+void trace_seq_destroy(struct trace_seq *s);
+
+extern int trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+extern int trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
+	__attribute__ ((format (printf, 2, 0)));
+
+extern int trace_seq_puts(struct trace_seq *s, const char *str);
+extern int trace_seq_putc(struct trace_seq *s, unsigned char c);
+
+extern void trace_seq_terminate(struct trace_seq *s);
+
+extern int trace_seq_do_fprintf(struct trace_seq *s, FILE *fp);
+extern int trace_seq_do_printf(struct trace_seq *s);
+
+#endif /* _TRACE_SEQ_H */
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 40204ec3a7a2..c69d77d7cf55 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -3,6 +3,7 @@
 #define _PERF_UTIL_TRACE_EVENT_H
 
 #include <traceevent/event-parse.h>
+#include <traceevent/trace-seq.h>
 #include "parse-events.h"
 
 struct machine;
-- 
2.13.6

