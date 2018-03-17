Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuxfGdn2DlEkEmYq2ixAcLy73CKmIPZfrdDuC1JfsclV/nW/NApLUI1ZohggNyPhghYOjKC
ARC-Seal: i=1; a=rsa-sha256; t=1521290431; cv=none;
        d=google.com; s=arc-20160816;
        b=E7Ou7OU0SZYMvRcwEHCnToRopF+rBfgyTZL3uEYQ/Fqz4YxXJNLi5gs9eTNrZCkK4t
         ewWG6edWWDrcZD32e7ZmU9F2hfi3pAXUJXljkKRGOSuR46381DPqKzEseZ0S9nGP5NlZ
         XVFMlIOymsmIF/DcQE+wCyp6OHAlXzFohJpxNogPHoNYsi5w6WfECqL4O8XgiAMbUE+N
         IaZ0esb5H6mpz3ee9kulm719ljs6auth9bO4pCMvAICULfo+1zVVMHjlBCTQPi8sxjFg
         XFXDM223aDq1S4XE/gmsyRD0B0gmk4X5TeQz7GCxe4hixvIgYCyTnC1wchMYW6WwZrY6
         cUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ROLfIujIxGgXBYkZ9XBsMoCYyAz6jbwvTxn4Cz5wcCc=;
        b=AXCEwW8vvzHrLcItLa+UW8RSlMJVuRbGOdmJPeU0L2qq8dZ5qxouhvXMhDdaDXZX1b
         19qIKia9HtoOLN2RC3YWwXol44d9e4IiazxKGPKlTfos/xirGqYLvmyYXb9bsDBZSFNq
         29JF5HZ6y6mPYIQpMgWZb4vlVZrS7dfq7yl4LuRYVE0EYTVFzVauvopXdWSS6mPW/hoO
         6Pb1vft8uDchlDX4c6B42tW+R0rBTEcpmLWYxAa2B/LuDS7RAxkd4y30LgWnb3o1fmck
         1hEYN1+qtMh/GOWTE4PROICEO7RQyKqF31apAMegUwgEB5KGWne/v9DL1aaEdzeqMgOk
         IilQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeCQMka (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752170AbeCQMka (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:40:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E907721737
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
Subject: [PATCH v6 03/21] selftests: ftrace: Add a testcase for string type with kprobe_event
Date: Sat, 17 Mar 2018 21:39:44 +0900
Message-Id: <152129038381.31874.9201387794548737554.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1595188635413689789?=
X-GMAIL-MSGID: =?utf-8?q?1595188635413689789?=
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

