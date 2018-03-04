Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeCDRbb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 12:31:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751878AbeCDRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 12:31:28 -0500
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [PATCH v2] xmon: Setup xmon debugger hooks when first break-point is set
Date: Sun,  4 Mar 2018 23:00:25 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18030417-0012-0000-0000-000005B893A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030417-0013-0000-0000-00001934A27E
Message-Id: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803040227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently sysrq key for xmon('x') is registered during kernel init
irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
even if 'xmon=off' is passed on the kernel command line. However this
doesn't enable the kernel debugger hooks needed for instruction or data
breakpoints. Thus when a break-point is hit with xmon=off a kernel oops
of the form below is reported:

Oops: Exception in kernel mode, sig: 5 [#1]
< snip >
Trace/breakpoint trap

To fix this the patch checks and enables debugger hooks when an
instruction or data break-point is set via xmon console.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Change-log:

v2 -> Moved the code that was force enabling xmon to a separate inline
      function (Balbir)

      The change related to clearing all breakpoints when xmon is
      disabled via debugfs will be respinned as a separate
      patch. (Mpe)
---
 arch/powerpc/xmon/xmon.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 82e1a3ee6e0f..e9c7ec8f15f8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1273,6 +1273,18 @@ static long check_bp_loc(unsigned long addr)
 	return 1;
 }
 
+/* Force enable xmon if not already enabled */
+static inline void force_enable_xmon(void)
+{
+	static const char warnxmon[] = "xmon: Enabling debugger hooks\n";
+
+	/* Enable xmon hooks if needed */
+	if (!xmon_on) {
+		printf(warnxmon);
+		xmon_on = 1;
+	}
+}
+
 static char *breakpoint_help_string =
     "Breakpoint command usage:\n"
     "b                show breakpoints\n"
@@ -1315,6 +1327,8 @@ bpt_cmds(void)
 			dabr.address &= ~HW_BRK_TYPE_DABR;
 			dabr.enabled = mode | BP_DABR;
 		}
+
+		force_enable_xmon();
 		break;
 
 	case 'i':	/* bi - hardware instr breakpoint */
@@ -1335,6 +1349,7 @@ bpt_cmds(void)
 		if (bp != NULL) {
 			bp->enabled |= BP_CIABR;
 			iabr = bp;
+			force_enable_xmon();
 		}
 		break;
 #endif
@@ -1399,8 +1414,10 @@ bpt_cmds(void)
 		if (!check_bp_loc(a))
 			break;
 		bp = new_breakpoint(a);
-		if (bp != NULL)
+		if (bp != NULL) {
 			bp->enabled |= BP_TRAP;
+			force_enable_xmon();
+		}
 		break;
 	}
 }
-- 
2.14.3
