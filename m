Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeDRK7T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:59:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753426AbeDRK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:59:16 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        maynard@us.ibm.com
Subject: [PATCH v2 3/3] perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
Date: Wed, 18 Apr 2018 16:29:00 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
References: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041810-0040-0000-0000-0000044EDFD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041810-0041-0000-0000-000020F32DDE
Message-Id: <20180418105900.5899-4-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For powerpc64, this test currently fails due to a mismatch in
the expected output.

Output before applying this patch:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 27723
  ping 27740 [012] 607801.690493: probe_libc:inet_pton: (7fff936caf28)
  15af28 __GI___inet_pton (/usr/lib64/libc-2.26.so)
  10fa54 gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
  FAIL: expected backtrace entry 2 "getaddrinfo[[:space:]]\(/usr/lib64/libc-2.26.so\)$" got "10fa54 gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

Output after applying this patch:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 28782
  ping 28799 [017] 608933.853323: probe_libc:inet_pton: (7fff891baf28)
  15af28 __GI___inet_pton (/usr/lib64/libc-2.26.so)
  10fa54 gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
  1105b4 getaddrinfo (/usr/lib64/libc-2.26.so)
  2d70 _init (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 1ecc1f0ff84a..b45afc59edc6 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -26,6 +26,14 @@ trace_libc_inet_pton_backtrace() {
 		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
 		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
 		;;
+	ppc64)
+		;&
+	ppc64le)
+		eventattr='max-stack=4'
+		expected[2]="gaih_inet.*[[:space:]]\($libc\)$"
+		expected[3]="getaddrinfo[[:space:]]\($libc\)$"
+		expected[4]=".*\(.*/bin/ping.*\)$"
+		;;
 	*)
 		eventattr='max-stack=3'
 		expected[2]="getaddrinfo[[:space:]]\($libc\)$"
-- 
2.14.3
