Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeBIUFN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752593AbeBIUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:04:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E40217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180209200359.919107191@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 09 Feb 2018 15:03:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 6/6] selftests/ftrace: Add more tests for removing of function probes
References: <20180209200304.703130163@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0006-selftests-ftrace-Add-more-tests-for-removing-of-func.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Al Viro discovered a bug in the removing of function probes where if it had
a '*' at the beginning, it would fail to find any matches. That is, because
it reset the glob search string to the the initial string with a "MATCH_END"
type, instead of skipping the wildcard "*" it included it, where it would
not match any functions because "*" was being treated as a normal character
and not a wildcard one.

Link: http://lkml.kernel.org/r/20180127031706.GE13338@ZenIV.linux.org.uk

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 0f3f92622e33..68e7a48f5828 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -128,6 +128,43 @@ if check_set_ftrace_filter "$FUNC1" "$FUNC2" ; then
     fail "Expected $FUNC1 and $FUNC2"
 fi
 
+test_actual() { # Compares $TMPDIR/expected with set_ftrace_filter
+    cat set_ftrace_filter | grep -v '#' | cut -d' ' -f1 | cut -d':' -f1 | sort -u > $TMPDIR/actual
+    DIFF=`diff $TMPDIR/actual $TMPDIR/expected`
+    test -z "$DIFF"
+}
+
+# Set traceoff trigger for all fuctions with "lock" in their name
+cat available_filter_functions | cut -d' ' -f1 |  grep 'lock' | sort -u > $TMPDIR/expected
+echo '*lock*:traceoff' > set_ftrace_filter
+test_actual
+
+# now remove all with 'try' in it, and end with lock
+grep -v 'try.*lock$' $TMPDIR/expected > $TMPDIR/expected2
+mv $TMPDIR/expected2 $TMPDIR/expected
+echo '!*try*lock:traceoff' >> set_ftrace_filter
+test_actual
+
+# remove all that start with "m" and end with "lock"
+grep -v '^m.*lock$' $TMPDIR/expected > $TMPDIR/expected2
+mv $TMPDIR/expected2 $TMPDIR/expected
+echo '!m*lock:traceoff' >> set_ftrace_filter
+test_actual
+
+# remove all that start with "c" and have "unlock"
+grep -v '^c.*unlock' $TMPDIR/expected > $TMPDIR/expected2
+mv $TMPDIR/expected2 $TMPDIR/expected
+echo '!c*unlock*:traceoff' >> set_ftrace_filter
+test_actual
+
+# clear all the rest
+> $TMPDIR/expected
+echo '!*:traceoff' >> set_ftrace_filter
+test_actual
+
+rm $TMPDIR/expected
+rm $TMPDIR/actual
+
 do_reset
 
 exit 0
-- 
2.15.1
