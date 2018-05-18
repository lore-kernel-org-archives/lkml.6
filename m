Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeERHY2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:24:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751320AbeERHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:24:26 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, tmricht@linux.ibm.com
Subject: [PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh
Date: Fri, 18 May 2018 12:54:17 +0530
X-Mailer: git-send-email 2.13.6
X-TM-AS-GCONF: 00
x-cbid: 18051807-0008-0000-0000-000004F7CDB6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051807-0009-0000-0000-00001E8C47A6
Message-Id: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180081
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test currently fails because the regular expressions for
matching the output of perf script do not consider the symbol
offsets to be part of the output.

The symbol offsets are seen because of the default behaviour
introduced by commit 4140d2ea74b3 ("perf script: Show symbol
offsets by default").

Before applying this patch:

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 30389
  ping 30406 [002] 307144.280983: probe_libc:inet_pton: (7f4117adf220)
  7f4117adf220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)
  FAIL: expected backtrace entry 1 ".*inet_pton[[:space:]]\(/usr/lib64/libc-2.25.so|inlined\)$" got "7f4117adf220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

After applying this patch:

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 30539
  ping 30556 [003] 307254.313217: probe_libc:inet_pton: (7fe19ab10220)
  7fe19ab10220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)
  7fe19aad5ebd getaddrinfo+0x11d (/usr/lib64/libc-2.25.so)
  56351e3c1c71 main+0x891 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index ee86473643be..650b208f700f 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -16,18 +16,18 @@ nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton[[:space:]]\($libc|inlined\)$"
+	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
-		expected[3]="(__GI_)?getaddrinfo[[:space:]]\($libc|inlined\)$"
-		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	*)
 		eventattr='max-stack=3'
-		expected[2]="getaddrinfo[[:space:]]\($libc\)$"
-		expected[3]=".*\(.*/bin/ping.*\)$"
+		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
+		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	esac
 
-- 
2.13.6
