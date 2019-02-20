Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEDEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E47B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBTSiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:38:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbfBTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA914222A6;
        Wed, 20 Feb 2019 18:38:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWkz-0006mz-3D; Wed, 20 Feb 2019 13:38:09 -0500
Message-Id: <20190220183808.990959993@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:38:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 27/29] tracing: Add alternative synthetic event trace action test case
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case for the alternative trace(<synthetic_event, params)
synthetic event generation syntax.

Link: http://lkml.kernel.org/r/0616d18423ab1dfdbf333bce9c92ac4fa0779207.1550100284.git.tom.zanussi@linux.intel.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../inter-event/trigger-trace-action-hist.tc  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
new file mode 100644
index 000000000000..8021d60aafec
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger trace action
+
+fail() { #msg
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
+grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test create histogram for synthetic event using trace action"
+echo "Test histogram variables,simple expression support and trace action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).trace(wakeup_latency,$wakeup_lat,next_pid,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
+echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
+
+ping $LOCALHOST -c 5
+
+if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
+    fail "Failed to create trace action inter-event histogram"
+fi
+
+exit 0
-- 
2.20.1


