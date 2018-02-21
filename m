Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226aW/5LIzY5Z5zZaimFeCjq00QNRI8FmncrEVn4fgjahVjml64qafKCX9EB0R8Y/KpkULw8
ARC-Seal: i=1; a=rsa-sha256; t=1519225315; cv=none;
        d=google.com; s=arc-20160816;
        b=unzdLY3Y53j4qv5R8NYlZumvQAo9MRg+my7eARL3ZmpaUsaKts350C9EhWqYVoUNP2
         z8/ta4Co+b83wYbmS+wMOI7i7DQGbcpXid0E7fiLXisIL7M6MIanduwPHaTS7KtaRTwA
         bQBZ9c2DnSF8UIQ7JF9kPEKIG7mBHu4ulTw7B47UohOjh+cr1c0EZHAOfdZsG0Og8sz5
         nq9zPg1ySHGFebMsG9GdZK+sPEAA2X6WC9/bWaB+7uu7TpBKTf/CwF0HOxA6wEX539EJ
         YKZ/mrPgZUxQPcrUO6aVedSdmqQXCAh5m3VxACnQE5e2rQGk2HfLMF+eKqqfRhl827r3
         FquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=jyCmF86AGjIIxne/19448LcTbObHqUgTNBv54LloPVE=;
        b=e8UF3d0Uj4Yy9GcDHiLkrpwHEW5XARc/ti6Gr66ws38gRfXmjnxJe7ZAjAh1uW2+nb
         uUCs1zjVS4N+c8JcnR1VSuZlhZnDk9MYRP6hOQLsyxkAONPTsnM3xVxw8PUJK5aFZ3nx
         n6GD1ZIfR2dK8laS5XsUTjPcPVlA3SkRkYXRuObgzexhaHzt712mQzuBzGhk89as6xMc
         FV0v4JYAJUboCo6KjqzdDWuykJ69TCbYz7+qUIlqhu2eXp0TYi9ji39AW8dVtI4ax9sf
         JfmlYVrmpPReAk5fYo4yzqAtcjucWovoS2pMEffun8FvuZBRpmNKbTqMvUwNK3nJZbHd
         k9Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937204AbeBUPBy (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 10:01:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934828AbeBUPBx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 10:01:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B51F2178E
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
Subject: [PATCH v2 15/17] selftests: ftrace: Add a testcase for symbol type
Date: Thu, 22 Feb 2018 00:01:29 +0900
Message-Id: <151922528927.6217.272823645130675841.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151922484560.6217.1143686155616343906.stgit@devbox>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593023203354951392?=
X-GMAIL-MSGID: =?utf-8?q?1593023203354951392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for symbol type with kprobe event.
This tests good/bad syntax combinations and also
the traced data.
If the kernel doesn't support symbol type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   73 ++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
new file mode 100644
index 000000000000..a5820b175df5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -0,0 +1,73 @@
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
+GOODSYM="_sdata"
+if ! grep -qw ${GOODSYM} /proc/kallsyms ; then
+  GOODSYM=$PROBEFUNC
+fi
+
+case `uname -m` in
+x86_64|i[3456]86)
+  GOODREG=%ax
+  BADREG=%ex
+;;
+aarch64)
+  GOODREG=%x0
+  BADREG=%ax
+;;
+arm*)
+  GOODREG=%r0
+  BADREG=%ax
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
+echo 'p:testprobe create_trace_kprobe $stack0:symbol' > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -q "arg1=trace_run_command"
+
+echo 0 > events/enable
+echo > kprobe_events

