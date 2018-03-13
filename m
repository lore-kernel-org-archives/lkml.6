Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933522AbeCMMH1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933473AbeCMMHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:07:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7DF217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/31] perf test: Fix exit code for record+probe_libc_inet_pton.sh
Date: Tue, 13 Mar 2018 09:05:08 -0300
Message-Id: <20180313120508.29327-32-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

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
-- 
2.14.3
