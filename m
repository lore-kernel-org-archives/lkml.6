Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227OisxHu2J50dBHcw+zxWBSYbrn4k8J0rqLlWDfZPuKWF7g3iN0Ny+cEJhCMQw91RRsOZjf
ARC-Seal: i=1; a=rsa-sha256; t=1519450652; cv=none;
        d=google.com; s=arc-20160816;
        b=WocijHgL9O6YURJGIgYx7zc3oVzSXnX6RZtolL7FaTqNQilONAfURqo1Dc93T2/wlm
         yTSKhHwTpx0bQn8UF3Igm6esdgPY+MzlX8g/T/S4Khe9F4AmhA1rGOxZ2WKErEHJrXUX
         r0ppWCjCTXHH+nSORHB8y5JqCGf0QQ1lBeSxDW5j8bsHEZmWoANCOfMeepyadMOuWEP8
         BC2ss2vJpQ1iyVCnB8sqRkpOwzb+NqXwhfWaS+4UU3dYegslD8tqo27TJpBfZbbsyrT7
         PohJvWWGo2Sn8BqKbm7uUg49pQ/El4YRKeCbgyzRSw7NhDcQF1Xr66FyhbXPuTynTgdm
         OzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=guuK+zNPqVwe9RHHKGs57S3yW1c2zeDHNV8Fu1QEQjI=;
        b=lhntIkVle/uUceySrYRv1vPYkUNigWHTta2c4K0k8odwtdHKmUU/YdnpXKRLPBGOB3
         AAc8k/MwM6EfBm3LuZ0NmxVQTqpuFhJm8fMlBnqLe8vTwTQfHy1FRFofu5v4VJwRz+91
         aFIoyq92gMH0RaGniWuQXtM7hcpZsiBUmvAs2ePWd/Pjz7mWH3NT4rKrkr9NgJMSVPn8
         f/bOMLaCN+XPe0equWqNkRfNQL6FDK6d0V7meKis0MYQu7VPbZYPOKkUadD1p9q+PxCr
         qbFtZle6XEd/Mtec6YolCN2VFcBJS5erMOqN6nDd/6sWKYeGf1S/T2fNufz6CXnAUwxQ
         gzkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBXFhb (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeBXFhb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:37:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F99E21741
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
Subject: [PATCH v3 18/18] selftests: ftrace: Add a testcase for array type with kprobe_event
Date: Sat, 24 Feb 2018 14:37:07 +0900
Message-Id: <151945062720.27508.495663650461994021.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593259487408003592?=
X-GMAIL-MSGID: =?utf-8?q?1593259487408003592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for array type with kprobe event.
This tests good/bad syntax combinations and also
the traced data is correct in several way.
If the kernel doesn't support array type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_array.tc      |   75 ++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
new file mode 100644
index 000000000000..27c9628c1fff
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
@@ -0,0 +1,75 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event array argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -q "<type>\[<array-size>\]" README || exit_unsupported # version issue
+
+GOODSYM="_sdata"
+if ! grep -qw ${GOODSYM} /proc/kallsyms ; then
+  GOODSYM="create_trace_kprobe"
+fi
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
+create_testprobe() { # args
+  echo "p:testprobe create_trace_kprobe $*" > kprobe_events
+}
+
+echo 0 > events/enable
+echo > kprobe_events
+
+: "Syntax test"
+create_testprobe "+0(${ARG2}):x8[1] +0(${ARG2}):s16[1] +0(${ARG2}):u32[1]"
+create_testprobe "+0(${ARG2}):x64[1] +0(${ARG2}):symbol[1]"
+create_testprobe "+0(${ARG2}):b2@3/8[1] +0(${ARG2}):string[1]"
+create_testprobe "+0(${ARG2}):x8[64] @${GOODSYM}:x8[4]"
+
+! create_testprobe "${ARG2}:x8[1]" # Can not use array type on register
+! create_testprobe "\$comm:x8[1]" # Can not use array type on \$comm
+! create_testprobe "\$comm:string[1]" # No, even if it is string array
+! create_testprobe "+0(${ARG2}):x64[0]" # array size >= 1
+! create_testprobe "+0(${ARG2}):x64[65]" # array size <= 64
+
+: "Test get argument (1)"
+create_testprobe "arg1=+0(${ARG2}):string[1]" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1={\"test\"}"
+echo 0 > events/kprobes/testprobe/enable
+
+: "Test get argument (2)"
+create_testprobe "arg1=+0(${ARG2}):string[3]" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo foo bar buzz >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1={\"foo\",\"bar\",\"buzz\"}"
+echo 0 > events/kprobes/testprobe/enable
+
+: "Test get argument (3)"
+create_testprobe "arg1=+0(+0(${ARG2})):u8[4]" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo 1234 >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1={49,50,51,52}" # ascii code
+echo 0 > events/kprobes/testprobe/enable
+
+echo > kprobe_events

