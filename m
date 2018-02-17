Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeBQFuP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:50:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:59982 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeBQFtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863408"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 14/17] trace doc: convert trace/mmiotrace.txt to rst format
Date: Sat, 17 Feb 2018 13:39:47 +0800
Message-Id: <1518845990-20733-15-git-send-email-changbin.du@intel.com>
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
 Documentation/trace/index.rst                      |  1 +
 .../trace/{mmiotrace.txt => mmiotrace.rst}         | 86 +++++++++++++---------
 2 files changed, 54 insertions(+), 33 deletions(-)
 rename Documentation/trace/{mmiotrace.txt => mmiotrace.rst} (78%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 307468d..4b3d690 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -17,3 +17,4 @@ Linux Tracing Technologies
    events-power
    events-nmi
    events-msr
+   mmiotrace
diff --git a/Documentation/trace/mmiotrace.txt b/Documentation/trace/mmiotrace.rst
similarity index 78%
rename from Documentation/trace/mmiotrace.txt
rename to Documentation/trace/mmiotrace.rst
index 664e738..5116e8c 100644
--- a/Documentation/trace/mmiotrace.txt
+++ b/Documentation/trace/mmiotrace.rst
@@ -1,4 +1,6 @@
-		In-kernel memory-mapped I/O tracing
+===================================
+In-kernel memory-mapped I/O tracing
+===================================
 
 
 Home page and links to optional user space tools:
@@ -31,30 +33,35 @@ is no way to automatically detect if you are losing events due to CPUs racing.
 
 Usage Quick Reference
 ---------------------
+::
 
-$ mount -t debugfs debugfs /sys/kernel/debug
-$ echo mmiotrace > /sys/kernel/debug/tracing/current_tracer
-$ cat /sys/kernel/debug/tracing/trace_pipe > mydump.txt &
-Start X or whatever.
-$ echo "X is up" > /sys/kernel/debug/tracing/trace_marker
-$ echo nop > /sys/kernel/debug/tracing/current_tracer
-Check for lost events.
+	$ mount -t debugfs debugfs /sys/kernel/debug
+	$ echo mmiotrace > /sys/kernel/debug/tracing/current_tracer
+	$ cat /sys/kernel/debug/tracing/trace_pipe > mydump.txt &
+	Start X or whatever.
+	$ echo "X is up" > /sys/kernel/debug/tracing/trace_marker
+	$ echo nop > /sys/kernel/debug/tracing/current_tracer
+	Check for lost events.
 
 
 Usage
 -----
 
 Make sure debugfs is mounted to /sys/kernel/debug.
-If not (requires root privileges):
-$ mount -t debugfs debugfs /sys/kernel/debug
+If not (requires root privileges)::
+
+	$ mount -t debugfs debugfs /sys/kernel/debug
 
 Check that the driver you are about to trace is not loaded.
 
-Activate mmiotrace (requires root privileges):
-$ echo mmiotrace > /sys/kernel/debug/tracing/current_tracer
+Activate mmiotrace (requires root privileges)::
+
+	$ echo mmiotrace > /sys/kernel/debug/tracing/current_tracer
+
+Start storing the trace::
+
+	$ cat /sys/kernel/debug/tracing/trace_pipe > mydump.txt &
 
-Start storing the trace:
-$ cat /sys/kernel/debug/tracing/trace_pipe > mydump.txt &
 The 'cat' process should stay running (sleeping) in the background.
 
 Load the driver you want to trace and use it. Mmiotrace will only catch MMIO
@@ -66,30 +73,42 @@ This makes it easier to see which part of the (huge) trace corresponds to
 which action. It is recommended to place descriptive markers about what you
 do.
 
-Shut down mmiotrace (requires root privileges):
-$ echo nop > /sys/kernel/debug/tracing/current_tracer
+Shut down mmiotrace (requires root privileges)::
+
+	$ echo nop > /sys/kernel/debug/tracing/current_tracer
+
 The 'cat' process exits. If it does not, kill it by issuing 'fg' command and
 pressing ctrl+c.
 
-Check that mmiotrace did not lose events due to a buffer filling up. Either
-$ grep -i lost mydump.txt
-which tells you exactly how many events were lost, or use
-$ dmesg
+Check that mmiotrace did not lose events due to a buffer filling up. Either::
+
+	$ grep -i lost mydump.txt
+
+which tells you exactly how many events were lost, or use::
+
+	$ dmesg
+
 to view your kernel log and look for "mmiotrace has lost events" warning. If
 events were lost, the trace is incomplete. You should enlarge the buffers and
 try again. Buffers are enlarged by first seeing how large the current buffers
-are:
-$ cat /sys/kernel/debug/tracing/buffer_size_kb
+are::
+
+	$ cat /sys/kernel/debug/tracing/buffer_size_kb
+
 gives you a number. Approximately double this number and write it back, for
-instance:
-$ echo 128000 > /sys/kernel/debug/tracing/buffer_size_kb
+instance::
+
+	$ echo 128000 > /sys/kernel/debug/tracing/buffer_size_kb
+
 Then start again from the top.
 
 If you are doing a trace for a driver project, e.g. Nouveau, you should also
-do the following before sending your results:
-$ lspci -vvv > lspci.txt
-$ dmesg > dmesg.txt
-$ tar zcf pciid-nick-mmiotrace.tar.gz mydump.txt lspci.txt dmesg.txt
+do the following before sending your results::
+
+	$ lspci -vvv > lspci.txt
+	$ dmesg > dmesg.txt
+	$ tar zcf pciid-nick-mmiotrace.tar.gz mydump.txt lspci.txt dmesg.txt
+
 and then send the .tar.gz file. The trace compresses considerably. Replace
 "pciid" and "nick" with the PCI ID or model name of your piece of hardware
 under investigation and your nickname.
@@ -148,17 +167,18 @@ zero if it is not recorded. PID is always zero as tracing MMIO accesses
 originating in user space memory is not yet supported.
 
 For instance, the following awk filter will pass all 32-bit writes that target
-physical addresses in the range [0xfb73ce40, 0xfb800000[
+physical addresses in the range [0xfb73ce40, 0xfb800000]
+::
 
-$ awk '/W 4 / { adr=strtonum($5); if (adr >= 0xfb73ce40 &&
-adr < 0xfb800000) print; }'
+	$ awk '/W 4 / { adr=strtonum($5); if (adr >= 0xfb73ce40 &&
+	adr < 0xfb800000) print; }'
 
 
 Tools for Developers
 --------------------
 
 The user space tools include utilities for:
-- replacing numeric addresses and values with hardware register names
-- replaying MMIO logs, i.e., re-executing the recorded writes
+  - replacing numeric addresses and values with hardware register names
+  - replaying MMIO logs, i.e., re-executing the recorded writes
 
 
-- 
2.7.4
