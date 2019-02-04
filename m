Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0625C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC1320844
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549316751;
	bh=ZrMDhspZRqsHQCgIRprU3Q2jciZ8eMIG6Ar+7cGmCjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ar60F6Tx319o6Rnefw8rZRGaV7hRwdZukyPgarHyePhkuvh9/4CkYFcB7smOwn1Bj
	 vUtr8OHzRV0IaximWnPFAkJ8IEbtPbW/MLuDcFDTeKJDCuRttYx6NCaWY5ytXOUEUR
	 x4q37I9+bAd4WDnjiZ70+f8PPd1MTGF8z2BZRmpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfBDVpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:45:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbfBDVpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:45:46 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B962F20823;
        Mon,  4 Feb 2019 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549316745;
        bh=ZrMDhspZRqsHQCgIRprU3Q2jciZ8eMIG6Ar+7cGmCjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=oyw7AOfF0qCmWhuFzJqhTylBoT2hy5KntQgzwBDsvE8NZjm/vYWgoeuwsyIDGb66W
         pyDvhQyDRpWWiByy7/mOvYhSUhGFjhnRWizfHf1G2EOxH9Q4gza2mQD/SzP59NWHO2
         3f/sk6YbhM0DL403B/9ssvLVRsOMBNhRvXwF8/60=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v13 14/15] tracing: Add alternative synthetic event trace action test case
Date:   Mon,  4 Feb 2019 15:45:08 -0600
Message-Id: <69c182c96c7298693dc232ce4b3173ab534bb416.1549310519.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1549310519.git.tom.zanussi@linux.intel.com>
References: <cover.1549310519.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549310519.git.tom.zanussi@linux.intel.com>
References: <cover.1549310519.git.tom.zanussi@linux.intel.com>
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

