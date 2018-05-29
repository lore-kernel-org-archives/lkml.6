Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935621AbeE2P0T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935544AbeE2PXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:32 -0400
Message-Id: <20180529152327.788724899@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 13/19] ftrace/selftest: Have the reset_trigger code be a bit more careful
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0013-ftrace-selftest-Have-the-reset_trigger-code-be-a-bit.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The trigger code is picky in how it can be disabled as there may be
dependencies between different events and synthetic events. Change the order
on how triggers are reset.

 1) Reset triggers of all synthetic events first
 2) Remove triggers with actions attached to them
 3) Remove all other triggers

If this order isn't followed, then some triggers will not be reset, and an
error may happen because a trigger is busy.

Cc: stable@vger.kernel.org
Fixes: cfa0963dc474f ("kselftests/ftrace : Add event trigger testcases")
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../testing/selftests/ftrace/test.d/functions | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 2a4f16fc9819..8393b1c06027 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -15,14 +15,29 @@ reset_tracer() { # reset the current tracer
     echo nop > current_tracer
 }
 
-reset_trigger() { # reset all current setting triggers
-    grep -v ^# events/*/*/trigger |
+reset_trigger_file() {
+    # remove action triggers first
+    grep -H ':on[^:]*(' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+    grep -Hv ^# $@ |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
-	echo "!$cmd" > `echo $line | cut -f1 -d:`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" > $file
     done
 }
 
+reset_trigger() { # reset all current setting triggers
+    if [ -d events/synthetic ]; then
+        reset_trigger_file events/synthetic/*/trigger
+    fi
+    reset_trigger_file events/*/*/trigger
+}
+
 reset_events_filter() { # reset all current setting filters
     grep -v ^none events/*/*/filter |
     while read line; do
-- 
2.17.0
