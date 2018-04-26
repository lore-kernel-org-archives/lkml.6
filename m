Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932293AbeDZRcj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756804AbeDZRcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:32:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA6A21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180426173202.268314519@goodmis.org>
User-Agent: quilt/0.63-1
Date: Thu, 26 Apr 2018 13:30:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5/7] selftests: ftrace: Fix trigger extended error testcase
References: <20180426173039.426131207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-selftests-ftrace-Fix-trigger-extended-error-testcase.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Previous testcase redirects echo-out into /dev/null
using "&>" as below

echo "trigger-command" >> trigger &> /dev/null

But this means redirecting both stdout and stderr into
/dev/null because it is same as below

echo "trigger-command" >> trigger > /dev/null 2>&1

So ">> trigger" redirects stdout to trigger file, but
next "> /dev/null" redirects stdout to /dev/null again
and the last "2>/&1" redirects stderr to stdout (/dev/null)

This fixes it by "2> /dev/null". And also, since it
must fail, add "!" to echo command.

Link: http://lkml.kernel.org/r/152292052250.15769.12565292689264162435.stgit@devbox

Fixes: f06eec4d0f2c ("selftests: ftrace: Add inter-event hist triggers testcases")
Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
index 786dce7e48be..2aabab363cfb 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
@@ -29,7 +29,7 @@ do_reset
 
 echo "Test extended error support"
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
-echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger &>/dev/null
+! echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger 2> /dev/null
 if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
     fail "Failed to generate extended error in histogram"
 fi
-- 
2.16.3
