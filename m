Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224FZYi6bBPuxpZksYB2EkytD5p7boSsgf5ryLp7VelGA3i/SRKsjj8L+zPe4M89vewYuQ+e
ARC-Seal: i=1; a=rsa-sha256; t=1519788110; cv=none;
        d=google.com; s=arc-20160816;
        b=WconyGLBZ49+pjbKJ1PnDE4MwjfUnGfP7iLNkrQLjgbolXImgH1YQE53d6PK2LXQln
         N5H49Icic54KujcFIxKJ9X4pL0SYzqJ8CLPFa9BTVLX307SRYdaiVfNUCpIoaxiJH/K2
         8mCfyoR14aaTPkSUUgu8LXUwJD0iCBItxTJxQP3k52O6nSGhrzVd0xG47klhQSpGjgaW
         U5Eyiu4SN9zwuYeEAxXXvBf56vhA5KAMl91Buq3Nfeh3tnB3hCAqEdTRfIo/hoYfiGac
         84Cqv7rSKgmlw7+XMqn5GBHz63d1gi08pVzhqNM49VQgT88d+uIaHmio8rCmjg1J49O5
         pJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=GfTXTHo79NzIzS+EIBbaAvgtLvhNddF0fLEzdPm3z/E=;
        b=mEwQ6oOJehxll2YhjWkWhSBZN5EOPWoU9U/qmYazhT+pfa/fLhj1qUfA8r0GXYO7m5
         jRbcQ3AvyZvTPYC9E7l8YswX1QS1qNyfO8hc/e/rHHN2p9Yl/o7aTmfG24x3wIBiOrNp
         ec0EA1mvO7DcXXy7XeVyeVB8X5GFf683QmtzQgQ71jJLqfVJ0bc60F1ppXD39aMTSrQs
         Qy+tFynEGY9nGewEa6MHilJCzgvG/Ts3/nWoOndDxAge+b6FXo+8qLIJ/DO0E7trFlk4
         ZQQ5u/tUn44BuDN8tWxlPIfDWvoyDLGYFAbtKAkZqHR6y/oAJJXVYs0UY+dETK4MXeg1
         BH2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeB1DVu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbeB1DVt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:21:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9592168D
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
Subject: [PATCH v4 04/19] selftests: ftrace: Add a testcase for probepoint
Date: Wed, 28 Feb 2018 12:21:25 +0900
Message-Id: <151978808571.2577.15710045326082964965.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593613337632950186?=
X-GMAIL-MSGID: =?utf-8?q?1593613337632950186?=
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

