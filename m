Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224EoUCm8a/iuGCBDbL5G42VfFYVYUeNOdY9Xgp/OUv59ggZ/GsED7y9IjSzieEYZevVfYL3
ARC-Seal: i=1; a=rsa-sha256; t=1519788090; cv=none;
        d=google.com; s=arc-20160816;
        b=UZeGsUxpzU8E67ZP8lknQjccvkGMtXoMkneJq9ddwEfMh3opnYeRvdSJTKkGt9fjuS
         wiDah+NXYgvndmp/jX7ytQXRtHAbV4JC879ziHEr9cersJ2b6aZMvdkI5NuNbpX1UBw4
         Uk0CewakYb6VMo5Y7ITs4qHVuJ4jF99f0cC1hzYiulOI3wfG9f1PxCMtJ/HX+0aeJ9QV
         BATtNrZgoMNyb/O/73Hnt1baxFQ65LWY2a9yhydZYx2O5h6gkBDmJGEachhQMdhlbpwv
         pqXJX+laqKBoL1qfZ49q4q14LFHZISsQoga+xlC00THxdUv1YQMLJaQ2Ykvkb3xOacV1
         ZkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=ROLfIujIxGgXBYkZ9XBsMoCYyAz6jbwvTxn4Cz5wcCc=;
        b=M7M0BaZjgc5bQIEW2C6CpL0kVrB6oS9rAMTdzlwJyIw9OdfyaPl2JRgb3zjb+a+hNG
         NWRVko8CjohUVtiWe/PIVXeOaDbeMZoqnMrL7xcgN13Vz3eN6jzC2Z++6RGP3cbnu72U
         T6SPSBWDmo6IMDVFenjzEWvXxA5pC4LXDHkawC7hqfB12SyDMTl6r2A3EuvkF9YmLcDW
         KCAdQE1UoDmQZEqhtnCgKiubRxIfS7WeoVAoSMl5ZyY+J0mMV9ZZTD4Xuc0aGoUR4KTN
         6WolcxsLxTV/H+teRRSVhfI4Ld4WD9OY0E6JYLLq+k7crNb/2Q81d8Rot5Ko8ruA9RGm
         Fouw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeB1DVW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbeB1DVU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:21:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C956A2168D
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
Subject: [PATCH v4 03/19] selftests: ftrace: Add a testcase for string type with kprobe_event
Date: Wed, 28 Feb 2018 12:20:56 +0900
Message-Id: <151978805672.2577.11785959630908181780.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593613316230478477?=
X-GMAIL-MSGID: =?utf-8?q?1593613316230478477?=
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

