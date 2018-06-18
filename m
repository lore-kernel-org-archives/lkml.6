Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D1EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084D020852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084D020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967279AbeFRJF7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:05:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967191AbeFRIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:50 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35B30BAD;
        Mon, 18 Jun 2018 08:31:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 063/189] selftests: ftrace: Add a testcase for multiple actions on trigger
Date:   Mon, 18 Jun 2018 10:12:39 +0200
Message-Id: <20180618081211.839387857@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 25aa50e0ca397a5e5d4d6fcecefa8107877d1dd0 ]

Add a testcase for multiple actions with different
parameters on an event trigger, which has been fixed
by commit 192c283e93bd ("tracing: Add action comparisons
 when testing matching hist triggers").

Link: http://lkml.kernel.org/r/152292055227.15769.6327959816123227152.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc |   44 ++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc

--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -0,0 +1,44 @@
+#!/bin/sh
+# description: event trigger - test multiple actions on hist trigger
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
+clear_synthetic_events
+reset_tracer
+do_reset
+
+echo "Test multiple actions on hist trigger"
+echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
+TRIGGER1=events/sched/sched_wakeup/trigger
+TRIGGER2=events/sched/sched_switch/trigger
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' > $TRIGGER1
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0 if next_comm=="cyclictest"' >> $TRIGGER2
+echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,next_pid) if next_comm=="cyclictest"' >> $TRIGGER2
+echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> $TRIGGER2
+echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> $TRIGGER2
+
+do_reset
+
+exit 0


