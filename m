Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvt/PRxormbNDsnWIbf+5Y4TkhmpQC2jl+L/e5oIQaW9qednTg4Zwd3Q6Z1kSWNzc+DqwCD
ARC-Seal: i=1; a=rsa-sha256; t=1521290472; cv=none;
        d=google.com; s=arc-20160816;
        b=IFcQ0+RoTjV44qNGr29RSVP2aqpRyp4466G0LVFPrrNk6AlFc8xBfGC0krf0LvHamQ
         IFCAqQNvfxB/Fm5rMBfJgmhxyl9r06/SLc/B0JvmixGo08ZXslo/MDIK6cpp9746s6JX
         eUYzqrswoLYhW0ixUyhAgW5YFv18QC87tdCOrR1AgRlw2VdVFfz//FPMt2gq0XEwhaOZ
         JCy8CyL2XphMvRK+QnRwzgmvbtMkyJssL6Jra+aeovMuQzCte1hP1a4rAs6SF7dc4gAH
         /eNsrnEbqLSLxijZLvxIBMCfNGFTd+cIjYYlpuiS3wu5MVlJddWsF5YF+k3fAWNpLykh
         NZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=GfTXTHo79NzIzS+EIBbaAvgtLvhNddF0fLEzdPm3z/E=;
        b=L8DoPMNSWeXqLQ+cbXU5b1SOYV6wR+S2cn4JGfZ1SD0836EXPUabcic1leKrkP7N6K
         N7U7/uTKV8wZPaMXgqKPef8dod+pRGDnO8IYYCfR2UwqZ3ZGtEAPfszkZkzSM6BnRVhH
         q1Hvmjog3UATsib6Qb7FFnTpuPGkV+O6StzIExbiy90bQmAEUpu1MhDpNPQHhWdrUkUZ
         k5BLZ5SDD+4n7447ExD4rddcPKLg8hv6qWXRNJsVINh747UEX0CK1VsQ/qhikkQKZqLy
         HQoHTFiEckI++Qs/B7P3Vi02L324S4BF26lXC5LgJc5OIsguFCZS4rOb7/K38ZVsYt5d
         MMEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeCQMlM (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeCQMlL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:41:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A63921737
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
Subject: [PATCH v6 04/21] selftests: ftrace: Add a testcase for probepoint
Date: Sat, 17 Mar 2018 21:40:31 +0900
Message-Id: <152129043097.31874.14273580606301767394.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1595188678577462103?=
X-GMAIL-MSGID: =?utf-8?q?1595188678577462103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for probe point definition. This tests
symbol, address and symbol+offset syntax. The offset
must be positive and smaller than UINT_MAX.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |   43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
new file mode 100644
index 000000000000..4fda01a08da4
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

