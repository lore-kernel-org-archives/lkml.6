Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeBQFvi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:51:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:1065 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbeBQFtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863389"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 12/17] trace doc: convert trace/events-nmi.txt to rst format
Date: Sat, 17 Feb 2018 13:39:45 +0800
Message-Id: <1518845990-20733-13-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This converts the plain text documentation to reStructuredText format and
add it into Sphinx TOC tree. No essential content change.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 Documentation/trace/events-nmi.rst | 45 ++++++++++++++++++++++++++++++++++++++
 Documentation/trace/events-nmi.txt | 43 ------------------------------------
 Documentation/trace/index.rst      |  1 +
 3 files changed, 46 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/trace/events-nmi.rst
 delete mode 100644 Documentation/trace/events-nmi.txt

diff --git a/Documentation/trace/events-nmi.rst b/Documentation/trace/events-nmi.rst
new file mode 100644
index 0000000..9e0a728
--- /dev/null
+++ b/Documentation/trace/events-nmi.rst
@@ -0,0 +1,45 @@
+================
+NMI Trace Events
+================
+
+These events normally show up here:
+
+	/sys/kernel/debug/tracing/events/nmi
+
+
+nmi_handler
+-----------
+
+You might want to use this tracepoint if you suspect that your
+NMI handlers are hogging large amounts of CPU time.  The kernel
+will warn if it sees long-running handlers::
+
+	INFO: NMI handler took too long to run: 9.207 msecs
+
+and this tracepoint will allow you to drill down and get some
+more details.
+
+Let's say you suspect that perf_event_nmi_handler() is causing
+you some problems and you only want to trace that handler
+specifically.  You need to find its address::
+
+	$ grep perf_event_nmi_handler /proc/kallsyms
+	ffffffff81625600 t perf_event_nmi_handler
+
+Let's also say you are only interested in when that function is
+really hogging a lot of CPU time, like a millisecond at a time.
+Note that the kernel's output is in milliseconds, but the input
+to the filter is in nanoseconds!  You can filter on 'delta_ns'::
+
+	cd /sys/kernel/debug/tracing/events/nmi/nmi_handler
+	echo 'handler==0xffffffff81625600 && delta_ns>1000000' > filter
+	echo 1 > enable
+
+Your output would then look like::
+
+	$ cat /sys/kernel/debug/tracing/trace_pipe
+	<idle>-0     [000] d.h3   505.397558: nmi_handler: perf_event_nmi_handler() delta_ns: 3236765 handled: 1
+	<idle>-0     [000] d.h3   505.805893: nmi_handler: perf_event_nmi_handler() delta_ns: 3174234 handled: 1
+	<idle>-0     [000] d.h3   506.158206: nmi_handler: perf_event_nmi_handler() delta_ns: 3084642 handled: 1
+	<idle>-0     [000] d.h3   506.334346: nmi_handler: perf_event_nmi_handler() delta_ns: 3080351 handled: 1
+
diff --git a/Documentation/trace/events-nmi.txt b/Documentation/trace/events-nmi.txt
deleted file mode 100644
index c03c8c8..0000000
--- a/Documentation/trace/events-nmi.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-NMI Trace Events
-
-These events normally show up here:
-
-	/sys/kernel/debug/tracing/events/nmi
-
---
-
-nmi_handler:
-
-You might want to use this tracepoint if you suspect that your
-NMI handlers are hogging large amounts of CPU time.  The kernel
-will warn if it sees long-running handlers:
-
-	INFO: NMI handler took too long to run: 9.207 msecs
-
-and this tracepoint will allow you to drill down and get some
-more details.
-
-Let's say you suspect that perf_event_nmi_handler() is causing
-you some problems and you only want to trace that handler
-specifically.  You need to find its address:
-
-	$ grep perf_event_nmi_handler /proc/kallsyms
-	ffffffff81625600 t perf_event_nmi_handler
-
-Let's also say you are only interested in when that function is
-really hogging a lot of CPU time, like a millisecond at a time.
-Note that the kernel's output is in milliseconds, but the input
-to the filter is in nanoseconds!  You can filter on 'delta_ns':
-
-cd /sys/kernel/debug/tracing/events/nmi/nmi_handler
-echo 'handler==0xffffffff81625600 && delta_ns>1000000' > filter
-echo 1 > enable
-
-Your output would then look like:
-
-$ cat /sys/kernel/debug/tracing/trace_pipe
-<idle>-0     [000] d.h3   505.397558: nmi_handler: perf_event_nmi_handler() delta_ns: 3236765 handled: 1
-<idle>-0     [000] d.h3   505.805893: nmi_handler: perf_event_nmi_handler() delta_ns: 3174234 handled: 1
-<idle>-0     [000] d.h3   506.158206: nmi_handler: perf_event_nmi_handler() delta_ns: 3084642 handled: 1
-<idle>-0     [000] d.h3   506.334346: nmi_handler: perf_event_nmi_handler() delta_ns: 3080351 handled: 1
-
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 309c9c5..f4a8fbc 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -15,3 +15,4 @@ Linux Tracing Technologies
    events
    events-kmem
    events-power
+   events-nmi
-- 
2.7.4
