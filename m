Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCDRcK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 12:32:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751838AbeCDRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 12:32:09 -0500
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [PATCH] xmon: Clear all breakpoints when xmon is disabled via debugfs
Date: Sun,  4 Mar 2018 23:01:32 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18030417-0040-0000-0000-0000041A93F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030417-0041-0000-0000-0000261DA03D
Message-Id: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803040227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently when xmon is disabled by debugfs any existing
instruction/data-access breakpoints set are not disabled. This may
lead to kernel oops when those breakpoints are hit as the necessary
debugger hooks aren't installed.

Hence this patch introduces a new function named clear_all_bpt()
which is called when xmon is disabled via debugfs. The function will
unpatch/clear all the trap and ciabr/dab based breakpoints.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e9c7ec8f15f8..f43aacd74625 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -903,6 +903,27 @@ static void remove_bpts(void)
 	}
 }
 
+static void clear_all_bpt(void)
+{
+	int i;
+
+	/* clear/unpatch all breakpoints */
+	remove_bpts();
+	remove_cpu_bpts();
+
+	/* Disable all breakpoints */
+	for (i = 0; i < NBPTS; ++i)
+		bpts[i].enabled = 0;
+
+	/* Clear any data or iabr breakpoints */
+	if (iabr || dabr.enabled) {
+		iabr = NULL;
+		dabr.enabled = 0;
+	}
+
+	printf("xmon: All breakpoints cleared\n");
+}
+
 static void remove_cpu_bpts(void)
 {
 	hw_breakpoint_disable();
@@ -3671,6 +3692,9 @@ static int xmon_dbgfs_set(void *data, u64 val)
 	xmon_on = !!val;
 	xmon_init(xmon_on);
 
+	/* make sure all breakpoints removed when disabling */
+	if (!xmon_on)
+		clear_all_bpt();
 	return 0;
 }
 
-- 
2.14.3
