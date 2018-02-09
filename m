Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeBIUF0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbeBIUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:04:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE513217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180209200359.775843987@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 09 Feb 2018 15:03:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 5/6] selftests/ftrace: Add some missing glob checks
References: <20180209200304.703130163@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-selftests-ftrace-Add-some-missing-glob-checks.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Al Viro discovered a bug in the glob ftrace filtering code where "*a*b" is
treated the same as "a*b", and functions that would be selected by "*a*b"
but not "a*b" are not selected with "*a*b".

Add tests for patterns "*a*b" and "a*b*" to the glob selftest.

Link: http://lkml.kernel.org/r/20180127170748.GF13338@ZenIV.linux.org.uk

Cc: Shuah Khan <shuah@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 589d52b211b7..27a54a17da65 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -29,6 +29,12 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
 # filter by *, end match
 ftrace_filter_check 'schedule*' '^schedule.*$'
 
+# filter by *mid*end
+ftrace_filter_check '*aw*lock' '.*aw.*lock$'
+
+# filter by start*mid*
+ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
+
 # Advanced full-glob matching feature is recently supported.
 # Skip the tests if we are sure the kernel does not support it.
 if grep -q 'accepts: .* glob-matching-pattern' README ; then
-- 
2.15.1
