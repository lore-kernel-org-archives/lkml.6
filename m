Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7E220862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSRurRT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7E220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeKESYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKESYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:24:30 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DAC2082A;
        Mon,  5 Nov 2018 09:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408748;
        bh=XpbGP9ViM6N7OK2gsh4iwTfOv63fljxpFhi8PNSaTKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSRurRT7UkIDUl6LGDev4nVP8gdX815HkdHEQ0neRov4Q8paBX9Dq4bTlDZfEA1Mi
         G/9Wfelte2ZNc0i/ztsTj1E/bGhd3AOZeTW4zObfgEYjBNRwwpYwnKGXOcejbKYPvc
         4IBCAoQYi7y9RVhAsG8gMaqRLXciOVOXZV1TGoEY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 12/12] selftests/ftrace: Add testcases for dynamic event
Date:   Mon,  5 Nov 2018 18:05:26 +0900
Message-Id: <154140872590.17322.10394440849261743052.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154140838606.17322.15294184388075458777.stgit@devbox>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common testcases for dynamic_events interface.
 - Add/remove kprobe events via dynamic_events
 - Add/remove synthetic events via dynamic_events
 - Selective clear events (clear events other interfaces)
 - Genelic clear events ("!LINE" syntax)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |   30 ++++++++++++
 .../ftrace/test.d/dynevent/add_remove_synth.tc     |   27 +++++++++++
 .../ftrace/test.d/dynevent/clear_select_events.tc  |   50 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |   49 ++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
new file mode 100644
index 000000000000..c6d8387dbbb8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove kprobe events
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
+grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=_do_fork
+
+echo "p:myevent1 $PLACE" >> dynamic_events
+echo "r:myevent2 $PLACE" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/kprobes/myevent1
+test -d events/kprobes/myevent2
+
+echo "-:myevent2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
new file mode 100644
index 000000000000..62b77b5941d0
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove synthetic events
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "s:\[synthetic/\]" README || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+echo "s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+echo "s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+test -d events/synthetic/latency1
+test -d events/synthetic/latency2
+
+echo "-:synthetic/latency2" >> dynamic_events
+
+grep -q latency1 dynamic_events
+! grep -q latency2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
new file mode 100644
index 000000000000..e0842109cb57
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - selective clear (compatibility)
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
+grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+
+grep -q "s:\[synthetic/\]" README || exit_unsupported
+
+[ -f synthetic_events ] || exit_unsupported
+[ -f kprobe_events ] || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=_do_fork
+
+setup_events() {
+echo "p:myevent1 $PLACE" >> dynamic_events
+echo "s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+echo "r:myevent2 $PLACE" >> dynamic_events
+echo "s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+}
+
+setup_events
+echo > synthetic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+! grep -q latency1 dynamic_events
+! grep -q latency2 dynamic_events
+
+echo > dynamic_events
+
+setup_events
+echo > kprobe_events
+
+! grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+
+echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
new file mode 100644
index 000000000000..901922e97878
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
@@ -0,0 +1,49 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - generic clear event
+
+[ -f dynamic_events ] || exit_unsupported
+
+grep -q "place: \[<module>:\]<symbol>" README || exit_unsupported
+grep -q "place (kretprobe): \[<module>:\]<symbol>" README || exit_unsupported
+
+grep -q "s:\[synthetic/\]" README || exit_unsupported
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=_do_fork
+
+setup_events() {
+echo "p:myevent1 $PLACE" >> dynamic_events
+echo "s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+echo "r:myevent2 $PLACE" >> dynamic_events
+echo "s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+}
+
+setup_events
+
+echo "!p:myevent1 $PLACE" >> dynamic_events
+! grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+
+echo "!s:latency1 u64 lat; pid_t pid;" >> dynamic_events
+grep -q myevent2 dynamic_events
+! grep -q latency1 dynamic_events
+grep -q latency2 dynamic_events
+
+echo "!r:myevent2 $PLACE" >> dynamic_events
+! grep -q myevent2 dynamic_events
+grep -q latency2 dynamic_events
+
+echo "!s:latency2 u64 lat; pid_t pid;" >> dynamic_events
+! grep -q latency2 dynamic_events
+
+echo > dynamic_events

