Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeBFWpq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753314AbeBFWpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:45:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A342179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180206224541.521694128@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 06 Feb 2018 17:43:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: [RFC][PATCH 4/6] selftests/ftrace: Have reset_ftrace_filter handle multiple instances
References: <20180206224338.446477232@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-selftests-ftrace-Have-reset_ftrace_filter-handle-mul.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a probe is attached to a static function that is in multiple files with
the same name, removing it by name will remove all instances:

 # grep jump_label_unlock set_ftrace_filter
jump_label_unlock:traceoff:unlimited
jump_label_unlock:traceoff:unlimited

 # echo '!jump_label_unlock:traceoff' >> set_ftrace_filter
 # grep jump_label_unlock set_ftrace_filter
 #

But the loop in reset_ftrace_filter will try to remove multiple instances
multiple times. If this happens the second time will error and cause the
test to fail.

At each iteration of the loop, check to see if the probe being removed still
exists.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index e7c4c7b752a2..df3dd7fe5f9b 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -37,6 +37,9 @@ reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
 	if [ "$tr" = "" ]; then
 	    continue
 	fi
+	if ! grep -q "$t" set_ftrace_filter; then
+		continue;
+	fi
 	name=`echo $t | cut -d: -f1 | cut -d' ' -f1`
 	if [ $tr = "enable_event" -o $tr = "disable_event" ]; then
 	    tr=`echo $t | cut -d: -f2-4`
-- 
2.15.1
