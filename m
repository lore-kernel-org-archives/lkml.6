Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvrgcoZD86F0SbW3yPJG5pMXwjaust/O5woh63kzYwJyNSskiittqxsAxjDYeTUkX6UMpFB
ARC-Seal: i=1; a=rsa-sha256; t=1520499165; cv=none;
        d=google.com; s=arc-20160816;
        b=hAZNHCcUOMKAzjuXr8+lNXiqJOEEmnmCL1ffNsJ8KS0FAToHYspX1E+GtDZDMVtV9Y
         ZkI6HOCg4aXChnGgZfz7xk2CJUid3RM1ZMYXwUcWNNPEYxARt4u5UNFwVHJOl2MlcTUz
         0Pxy64XKQ33ExHVso+OJKHQxNo5YQfu1ytvv7gVzLQF/5Ise38I7i6EbTTe96iiTjRRK
         JbzcuLZ2acxl1HcZ9EFoSl2QcQBfmAQNToabRmZKRTPv23rwXGtiRGIZB6XXTfLVUqwZ
         R/WeOB/yLPmZami43Y4cMtuw5OGccbo8mrzpneuilFor0QZROP5peeOpzCe0GDMGE3Ym
         r7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=DalFNfqyUNMZvr1wDP6/QRmFOU4lKwB2alolEgDBA2w=;
        b=vuD2nF+U+e4Am7F73R/heo8vIr1uEXiyrloUfSoFPkNS4RYl+uVY3/Ylv+9LEKE5in
         h8cuEH35UH/BUc/nQKxalerv7jPWVBfLQqMZVw0ki5p8GjuKdboedwrtK4J5lsGBLR9y
         fI/IQrhyKp0ZD1ZhsYAn4PpVL6NW+N3UEhTwIZgOrMJpEdauF2Oau/6PjTxugKxSA3NV
         jDPpJwrwM2z1p67TfoPzYc1hHjNPfyt8yGMXBhPdKEZuA0E6m23Qu8x74IKVp446j3XQ
         FXxHOuLNNXND4Ikugo6UrJ7/oirb5kQ/sgvha5zhzzpgMb7JQq4XVGenu4AUvW4/+BiR
         Dmxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935648AbeCHIwP (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:52:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935643AbeCHIwN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:52:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BF42133D
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
Subject: [PATCH v5 18/19] selftests: ftrace: Add a testcase for $argN with kprobe_event
Date: Thu,  8 Mar 2018 17:51:49 +0900
Message-Id: <152049910927.7289.5675699018820188003.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1594358932355013585?=
X-GMAIL-MSGID: =?utf-8?q?1594358932355013585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for $argN with kprobe event.
This tests whether the traced data is correct or not.
If the kernel doesn't support $argN (depends on arch),
it skips the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
  - Fix description.
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

