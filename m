Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224NtLMVS6pZRP1YIDtpbKUooIiq34fqN7q0qT6cLnUG6RSG2nT/QPkycL3WLHBd47VUMPhi
ARC-Seal: i=1; a=rsa-sha256; t=1519225343; cv=none;
        d=google.com; s=arc-20160816;
        b=IEslkngJ4cU+dsMWTvzUan/r1dKB83iu1+h7yt8SkkEokPXx+HKfZRdVuZQvCZjzLI
         leRLr4AMvkERxgZfwANtMbMrx4ngrXkwtiliGFCCfB69wTCgLqOx6tRgXEJBFQNp2Yl6
         m30Uiy9CVMp63R0db7BLNe7BOVOOC7XAp150TjAHaq49KFDKg4fvY19jZYeZZEdrlMmO
         uri3N2UKL7MdCUL+8cyA9QMq0Vv7FhHrUrQhQG2+zLJDcQX8wa3eZxpEy+fZOa02ioFn
         ymW6waMkjTIyf3UyeL2n1U8lKLpsUSkN90mUmTbhLFfKuvs8zqOfCs8PVE6Fh+dfKpGF
         yRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ChLbg8iG0YLaBNjceKjhUkfd0VLfLHL0T71unVjO9Bs=;
        b=lZ+tR9wHNlVjnvxyud6pMjcf6x8FGXwTYnOOPenaMjU8N2qOp7E3xccZxj7cTFE68g
         nWoK45hV8lRH/0cN8kiDwITEtjZAU4xBP+ZJCBvlF2nmkcJ7yeog5kv3RbPYdtCJ96yA
         1tm7gwBHeRjnRvnbqxd5m7NN9/WDyFT4ZVGDLwCD3OnIcGdjpHM6z0GiXTufID0EyNLS
         Iv4+bPl704r5KPZSGiBKhlP87ByWnQHfoESBuelqydCC6/3F28P9tp/oZoo5utVAOM1I
         A838Bi1pB4yr/dTP6pe/brf1+Sfs4qLo1wSX5h6cvOUibj6bghhDWd8qNYUQfWsGfqhj
         phjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934828AbeBUPCW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 10:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934232AbeBUPCW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 10:02:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4D22178E
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
Subject: [PATCH v2 16/17] selftests: ftrace: Add a testcase for $argN with kprobe_event
Date: Thu, 22 Feb 2018 00:01:58 +0900
Message-Id: <151922531797.6217.2490233092090771101.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151922484560.6217.1143686155616343906.stgit@devbox>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593023233618611033?=
X-GMAIL-MSGID: =?utf-8?q?1593023233618611033?=
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

