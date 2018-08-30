Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F5DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDF0205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1yHSkTKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDF0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeH3S1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbeH3S13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:27:29 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89BCD205C9;
        Thu, 30 Aug 2018 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535639105;
        bh=/AYcYGVbdWP2qiAlYDm4hCAlXbs3VOAXwm1ZLFfyYCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1yHSkTKSBSPeqYIQ637luscAN2Y/Zd1M3Ycrqm1d/vStit+rS8Fa2qXsGtrtP1Ios
         OOxvQwBUqFSPcQGa5smLvwN5yF+SwYKPfD8Umu0rPQvEWr46PYSFEF4pHmoVUzHTcO
         WTRSMqa4APB7icCr5CzUYyr+ho56KFqFta9rPa5I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 26/28] selftests/ftrace: Add wakeup tracer testcase
Date:   Thu, 30 Aug 2018 23:24:42 +0900
Message-Id: <153563908252.29700.10243618182223298702.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153563834333.29700.11242968505215651399.stgit@devbox>
References: <153563834333.29700.11242968505215651399.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for wakeup tracer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/config              |    1 +
 .../selftests/ftrace/test.d/tracer/wakeup.tc       |   25 ++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index b7ac74fcb0fa..c2c8de4fafff 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,6 +4,7 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_SCHED_TRACER=y
 CONFIG_PREEMPT_TRACER=y
 CONFIG_IRQSOFF_TRACER=y
 CONFIG_PREEMPTIRQ_DELAY_TEST=m
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
new file mode 100644
index 000000000000..e3005fa785f0
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: Test wakeup tracer
+
+if ! which chrt ; then
+  echo "chrt is not found. This test requires nice command."
+  exit_unresolved
+fi
+
+if ! grep -wq "wakeup" available_tracers ; then
+  echo "wakeup tracer is not supported"
+  exit_unsupported
+fi
+
+echo wakeup > current_tracer
+echo 1 > tracing_on
+echo 0 > tracing_max_latency
+
+: "Wakeup higher priority task"
+chrt -f 5 sleep 1
+
+echo 0 > tracing_on
+grep '+ \[[[:digit:]]*\]' trace
+grep '==> \[[[:digit:]]*\]' trace
+

