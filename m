Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeBJDtg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 22:49:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750832AbeBJDte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 22:49:34 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 1/4] powerpc/vas: Fix order of cleanup in debugfs dir
Date: Fri,  9 Feb 2018 19:49:24 -0800
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18021003-0056-0000-0000-000004188E93
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008507; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00987497; UDB=6.00501244; IPR=6.00766855;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019472; XFM=3.00000015;
 UTC=2018-02-10 03:49:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021003-0057-0000-0000-000008500112
Message-Id: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802100047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the order of cleanup to ensure we free the name buffer in case
of an error creating 'hvwc' or 'info' files.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index ca22f1e..b4de4c6 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -166,13 +166,13 @@ void vas_window_init_dbgdir(struct vas_window *window)
 
 	return;
 
-free_name:
-	kfree(window->dbgname);
-	window->dbgname = NULL;
-
 remove_dir:
 	debugfs_remove_recursive(window->dbgdir);
 	window->dbgdir = NULL;
+
+free_name:
+	kfree(window->dbgname);
+	window->dbgname = NULL;
 }
 
 void vas_instance_init_dbgdir(struct vas_instance *vinst)
-- 
2.7.4
