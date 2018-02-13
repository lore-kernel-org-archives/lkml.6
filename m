Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965730AbeBMTxt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:53:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965651AbeBMTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:53:47 -0500
Date: Tue, 13 Feb 2018 11:53:27 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix cleanup when VAS is not configured
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18021319-2213-0000-0000-0000026BFB2C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008528; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000253; SDB=6.00989257; UDB=6.00502301; IPR=6.00768611;
 BA=6.00005827; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019537; XFM=3.00000015;
 UTC=2018-02-13 19:53:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021319-2214-0000-0000-000059190436
Message-Id: <20180213195327.GA10678@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 11:49:06 -0600
Subject: [PATCH 1/1] powerpc/vas: Fix cleanup when VAS is not configured

When VAS is not configured, unregister the platform driver. Also simplify
cleanup by delaying vas debugfs init until we know VAS is configured.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v2]
	- [Michael Ellerman] Move vas_init_dbgdir() into a lower level
	  function to keep vas_init() cleaner.
---
 arch/powerpc/platforms/powernv/vas-debug.c | 11 +++++++++++
 arch/powerpc/platforms/powernv/vas.c       |  6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index b4de4c6..4f7276e 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -179,6 +179,7 @@ void vas_instance_init_dbgdir(struct vas_instance *vinst)
 {
 	struct dentry *d;
 
+	vas_init_dbgdir();
 	if (!vas_debugfs)
 		return;
 
@@ -201,8 +202,18 @@ void vas_instance_init_dbgdir(struct vas_instance *vinst)
 	vinst->dbgdir = NULL;
 }
 
+/*
+ * Set up the "root" VAS debugfs dir. Return if we already set it up
+ * (or failed to) in an earlier instance of VAS.
+ */
 void vas_init_dbgdir(void)
 {
+	static bool first_time = true;
+
+	if (!first_time)
+		return;
+
+	first_time = false;
 	vas_debugfs = debugfs_create_dir("vas", NULL);
 	if (IS_ERR(vas_debugfs))
 		vas_debugfs = NULL;
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index aebbe95..5a2b24c 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -160,8 +160,6 @@ static int __init vas_init(void)
 	int found = 0;
 	struct device_node *dn;
 
-	vas_init_dbgdir();
-
 	platform_driver_register(&vas_driver);
 
 	for_each_compatible_node(dn, NULL, "ibm,vas") {
@@ -169,8 +167,10 @@ static int __init vas_init(void)
 		found++;
 	}
 
-	if (!found)
+	if (!found) {
+		platform_driver_unregister(&vas_driver);
 		return -ENODEV;
+	}
 
 	pr_devel("Found %d instances\n", found);
 
-- 
2.7.4
