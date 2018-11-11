Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FF5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8152020871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zSqDBWB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbeKLITB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbeKLITA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:00 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5B221104;
        Sun, 11 Nov 2018 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975344;
        bh=1yN4KlMFrxDcpE7I0OTQy/0svzIK/NFZB2v2LZgbJnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSqDBWB2OTvKW4He3kcGX8HG21+yylg1XCGGTQCayO2BZKOXNdIYvu3sTNJACQEEs
         36/OiDfDXgtQ6cOzr1bH4b1nUBHZA+qnkLT+DtJDfoLhL7ylpIBGYXcBiqqdUKVnKg
         8MydkfBt11UW7tpKnS2MYZdgFibkAppDTgfdlB/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 323/361] selftests/ftrace: Fix synthetic event test to delete event correctly
Date:   Sun, 11 Nov 2018 14:21:10 -0800
Message-Id: <20181111221659.241545882@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0d0352d8b3d6d7ca9a710b40e194cbbaeb841c88 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc |   12 +++++-----
 1 file changed, 6 insertions(+), 6 deletions(-)

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


