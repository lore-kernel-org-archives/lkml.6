Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeCLMo7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:44:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751232AbeCLMo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:44:58 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH] perf test: Fix exit code for record+probe_libc_inet_pton.sh
Date: Mon, 12 Mar 2018 18:14:50 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18031212-0016-0000-0000-000005307073
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031212-0017-0000-0000-0000286D9D98
Message-Id: <20180312124450.30371-1-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes record+probe_libc_inet_pton.sh from always exiting
with code 0 and making the test pass even if the perf script
output does not match the expected pattern.

The issue can be observed if this test is run with the verbose
flags as shown below:

60: probe libc's inet_pton & backtrace it with ping       :
...
ping 19602 [006] 16988.413767: probe_libc:inet_pton: (7fff9a2c42e8)
1842e8 __GI___inet_pton (/usr/lib64/libc-2.26.so)
130db4 getaddrinfo (/usr/lib64/libc-2.26.so)

FAIL: expected backtrace entry 3 ".*\(.*/bin/ping.*\)$" got ""
test child finished with 0
...
probe libc's inet_pton & backtrace it with ping: Ok

Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
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
