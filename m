Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225JxT5fj4XSfnK5NRZgRQLf/dvlk9EAmmkmMip5Qn+4j5S0m2ZxBtO8t3jnzQ8HSv+bCFXr
ARC-Seal: i=1; a=rsa-sha256; t=1519450595; cv=none;
        d=google.com; s=arc-20160816;
        b=Hyoa5KS0M7lBUX1tNvy+TPxa3wkXOs79ka7Q5oY1rmECz+yyib+7LgC3+2i9pmwj29
         0yOSazvWBSH6l1GWsd1vSz1/2HNpl3B7h3o2tGjsNCSfoP1HN23y+BOiAIAjHpMMfXNm
         ARvh4PhnY8BYuS4O4OJ2Em4Gx8q3eAKqwpzqFJ+CQSYvszLs61aWSX9l5S7/XwH8lDiC
         qLpxqyHKdHfHCSR23tlZdBcmvWau9AoRlvnxxzV3hI0vIn6KkisEYEXVDviu2hr5EGhI
         ZLUyF2ZGPwTvKAFDh7sqf3g/9b0H0GXG5LO4Q8kjjRCgFsvbUzXJeV9A+2HQaYgKpkdI
         IfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=R/dyTmRnW8g5+R8eJUQju+kwfMcUMcRJrj3q5UyXUrg=;
        b=xrKQy7YhHNRjMDPGG6lp5KINl2sf/O8wld4EiSdkuZhGwrNgw5HSV9rCdhZY5/zbI8
         xbZXwrbKLnT1xCPb4Wyc1ampYxhRjYtdzPvC1694gjVHv9isCYD7HEOAmKBjYp5Uy7x7
         6kw3VX6DsiEAKfuV/XkjNx1bmpOwqxksIlcg2TsKrXZAFvwVpXwhPWQPSBJ6eTr+ag6i
         GSrdVT6MLeC+hU5FH5oX32dJOIO9mf9rPDsctISefRnM41sTnIuAZxg+EucYrWSxIb6d
         rzeod3jeZcr+//KHK2FrCDSRVcMHQD6pIufT98FzEDPllAD9uFy8cVFTwkjmNrW/hCb9
         Jv+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeBXFge (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:36:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbeBXFgd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:36:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749CE21785
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
Subject: [PATCH v3 16/18] selftests: ftrace: Add a testcase for symbol type
Date: Sat, 24 Feb 2018 14:36:09 +0900
Message-Id: <151945056932.27508.12649549123602913039.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593259427146841213?=
X-GMAIL-MSGID: =?utf-8?q?1593259427146841213?=
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

