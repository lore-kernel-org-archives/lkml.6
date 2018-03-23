Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeCWWOd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeCWWO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:14:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B682921835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180323221427.710221696@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 23 Mar 2018 18:13:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/4] selftests: ftrace: Add probe event argument syntax testcase
References: <20180323221311.405667933@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-selftests-ftrace-Add-probe-event-argument-syntax-tes.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a testcase for probe event argument syntax which
ensures the kprobe_events interface correctly parses
given event arguments.

Link: http://lkml.kernel.org/r/152129033679.31874.12705519603869152799.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
new file mode 100644
index 000000000000..231bcd2c4eb5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -0,0 +1,97 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event argument syntax
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
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
+BADSYM="deaqswdefr"
+SYMADDR=0x`grep -w ${GOODSYM} /proc/kallsyms | cut -f 1 -d " "`
+GOODTYPE="x16"
+BADTYPE="y16"
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
+: "Register access"
+test_goodarg ${GOODREG}
+test_badarg ${BADREG}
+
+: "Symbol access"
+test_goodarg "@${GOODSYM}" "@${SYMADDR}" "@${GOODSYM}+10" "@${GOODSYM}-10"
+test_badarg "@" "@${BADSYM}" "@${GOODSYM}*10" "@${GOODSYM}/10" \
+	    "@${GOODSYM}%10" "@${GOODSYM}&10" "@${GOODSYM}|10"
+
+: "Stack access"
+test_goodarg "\$stack" "\$stack0" "\$stack1"
+test_badarg "\$stackp" "\$stack0+10" "\$stack1-10"
+
+: "Retval access"
+echo "r ${PROBEFUNC} \$retval" > kprobe_events
+! echo "p ${PROBEFUNC} \$retval" > kprobe_events
+
+: "Comm access"
+test_goodarg "\$comm"
+
+: "Indirect memory access"
+test_goodarg "+0(${GOODREG})" "-0(${GOODREG})" "+10(\$stack)" \
+	"+0(\$stack1)" "+10(@${GOODSYM}-10)" "+0(+10(+20(\$stack)))"
+test_badarg "+(${GOODREG})" "(${GOODREG}+10)" "-(${GOODREG})" "(${GOODREG})" \
+	"+10(\$comm)" "+0(${GOODREG})+10"
+
+: "Name assignment"
+test_goodarg "varname=${GOODREG}"
+test_badarg "varname=varname2=${GOODREG}"
+
+: "Type syntax"
+test_goodarg "${GOODREG}:${GOODTYPE}"
+test_badarg "${GOODREG}::${GOODTYPE}" "${GOODREG}:${BADTYPE}" \
+	"${GOODTYPE}:${GOODREG}"
+
+: "Combination check"
+
+test_goodarg "\$comm:string" "+0(\$stack):string"
+test_badarg "\$comm:x64" "\$stack:string" "${GOODREG}:string"
+
+echo > kprobe_events
-- 
2.15.1
