Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936777AbeE2P0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935545AbeE2PXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:32 -0400
Message-Id: <20180529152327.931763476@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [for-next][PATCH 14/19] ftrace/selftest: Fix reset_trigger() to handle triggers with filters
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0014-ftrace-selftest-Fix-reset_trigger-to-handle-triggers.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The reset_trigger() function breaks up the command by a space ' '. This is
useful to ignore the '[active]' word for triggers when removing them. But if
the trigger has a filter (ie. "if prio < 10") then the filter needs to be
attached to the line that is written into the trigger file to remove it. But
the truncation removes the filter and the triggers are not cleared properly.

Before, reset_trigger() did this:

 # echo 'hist:keys=common_pid if prev_prio < 10' > events/sched/sched_switch/trigger
 # echo 'hist:keys=common_pid if next_prio < 10' >> events/sched/sched_switch/trigger
 # cat events/sched/sched_switch/trigger
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if prev_prio < 10 [active]
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if next_prio < 10 [active]

 reset_trigger() {
   echo '!hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048' >> events/sched/sched_switch/trigger
 }

 # cat events/sched/sched_switch/trigger
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if prev_prio < 10 [active]
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if next_prio < 10 [active]

After, where it includes the filter:

 reset_trigger() {
   echo '!hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if prev_prio < 10' >> events/sched/sched_switch/trigger
 }

 # cat events/sched/sched_switch/trigger
hist:keys=common_pid:vals=hitcount:sort=hitcount:size=2048 if next_prio < 10 [active]

Fixes: cfa0963dc474f ("kselftests/ftrace : Add event trigger testcases")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 8393b1c06027..e4645d5e3126 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -19,13 +19,13 @@ reset_trigger_file() {
     # remove action triggers first
     grep -H ':on[^:]*(' $@ |
     while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
     done
     grep -Hv ^# $@ |
     while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" > $file
     done
-- 
2.17.0
