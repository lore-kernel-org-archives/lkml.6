Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBJDuK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 22:50:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750942AbeBJDtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 22:49:35 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] powerpc/vas: Fix cleanup when VAS is not configured
Date: Fri,  9 Feb 2018 19:49:25 -0800
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021003-0040-0000-0000-000003F1910B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008507; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00987497; UDB=6.00501244; IPR=6.00766854;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019472; XFM=3.00000015;
 UTC=2018-02-10 03:49:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021003-0041-0000-0000-000007E706E3
Message-Id: <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802100047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VAS is not configured in the system, make sure to remove
the VAS debugfs directory and unregister the platform driver.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-debug.c | 5 +++++
 arch/powerpc/platforms/powernv/vas.c       | 5 ++++-
 arch/powerpc/platforms/powernv/vas.h       | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index b4de4c6..e6e4067 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -207,3 +207,8 @@ void vas_init_dbgdir(void)
 	if (IS_ERR(vas_debugfs))
 		vas_debugfs = NULL;
 }
+
+void vas_cleanup_dbgdir(void)
+{
+	debugfs_remove_recursive(vas_debugfs);
+}
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index aebbe95..f83e27d8 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -169,8 +169,11 @@ static int __init vas_init(void)
 		found++;
 	}
 
-	if (!found)
+	if (!found) {
+		platform_driver_unregister(&vas_driver);
+		vas_cleanup_dbgdir();
 		return -ENODEV;
+	}
 
 	pr_devel("Found %d instances\n", found);
 
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index ae0100f..2645613 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -406,6 +406,7 @@ extern struct mutex vas_mutex;
 
 extern struct vas_instance *find_vas_instance(int vasid);
 extern void vas_init_dbgdir(void);
+extern void vas_cleanup_dbgdir(void);
 extern void vas_instance_init_dbgdir(struct vas_instance *vinst);
 extern void vas_window_init_dbgdir(struct vas_window *win);
 extern void vas_window_free_dbgdir(struct vas_window *win);
-- 
2.7.4
