Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeECG6x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:58:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751968AbeECG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:58:49 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf: test 60 fails on s390 inline missing on s390
Date: Thu,  3 May 2018 08:58:37 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18050306-0008-0000-0000-000004F26BC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050306-0009-0000-0000-00001E869034
Message-Id: <20180503065837.71043-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030065
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test 60: probe libc's inet_pton & backtrace it with ping
fails on 4.17.0rc3. It turned out that function __inet_pton
is reported as inline:

[root@s8360047 perf]# ./perf script -i /tmp/perf.data.111
ping 12457 [000]  1584.478959: probe_libc:inet_pton: (3ffb5a347e8)
                  1347e8 __inet_pton (inlined)
                   f19d7 gaih_inet.constprop.5 (/usr/lib64/libc-2.24.so)
                   f4c3f __GI_getaddrinfo (inlined)
                    410b main (/usr/bin/ping)

Allow __inet_pton listed as inline.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 016882d..ee86473 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -16,7 +16,7 @@ nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[1]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-- 
2.9.3
