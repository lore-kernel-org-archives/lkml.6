Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuKqdCPjkkZ9zNfUnSDoHaYdP0fbG2MUsYCVekBGssUMHWjk9us/TZWltw6Nodt30KvqsHc
ARC-Seal: i=1; a=rsa-sha256; t=1520499159; cv=none;
        d=google.com; s=arc-20160816;
        b=eximQS3wDC4Sv1ZTB1UIK/uqTrmwRcFkOZaTRvWqDFb2HUssL33KBsVtGOuINJepft
         eL/x8gEDE76M4bYToNPImKaxMCF/6hUNUjihW48NiF54bJTzqi2jjpEgyW+D+uOdc6+v
         vNVlIPuqvpIy9bQuvCH50rqh5prOGDax9/T/4jVUu814ko6Vbx8TF8n0878JobTWet0Y
         3bOCYjUuxNyhV/UyEpfY9IpwUdxBI8WRuYFnJc08Wp/DOga0K1Fkh+VmNAIsQTulCMH1
         h9ztgELXxyshTNN5Ugtmj/S++KOXrkA9TawmkP2DG9j09PYKiM5j5tnt2pzi2+GggZVO
         x4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=UEPssAzz3xtqs2h5d5cnOd9w0Tn+gQrn3eNA+NQ2y2s=;
        b=08SxDxlZEYeO6nW3yBiudv1Crl32MShgplO/8oce7r61fS5jT7z5DBI/2lE7SxaAWy
         wwSd2GtMKB+t4+TWoyNzkfiIuVYGrLcInAuk+iC0HL9hveB0vTRxIwq9b22iXN2B+PMa
         SkSGQLmIhW/1kYBiE5yWUVS/hy25YLUQ6fZMJlgmSors1dnvYbZMk/9Jd7fTm/p16seH
         vIWMseQK4FolbJuRxmwwCvBC42wtyTkjzfD2gZTm1M/O9rNtbJ4xZbUaVYQEGngSLddS
         ykKkEn6cNCcMeB30E87UW2+Bu1KyXX4AxVWKqoGIMATX3ncd5H68vClecUJ4yYEQ8Cbx
         fi5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934435AbeCHIwZ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934942AbeCHIwX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:52:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87BA2133D
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
Subject: [PATCH v5 19/19] selftests: ftrace: Add a testcase for array type with kprobe_event
Date: Thu,  8 Mar 2018 17:52:18 +0900
Message-Id: <152049913872.7289.12057765140002812591.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1594358926800764135?=
X-GMAIL-MSGID: =?utf-8?q?1594358926800764135?=
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

