Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDA5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5A921916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409788;
	bh=ZrMDhspZRqsHQCgIRprU3Q2jciZ8eMIG6Ar+7cGmCjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ndtcilKD34ZMV6XOKC0kcrRzUNs41k0I/Z2/Sr8pNMBi04wSCrHz3Cot5Irlo3Imq
	 DQ1BXieTzQc8e/bkqXIQ7BWJ3EmZGz3noIWeLSbd2QvusjlOmMSjsgim1B+HXzrTnD
	 He8Ul/PeC5C6MzYqJxqWosHfB1mY/WhgNHKsrQy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404300AbeLUQ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404249AbeLUQ3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:29:44 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A352087F;
        Fri, 21 Dec 2018 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409784;
        bh=ZrMDhspZRqsHQCgIRprU3Q2jciZ8eMIG6Ar+7cGmCjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=J4M73yRczCSesWuCZ5dvtTHO1w2Iys2wxD9PAxooQU5ZSp5CsFutRMutrmDF5lmgS
         +gOYX+fQJEdb+KHBPKZ9K0AlqQ/qzNKfXiazLgz5n1U7SwlqyELkQY0icrYPKZu1Cf
         7uKToI8gOKh5FD0eMzv/qILKNtDjDzjuKOReIuOo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v10 14/15] tracing: Add alternative synthetic event trace action test case
Date:   Fri, 21 Dec 2018 10:29:13 -0600
Message-Id: <dd5bcb5db7f4aed314625c182c60977ece37fd4f.1545408962.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545408962.git.tom.zanussi@linux.intel.com>
References: <cover.1545408962.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545408962.git.tom.zanussi@linux.intel.com>
References: <cover.1545408962.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case for the alternative trace(<synthetic_event, params)
synthetic event generation syntax.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../inter-event/trigger-trace-action-hist.tc       | 42 ++++++++++++++++++++++
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
2.14.1

