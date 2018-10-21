Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C548BECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8628A20869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUbHmq9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8628A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJUXXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbeJUXXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 19:23:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6876D2083E;
        Sun, 21 Oct 2018 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540134551;
        bh=llz1jP8X+5W5o3JkEU+Sfm03mHjCguE/sSf24pJljVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUbHmq9KIi857a+bgnRK4j3GCGmEEOJqpPDNyJhe6fNJHW7N2HK+TqRxnMAsccQNd
         /kqUTdvs0H/rTNOzlKbbjsQZWbWY0LXYtUuabYQTsi/Z+Pd7qMjiGcFcDJ+xQdPf9a
         MwRynS4Z9gLttcKv16Wttm1vBiT1NoIqfdqngfMs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/2] selftests/ftrace: Fix synthetic event test to delete event correctly
Date:   Mon, 22 Oct 2018 00:08:48 +0900
Message-Id: <154013452832.25576.2305459545429386517.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154013446976.25576.14780785912268176178.stgit@devbox>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: f06eec4d0f2c ('selftests: ftrace: Add inter-event hist triggers testcases')
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger-synthetic-event-createremove.tc        |   12 ++++++------
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

