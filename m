Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224nepNVxBV3zO+qS8faM+XQIVg1Ond1aG0QXZufjIdddGIu98Yaors9x0zfkyzd4RFy3U41
ARC-Seal: i=1; a=rsa-sha256; t=1519788576; cv=none;
        d=google.com; s=arc-20160816;
        b=CI1a9SOYUffRsvnvHREs5GlXpqq/pzrr2kXS9uU6FyJK5mfGgXCkl3b15TAoK8Eg8G
         +Bg26DsypF/h2zhYL30zXSfgb+wtgMRcbxgAQKNhBfv/xfT2Mo9+8DOzEJ54rnzho4F1
         LS/4i2w7SsnXcAFIKbP93UGYPKCzKePVMy/dRX6AAwYkz7nSx/x17/KhiqO+f6h7hH4F
         dOXRXy+zUibCrwnzIk4h7drTmS31xdgn4DdasB9QR5PF17E8jElQpRRq6tsNTlWrv5Qi
         9oZf0Dpnc5X8uFz/eXX8fQ99ZbktvhtW8kKurNmCKKTnKauTt6ksf7YyQUj60YiWyxIC
         w8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=UEPssAzz3xtqs2h5d5cnOd9w0Tn+gQrn3eNA+NQ2y2s=;
        b=1Iu9VaZsqtjALiSlPe3nYqp66QR0lilgbXqZznqdnJ5eRtTf/jaqDPw/O/cJf78Nii
         udj4ZDNV4u/GRTM2h7hRmTDUoHyU8VIoa/5tD9lGsaswcJdM1b4Tt3jzbQ4xQcDFg3Rq
         +dtwYewaqB1RpJwp+ah3IW0AA9ncg1MqS1PsdoFGuVvWFOKH8j+T80wt7eEs/r+VioLD
         u+Vnm0vJQLxWNqKUzIGrMggJlhoTSjWX/SpQD1T1jjXWjZQXwpcEnMbMMGo4EcbCzYeu
         Wuv7ewEHrmT1MWzXmuFIlZJjBYzRzu2gddNwMGBZINVOmbo5N78LABr6Th5HLPArmBoi
         TXLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeB1D3X (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:29:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbeB1D3E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:29:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECD02133D
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
Subject: [PATCH v4 19/19] selftests: ftrace: Add a testcase for array type with kprobe_event
Date: Wed, 28 Feb 2018 12:28:40 +0900
Message-Id: <151978851997.2577.2012127759002018319.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151978796240.2577.6531711990653677529.stgit@devbox>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613826663191068?=
X-GMAIL-MSGID: =?utf-8?q?1593613826663191068?=
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

