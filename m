Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE0FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E87205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/pwxvie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E87205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeH3S16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeH3S16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:27:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E1D205C9;
        Thu, 30 Aug 2018 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535639133;
        bh=vOAU2GRH9GVIrATzx8HXQPQB7XOKRntI9eoRNkNSC0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/pwxvieXKdRptVKgMBoJ6hrhZVDOrio8ADbLTrKcOiBnLeYBo7oxjNny7+rVj1Dk
         qlY7yw4D3gV77/iK5iYsS3y1D+X4dd/C4Ex5XbbwLafsinctmkw11doqC2zaEa1AVl
         pCoKoAcCX66Wxzm6RRmLiBI94lTh+9hrezHy01+U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 27/28] selftests/ftrace: Add wakeup_rt tracer testcase
Date:   Thu, 30 Aug 2018 23:25:11 +0900
Message-Id: <153563911084.29700.11577853607938050611.stgit@devbox>
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

Add a testcase for wakeup_rt tracer. This requires chrt
command to test.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
 - Check "chrt" command exist correctly.
 - Use "wakeup_rt" tracer correctly.
---
 .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc

diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
new file mode 100644
index 000000000000..f99b5178e00a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: Test wakeup RT tracer
+
+if ! which chrt ; then
+  echo "chrt is not found. This test requires chrt command."
+  exit_unresolved
+fi
+
+if ! grep -wq "wakeup_rt" available_tracers ; then
+  echo "wakeup_rt tracer is not supported"
+  exit_unsupported
+fi
+
+echo wakeup_rt > current_tracer
+echo 1 > tracing_on
+echo 0 > tracing_max_latency
+
+: "Wakeup a realtime task"
+chrt -f 5 sleep 1
+
+echo 0 > tracing_on
+grep "+ \[[[:digit:]]*\]" trace
+grep "==> \[[[:digit:]]*\]" trace
+

