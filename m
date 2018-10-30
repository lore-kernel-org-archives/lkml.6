Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F0020838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xcdbueSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F0020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeJ3WVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6A62080A;
        Tue, 30 Oct 2018 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906099;
        bh=K4myFZ/oLdGd1JDFoRYXGVt8FOfoafJ4QRU0BkkON0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcdbueSPJbL9ci18S/WO6R6NzkpeXQ3QuHOiKY6AcCldqNzdejGK7czz/f5I+UpO6
         xD2GmzJXkaon5USIEYtj/bnG6Vyalby31ivWLiR24/8E3oYKvEdi4aqmXriyw8ucJA
         xx6JRofZLsLe10bWrrhXrWgLErR/XJJbN94e9pf4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 31/33] selftests: ftrace: Add synthetic event syntax testcase
Date:   Tue, 30 Oct 2018 09:26:55 -0400
Message-Id: <20181030132657.217970-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit ba0e41ca81b935b958006c7120466e2217357827 ]

Add a testcase to check the syntax and field types for
synthetic_events interface.

Link: http://lkml.kernel.org/r/153986838264.18251.16627517536956299922.stgit@devbox

Acked-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../trigger-synthetic-event-syntax.tc         | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
new file mode 100644
index 000000000000..88e6c3f43006
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
@@ -0,0 +1,80 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test synthetic_events syntax parser
+
+do_reset() {
+    reset_trigger
+    echo > set_event
+    clear_trace
+}
+
+fail() { #msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+reset_tracer
+do_reset
+
+echo "Test synthetic_events syntax parser"
+
+echo > synthetic_events
+
+# synthetic event must have a field
+! echo "myevent" >> synthetic_events
+echo "myevent u64 var1" >> synthetic_events
+
+# synthetic event must be found in synthetic_events
+grep "myevent[[:space:]]u64 var1" synthetic_events
+
+# it is not possible to add same name event
+! echo "myevent u64 var2" >> synthetic_events
+
+# Non-append open will cleanup all events and add new one
+echo "myevent u64 var2" > synthetic_events
+
+# multiple fields with different spaces
+echo "myevent u64 var1; u64 var2;" > synthetic_events
+grep "myevent[[:space:]]u64 var1; u64 var2" synthetic_events
+echo "myevent u64 var1 ; u64 var2 ;" > synthetic_events
+grep "myevent[[:space:]]u64 var1; u64 var2" synthetic_events
+echo "myevent u64 var1 ;u64 var2" > synthetic_events
+grep "myevent[[:space:]]u64 var1; u64 var2" synthetic_events
+
+# test field types
+echo "myevent u32 var" > synthetic_events
+echo "myevent u16 var" > synthetic_events
+echo "myevent u8 var" > synthetic_events
+echo "myevent s64 var" > synthetic_events
+echo "myevent s32 var" > synthetic_events
+echo "myevent s16 var" > synthetic_events
+echo "myevent s8 var" > synthetic_events
+
+echo "myevent char var" > synthetic_events
+echo "myevent int var" > synthetic_events
+echo "myevent long var" > synthetic_events
+echo "myevent pid_t var" > synthetic_events
+
+echo "myevent unsigned char var" > synthetic_events
+echo "myevent unsigned int var" > synthetic_events
+echo "myevent unsigned long var" > synthetic_events
+grep "myevent[[:space:]]unsigned long var" synthetic_events
+
+# test string type
+echo "myevent char var[10]" > synthetic_events
+grep "myevent[[:space:]]char\[10\] var" synthetic_events
+
+do_reset
+
+exit 0
-- 
2.17.1

