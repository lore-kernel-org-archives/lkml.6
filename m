Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225E7P1dDOi1H1KiJyzf6mPMccNEyuPFrMa5tNGzBQgxrRcbOf2gTp8ios8W16UC67DS9qMl
ARC-Seal: i=1; a=rsa-sha256; t=1519450623; cv=none;
        d=google.com; s=arc-20160816;
        b=YxLRi2QEScU+4Xk5RbDq84axcSyRFAEuEvzI1AmTD56EnyImhCG18QRbjotwPZG6Cw
         3S+6ayfLJowBLAv6WBrLyILpGluGQCZ+rI2fGdIZKCJHzAknH8+iP7OiLlr+RqYPMbRE
         Emm1/8YeVntWoZVEU5BZSUvnhE08FSpACs5koA1SXAAHbT1+NiZeQw1qfbVkJDSYftv+
         LNG5gQ0yv2ktB2hYsnjK270Lg+JoW6GOPP0Q7hcqfZz5EheNQzbXqSVHsa1aAq7qpGGh
         izS8pLYcnjlVySCDMwlzAi7Q6qfWDd4BSaZqTsCIDRpkP+HpHWGwlstMs8fC2fROxSiT
         OIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ChLbg8iG0YLaBNjceKjhUkfd0VLfLHL0T71unVjO9Bs=;
        b=RqQgEGsQc+/CeNJ/zHrPLvWJAnaqIS9pToamd9vGyPe+33x6PRUY21q0DQQC0u2TQ8
         DhOW//J4kO8kJN+rHYvY3NJSYywAIpWeJFNv2SpWjOgNFMJzktUyvbXPdQUyfB3gCZez
         BUJT+1mV3syecpHG4no8/T6E+MqBQH/Ib2uh3WAhOusILGRU5xfrMBkEOm5JSAdjtJj7
         vorQmCRZYQ/eib+m6OlibWijXCpq6o5sC4V0uK2HLYaBTmBEk2+tRSKDWj9d33iZUnHk
         wg4DpAjFB42Wwn1KsBY00+DwyonBB2iT3+nAuoLWfNr0pYOYHZsGw1FlHlydqylMyIbx
         qsUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBXFhD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbeBXFhC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:37:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FA121746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v3 17/18] selftests: ftrace: Add a testcase for $argN with kprobe_event
Date: Sat, 24 Feb 2018 14:36:38 +0900
Message-Id: <151945059838.27508.5474124421831859939.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151945010287.27508.6226184958678620828.stgit@devbox>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593259457350310046?=
X-GMAIL-MSGID: =?utf-8?q?1593259457350310046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for array type with kprobe event.
This tests whether the traced data is correct or not.
If the kernel doesn't support array type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
new file mode 100644
index 000000000000..d5c5c8c3a51e
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event argN argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -q "arg<N>" README || exit_unsupported # version issue
+
+echo 0 > events/enable
+echo > kprobe_events
+
+: "Test bad pattern : arg0 is not allowed"
+! echo 'p:testprobe create_trace_kprobe $arg0' > kprobe_events
+
+: "Test get argument"
+echo 'p:testprobe create_trace_kprobe $arg1' > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=0x1"
+
+! echo test test test >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=0x3"
+
+echo 0 > events/enable
+echo > kprobe_events

