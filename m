Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/PVVyuslc95AOlS/T2Oz4/vMnkzdOmFGGS98xYKyVbxp0zMsjpLkXAVOpi2X1WhOAKyow/
ARC-Seal: i=1; a=rsa-sha256; t=1524658999; cv=none;
        d=google.com; s=arc-20160816;
        b=aHYfstrC0dPcmJ9G7MVPvesMer6YWQbfurPAwgmTopoLt19RYJDLOoILvdkE6RZBbi
         IVCURas4ajr3sbt8Toy+8h68rxsj+RMjwD4DdAEVcSVHCXkagnlJCVErf5sO2G1us2Dp
         YR9i0kIzdVWZgEjY2e2uCf39ic9MpV/cH7jbnr7YZZ1dnxj5DKTBOapINsn66fScIk1d
         4nsBRMYKEcLeIE7Sf2oshoPu//u76NY/HTdTzfPiMp0gblNZu1YF6wcBUfScmx4NLKMH
         e9NgPzPV+SqH4C42xm1faYP4oORSGO7PqNDrS38sAiEqcSxMcjOU/DmBr1jSGaV8rBFu
         8pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=qyjYX+jvpvoKt3UhLdaHr70/ZArOiIL4MRqBAMV/I+A=;
        b=bZUC01FbLG0q6aFsT3sg36Yu0r0EMINMYI1neB5/xPUndZ30p+jJe0c4S8MpaO/paQ
         uniZTL5+aNzE+w2x2hPJew5S6NirEB1cSUwf/znyGG4FT80Trp/121FgVI4quj3JwoCK
         vqMjgTKFn8DlCI0MTbTttEAqnrsP8cRSvJbl8Q/YfVRvPfrtRhy2XFlGWQ21PkC0tDwS
         W7twvOEwTCGo7+fnoPimvF0GpUXjGuAuYWz5DpHP9BN3EC51Z4llCQShoF4mqb0wNQiX
         LenDWiAAdKvfLirqzTreHRqmwBCdgVAQH8Bc3y/clQoNwuc8Viu2K8LXa/AWCHPlczaa
         qXZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeDYMXS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDYMXR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:23:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8922421789
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
Subject: [PATCH v7 14/16] selftests: ftrace: Add a testcase for $argN with kprobe_event
Date: Wed, 25 Apr 2018 21:22:53 +0900
Message-Id: <152465897360.26224.16676645261172472109.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720835064266511?=
X-GMAIL-MSGID: =?utf-8?q?1598720835064266511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for $argN with kprobe event.
This tests whether the traced data is correct or not.
If the kernel doesn't support $argN (depends on arch),
it skips the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
  - Fix description. (Thanks Namhyung!)
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

