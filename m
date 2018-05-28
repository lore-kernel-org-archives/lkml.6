Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164302AbeE1Kyi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164279AbeE1Ky3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 293/496] selftests: ftrace: Add a testcase for probepoint
Date: Mon, 28 May 2018 12:01:18 +0200
Message-Id: <20180528100332.168568461@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit dfa453bc90eca0febff33c8d292a656e53702158 ]

Add a testcase for probe point definition. This tests
symbol, address and symbol+offset syntax. The offset
must be positive and smaller than UINT_MAX.

Link: http://lkml.kernel.org/r/152129043097.31874.14273580606301767394.stgit@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc |   43 +++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc

--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe events - probe points
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+TARGET_FUNC=create_trace_kprobe
+
+dec_addr() { # hexaddr
+  printf "%d" "0x"`echo $1 | tail -c 8`
+}
+
+set_offs() { # prev target next
+  A1=`dec_addr $1`
+  A2=`dec_addr $2`
+  A3=`dec_addr $3`
+  TARGET="0x$2" # an address
+  PREV=`expr $A1 - $A2` # offset to previous symbol
+  NEXT=+`expr $A3 - $A2` # offset to next symbol
+  OVERFLOW=+`printf "0x%x" ${PREV}` # overflow offset to previous symbol
+}
+
+# We have to decode symbol addresses to get correct offsets.
+# If the offset is not an instruction boundary, it cause -EILSEQ.
+set_offs `grep -A1 -B1 ${TARGET_FUNC} /proc/kallsyms | cut -f 1 -d " " | xargs`
+
+UINT_TEST=no
+# printf "%x" -1 returns (unsigned long)-1.
+if [ `printf "%x" -1 | wc -c` != 9 ]; then
+  UINT_TEST=yes
+fi
+
+echo 0 > events/enable
+echo > kprobe_events
+echo "p:testprobe ${TARGET_FUNC}" > kprobe_events
+echo "p:testprobe ${TARGET}" > kprobe_events
+echo "p:testprobe ${TARGET_FUNC}${NEXT}" > kprobe_events
+! echo "p:testprobe ${TARGET_FUNC}${PREV}" > kprobe_events
+if [ "${UINT_TEST}" = yes ]; then
+! echo "p:testprobe ${TARGET_FUNC}${OVERFLOW}" > kprobe_events
+fi
+echo > kprobe_events
+clear_trace
