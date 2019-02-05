Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFCC282E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689A4217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549406572;
	bh=wNXpEvHfF8L0Pgc8OIMtZCLN2O99PXMpLp2xLuYBUGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Ihb+5oKpBIZ2zoKzHiIJCdxb8h+B9i3bg1lU1zG8/SJIOhx8/T7WisaJWpyNQWUva
	 bSboK2gUW9/96qLiUaSqyDCZ3fqpjt1Ex1HXaDdfuCkZp1lSrYOJETS9ZwXy0l+JT/
	 qPwKOK2kcwqayjVyeN8PIBeVtqf7Ika3EG0Oir4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfBEWmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730470AbfBEWma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:42:30 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4CC218D3;
        Tue,  5 Feb 2019 22:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549406550;
        bh=wNXpEvHfF8L0Pgc8OIMtZCLN2O99PXMpLp2xLuYBUGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=yqTpbjJsegO5sMY2mN8PY/tE7K8fM9InuviyQtrD6N1Ez3xg49dvu+KmFsvSgLpGn
         SoggHU30JwjuifTuUn88gTC7caJ4d+tIRDsiXZkRmqkTqK0d9oalPkJuZhUVlT0ZS5
         +HjwHbo/BPW2WLLj2sq3leV/wiXu6hRROxq+WT6g=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v14 15/15] tracing: Add hist trigger action 'expected fail' test case
Date:   Tue,  5 Feb 2019 16:42:01 -0600
Message-Id: <779474478eacb64a1e686a37cf663d8210d88f84.1549403369.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
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
index 000000000000..1221240f8cf6
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
+grep -q "snapshot()" README || exit_unsupported # version issue
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

