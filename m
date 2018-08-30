Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DACC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E308E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC1AqkrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E308E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeH3S0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbeH3S0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:26:32 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1033C205C9;
        Thu, 30 Aug 2018 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535639049;
        bh=7K2D2hri2tO8U4DDEIv/LBVSkY8Z5d6Esa/mPkV84K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vC1AqkrWPRsVyikiUQ2qu9pQQgiB9gVttMm8b8+OnMXKxidlaswyLNJ393PqOf2Pc
         0AmO4EZKK4r8vUTlK7P6VzOfcuyFIE8tjc6kvwgUMmLGjj74oxHnjPW9Rabmj1wRy5
         mpiCjqqMUV6yMo8zORCH5fr5//jyTDvox5LStgd8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 24/28] selftests/ftrace: Add trace_pipe testcase
Date:   Thu, 30 Aug 2018 23:23:46 +0900
Message-Id: <153563902610.29700.13670948265261478540.stgit@devbox>
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

Add a simple testcase for trace_pipe which can consume
ringbuffer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
 - Run this on an instance too.
---
 .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
new file mode 100644
index 000000000000..5058fbcfd90f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: trace_pipe and trace_marker
+# flags: instance
+
+[ ! -f trace_marker ] && exit_unsupported
+
+echo "test input 1" > trace_marker
+
+: "trace interface never consume the ring buffer"
+grep -q "test input 1" trace
+grep -q "test input 1" trace
+
+: "trace interface never consume the ring buffer"
+head -n 1 trace_pipe | grep -q "test input 1"
+! grep -q "test input 1" trace

