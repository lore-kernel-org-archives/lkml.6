Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELt18h1Q8kbKegjOXun5J4S8i8+NdSw/k6jFvMDpIZdR4ZcdANCiGyphAN9af1S/r0Fu6Fpf
ARC-Seal: i=1; a=rsa-sha256; t=1519788530; cv=none;
        d=google.com; s=arc-20160816;
        b=Iinfmsx6YBcCzMQwvKWOw3D+EVo52dqTWihU/ygVaRvEbZ/65XfBeUST8kZ73VcoMq
         oVn6GXGobTml7sooQjNyVitcmJZHm39qFvNZrpqEPUrugqMC29G2fw5xKuPkbKYGgJyG
         LakunoHn613YNHG9gTMnCxwrbqzAjClGyYe46FyKgLh6oOQfTylP/0S7kB2m0J7Tg9tS
         QL7zuMsB9bQrvUTSRO6bzg6hEgGAKrGse4uLjO9xo9MZrMjb2mCQjnmhDl+A4/s+p73p
         NhTE0/Srku6PfgWB2l8T02Ltq+qRnVHBDsa9/zie+jmTXD1u+w5wTbvcOR3N+D9KTcHb
         Zgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ChLbg8iG0YLaBNjceKjhUkfd0VLfLHL0T71unVjO9Bs=;
        b=NUQm1I1Qhs59Vc2coxXoIcBpWsHyzUqIveUPT5151ci8uIAVwi+pO6IwJaqBqeIFbX
         fezGDwRD3KT8x+rjz2iiykXci/5ZaKwWzm2IdK0ivQSXZBrSRjm9XtBhUQhQRkmYIh/v
         lHgMzMFcGYPCE90NHo80hV57A4NqRzqQKU8WaPd4o16izVX4DtRzrFfFGudEGa2nxrHa
         isuLF9EpTTCifPwPfJOttSmWyaaSBWaJHuaI7uowOBzk+WoljD9pvC1wZzwLJISTpUZO
         P9P9EEWnrJpoOOiLLFqfDG/vAgxPt9iXL5/s1wO/6MDTqzESL3Zd9l6OHwfwsH2EnEzu
         3o2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeB1D2g (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:28:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbeB1D2f (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:28:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299DE2133D
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
Subject: [PATCH v4 18/19] selftests: ftrace: Add a testcase for $argN with kprobe_event
Date: Wed, 28 Feb 2018 12:28:11 +0900
Message-Id: <151978849122.2577.13948527724464684401.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593613778351976623?=
X-GMAIL-MSGID: =?utf-8?q?1593613778351976623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for array type with kprobe event.
This tests whether the traced data is correct or not.
If the kernel doesn't support array type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
new file mode 100644
index 000000000000..d5c5c8c3a51e
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event argN argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -q "arg<N>" README || exit_unsupported # version issue
+
+echo 0 > events/enable
+echo > kprobe_events
+
+: "Test bad pattern : arg0 is not allowed"
+! echo 'p:testprobe create_trace_kprobe $arg0' > kprobe_events
+
+: "Test get argument"
+echo 'p:testprobe create_trace_kprobe $arg1' > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=0x1"
+
+! echo test test test >> kprobe_events
+tail -n 1 trace | grep -qe "testprobe.* arg1=0x3"
+
+echo 0 > events/enable
+echo > kprobe_events

