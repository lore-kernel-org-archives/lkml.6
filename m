Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbeBNHDa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 02:03:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754470AbeBNHD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 02:03:28 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test: Fix test case inet_pton to accept inlines.
Date: Wed, 14 Feb 2018 08:03:03 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18021407-0008-0000-0000-000004CC9383
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021407-0009-0000-0000-00001E6056E0
Message-Id: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802140082
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using Fedora 27 and latest Linux kernel the test case
trace+probe_libc_inet_pton.sh fails again on s390.
This time is the inlining of functions which does not match.
After an update of the glibc (from 2.26-16 to 2.26-24)
the output is different

The expected output is:
           __inet_pton (/usr/lib64/libc-2.26.so)
           gaih_inet (inlined)
           ....

The actual output is:
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.061/0.061/0.061/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb2140448))
           __inet_pton (inlined)
           gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
           ...

Fix this by being less strict on 'inlined' verses library
name and accept both

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index c446c894b297..8c4ab0b390c0 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -21,12 +21,12 @@ trace_libc_inet_pton_backtrace() {
 	expected[3]=".*packets transmitted.*"
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
-	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[6]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf'
-		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
-		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[7]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
 		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
 		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
 		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
-- 
2.14.3
