Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BAC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54B02251E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMUuaha7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54B02251E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbeKOGXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387688AbeKOGXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:23:24 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791AC2251D;
        Wed, 14 Nov 2018 20:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542226723;
        bh=cbjgt9VUqkPqDbZxvXbXlC8xH86GsMCbpFuW5xTHqqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bMUuaha7ZP4jNMsqBfMw6cfnh2qxoN8NaDiyffXNeIOEe4ReOGlqgN8zp2Lyqp/Uu
         piDbR8UIBivSd+6d86kNdfCqOU9I5oAalQ7a9D9LQQQ9fclTufoRGkTe6wZRPFCKMq
         RTOwtXWwGes5RaqlOPE9Hh8YdRkB6iuUzKdSAj20=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v7 15/16] tracing: Add hist trigger action 'expected fail' test case
Date:   Wed, 14 Nov 2018 14:18:12 -0600
Message-Id: <f57dc207aba8b75aafb69049fc8bed05b2bda6e1.1542221863.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1542221862.git.tom.zanussi@linux.intel.com>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1542221862.git.tom.zanussi@linux.intel.com>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case verifying that basic action combinations fail as
expected.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../inter-event/trigger-action-hist-xfail.tc       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
new file mode 100644
index 000000000000..3d23eb874c2c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger expected fail actions
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
+grep -q "snapshot()" README > /dev/null || exit_unsupported # version issue
+
+echo "Test expected snapshot action failure"
+
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+
+echo "Test expected save action failure"
+
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+
+exit_xfail
-- 
2.14.1

