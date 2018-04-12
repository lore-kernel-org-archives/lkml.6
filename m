Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeDLQVv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:21:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752793AbeDLQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:21:49 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com
Subject: [PATCH] perf tests: Disable breakpoint accounting test for powerpc
Date: Thu, 12 Apr 2018 21:51:40 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18041216-0044-0000-0000-00000546913A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041216-0045-0000-0000-00002886CD49
Message-Id: <20180412162140.2992-1-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We disable this test as instruction breakpoints (HW_BREAKPOINT_X)
are not available for powerpc.

Before applying patch:

21: Breakpoint accounting                                 :
--- start ---
test child forked, pid 3635
failed opening event 0
failed opening event 0
watchpoints count 1, breakpoints count 0, has_ioctl 1, share 0
test child finished with -2
---- end ----
Breakpoint accounting: Skip

After applying patch:

21: Breakpoint accounting                                 : Disabled

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/tests/builtin-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 625f5a6772af..cac8f8889bc3 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -118,6 +118,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Breakpoint accounting",
 		.func = test__bp_accounting,
+		.is_supported = test__bp_signal_is_supported,
 	},
 	{
 		.desc = "Number of exit events of a simple workload",
-- 
2.14.3
