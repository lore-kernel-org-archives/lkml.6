Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvqDAOX6X67ARR9PU/MDVvFWt1QYcdbGzBoaGsYaOkgSS1T673g4tdA2dco5UH0f5NOCxdG
ARC-Seal: i=1; a=rsa-sha256; t=1521291145; cv=none;
        d=google.com; s=arc-20160816;
        b=xi+5A8F/EemiXlUgBh1YPGyXs4sV6m2MlYz0tk4PdH/9lXY+ac8jAQobCAApI/MZY2
         V3zcrfjUsuosEyGtjWE9rwX0xptFRxgb4z4hUrJiecbepLNMnJ04SFkO62wHeCdPlrvG
         /YZ7e/2MiEFBfyFrsroZ8Yj0pTwtI6yxFCgFpVh6lxjNCJ3mPXa6tmGB7m18yD+lKAnV
         eGcn68YkHLyE0s1EnmMECy+3rWTbidUVR8g7rTwdhRy5S4yipjb8qmCc5HGGeVeQtdTO
         G7MXP4on65CioP65ACn0yzfKnL/vuY0bM4sGSG9dlUhKow+wqnrd3odQZFmDztGynbnx
         tEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=UEPssAzz3xtqs2h5d5cnOd9w0Tn+gQrn3eNA+NQ2y2s=;
        b=nvm5rnwpUxOkmPDx2dPBUeaFAOlSrF2b4ViixZ9fQ7skJKwnoau/ik7oNXf5UZ5H+j
         ft9Yh5isw98bdZmh5xCsbQeDygGtS6UGgHd5h5UbNzYQHXDf0wNzqBtTvp4PX+y2S4Jy
         9MbdYBGsNUYpbQ21dzK+6dM3F7MobSIzP/XtGbuN1MuGhgUbyjmyAeebQuVoM1IpAaT3
         Db2H2+b+fW+P1L034GL6XQ3CdR8fanHGZPUbMQA2da942lu+R2F26nQNOQubpiunlY7x
         rQl1M3cXMJn67T9rQlBQevCqZK0m0UwhP8WqCECmCwVE9KZtfar7nXwdt7tJrZ8OzRqO
         U0HA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeCQMwY (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeCQMwY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:52:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AFF21720
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
Subject: [PATCH v6 19/21] selftests: ftrace: Add a testcase for array type with kprobe_event
Date: Sat, 17 Mar 2018 21:51:35 +0900
Message-Id: <152129109566.31874.6546174329596347746.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1595189384072600864?=
X-GMAIL-MSGID: =?utf-8?q?1595189384072600864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for array type with kprobe event.
This tests good/bad syntax combinations and also
the traced data is correct in several way.
If the kernel doesn't support array type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Add format field tests.
---
 .../ftrace/test.d/kprobe/kprobe_args_array.tc      |   92 ++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
new file mode 100644
index 000000000000..0d0450b858fc
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
@@ -0,0 +1,92 @@
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
+  BITS=64
+;;
+i[3456]86)
+  ARG2=%cx
+  OFFS=4
+  BITS=32
+;;
+aarch64)
+  ARG2=%x1
+  OFFS=8
+  BITS=64
+;;
+arm*)
+  ARG2=%r1
+  OFFS=4
+  BITS=32
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
+check_field() { # grep-pattern
+  grep -e "$*" events/kprobes/testprobe/format
+}
+
+echo 0 > events/enable
+echo > kprobe_events
+
+: "Syntax test"
+create_testprobe "+0(${ARG2}):x8[1] +0(${ARG2}):s16[1] +0(${ARG2}):u32[1]"
+check_field "field:u8 arg1\[1\];.*size:1;"
+check_field "field:s16 arg2\[1\];.*size:2;"
+check_field "field:u32 arg3\[1\];.*size:4;"
+create_testprobe "+0(${ARG2}):x64[1] +0(${ARG2}):symbol[1]"
+check_field "field:u64 arg1\[1\];.*size:8;"
+check_field "field:u${BITS} arg2\[1\];.*size:${OFFS};"
+create_testprobe "+0(${ARG2}):b2@3/8[1] +0(${ARG2}):string[1]"
+check_field "field:u8 arg1\[1\];.*size:1;"
+check_field "field:__data_loc char\[\]\[1\] arg2;.*size:4;"
+create_testprobe "+0(${ARG2}):x8[64] @${GOODSYM}:x8[4]"
+check_field "field:u8 arg1\[64\];.*size:64;"
+check_field "field:u8 arg2\[4\];.*size:4;"
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

