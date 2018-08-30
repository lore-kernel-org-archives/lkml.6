Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C33C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB6205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI+YjjsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DB6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeH3SZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbeH3SZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:25:07 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3C8205C9;
        Thu, 30 Aug 2018 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638964;
        bh=ZDhIA09tWcOlqN0rNgg50H7v3c95gH1exAR2kP9TYxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rI+YjjsTFca4C1XOYCsFpuyKFh+mckGgk228NICNsBDrgXpzttCADWd20biDtAdiX
         ee5FLyV8WdaK0BMYuG42EbiCgS7RRZ8Y7oK89lLCXcmpZtns76Hb2Z0uDAy1q86gZ2
         nWHoitlpEN7HPINLMTsZgEVXaKHqwa62ajILQ3L4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/28] selftests/ftrace: Add function profiling stat testcase
Date:   Thu, 30 Aug 2018 23:22:21 +0900
Message-Id: <153563894147.29700.6575031484306159534.stgit@devbox>
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

Add a testcase for function profiling per-cpu statistics
interface. There is already func_profile.tc, but that is
mainly focusing on the combination of function-profiler
and function tracer. This testcase ensures trace_stat
per-cpu function statistics is correctly updated.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Changes in v3:
 - Remove the last empty line.
---
 .../ftrace/test.d/ftrace/func_profile_stat.tc      |   22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
new file mode 100644
index 000000000000..0d501058aa75
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function profiling
+
+[ ! -f function_profile_enabled ] && exit_unsupported
+
+: "Enable function profile"
+echo 1 > function_profile_enabled
+
+: "Profile must be updated"
+cp trace_stat/function0 $TMPDIR/
+( echo "forked"; sleep 1 )
+: "diff returns 0 if there is no difference"
+! diff trace_stat/function0 $TMPDIR/function0
+
+echo 0 > function_profile_enabled
+
+: "Profile must NOT be updated"
+cp trace_stat/function0 $TMPDIR/
+( echo "forked"; sleep 1 )
+: "diff returns 0 if there is no difference"
+diff trace_stat/function0 $TMPDIR/function0

