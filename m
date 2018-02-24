Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224NxGqgw+2l0TTZQPRaBK5fz78w1fAIqOvN3QQT11f+HOAvZzW6idniK9NpRkB5xT+FxVnk
ARC-Seal: i=1; a=rsa-sha256; t=1519450229; cv=none;
        d=google.com; s=arc-20160816;
        b=sKarSJ99upzWNq/HkKyvHJeb5pwMDlkAksRi+p7MazGGqFwuHQMBPqaXxT3+iFQLcB
         pPlmZHpBNCodBDMHS0Kyj6PTZjJksMH7nOltxtojY8JGzbu5KGYm4Lr/h4RGm47pDK8n
         zVmYfN7/uIIIMaSovf0D4CSe3DLTLqmxSVx7lRoLsnTZcQIpT34J8SC+W3qjDW+LAFzO
         nok4SwcEsFQ7LDLQ28O+3VhrWhtspv2+aQZnW4y+JjMMayQKvK8EpUQ7Wyv9n32/NzoU
         yN2mZm8XR8htBHT7ojkVm7L2/jl1oarOha+syhQln85y8fkMZJoEBHLe/KZrNnG+OTIA
         MDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ROLfIujIxGgXBYkZ9XBsMoCYyAz6jbwvTxn4Cz5wcCc=;
        b=q0zPmJS9TCCE+TQzNp1wE6gPNXoSVMtKeLLaHTp6Y1ave3IOKbhSlaBFh5ecUNmBsy
         c6mFdFe/yEhDvYxLoUDGImMhOu6uP21EkXA2SpnTZbNHXx6ufbMc58ISPM2vfZXvSFh9
         GzpL9pRMxER+TiOA1H/JEDyyVgoZj8ucUidEjAc/wXj77ibL1M+/zyC6kavhJ6aOVPB+
         JCjfnr1hrNPF2n2Et4eKKiAuXsrLV5FV1FVwFKHIa+P7irvJzaLEZ97Xw+AckPzUqd+F
         NYr0ebCelUZzTsfE10kstDu9/ua4HC/lreUpArDEMzl6JB4HnkuWr2Tobgq3Q3iqSlSS
         Ww4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeBXFaQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbeBXFaP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:30:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DE221741
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
Subject: [PATCH v3 03/18] selftests: ftrace: Add a testcase for string type with kprobe_event
Date: Sat, 24 Feb 2018 14:29:50 +0900
Message-Id: <151945019057.27508.10241383074659805761.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593259043297539172?=
X-GMAIL-MSGID: =?utf-8?q?1593259043297539172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for string type with kprobe event.
This tests good/bad syntax combinations and also
the traced data is correct in several way.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
new file mode 100644
index 000000000000..5ba73035e1d9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event string type argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+echo 0 > events/enable
+echo > kprobe_events
+
+case `uname -m` in
+x86_64)
+  ARG2=%si
+  OFFS=8
+;;
+i[3456]86)
+  ARG2=%cx
+  OFFS=4
+;;
+aarch64)
+  ARG2=%x1
+  OFFS=8
+;;
+arm*)
+  ARG2=%r1
+  OFFS=4
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
+esac
+
+: "Test get argument (1)"
+echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=\"test\""
+
+echo 0 > events/kprobes/testprobe/enable
+: "Test get argument (2)"
+echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string arg2=+0(+${OFFS}(${ARG2})):string" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test1 test2 >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=\"test1\" arg2=\"test2\""
+
+echo 0 > events/enable
+echo > kprobe_events

