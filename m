Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4CFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A482084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfBTSjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfBTSiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1881C21B25;
        Wed, 20 Feb 2019 18:38:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWkx-0006jZ-7P; Wed, 20 Feb 2019 13:38:07 -0500
Message-Id: <20190220183807.108498852@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:37:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 20/29] tracing: Add hist trigger snapshot() action Documentation
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add Documentation for the hist:handlerXXX($var).snapshot() action.

Link: http://lkml.kernel.org/r/445861d7822cd4b6aeaea1cecfcdbda466502148.1550100284.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 110 ++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 63e522107e59..353317bc3825 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1874,6 +1874,7 @@ The available actions are:
 
   - <synthetic_event_name>(param list)         - generate synthetic event
   - save(field,...)                            - save current event fields
+  - snapshot()                                 - snapshot the trace buffer
 
 The following commonly-used handler.action pairs are available:
 
@@ -2030,6 +2031,115 @@ The following commonly-used handler.action pairs are available:
             Entries: 2
             Dropped: 0
 
+  - onmax(var).snapshot()
+
+    The 'onmax(var).snapshot()' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    exceeds the current maximum contained in that variable.
+
+    The end result is that a global snapshot of the trace buffer will
+    be saved in the tracing/snapshot file if 'var' exceeds the current
+    maximum for any hist trigger entry.
+
+    Note that in this case the maximum is a global maximum for the
+    current trace instance, which is the maximum across all buckets of
+    the histogram.  The key of the specific trace event that caused
+    the global maximum and the global maximum itself are displayed,
+    along with a message stating that a snapshot has been taken and
+    where to find it.  The user can use the key information displayed
+    to locate the corresponding bucket in the histogram for even more
+    detail.
+
+    As an example the below defines a couple of hist triggers, one for
+    sched_waking and another for sched_switch, keyed on pid.  Whenever
+    a sched_waking event occurs, the timestamp is saved in the entry
+    corresponding to the current pid, and when the scheduler switches
+    back to that pid, the timestamp difference is calculated.  If the
+    resulting latency, stored in wakeup_lat, exceeds the current
+    maximum latency, a snapshot is taken.  As part of the setup, all
+    the scheduler events are also enabled, which are the events that
+    will show up in the snapshot when it is taken at some point:
+
+    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+
+    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
+            if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+
+    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
+            onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio, \
+	    prev_comm):onmax($wakeup_lat).snapshot() \
+	    if next_comm=="cyclictest"' >> \
+	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+
+    When the histogram is displayed, for each bucket the max value
+    and the saved values corresponding to the max are displayed
+    following the rest of the fields.
+
+    If a snaphot was taken, there is also a message indicating that,
+    along with the value and event that triggered the global maximum:
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+      { next_pid:       2101 } hitcount:        200
+	max:         52  next_prio:        120  next_comm: cyclictest \
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
+
+      { next_pid:       2103 } hitcount:       1326
+	max:        572  next_prio:         19  next_comm: cyclictest \
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+
+      { next_pid:       2102 } hitcount:       1982 \
+	max:         74  next_prio:         19  next_comm: cyclictest \
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/5
+
+    Snapshot taken (see tracing/snapshot).  Details:
+	triggering value { onmax($wakeup_lat) }:        572	\
+	triggered by event with key: { next_pid:       2103 }
+
+    Totals:
+        Hits: 3508
+        Entries: 3
+        Dropped: 0
+
+    In the above case, the event that triggered the global maximum has
+    the key with next_pid == 2103.  If you look at the bucket that has
+    2103 as the key, you'll find the additional values save()'d along
+    with the local maximum for that bucket, which should be the same
+    as the global maximum (since that was the same value that
+    triggered the global snapshot).
+
+    And finally, looking at the snapshot data should show at or near
+    the end the event that triggered the snapshot (in this case you
+    can verify the timestamps between the sched_waking and
+    sched_switch events, which should match the time displayed in the
+    global maximum):
+
+    # cat /sys/kernel/debug/tracing/snapshot
+
+     <...>-2103  [005] d..3   309.873125: sched_switch: prev_comm=cyclictest prev_pid=2103 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
+     <idle>-0     [005] d.h3   309.873611: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] dNh4   309.873613: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] d..3   309.873616: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
+     <...>-2102  [005] d..3   309.873625: sched_switch: prev_comm=cyclictest prev_pid=2102 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
+     <idle>-0     [005] d.h3   309.874624: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] dNh4   309.874626: sched_wakeup: comm=cyclictest pid=2102 prio=19 target_cpu=005
+     <idle>-0     [005] dNh3   309.874628: sched_waking: comm=cyclictest pid=2103 prio=19 target_cpu=005
+     <idle>-0     [005] dNh4   309.874630: sched_wakeup: comm=cyclictest pid=2103 prio=19 target_cpu=005
+     <idle>-0     [005] d..3   309.874633: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2102 next_prio=19
+     <idle>-0     [004] d.h3   309.874757: sched_waking: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
+     <idle>-0     [004] dNh4   309.874762: sched_wakeup: comm=gnome-terminal- pid=1699 prio=120 target_cpu=004
+     <idle>-0     [004] d..3   309.874766: sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=gnome-terminal- next_pid=1699 next_prio=120
+ gnome-terminal--1699  [004] d.h2   309.874941: sched_stat_runtime: comm=gnome-terminal- pid=1699 runtime=180706 [ns] vruntime=1126870572 [ns]
+     <idle>-0     [003] d.s4   309.874956: sched_waking: comm=rcu_sched pid=9 prio=120 target_cpu=007
+     <idle>-0     [003] d.s5   309.874960: sched_wake_idle_without_ipi: cpu=7
+     <idle>-0     [003] d.s5   309.874961: sched_wakeup: comm=rcu_sched pid=9 prio=120 target_cpu=007
+     <idle>-0     [007] d..3   309.874963: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=9 next_prio=120
+  rcu_sched-9     [007] d..3   309.874973: sched_stat_runtime: comm=rcu_sched pid=9 runtime=13646 [ns] vruntime=22531430286 [ns]
+  rcu_sched-9     [007] d..3   309.874978: sched_switch: prev_comm=rcu_sched prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=swapper/7 next_pid=0 next_prio=120
+      <...>-2102  [005] d..4   309.874994: sched_migrate_task: comm=cyclictest pid=2103 prio=19 orig_cpu=5 dest_cpu=1
+      <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
+     <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
+
 3. User space creating a trigger
 --------------------------------
 
-- 
2.20.1


