Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu5V/jnlU5bxnb3FDzCLmpb5+nRVSWdstS0oS+BX7rDPdH0JLhoQ48juH6Bro/CCP31ZmmI
ARC-Seal: i=1; a=rsa-sha256; t=1521291096; cv=none;
        d=google.com; s=arc-20160816;
        b=bS+6MqVUuFsKQnN7Bnp3GNWY20eCrwTndG91sY/Xar6N33eUM5dmRYbjYAXmjVyrE0
         BwXplGzx1woWINfPD9mBtUi8PASlb2aUqsyk08MYTqYDxB+XvlaSOMIk0BLESO79+QPY
         cGvaIRl4ZdLX1Qe+OIT7as3jFQDpI9/u7+aAH3ZfvsTjpi2dUPHuzQExCnqPAVvAdx16
         SYMMTlGDH3VS1GPQYoIcBN7zUqkGWjL9YWo2Izw1BGtmSkBJWWEeMHjMaswtUDWP+ko/
         bqcO++Ls7STuAwSR8FKpo3uJyrFYIhxpv14P/mwQOr4C98tcErJsGLkTdoO5HTmdrwb9
         FHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=DalFNfqyUNMZvr1wDP6/QRmFOU4lKwB2alolEgDBA2w=;
        b=Bxh7KUV0Zy3UbN1Nn7+5JBNTVCnplWClT1GfMMGdxXALUmFNdQGGJXU8a8DJWtDjRD
         rZXy3S5QyBlBnP6q5XHIA8Te004PVMQxqJ5ExbAedx4ZDDcdbju2PKV7tRa0ivQdi3rQ
         8N6X1a4xoBlWVBLdpVlPb7Mhf2w/JA+5rIVjg8MSxI2Jgng2pdfH+PRFyMJdj+rNFde0
         S4bq53BwUQBflPAIk5ebrpyMS9QvGo/C4x2ABVkHLgPBE0eY6Dbz2tBlyRv9+nc8eYY6
         VccTEam0jjri1hweTS7MatY/CndMXOEKa/QlEamUg4RL3xfaj05INxCWuyfDL6ZzZdE/
         FrbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeCQMvf (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752692AbeCQMve (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:51:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A038221720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 18/21] selftests: ftrace: Add a testcase for $argN with kprobe_event
Date: Sat, 17 Mar 2018 21:50:54 +0900
Message-Id: <152129105459.31874.15978479654038019110.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152129024033.31874.15800253385376959274.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595189332626370853?=
X-GMAIL-MSGID: =?utf-8?q?1595189332626370853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for $argN with kprobe event.
This tests whether the traced data is correct or not.
If the kernel doesn't support $argN (depends on arch),
it skips the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
  - Fix description.
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

