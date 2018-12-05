Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEA9C65BB3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A2320645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A2320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeLEXsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbeLEXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0240E223C7;
        Wed,  5 Dec 2018 23:48:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu9-0000Mx-1N; Wed, 05 Dec 2018 18:48:33 -0500
Message-Id: <20181205234832.933452563@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 30/30] selftests/ftrace: Add testcases for dynamic event
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add common testcases for dynamic_events interface.
 - Add/remove kprobe events via dynamic_events
 - Add/remove synthetic events via dynamic_events
 - Selective clear events (clear events other interfaces)
 - Genelic clear events ("!LINE" syntax)

Link: http://lkml.kernel.org/r/154140872590.17322.10394440849261743052.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../test.d/dynevent/add_remove_kprobe.tc      | 30 +++++++++++
 .../test.d/dynevent/add_remove_synth.tc       | 27 ++++++++++
 .../test.d/dynevent/clear_select_events.tc    | 50 +++++++++++++++++++
 .../test.d/dynevent/generic_clear_event.tc    | 49 ++++++++++++++++++
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
-- 
2.19.1


