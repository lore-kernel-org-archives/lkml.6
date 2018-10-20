Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6D7ECDE45
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6815C214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6815C214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeJTJja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeJTJj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:39:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0EB2150F;
        Sat, 20 Oct 2018 01:30:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gDg6N-0006FW-4B; Fri, 19 Oct 2018 21:30:51 -0400
Message-Id: <20181020013051.030308325@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Oct 2018 21:30:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] selftests: ftrace: Add synthetic event syntax testcase
References: <20181020012958.223064271@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a testcase to check the syntax and field types for
synthetic_events interface.

Link: http://lkml.kernel.org/r/153986838264.18251.16627517536956299922.stgit@devbox

Acked-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.19.0


