Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225nudlQMyNeEq4UV1R7zItok13fI0XyF9ccKVvzxaHtXXZXlOarm3dbEpchaSYZdY+2Vz1r
ARC-Seal: i=1; a=rsa-sha256; t=1519788501; cv=none;
        d=google.com; s=arc-20160816;
        b=YAmayFNpIH8OgzThvs8xSk5VNhxtEOLZ08dkkYq/+ZotESxMaVlVZYb8BqSJUJPpmz
         jzu27KDwogqYJOoTECr3tZlUrn0K2aVl5PjDQFepwwMXXmH5QXkMm5AN18Gap/xjKPB0
         MU3S2Mqdt/oSD4uW1U7zM/+Z/IPCL0tWgoCI80zrRp4Wv+roUBZrtFBsCLxzpSVwM4na
         3ihS6Zz2noKWT7NdyTqrrN+HIsT/MTCyE+ZoM1psJ77+2aoQMCzt3CUWazwJLQKJXxzO
         Irp9t1F7f5JGrKJmXpU+ajXI8eEBsCvpX3cc7SHgzPmStfJ5KSUFRwtHSzendQyHSgr2
         ki4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=R/dyTmRnW8g5+R8eJUQju+kwfMcUMcRJrj3q5UyXUrg=;
        b=BIOltAo+XQN/WdwP7EsJ/ow56cNUT5pq4d1X3l0Jj96goocJeyVxW4BmCLeIsKuhfL
         wHmqk3P1me7nWVgGf0NwOekA0eMY/T9bgv+bN65+c12s6kBvElp8dIDDWpMF66fffMZI
         Kc4gHK4J0BTj4WN/NZ/vTgqen6zWA6O9exHRsVw2xQSELbQ/aqt/i2qeFJNgg3yseNve
         XWMc+RwfeMPdG71AJCI7lOz4fjtU2v9W3MdUNprenrklNPPK2RW5saZ7MBBFgIHXL1pT
         i48q2ZJyTSckSsIfaQuBsZxfGnHEnu2bEpaxXmcwyhDB12DXWxCaAlfycUncSH+/pUIL
         /mYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeB1D2I (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:28:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbeB1D2G (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:28:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D95D21795
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
Subject: [PATCH v4 17/19] selftests: ftrace: Add a testcase for symbol type
Date: Wed, 28 Feb 2018 12:27:42 +0900
Message-Id: <151978846246.2577.9340621494520438694.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593613747357134068?=
X-GMAIL-MSGID: =?utf-8?q?1593613747357134068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for symbol type with kprobe event.
This tests good/bad syntax combinations and also
the traced data.
If the kernel doesn't support symbol type, it skips
the test as UNSUPPORTED.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Use IP/PC register to test the symbol type
---
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   77 ++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
new file mode 100644
index 000000000000..20a8664a838b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -0,0 +1,77 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event argument symbol type
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -qe "type:.* symbol" README || exit_unsupported # version issue
+
+echo 0 > events/enable
+echo > kprobe_events
+
+PROBEFUNC="vfs_read"
+GOODREG=
+BADREG=
+REG=
+GOODSYM="_sdata"
+if ! grep -qw ${GOODSYM} /proc/kallsyms ; then
+  GOODSYM=$PROBEFUNC
+fi
+
+case `uname -m` in
+x86_64|i[3456]86)
+  GOODREG=%ax
+  BADREG=%ex
+  REG=%ip
+;;
+aarch64)
+  GOODREG=%x0
+  BADREG=%ax
+  REG=%pc
+;;
+arm*)
+  GOODREG=%r0
+  BADREG=%ax
+  REG=%pc
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
+esac
+
+test_goodarg() # Good-args
+{
+  while [ "$1" ]; do
+    echo "p ${PROBEFUNC} $1" > kprobe_events
+    shift 1
+  done;
+}
+
+test_badarg() # Bad-args
+{
+  while [ "$1" ]; do
+    ! echo "p ${PROBEFUNC} $1" > kprobe_events
+    shift 1
+  done;
+}
+
+echo > kprobe_events
+
+: "Symbol type"
+test_goodarg "${GOODREG}:symbol" "@${GOODSYM}:symbol" "@${GOODSYM}+10:symbol" \
+	 "\$stack0:symbol" "+0(\$stack):symbol"
+test_badarg "\$comm:symbol"
+
+: "Retval with symbol type"
+echo "r ${PROBEFUNC} \$retval:symbol" > kprobe_events
+
+echo > kprobe_events
+
+: "Test get symbol"
+echo "p:testprobe create_trace_kprobe ${REG}:symbol" > kprobe_events
+echo 1 > events/kprobes/testprobe/enable
+! echo test >> kprobe_events
+tail -n 1 trace | grep -q "arg1=create_trace_kprobe"
+
+echo 0 > events/enable
+echo > kprobe_events

