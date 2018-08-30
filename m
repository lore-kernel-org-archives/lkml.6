Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D611C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FE6205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwWytpLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FE6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeH3SZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbeH3SZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:25:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945E5205C9;
        Thu, 30 Aug 2018 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638992;
        bh=yOeR/MG0QqRDR6THa5CfdWNDZOLwmhLwoyVVk2BJFnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwWytpLrvRxh7vhQRhqo1Ar6XEd/oYuqL66QtiEV0FDZsykgqiRhRMpKRIjrmoj2I
         dNtM3PYKALd5PjrtpYvA1MHoS1qp1c5CoxAwqHR3+f17IoM3UhAQpot4YMf6FEwQaX
         RJhKGw2tAZYnJpuctfazYbSQ07ArPbPG9gV3g6Fc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/28] selftests/ftrace: Add max stack tracer testcase
Date:   Thu, 30 Aug 2018 23:22:49 +0900
Message-Id: <153563896959.29700.11240549305697395476.stgit@devbox>
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

Add a testcase for max stack tracer, which checks basic
max stack usage tracing and its filter feature.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/func_stack_tracer.tc      |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
new file mode 100644
index 000000000000..b414f0e3c646
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - Max stack tracer
+# Test the basic function of max-stack usage tracing
+
+if [ ! -f stack_trace ]; then
+  echo "Max stack tracer is not supported - please make CONFIG_STACK_TRACER=y"
+  exit_unsupported
+fi
+
+echo > stack_trace_filter
+echo 0 > stack_max_size
+echo 1 > /proc/sys/kernel/stack_tracer_enabled
+
+: "Fork and wait for the first entry become !lock"
+timeout=10
+while [ $timeout -ne 0 ]; do
+  ( echo "forked" )
+  FL=`grep " 0)" stack_trace`
+  echo $FL | grep -q "lock" || break;
+  timeout=$((timeout - 1))
+done
+echo 0 > /proc/sys/kernel/stack_tracer_enabled
+
+echo '*lock*' > stack_trace_filter
+test `cat stack_trace_filter | wc -l` -eq `grep lock stack_trace_filter | wc -l`
+
+echo 0 > stack_max_size
+echo 1 > /proc/sys/kernel/stack_tracer_enabled
+
+: "Fork and always the first entry including lock"
+timeout=10
+while [ $timeout -ne 0 ]; do
+  ( echo "forked" )
+  FL=`grep " 0)" stack_trace`
+  echo $FL | grep -q "lock"
+  timeout=$((timeout - 1))
+done
+echo 0 > /proc/sys/kernel/stack_tracer_enabled

