Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D405214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547063438;
	bh=alDVXvG/kmHoahAYIoLfxDroKlCCKLYWMSwwYVnO8k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=H4NLWhViGf+9+kClbHOBkWfM7CKHFBHijw4Wyh0sDllNwMSuUw4eHr/02CfA3y974
	 a+05yDcuJQ6Cl1o5IIVJOKZyfgUu0SRoO/gT7hwvCz6UNqgUJOaNve4riVdUfOFdDW
	 6uN9nLhsnRadSkRty7fosv8FC+EMz4D1TQGBnHgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfAITuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbfAITuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:50:12 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDA42184B;
        Wed,  9 Jan 2019 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547063411;
        bh=alDVXvG/kmHoahAYIoLfxDroKlCCKLYWMSwwYVnO8k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=IU5pkccVGIgCmBNAl2POfh3nAbyXyD0MKYb6XBAW/Jc0/sm0PAeR6twUw4gL9hQp1
         xXGj9K8TuuvFxX4oI30/Dt+jofQIoAl/QJyH8PO4IrVbSF4k7dc/su2LOB+OH389qg
         n4F0dzfZIfR0ArQTiozY/KKooKiUsmye9lbRhESA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v11 12/15] tracing: Add hist trigger snapshot() action test case
Date:   Wed,  9 Jan 2019 13:49:19 -0600
Message-Id: <67a603c1a920be486dd061268a07d79253ce25b7.1547062835.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1547062835.git.tom.zanussi@linux.intel.com>
References: <cover.1547062835.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1547062835.git.tom.zanussi@linux.intel.com>
References: <cover.1547062835.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case verifying the basic functionality of the
hist:snapshot() action.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../inter-event/trigger-snapshot-action-hist.tc    | 43 ++++++++++++++++++++++
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
2.14.1

