Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE8C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124E120870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124E120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJ3WI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbeJ3WI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:08:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4842E2087A;
        Tue, 30 Oct 2018 13:15:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gHTrK-0002gS-Aj; Tue, 30 Oct 2018 09:15:02 -0400
Message-Id: <20181030131502.234039514@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 30 Oct 2018 09:13:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] selftests/ftrace: Fix synthetic event test to delete event correctly
References: <20181030131332.141023797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix the synthetic event test case to remove event correctly.
If redirecting command to synthetic_event file without append
mode, it cleans up all existing events and execute (parse) the
command. This means "delete event" always fails to find the
target event.

Since previous synthetic event has a bug which doesn't return
-ENOENT even if it fails to find the deleting event, this test
passed. But fixing that bug, this test fails because this test
itself has a bug.

This fixes that bug by trying to delete event right after
adding an event, and use append mode redirection ('>>') instead
of normal redirection ('>').

Link: http://lkml.kernel.org/r/154013452832.25576.2305459545429386517.stgit@devbox

Acked-by: Shuah Khan <shuah@kernel.org>
Acked-by: Tom Zanussi <zanussi@linux.intel.com>
Tested-by: Tom Zanussi <zanussi@linux.intel.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: stable@vger.kernel.org
Fixes: f06eec4d0f2c ('selftests: ftrace: Add inter-event hist triggers testcases')
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger-synthetic-event-createremove.tc          | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
index cef11377dcbd..c604438df13b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
@@ -35,18 +35,18 @@ fi
 
 reset_trigger
 
-echo "Test create synthetic event with an error"
-echo 'wakeup_latency  u64 lat pid_t pid char' > synthetic_events > /dev/null
+echo "Test remove synthetic event"
+echo '!wakeup_latency  u64 lat pid_t pid char comm[16]' >> synthetic_events
 if [ -d events/synthetic/wakeup_latency ]; then
-    fail "Created wakeup_latency synthetic event with an invalid format"
+    fail "Failed to delete wakeup_latency synthetic event"
 fi
 
 reset_trigger
 
-echo "Test remove synthetic event"
-echo '!wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+echo "Test create synthetic event with an error"
+echo 'wakeup_latency  u64 lat pid_t pid char' > synthetic_events > /dev/null
 if [ -d events/synthetic/wakeup_latency ]; then
-    fail "Failed to delete wakeup_latency synthetic event"
+    fail "Created wakeup_latency synthetic event with an invalid format"
 fi
 
 do_reset
-- 
2.19.0


