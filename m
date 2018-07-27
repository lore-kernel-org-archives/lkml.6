Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345C5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46D7208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xsh9yicL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46D7208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbeG0Nn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbeG0Nn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:43:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFBD7208B1;
        Fri, 27 Jul 2018 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532694137;
        bh=UEnZWLSV/9A5olbIXjcbsfjJR7YoR1rBfye+Licg+pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsh9yicLmzVgdBZmQLKK5dCXdpOd7XWqkiVEgYZOoWvcdW3CJMtzVY6E45vqD1j6I
         H7ZitD3UrmqxFbysqaLnYUTx/bdWXn7/EsNbywG52Kz2xz8AQuw1hRkoqSyGOltv+X
         REv3sxfWXtM1TulC2M/qQutOnBaMOZwJ6Ej+KWds=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] selftests/ftrace: Add trace_pipe testcase
Date:   Fri, 27 Jul 2018 21:21:54 +0900
Message-Id: <153269411396.3084.11842883301653040754.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153269339575.3084.16279591141931053689.stgit@devbox>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
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
 .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
new file mode 100644
index 000000000000..a7dd6fda487a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: trace_pipe and trace_marker
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

