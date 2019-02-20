Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6449D21848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfBTSi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfBTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8702229F;
        Wed, 20 Feb 2019 18:38:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWky-0006m1-Oz; Wed, 20 Feb 2019 13:38:08 -0500
Message-Id: <20190220183808.649002474@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:38:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 25/29] tracing: Add hist trigger snapshot() action test case
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case verifying the basic functionality of the
hist:snapshot() action.

Link: http://lkml.kernel.org/r/c0555f462cbfe56dadfec6e63e531e109bd72930.1550100284.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger-snapshot-action-hist.tc           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
new file mode 100644
index 000000000000..18fff69fc433
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger snapshot action
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
+if [ ! -f snapshot ]; then
+    echo "snapshot is not supported"
+    exit_unsupported
+fi
+
+grep -q "onchange(var)" README || exit_unsupported # version issue
+
+grep -q "snapshot()" README || exit_unsupported # version issue
+
+echo "Test snapshot action"
+
+echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+
+echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+
+ping $LOCALHOST -c 3
+nice -n 1 ping $LOCALHOST -c 3
+
+echo 0 > tracing_on
+
+if ! grep -q "changed:" events/sched/sched_waking/hist; then
+    fail "Failed to create onchange action inter-event histogram"
+fi
+
+if ! grep -q "comm=ping" snapshot; then
+    fail "Failed to create snapshot action inter-event histogram"
+fi
+
+exit 0
-- 
2.20.1


