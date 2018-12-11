Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B9DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7142214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486603;
	bh=0kAK0tFAZSnIPth6D3BqF/ptRH/oVU7SV1k7/wzNJcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=BAkAzOUW2ksGCCxekIW5CsHjk0NkRI7Pm5LfkXncYk7vFdkX2iBt20R+CsZk8MMCK
	 SpqdHToBTjnL0aiLT5hzpdcFIjx7GUF23F+/naNwYoE7XwO/f9hoilPmRu/H90vvsr
	 2JnY8N8DL8yTQnvrPPDJwpIMBepVCF8IK9iM0Y5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7142214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeLKADV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbeLKACD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:02:03 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82E8C214F1;
        Tue, 11 Dec 2018 00:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486522;
        bh=0kAK0tFAZSnIPth6D3BqF/ptRH/oVU7SV1k7/wzNJcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=njdSXoJaKolNAXqPg6nwJ6k28lMc6RVLprLW48NCNAFulCHKkyfPi2MR2FM3oTO12
         UT3cv0dcysxHR8BEtp9NmnULyvnhnW+wW9zqb9fV+3v6csnAL8ZcDWAyEJ9x3OJu4i
         5dqnbsUDcG46CxWrXGfKG3x11xshEcGpv0JNKARM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 11/22] tracing: Add hist trigger onchange() handler Documentation
Date:   Mon, 10 Dec 2018 18:01:25 -0600
Message-Id: <1376631284f39481a0a188ec8b2566b620b9e48c.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add Documentation for the hist:onchange($var) handler.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst | 98 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 353317bc3825..79476c906b1a 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1869,6 +1869,7 @@ The available handlers are:
 
   - onmatch(matching.event)    - invoke action on any addition or update
   - onmax(var)                 - invoke action if var exceeds current max
+  - onchange(var)              - invoke action if var changes
 
 The available actions are:
 
@@ -2140,6 +2141,103 @@ The following commonly-used handler.action pairs are available:
       <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
      <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
 
+  - onchange(var).save(field,..	.)
+
+    The 'onchange(var).save(field,...)' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    changes.
+
+    The end result is that the trace event fields specified as the
+    onchange.save() params will be saved if 'var' changes for that
+    hist trigger entry.  This allows context from the event that
+    changed the value to be saved for later reference.  When the
+    histogram is displayed, additional fields displaying the saved
+    values will be printed.
+
+  - onchange(var).snapshot()
+
+    The 'onchange(var).snapshot()' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    changes.
+
+    The end result is that a global snapshot of the trace buffer will
+    be saved in the tracing/snapshot file if 'var' changes for any
+    hist trigger entry.
+
+    Note that in this case the changed value is a global variable
+    associated withe current trace instance.  The key of the specific
+    trace event that caused the value to change and the global value
+    itself are displayed, along with a message stating that a snapshot
+    has been taken and where to find it.  The user can use the key
+    information displayed to locate the corresponding bucket in the
+    histogram for even more detail.
+
+    As an example the below defines a hist trigger on the tcp_probe
+    event, keyed on dport.  Whenever a tcp_probe event occurs, the
+    cwnd field is checked against the current value stored in the
+    $cwnd variable.  If the value has changed, a snapshot is taken.
+    As part of the setup, all the scheduler and tcp events are also
+    enabled, which are the events that will show up in the snapshot
+    when it is taken at some point:
+
+    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+    # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
+
+    # echo 'hist:keys=dport:cwnd=snd_cwnd: \
+            onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
+	    onchange($cwnd).snapshot()' >> \
+	    /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
+
+    When the histogram is displayed, for each bucket the tracked value
+    and the saved values corresponding to that value are displayed
+    following the rest of the fields.
+
+    If a snaphot was taken, there is also a message indicating that,
+    along with the value and event that triggered the snapshot:
+
+    # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
+      { dport:       1521 } hitcount:          8
+	changed:         10  snd_wnd:      35456  srtt:     154262  rcv_wnd:      42112
+
+      { dport:         80 } hitcount:         23
+	changed:         10  snd_wnd:      28960  srtt:      19604  rcv_wnd:      29312
+
+      { dport:       9001 } hitcount:        172
+	changed:         10  snd_wnd:      48384  srtt:     260444  rcv_wnd:      55168
+
+      { dport:        443 } hitcount:        211
+	changed:         10  snd_wnd:      26960  srtt:      17379  rcv_wnd:      28800
+
+    Snapshot taken (see tracing/snapshot).  Details:
+        triggering value { onchange($cwnd) }:         10
+        triggered by event with key: { dport:         80 }
+
+    Totals:
+        Hits: 414
+        Entries: 4
+        Dropped: 0
+
+    In the above case, the event that triggered the snapshot has the
+    key with dport == 80.  If you look at the bucket that has 80 as
+    the key, you'll find the additional values save()'d along with the
+    changed value for that bucket, which should be the same as the
+    global changed value (since that was the same value that triggered
+    the global snapshot).
+
+    And finally, looking at the snapshot data should show at or near
+    the end the event that triggered the snapshot:
+
+    # cat /sys/kernel/debug/tracing/snapshot
+
+       gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
+     kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
+       gnome-shell-1261  [006] d..3    49.823114: sched_switch: prev_comm=gnome-shell prev_pid=1261 prev_prio=120 prev_state=R+ ==> next_comm=kworker/6:2 next_pid=387 next_prio=120
+       kworker/3:2-135   [003] d..3    49.823118: sched_stat_runtime: comm=kworker/3:2 pid=135 runtime=5339 [ns] vruntime=17815800388 [ns]
+       kworker/6:2-387   [006] d..3    49.823120: sched_stat_runtime: comm=kworker/6:2 pid=387 runtime=9594 [ns] vruntime=14589605367 [ns]
+       kworker/6:2-387   [006] d..3    49.823122: sched_switch: prev_comm=kworker/6:2 prev_pid=387 prev_prio=120 prev_state=R+ ==> next_comm=gnome-shell next_pid=1261 next_prio=120
+       kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
+            <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
+
 3. User space creating a trigger
 --------------------------------
 
-- 
2.14.1

