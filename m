Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754810AbeBGU2Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:28:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754157AbeBGU2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F087A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202814.871789079@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 02/20 v2] tracing: Add documentation for function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-Add-documentation-for-function-based-events.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Start documenting the usage of function based events. This only gives an
introduction for the function based events. As new features are added to
them, those features will be documented in this document.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/trace/function-based-events.rst

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
new file mode 100644
index 000000000000..843a1bf76459
--- /dev/null
+++ b/Documentation/trace/function-based-events.rst
@@ -0,0 +1,69 @@
+=====================
+Function based events
+=====================
+
+.. Copyright 2018 VMware Inc.
+..   Author:   Steven Rostedt <srostedt@goodmis.org>
+..  License:   The GNU Free Documentation License, Version 1.2
+..               (dual licensed under the GPL v2)
+
+
+Introduction
+============
+
+Static events are extremely useful for analyzing the happenings of
+inside the Linux kernel. But there are times where events are not
+available, either due to not being in control of the kernel, or simply
+because a maintainer refuses to have them in their subsystem.
+
+The function tracer is a way trace within a subsystem without trace events.
+But it only provides information of when a function was hit and who
+called it. Combining trace events with the function tracer allows
+for dynamically creating trace events where they do not exist at
+function entry. They provide more information than the function
+tracer can provide, as they can read the parameters of a function
+or simply read an address. This makes it possible to create a
+trace point at any function that the function tracer can trace, and
+read the parameters of the function.
+
+
+Usage
+=====
+
+Simply writing an ASCII string into a file called "function_events"
+in the tracefs file system will create the function based events.
+Note, this file is only writable by root.
+
+ # mount -t tracefs nodev /sys/kernel/tracing
+ # cd /sys/kernel/tracing
+ # echo 'do_IRQ()' > function_events
+
+The above will create a trace event on the do_IRQ function call.
+As no parameters were specified, it will not trace anything other
+than the function and the parent. This is the minimum function
+based event.
+
+ # ls events/functions/do_IRQ
+enable  filter  format  hist  id  trigger
+
+Even though the above function based event does not record much more
+than the function tracer does, it does become a full fledge event.
+This can be used by the histogram infrastructure, and triggers.
+
+ # cat events/functions/do_IRQ/format
+name: do_IRQ
+ID: 1304
+format:
+	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
+	field:int common_pid;	offset:4;	size:4;	signed:1;
+
+	field:unsigned long __parent_ip;	offset:8;	size:8;	signed:0;
+	field:unsigned long __ip;	offset:16;	size:8;	signed:0;
+
+print fmt: "%pS->%pS()", REC->__ip, REC->__parent_ip
+
+The above shows that the format is very close to the function trace
+except that it displays the parent function followed by the called
+function.
-- 
2.15.1
