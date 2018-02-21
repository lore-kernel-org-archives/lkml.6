Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227Sch0tBQFP0hQC2GEBoxmMp4UMXw8njtlR/3HZ3e0ZDJKvBJ/fgUvXsTDi9vus23tM/bjZ
ARC-Seal: i=1; a=rsa-sha256; t=1519224966; cv=none;
        d=google.com; s=arc-20160816;
        b=JRf2M1ZZQ4/E0nUykhmktVZfQwxPQrJPFs7BReiPQ05TjZKyQWehKgvux1dfLAqjG6
         BkF0wF+l9f9mnFRX7P5VmIzcxCEqoY83R8vff+Oe3WwtOE6tcKNR6A7GepitrzHioGVi
         QGmL3pWWVue5vqWsZ2wSXoH4bZKABOPTgmwb6X4nDNDXi/Mylfu+ZvRIE76canK6fJaY
         HSU/eaXuib+ZqHO9+zXZ4z0E1yRPmtNa409gi4ogSwlm8ZcfgvL6EqTdSjer0eQc/qrD
         B6mk5IMzwAgPykYlwVMouxVc8geg+YbIvOflcrccoGK72r5O9hlboH7lF9TfLUl+QbUA
         0KPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ROLfIujIxGgXBYkZ9XBsMoCYyAz6jbwvTxn4Cz5wcCc=;
        b=Gpi4hC2YxV/eEvgE038fJQ71EcQzLbOwOWKGqEV9ZToq7rzuyMquH+rIoLrxtE8jyA
         tQwuYgX2rwbzBNDcaE3kskFsA7en2yWoPAMckIE/iEqjVk1hk0LooaKlhFp3BAWd2JN8
         3G9TNKA+DlIIHWj5qLmXySAT0+/Y4z6QNR0/e6yJtK1GHk9MfDUz4yegDRJtS75YVaC/
         T9XFQDyWWT58Wycg2UnTAHAlvO5CQPVzIPibGGMCOK7jrq1c0P6Hp3xGgTiqcw6Ti0D+
         tYYpdchj5YxtVmATsPqmk6fk/M4vYqJLInrXUHI9cy2LYRiuAQQ7Rs2wbl5z4X3UiGjr
         fMfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937392AbeBUO4G (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936893AbeBUO4E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:56:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770B1205F4
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
Subject: [PATCH v2 03/17] selftests: ftrace: Add a testcase for string type with kprobe_event
Date: Wed, 21 Feb 2018 23:55:40 +0900
Message-Id: <151922494028.6217.2260900936608276328.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593022838638842956?=
X-GMAIL-MSGID: =?utf-8?q?1593022838638842956?=
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

