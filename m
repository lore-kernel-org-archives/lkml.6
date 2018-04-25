Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZrhJb30e81CQHSpNf1kXCh58WIOPf0sLPWcTOKBWlcOxHWJRUv2H3if7cnnGPzJLdWCow9U
ARC-Seal: i=1; a=rsa-sha256; t=1524658970; cv=none;
        d=google.com; s=arc-20160816;
        b=CgsPyUD/JH7lM3EA4vO5oCQeVD2gZjobDyhoxWEfytoJB7ixyBb7Y7FveNwpbyjDgm
         PVT/kJBLnqehMWg41UfFaaDMEujUDogn1u1CFsmtDIuZVkDjmpY/Pkt2YxRameo4Ek/v
         A5Yn6OqTvZgTi3+QzQUrXkqU3+tSLxAu9mhzWDN85auBkGI3Lkl7c4dg73t31Aem2cRM
         q+RHhzEacvmHCj9YEVZxo1yKFpQBPDu6GghE/BkY+8fXqOnDGONhGH99E7ij9tR2JzTd
         2braRk6a7F5/bsbkAnAYl3xwoAhkb7JrjYc3aVZ0D4xfmyzRraJDsE9KnMB+I/LXCQqp
         Zxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=R/dyTmRnW8g5+R8eJUQju+kwfMcUMcRJrj3q5UyXUrg=;
        b=ZITHJCRyaG3jMzpxV77tZdkTuKGVNTMnVj0hGJJOZrFo/gPmNz63dzkSX4w3Y5Zi3q
         sfCXNJyRxL7Wgwnd+iUud26HDPFnzskal3kwf7VaIf7evcFYoIPzDuFZu5C7Gnc/5T54
         Q8u51tnu7soi2fsZawOBVfl51o96bbJA1NGnhygIC1FJm4yFmVhSO6rqfpC8S8Fwafr5
         m+bqPwSsbJ9RquSdD0EXFtoJb8VU1XheTC9kauqUsyPBucQiUQojyAJSg6O2bO+3bq6C
         XJh4M02fN9DddRBxANQ1QsJwVJFOrgTkz0XZ4XBLI65+lnG6HiKVO9kpxYA1/KmsNvOK
         vKnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeDYMWt (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbeDYMWs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:22:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9595021748
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
Subject: [PATCH v7 13/16] selftests: ftrace: Add a testcase for symbol type
Date: Wed, 25 Apr 2018 21:22:24 +0900
Message-Id: <152465894448.26224.1696382157544475060.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720804376247512?=
X-GMAIL-MSGID: =?utf-8?q?1598720804376247512?=
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

