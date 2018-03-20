Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeCTGa7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:30:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeCTGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:30:56 -0400
Date: Mon, 19 Mar 2018 23:30:47 -0700
From: tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-10f354a36f9a9aa1b8bffe0abc1cd43822a85bcd@git.kernel.org>
Cc: acme@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        sandipan@linux.vnet.ibm.com, jolsa@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, acme@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sandipan@linux.vnet.ibm.com, jolsa@kernel.org, mingo@kernel.org
In-Reply-To: <20180312124450.30371-1-sandipan@linux.vnet.ibm.com>
References: <20180312124450.30371-1-sandipan@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Fix exit code for
 record+probe_libc_inet_pton.sh
Git-Commit-ID: 10f354a36f9a9aa1b8bffe0abc1cd43822a85bcd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  10f354a36f9a9aa1b8bffe0abc1cd43822a85bcd
Gitweb:     https://git.kernel.org/tip/10f354a36f9a9aa1b8bffe0abc1cd43822a85bcd
Author:     Sandipan Das <sandipan@linux.vnet.ibm.com>
AuthorDate: Mon, 12 Mar 2018 18:14:50 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:56:31 -0300

perf test: Fix exit code for record+probe_libc_inet_pton.sh

This fixes record+probe_libc_inet_pton.sh from always exiting with code
0 and making the test pass even if the perf script output does not match
the expected pattern.

The issue can be observed if this test is run with the verbose flags as
shown below:

  60: probe libc's inet_pton & backtrace it with ping       :
  ...
  ping 19602 [006] 16988.413767: probe_libc:inet_pton: (7fff9a2c42e8)
  1842e8 __GI___inet_pton (/usr/lib64/libc-2.26.so)
  130db4 getaddrinfo (/usr/lib64/libc-2.26.so)

  FAIL: expected backtrace entry 3 ".*\(.*/bin/ping.*\)$" got ""
  test child finished with 0
  ...
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
Link: http://lkml.kernel.org/r/20180312124450.30371-1-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 52c3ee701a89..1ecc1f0ff84a 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -47,7 +47,10 @@ trace_libc_inet_pton_backtrace() {
 		[ -z "${expected[$idx]}" ] && break
 	done
 
-	rm -f $file
+	# If any statements are executed from this point onwards,
+	# the exit code of the last among these will be reflected
+	# in err below. If the exit code is 0, the test will pass
+	# even if the perf script output does not match.
 }
 
 # Check for IPv6 interface existence
