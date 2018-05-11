Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeEKLSP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:18:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753242AbeEKLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:17:44 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc: Enable ASYM_SMT on interleaved big-core systems
Date: Fri, 11 May 2018 16:47:24 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051111-0052-0000-0000-000002ED0829
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009005; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000259; SDB=6.01030698; UDB=6.00526774; IPR=6.00809829;
 MB=3.00021044; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 11:17:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051111-0053-0000-0000-00005CA5389A
Message-Id: <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Each of the SMT4 cores forming a fused-core are more or less
independent units. Thus when multiple tasks are scheduled to run on
the fused core, we get the best performance when the tasks are spread
across the pair of SMT4 cores.

Since the threads in the pair of SMT4 cores of an interleaved big-core
are numbered {0,2,4,6} and {1,3,5,7} respectively, enable ASYM_SMT on
such interleaved big-cores that will bias the load-balancing of tasks
on smaller numbered threads, which will automatically result in
spreading the tasks uniformly across the associated pair of SMT4
cores.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9ca7148..0153f01 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1082,7 +1082,7 @@ static int powerpc_smt_flags(void)
 {
 	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
 
-	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
+	if (cpu_has_feature(CPU_FTR_ASYM_SMT) || has_interleaved_big_core) {
 		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
 		flags |= SD_ASYM_PACKING;
 	}
-- 
1.9.4
