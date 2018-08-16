Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58936208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4GmJCAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58936208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404557AbeHPTn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404535AbeHPTnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:43:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF9B208E9;
        Thu, 16 Aug 2018 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437824;
        bh=iGVFYsYMI8A/+2jMFkW1NWU93tA6plVYQ1RhtC6QMRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4GmJCAFOJspscs33uq/yM+YLkOnQq31tHLqYSntCbh2nYLRyfbYx7aMWB9uHMHyM
         1ca6KaRL1zkiC+4iXQVdKm/zKjr8jVXi53VCPEtREkkFrvi+GHkTOR+XrFbVuMVo3H
         +looW8Y67Ch5GQG0YtgjKNTqJuw+tpE10G34o59Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/32] selftests/ftrace: Add ftrace cpumask testcase
Date:   Fri, 17 Aug 2018 01:43:20 +0900
Message-Id: <153443780039.23257.5243924038958174104.stgit@devbox>
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

Add a testcase for tracing_cpumask with function tracer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |   34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
new file mode 100644
index 000000000000..37420e355445
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: ftrace - function trace with cpumask
+
+NP=`grep "^processor" /proc/cpuinfo | wc -l`
+
+if [ $NP -eq 1 ] ;then
+  echo "We can not test cpumask on UP environment"
+  exit_unresolved
+fi
+
+do_reset() {
+  echo ffff > tracing_cpumask
+}
+
+echo 0 > tracing_on
+echo > trace
+: "Bitmask only record on CPU1"
+echo 2 > tracing_cpumask
+MASK=0x`cat tracing_cpumask`
+test `printf "%d" $MASK` -eq 2 || do_reset
+
+echo function > current_tracer
+echo 1 > tracing_on
+(echo "forked")
+echo 0 > tracing_on
+
+: "Check CPU1 events are recorded"
+grep -q -e "\[001\]" trace || do_reset
+
+: "There should be No other cpu events"
+! grep -qv -e "\[001\]" -e "^#" trace || do_reset
+
+do_reset

