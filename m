Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E928BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5E720675
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545165334;
	bh=HzWfxiGJX5Xsuy9W7GKgHAh/SHNyllXvhXrssvb8uWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=vQVEE4M7QeCYmdozc3EwcBvO/wSvQpYdzFNLXfiklm25gh1xZjbUw15fOM8Gb62Yp
	 fzXPyjMLOAoUTj4sy7P3ZQbXcahxeSuNuhzyR9yT8JFTg6dAJKvXwQoG9XrEv6xtv9
	 24f2lPtohdi7U0hx3xIUwjPfrvedmWFTQNqztr/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbeLRUfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:35:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeLRUfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:35:02 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17529218AE;
        Tue, 18 Dec 2018 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545165302;
        bh=HzWfxiGJX5Xsuy9W7GKgHAh/SHNyllXvhXrssvb8uWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VvUf1MioFuXICZeMkAffg04KimSOdNReV64dRsVZ0aqclVSJmnbntx5Xrv9gc1Pwz
         iHVeJWTkv1Tsx8PhpA3ciVcHrQ+dIF7E/Di0DFNCWPOW7GNCaGuaiYpv/ws6TU4nv3
         m00ppfeb+/6fkmrmTxcvZNiCBwcHaQITcsu5HxF0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v9 12/15] tracing: Add hist trigger snapshot() action test case
Date:   Tue, 18 Dec 2018 14:34:11 -0600
Message-Id: <70170085e7c70124530d42d8ae40a80544235269.1545161056.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545161056.git.tom.zanussi@linux.intel.com>
References: <cover.1545161056.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161056.git.tom.zanussi@linux.intel.com>
References: <cover.1545161056.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case verifying the basic functionality of the
hist:snapshot() action.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
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

