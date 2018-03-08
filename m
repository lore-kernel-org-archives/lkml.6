Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsBzj0JzoKXi/Vv6AmhDxsNgUoCtllKmRoguAiza4f4JFrqWNMLP6GB9iQm7zWVn4R1IOT4
ARC-Seal: i=1; a=rsa-sha256; t=1520498729; cv=none;
        d=google.com; s=arc-20160816;
        b=ZPUDcU38S9paH2gBGLZ2/bHYbzrQkqhdKcwhp24gKR2Fhi+Rpk3a6qeipf8dPcyvKb
         Gf14Lirnlri4EOioAT2takjffzYJ1O4Cs3AVlK6NFE0Jb/L46gp0VVIyE6LTYCpNvNgz
         5H2J1OwnpKn/HGKd9Bp6/UFDCvxpy4Kx50KGj0IXVPCFR2sISjuLMENfjpwRWKoAMqcv
         sgSMiSg35wvy2hT3gArWTl7Zj1YPtR4a92wff143wNpsRKyDKBoQ9leC4NjiEdeiUOT8
         xx0GPT3mBUdirRdiUChl7jB7hGCRIW55asyKQ4kouqGXnQN4oljg5cUQ3Iy5dAvPZy+5
         41Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ROLfIujIxGgXBYkZ9XBsMoCYyAz6jbwvTxn4Cz5wcCc=;
        b=zyhAAeAUA3ssoch1W+3le9twmcFqC73YOUdooe+t6bu/Agna2+HCwkDTlYbMvuFjhz
         31phFPxPV/lqg6wovlEwiwvFROClwBp7VSiSLcr1r+pXjppdlWpsNkvpNjoDCDkKa3M8
         EmIVt21d2eFCNbgjvoFwXFxE9YmGHXilMKQVbVfxxo5vZwp+vkZIRGxWJX53FUNmerNE
         ebC611GhlzWm69/FCbGu1Z8IOvCWDk/GbOPKx0GuDLt8pN968fub0hnnyN3B1XIbXtqm
         NUPgkxmL8agtHmXF2i90ZbH1D6dCu4sbRcO2eMEm8bXFJpg3D8CYDs0CxIRTtu9ZSFQw
         vbxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755256AbeCHIp3 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:45:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755303AbeCHIp2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:45:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948322133D
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
Subject: [PATCH v5 03/19] selftests: ftrace: Add a testcase for string type with kprobe_event
Date: Thu,  8 Mar 2018 17:45:03 +0900
Message-Id: <152049870345.7289.2673869684625643737.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152049860385.7289.14079393589900496424.stgit@devbox>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358476094820290?=
X-GMAIL-MSGID: =?utf-8?q?1594358476094820290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for string type with kprobe event.
This tests good/bad syntax combinations and also
the traced data is correct in several way.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
new file mode 100644
index 000000000000..5ba73035e1d9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event string type argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+echo 0 > events/enable
+echo > kprobe_events
+
+case `uname -m` in
+x86_64)
+  ARG2=%si
+  OFFS=8
+;;
+i[3456]86)
+  ARG2=%cx
+  OFFS=4
+;;
+aarch64)
+  ARG2=%x1
+  OFFS=8
+;;
+arm*)
+  ARG2=%r1
+  OFFS=4
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
+esac
+
+: "Test get argument (1)"
+echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=\"test\""
+
+echo 0 > events/kprobes/testprobe/enable
+: "Test get argument (2)"
+echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string arg2=+0(+${OFFS}(${ARG2})):string" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test1 test2 >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=\"test1\" arg2=\"test2\""
+
+echo 0 > events/enable
+echo > kprobe_events

