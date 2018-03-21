Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeCUCXr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbeCUCVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E6C21856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022130.353736860@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 38/46] selftests: ftrace: Add inter-event hist triggers testcases
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0038-selftests-ftrace-Add-inter-event-hist-triggers-testc.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajvi Jingar <rajvi.jingar@intel.com>

    This adds inter-event hist triggers testcases which covers following:
     - create/remove synthetic event
     - disable histogram for synthetic event
     - extended error support
     - field variable support
     - histogram variables
     - histogram trigger onmatch action
     - histogram trigger onmax action
     - histogram trigger onmatch-onmax action
     - simple expression support
     - combined histogram

    Here is the test result.
    === Ftrace unit tests ===
    [1] event trigger - test extended error support [PASS]
    [2] event trigger - test field variable support [PASS]
    [3] event trigger - test inter-event combined histogram trigger [PASS]
    [4] event trigger - test inter-event histogram trigger onmatch action   [PASS]
    [5] event trigger - test inter-event histogram trigger onmatch-onmax action     [PASS]
    [6] event trigger - test inter-event histogram trigger onmax action     [PASS]
    [7] event trigger - test synthetic event create remove  [PASS]

Link: http://lkml.kernel.org/r/e07ef1e72f7bf0f84dc87c9b736d6dc91b4b0b49.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions    |  7 +++
 .../inter-event/trigger-extended-error-support.tc  | 39 +++++++++++++++
 .../inter-event/trigger-field-variable-support.tc  | 54 ++++++++++++++++++++
 .../trigger-inter-event-combined-hist.tc           | 58 ++++++++++++++++++++++
 .../inter-event/trigger-onmatch-action-hist.tc     | 50 +++++++++++++++++++
 .../trigger-onmatch-onmax-action-hist.tc           | 50 +++++++++++++++++++
 .../inter-event/trigger-onmax-action-hist.tc       | 48 ++++++++++++++++++
 .../trigger-synthetic-event-createremove.tc        | 54 ++++++++++++++++++++
 8 files changed, 360 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index df3dd7fe5f9b..2a4f16fc9819 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -59,6 +59,13 @@ disable_events() {
     echo 0 > events/enable
 }
 
+clear_synthetic_events() { # reset all current synthetic events
+    grep -v ^# synthetic_events |
+    while read line; do
+        echo "!$line" >> synthetic_events
+    done
+}
+
 initialize_ftrace() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
new file mode 100644
index 000000000000..786dce7e48be
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# description: event trigger - test extended error support
+
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+reset_tracer
+do_reset
+
+echo "Test extended error support"
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger &>/dev/null
+if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
+    fail "Failed to generate extended error in histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
new file mode 100644
index 000000000000..7fd5b4a8f060
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -0,0 +1,54 @@
+#!/bin/sh
+# description: event trigger - test field variable support
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test field variable support"
+
+echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
+echo 'hist:keys=comm:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_waking/trigger
+echo 'hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
+echo 'hist:keys=pid,prio,comm:vals=lat:sort=pid,prio' > events/synthetic/wakeup_latency/trigger
+
+ping localhost -c 3
+if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
+    fail "Failed to create inter-event histogram"
+fi
+
+if ! grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
+    fail "Failed to create histogram with field variable"
+fi
+
+echo '!hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
+
+if grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
+    fail "Failed to remove histogram with field variable"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
new file mode 100644
index 000000000000..c93dbe38b5df
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -0,0 +1,58 @@
+#!/bin/sh
+# description: event trigger - test inter-event combined histogram trigger
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+reset_tracer
+do_reset
+clear_synthetic_events
+
+echo "Test create synthetic event"
+
+echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
+if [ ! -d events/synthetic/waking_latency ]; then
+    fail "Failed to create waking_latency synthetic event"
+fi
+
+echo "Test combined histogram"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_waking/trigger
+echo 'hist:keys=pid:waking_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).waking_latency($waking_lat,pid) if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=pid,lat:sort=pid,lat' > events/synthetic/waking_latency/trigger
+
+echo 'wakeup_latency u64 lat pid_t pid' >> synthetic_events
+echo 'hist:keys=pid:ts1=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts1:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid) if next_comm=="ping"' > events/sched/sched_switch/trigger
+
+echo 'waking+wakeup_latency u64 lat; pid_t pid' >> synthetic_events
+echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking+wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
+echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking+wakeup_latency/trigger
+
+ping localhost -c 3
+if ! grep -q "pid:" events/synthetic/waking+wakeup_latency/hist; then
+    fail "Failed to create combined histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
new file mode 100644
index 000000000000..e84e7d048566
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger onmatch action
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test create histogram for synthetic event"
+echo "Test histogram variables,simple expression support and onmatch action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
+echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
+ping localhost -c 5
+if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
+    fail "Failed to create onmatch action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
new file mode 100644
index 000000000000..7907d8aacde3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger onmatch-onmax action
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test create histogram for synthetic event"
+echo "Test histogram variables,simple expression support and onmatch-onmax action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm):onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
+echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
+ping localhost -c 5
+if [ ! grep -q "ping" events/synthetic/wakeup_latency/hist -o ! grep -q "max:" events/sched/sched_switch/hist]; then
+    fail "Failed to create onmatch-onmax action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
new file mode 100644
index 000000000000..38b7ed6242b2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -0,0 +1,48 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger onmax action
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test onmax action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_waking/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
+ping localhost -c 3
+if ! grep -q "max:" events/sched/sched_switch/hist; then
+    fail "Failed to create onmax action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
new file mode 100644
index 000000000000..cef11377dcbd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
@@ -0,0 +1,54 @@
+#!/bin/sh
+# description: event trigger - test synthetic event create remove
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+reset_trigger
+
+echo "Test create synthetic event with an error"
+echo 'wakeup_latency  u64 lat pid_t pid char' > synthetic_events > /dev/null
+if [ -d events/synthetic/wakeup_latency ]; then
+    fail "Created wakeup_latency synthetic event with an invalid format"
+fi
+
+reset_trigger
+
+echo "Test remove synthetic event"
+echo '!wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to delete wakeup_latency synthetic event"
+fi
+
+do_reset
+
+exit 0
-- 
2.15.1
