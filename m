Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA2CC67838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C4221477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8Pr7hFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C4221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJLEbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbeJLEbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:31:37 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CCB2147C;
        Thu, 11 Oct 2018 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539291756;
        bh=Kzl5SGHoVAY0IwIBqnvnSyLW0F0XJm7jowCI36olhpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=F8Pr7hFyOZUjQmru2rW74xbb8Acj439NKrVCrXaOobPNBRV9TGiDXaXuwWp//EERm
         S84bj+QReSM++V6xzsbPnWxjPkcN6I8BQs5cvFAma3T2A5F2d5HyDJEUT8kubIIeid
         7MW1JRXeAIkuVDxfGfHsM7qON0hoRN879muXF918=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v6 10/15] tracing: Add hist trigger snapshot() action test case
Date:   Thu, 11 Oct 2018 16:02:07 -0500
Message-Id: <75db4ded21471580e5ad8d57c74fd9c8923cd90a.1539288364.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case verifying the basic functionality of the
hist:snapshot() action.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../inter-event/trigger-snapshot-action-hist.tc    | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
new file mode 100644
index 000000000000..f427be989296
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -0,0 +1,55 @@
+#!/bin/sh
+# description: event trigger - test inter-event histogram trigger snapshot action
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    echo 0 > snapshot
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
+if [ ! -f snapshot ]; then
+    echo "snapshot is not supported"
+    exit_unsupported
+fi
+
+grep "onchange(var)" README > /dev/null || exit_unsupported # version issue
+
+grep "snapshot()" README > /dev/null || exit_unsupported # version issue
+
+reset_tracer
+do_reset
+
+echo "Test snapshot action"
+
+echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+
+echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+
+ping localhost -c 3
+nice -n 1 ping localhost -c 3
+
+echo 0 > /sys/kernel/debug/tracing/events/sched/enable
+
+if ! grep -q "changed:" events/sched/sched_waking/hist; then
+    fail "Failed to create onchange action inter-event histogram"
+fi
+
+if ! grep -q "comm=ping" snapshot; then
+    fail "Failed to create snapshot action inter-event histogram"
+fi
+
+do_reset
+
+exit 0
-- 
2.14.1

