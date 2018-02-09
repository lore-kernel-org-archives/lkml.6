Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeBIUEG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752573AbeBIUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:04:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C368217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180209200359.492417940@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 09 Feb 2018 15:03:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 3/6] selftests/ftrace: Have reset_ftrace_filter handle modules
References: <20180209200304.703130163@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-selftests-ftrace-Have-reset_ftrace_filter-handle-mod.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a function probe in set_ftrace_filter belongs to a module, it will
contain the module name. Like:

 wmi_query_block [wmi]:traceoff:unlimited

But writing:

 '!wmi_query_block [wmi]:traceoff' > set_ftrace_filter

will cause an error. We still need to write:

 '!wmi_query_block:traceoff' > set_ftrace_filter

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index f2019b37370d..e7c4c7b752a2 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -37,17 +37,18 @@ reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
 	if [ "$tr" = "" ]; then
 	    continue
 	fi
+	name=`echo $t | cut -d: -f1 | cut -d' ' -f1`
 	if [ $tr = "enable_event" -o $tr = "disable_event" ]; then
-	    tr=`echo $t | cut -d: -f1-4`
+	    tr=`echo $t | cut -d: -f2-4`
 	    limit=`echo $t | cut -d: -f5`
 	else
-	    tr=`echo $t | cut -d: -f1-2`
+	    tr=`echo $t | cut -d: -f2`
 	    limit=`echo $t | cut -d: -f3`
 	fi
 	if [ "$limit" != "unlimited" ]; then
 	    tr="$tr:$limit"
 	fi
-	echo "!$tr" > set_ftrace_filter
+	echo "!$name:$tr" > set_ftrace_filter
     done
 }
 
-- 
2.15.1
