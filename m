Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48x1wMKhKEcfS4FggbdwHz5GdbU/xAv6av1j/EsAjSlcKmBAj4oi5Onn5TKI2Gaa+OkXNNH
ARC-Seal: i=1; a=rsa-sha256; t=1524659043; cv=none;
        d=google.com; s=arc-20160816;
        b=hfNMT4dAE9tEDA4EHKujTzFRvkYVJo0u4hl5HjChaBulFSanyiFcailMH5VZHvZHqt
         rPIGiVSUkTf85gFjXQLJY6oVCZ1RI4nobmJx/oNkx3KDDUocos/twL3e3ih2FMcnAfXK
         Ggkm8+xEbYQXVr45/JH+gaKMrGQQsL0i7JCej4sfdjtR/FRBRmuMYI5lidMBg+VclNuF
         zzAPhsFQuMqhJCenoPDimtKdZGR0UHBghf9ktyBfVNq7BL4sXFdgMOT8CI93TPPRQWZX
         QINPOlOy0YQiVJG3n58bC453Cfn1rkjAAXrbDJsTJezUVvS+Jm3WsbRQFDL6nduRkVTz
         fGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=7aB1kwejNV17jGwVjM0014os7ABz8p7j7Dt0VYnQJ10=;
        b=Tub4i2saBiw7JTH99uQqtnKnWnKWNKuXhdcI3tyxHuOWX2o9X4BcOqWv65LSgAUdBK
         l+SFfobaGfCnJ1+y94Al6ZUKDu06nxAShxoA77J4ya4voDQtDpntRsxshr/FOrPeC5wS
         rFxtnugScf397sy9AkyLSqJ8JB+IffCjoSVLkAU/oRXd6p9oLXeHPh5rWxtxKDXJx1hK
         D7Qei5c6AhbTOR1m3QaSjyK8S9hLSzoON92JBmR+/5QjO0kEsYw0zmvesHXnT41Nm6YG
         5C1PM47oe4hS6f0zQiKte9WWKAUdHYX8ZzLLSgYaKlm6cBqRUfgGUa7UbX1Ib3GeMaxR
         hIRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeDYMXs (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDYMXq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:23:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7312121748
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
Subject: [PATCH v7 15/16] selftests: ftrace: Add a testcase for array type with kprobe_event
Date: Wed, 25 Apr 2018 21:23:22 +0900
Message-Id: <152465900245.26224.15182085325355859897.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1598720881055873854?=
X-GMAIL-MSGID: =?utf-8?q?1598720881055873854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for array type with kprobe event.
This tests good/bad syntax combinations and also
the traced data is correct in several way.
If the kernel doesn't support array type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v7:
  - Fix README test.
---
 .../ftrace/test.d/kprobe/kprobe_args_array.tc      |   92 ++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
new file mode 100644
index 000000000000..7a3819fc1c31
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
@@ -0,0 +1,92 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event array argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -q '<type>\\\[<array-size>\\\]' README || exit_unsupported # version issue
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

