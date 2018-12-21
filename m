Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA3D2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409786;
	bh=HzWfxiGJX5Xsuy9W7GKgHAh/SHNyllXvhXrssvb8uWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=mVtqLCdSrDXLtRO7ExDyc8XGONomPsvBXwcdmQgu5hGDolnAdmxLlFuQvRPirRHPM
	 gFJeL8+6M0UN3GvJ7krsztW858sP2f03WucZ4CIiQhcxYxCrEbuOs7UiwEENVdqA0m
	 UGKh4jMED2TCfFo80dFJ1ilaqIhkk/VBISSoPA4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbeLUQ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404190AbeLUQ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:29:41 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F00C21916;
        Fri, 21 Dec 2018 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409780;
        bh=HzWfxiGJX5Xsuy9W7GKgHAh/SHNyllXvhXrssvb8uWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=eQ/5cmBCo5+3TGbEiJKbLchfu7jA0YNKmNEOIC+/kk9QQMM8nfXESCdyuDoBoSm36
         LzgiiKKct/7ijoSwAH1iSNexp4cTxOEPiuRT4iNQha8rbtPhlalnue8WRkBR0OJTBT
         PT1qKC3aSpMOQAn14Uig0k9h3gqwrhrr0Yv1w1Zc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v10 12/15] tracing: Add hist trigger snapshot() action test case
Date:   Fri, 21 Dec 2018 10:29:11 -0600
Message-Id: <bbc341a2bcf33417e3136440ea4cde883c928e46.1545408962.git.tom.zanussi@linux.intel.com>
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

