Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5EBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0132C214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486542;
	bh=wNXpEvHfF8L0Pgc8OIMtZCLN2O99PXMpLp2xLuYBUGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=yaouru9tpy7FDZNTHsBg37zQhCdDxjwx+eKXylbyoqt/Ca5BVCdNp9JxaEkY69E/1
	 2Bo0d4NkeV5FyeTYeIwbdbFHY5UEhi8nSCyA6EhlzpAnq8ZhTLyIIceAwo3/Km4TCt
	 v9AAxyMnlfbQaKN6cucC8U7uvOoMXe2pvtGktjrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0132C214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeLKACU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbeLKACJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:02:09 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB798214E0;
        Tue, 11 Dec 2018 00:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486528;
        bh=wNXpEvHfF8L0Pgc8OIMtZCLN2O99PXMpLp2xLuYBUGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Djmk1tjCLlg5KYrmKdgaQ5YT3TXv9ygfUi8N+oB+cdb+cWhgpu9n1aiaqNe0VQFgj
         iUJ77Np7BmYUEMkAlcPIffvtik66ROvy5TsEjeGnfdcFZhwfZa4Ppbve4a7Ik8yAr/
         OOzTlWYBTxGfe9SwQXVMiB8TDSK+qBCRLw+RYwAs=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 15/22] tracing: Add hist trigger action 'expected fail' test case
Date:   Mon, 10 Dec 2018 18:01:29 -0600
Message-Id: <08399819a5aae7b50b79c9e81c580e0b961d73ea.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
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

