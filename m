Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C57C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACAC20862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wspWOFfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACAC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbeKLIWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389119AbeKLIWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:07 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBE5223CB;
        Sun, 11 Nov 2018 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975530;
        bh=RdH1+MhMH/9atVZN0DncY/nv8o+luAF4J50/tmLHMco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wspWOFfpkjLWyoJF1RG0VKe4J17kQ4zeek8CMUlq2WmpEnOjR+esOlCRMMwJmUdZL
         epThSJ/o8Wh5vjIsSBv9m9VGLg7QSnBqG2E6ZJho2uRVpyzKeBookQI07Rt3Ib7SSL
         3dcTybBouIKu/mKI2YdLoM641V0aoRWugyn9XdZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 037/222] selftests: ftrace: Add synthetic event syntax testcase
Date:   Sun, 11 Nov 2018 14:22:14 -0800
Message-Id: <20181111221651.506444646@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit ba0e41ca81b935b958006c7120466e2217357827 ]

Add a testcase to check the syntax and field types for
synthetic_events interface.

Link: http://lkml.kernel.org/r/153986838264.18251.16627517536956299922.stgit@devbox

Acked-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc |   80 ++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc

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


