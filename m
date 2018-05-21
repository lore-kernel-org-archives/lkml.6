Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeEUEVg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:21:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751019AbeEUEVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:21:33 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
        cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 3/3] powerpc/sstep: Fix emulate_step test if VSX not present
Date: Mon, 21 May 2018 09:51:08 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
References: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052104-0008-0000-0000-000004F8A570
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052104-0009-0000-0000-00001E8D2B41
Message-Id: <20180521042108.8318-4-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210051
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

emulate_step() tests are failing if VSX is not supported or disabled.

  emulate_step_test: lxvd2x         : FAIL
  emulate_step_test: stxvd2x        : FAIL

If !CPU_FTR_VSX, emulate_step() failure is expected and testcase should
PASS with a valid justification. After patch:

  emulate_step_test: lxvd2x         : PASS (!CPU_FTR_VSX)
  emulate_step_test: stxvd2x        : PASS (!CPU_FTR_VSX)

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/lib/test_emulate_step.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 2534c1447554..6c47daa61614 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -387,10 +387,14 @@ static void __init test_lxvd2x_stxvd2x(void)
 	/* lxvd2x vsr39, r3, r4 */
 	stepped = emulate_step(&regs, TEST_LXVD2X(39, 3, 4));
 
-	if (stepped == 1)
+	if (stepped == 1 && cpu_has_feature(CPU_FTR_VSX)) {
 		show_result("lxvd2x", "PASS");
-	else
-		show_result("lxvd2x", "FAIL");
+	} else {
+		if (!cpu_has_feature(CPU_FTR_VSX))
+			show_result("lxvd2x", "PASS (!CPU_FTR_VSX)");
+		else
+			show_result("lxvd2x", "FAIL");
+	}
 
 
 	/*** stxvd2x ***/
@@ -404,10 +408,15 @@ static void __init test_lxvd2x_stxvd2x(void)
 	stepped = emulate_step(&regs, TEST_STXVD2X(39, 3, 4));
 
 	if (stepped == 1 && cached_b[0] == c.b[0] && cached_b[1] == c.b[1] &&
-	    cached_b[2] == c.b[2] && cached_b[3] == c.b[3])
+	    cached_b[2] == c.b[2] && cached_b[3] == c.b[3] &&
+	    cpu_has_feature(CPU_FTR_VSX)) {
 		show_result("stxvd2x", "PASS");
-	else
-		show_result("stxvd2x", "FAIL");
+	} else {
+		if (!cpu_has_feature(CPU_FTR_VSX))
+			show_result("stxvd2x", "PASS (!CPU_FTR_VSX)");
+		else
+			show_result("stxvd2x", "FAIL");
+	}
 }
 #else
 static void __init test_lxvd2x_stxvd2x(void)
-- 
2.16.2
