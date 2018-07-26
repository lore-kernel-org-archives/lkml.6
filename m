Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7898C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B7720857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B7720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeG0AZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731933AbeG0AZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:25:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC3020899;
        Thu, 26 Jul 2018 23:06:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fipLP-00069v-Ry; Thu, 26 Jul 2018 19:06:51 -0400
Message-Id: <20180726230651.763688807@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 26 Jul 2018 19:06:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 3/7] selftests/ftrace: Add snapshot and tracing_on test case
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a testcase for checking snapshot and tracing_on
relationship. This ensures that the snapshotting doesn't
affect current tracing on/off settings.

Link: http://lkml.kernel.org/r/153149932412.11274.15289227592627901488.stgit@devbox

Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/00basic/snapshot.tc         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
new file mode 100644
index 000000000000..3b1f45e13a2e
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
@@ -0,0 +1,28 @@
+#!/bin/sh
+# description: Snapshot and tracing setting
+# flags: instance
+
+[ ! -f snapshot ] && exit_unsupported
+
+echo "Set tracing off"
+echo 0 > tracing_on
+
+echo "Allocate and take a snapshot"
+echo 1 > snapshot
+
+# Since trace buffer is empty, snapshot is also empty, but allocated
+grep -q "Snapshot is allocated" snapshot
+
+echo "Ensure keep tracing off"
+test `cat tracing_on` -eq 0
+
+echo "Set tracing on"
+echo 1 > tracing_on
+
+echo "Take a snapshot again"
+echo 1 > snapshot
+
+echo "Ensure keep tracing on"
+test `cat tracing_on` -eq 1
+
+exit 0
-- 
2.17.1


