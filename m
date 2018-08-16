Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC4E208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO6GFx8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC4E208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404524AbeHPTmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387875AbeHPTmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:42:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23638208E9;
        Thu, 16 Aug 2018 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437795;
        bh=Rvdl6l5EzrJhD2Mq+sG14OGD0Bjiy9GAEEcq+LOe5lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SO6GFx8vFm9cUBsxZhw4y48k/gvF99B5xlUTzgN/HAuHpf5btvESRueeQJ6j7Ab3v
         lUjAaByTloNrwp+B4+qTkpsA+Zw+4AMPrLfYLqz4lqy2Uecsu5hmDVCBuPfvKLpY4C
         bLSPZ9RISKx2bCSl/0U6ynIrMNcVTyxsIiYi+fMA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/32] selftests/ftrace: Add wakeup_rt tracer testcase
Date:   Fri, 17 Aug 2018 01:42:52 +0900
Message-Id: <153443777214.23257.14428652484801816908.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153443695002.23257.13628220023468200991.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
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
 .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc

diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
new file mode 100644
index 000000000000..3f279072ec2d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: Test wakeup RT tracer
+
+if ! which nice ; then
+  echo "chrt is not found. This test requires chrt command."
+  exit_unresolved
+fi
+
+if ! grep -wq "wakeup_rt" available_tracers ; then
+  echo "wakeup_rt tracer is not supported"
+  exit_unsupported
+fi
+
+echo wakeup > current_tracer
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

