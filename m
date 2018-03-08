Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvxqB+ZKebGOwUWenasFl7vGoh3UEhEgQ8cAvg14Dw/v5Nr6ktdo2lxfGHORr0uAJLiktOl
ARC-Seal: i=1; a=rsa-sha256; t=1520499106; cv=none;
        d=google.com; s=arc-20160816;
        b=MnuxZFfcWHWCQhI5BD485Lej4Id2pGhs9LiS7YTnZCL/1shMvl8sl8K4sh+3GQk4Te
         Qfp6CnlElmguTQRQtQnvDLZkNbaAvNrrCFcXh/oQrspddlKK3pOp0l7FMqkeIV4tMIhj
         U1IUFwiVWIjVTbmEEqsyIJ0J/f4vRtl37j7kdZDCvBuISObaiDMzd5qoslkkU8fPQDX0
         fKZ+DC0GD66mMUr+W3lE9Ibsg4c4qvonc9mskziCehn9ZkD9au+2n5dUgXR2OWOGvsbQ
         guR+Z6im2JE9FWaJb2fEotkxKn164Vu/Ec4U58EIQ7GIMGnF3lbu9tSD8iMjncsbmJTu
         LPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=R/dyTmRnW8g5+R8eJUQju+kwfMcUMcRJrj3q5UyXUrg=;
        b=Chvs0w8mS824f6RZjuqWUHyZGjdzJvKEklm0TqbV2OXZwp+2KOtDdJjIx9nouNrtS6
         b6cG4X8qxMbkLFl92jQAl4Su8mb08SCvOXuorh7hQiDyNGfsILqwQrHWDNqvpt8bWRMl
         STpb9dIOtdcXmLfeFq28oV9ZJKmMQURuKQIFvZaslZMl+t1VUpkm7bKf8xBWWUnHLKb7
         b6hutpk/YG/MMMTiADhKccw2R4/NgZl1FbdBr74ULqE81fB5uQo2305kw8FpAyIQfDQs
         /LLQKvs+DJdSDEbZX65aBQy4tL8QVAvsyZlkQQ1kR7aEaZuNSDGdHZ7Ns1DQVzsNINRK
         /9rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755303AbeCHIvp (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755224AbeCHIvo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:51:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AA52133D
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
Subject: [PATCH v5 17/19] selftests: ftrace: Add a testcase for symbol type
Date: Thu,  8 Mar 2018 17:51:20 +0900
Message-Id: <152049908037.7289.10781368517931604646.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1594358870761129289?=
X-GMAIL-MSGID: =?utf-8?q?1594358870761129289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for symbol type with kprobe event.
This tests good/bad syntax combinations and also
the traced data.
If the kernel doesn't support symbol type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Use IP/PC register to test the symbol type
---
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   77 ++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
new file mode 100644
index 000000000000..20a8664a838b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -0,0 +1,77 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event argument symbol type
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -qe "type:.* symbol" README || exit_unsupported # version issue
+
+echo 0 > events/enable
+echo > kprobe_events
+
+PROBEFUNC="vfs_read"
+GOODREG=
+BADREG=
+REG=
+GOODSYM="_sdata"
+if ! grep -qw ${GOODSYM} /proc/kallsyms ; then
+  GOODSYM=$PROBEFUNC
+fi
+
+case `uname -m` in
+x86_64|i[3456]86)
+  GOODREG=%ax
+  BADREG=%ex
+  REG=%ip
+;;
+aarch64)
+  GOODREG=%x0
+  BADREG=%ax
+  REG=%pc
+;;
+arm*)
+  GOODREG=%r0
+  BADREG=%ax
+  REG=%pc
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
+esac
+
+test_goodarg() # Good-args
+{
+  while [ "$1" ]; do
+    echo "p ${PROBEFUNC} $1" > kprobe_events
+    shift 1
+  done;
+}
+
+test_badarg() # Bad-args
+{
+  while [ "$1" ]; do
+    ! echo "p ${PROBEFUNC} $1" > kprobe_events
+    shift 1
+  done;
+}
+
+echo > kprobe_events
+
+: "Symbol type"
+test_goodarg "${GOODREG}:symbol" "@${GOODSYM}:symbol" "@${GOODSYM}+10:symbol" \
+	 "\$stack0:symbol" "+0(\$stack):symbol"
+test_badarg "\$comm:symbol"
+
+: "Retval with symbol type"
+echo "r ${PROBEFUNC} \$retval:symbol" > kprobe_events
+
+echo > kprobe_events
+
+: "Test get symbol"
+echo "p:testprobe create_trace_kprobe ${REG}:symbol" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -q "arg1=create_trace_kprobe"
+
+echo 0 > events/enable
+echo > kprobe_events

