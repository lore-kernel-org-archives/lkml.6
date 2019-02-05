Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807FCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430D62175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549406607;
	bh=YwpG66b1PbbNfHWKoWOhJAYkAamckUuMJ0ABZ58yDWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=qZxyeEH3R83b6CgjJnATJko3vRzjlxbORQqOpw7aqLgvTO7GczMkofD1o/LAhiK8c
	 SIElxjxA1sEn9KcceDgSbgSHcqieiVEUk2l85EIhnx9YtbGF1v1oHk7YozpQFA/quk
	 nmuIVqnCq8KrsyAE2SPBDHJ4rq1afYpITquWRuUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfBEWnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbfBEWmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:42:18 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9352F218AE;
        Tue,  5 Feb 2019 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549406536;
        bh=YwpG66b1PbbNfHWKoWOhJAYkAamckUuMJ0ABZ58yDWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NAzcPcCgi3EOvo0hSwkhcsjzCjSEmhCGkIOPXnBdP8NSQfkjgSupAYg5KHfPt+sxO
         A5ECznBAXBbM1xAbV8wZXIhb0SXQmdRGpT6MUIiAV/XY4D0QURIvSstpQe11sLPVVW
         dLELZbUzfLzFfneReanXSbO3czZ6ZekRoCCheZg0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v14 07/15] tracing: Add hist trigger snapshot() action Documentation
Date:   Tue,  5 Feb 2019 16:41:53 -0600
Message-Id: <802b2176893ca651660d42aff737e60ed4d92f9f.1549403369.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add Documentation for the hist:handlerXXX($var).snapshot() action.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst | 110 ++++++++++++++++++++++++++++++++++++++
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
2.14.1

