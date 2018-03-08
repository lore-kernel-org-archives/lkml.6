Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvQmQTf1hXVdjFAR9Jdcq3i00HaB40WAMHk53pN2/q9ayVpdOc4NfYYtzXnodM7XbgDl3NS
ARC-Seal: i=1; a=rsa-sha256; t=1520498771; cv=none;
        d=google.com; s=arc-20160816;
        b=n1gKvXOFDwrYzLm73AnseRzYzYb3tOrieSmXxPB2aP59R7C2OQtqcAlZrek1/BLweD
         KY1oI/kAmjGkD3b5VusVW/0B4ODrvTEBdVHn4/IqMvqh+okvzM93k9VVTnQOyJNd7y6o
         bLXkpukuhj3GN+JVgULeGMzh88FTquiz3SPTKdgIn17mbt9nl4hSPkFOIhXBe6etE0hJ
         3mdvQXI6aOPY7os7lYRLWNYR8F7qrtpMvuFn9JeG8yiErcPJ9OvAAc8Y1L8WBdFshEy0
         HyqHWYDTb0nhVJBmLBSkTO2ODWliPCVVj4pRYh87lQNhy79BJnBzoPTPortXBwPY2LvO
         bIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=GfTXTHo79NzIzS+EIBbaAvgtLvhNddF0fLEzdPm3z/E=;
        b=VzWMhfjTRzpWOneB53lI255GrJJyAVceVP5rUT72vzpSD1ahpOcWTC3QIxTjfG2bpo
         CxAidg/ZeLQ5U8xTnc53Gg4hgxpL/NasFPPIYhcV53kbC9MwPrcqVEc51wnmE5D2lBNS
         xS2W613BYCIuZd6YoTqTiYwoPFDtTPnkOdqt027akrCtSlM8B3FRy3uuuhOG1aD/OLSh
         /FuFGI9gmhFlBV9GJ/YxEBIAv/asYWm2QgQAlmyq1lAs7gMv2T1PI0BepCcJWPd0DOYt
         GFHESXET7XlkRZze0agwaIyGMcOaQ6omlb5nSUu0iMtAhfEvvgrBt6Uo2I34pRPLLEZG
         PjsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934653AbeCHIp5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934542AbeCHIp4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:45:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A962B2133D
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
Subject: [PATCH v5 04/19] selftests: ftrace: Add a testcase for probepoint
Date: Thu,  8 Mar 2018 17:45:32 +0900
Message-Id: <152049873256.7289.3073863568299389050.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1594358519687245811?=
X-GMAIL-MSGID: =?utf-8?q?1594358519687245811?=
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

