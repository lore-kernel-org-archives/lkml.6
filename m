Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeBASEF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:04:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50662 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeBASD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:03:58 -0500
From: Khalid Aziz <khalid.aziz@oracle.com>
To: davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, rob.gardner@oracle.com,
        anthony.yznaga@oracle.com, jane.chu@oracle.com, mingo@kernel.org,
        ebiederm@xmission.com, vegard.nossum@oracle.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v11 04/10] sparc64: Add HV fault type handlers for ADI related faults
Date: Thu,  1 Feb 2018 11:01:12 -0700
Message-Id: <19a28478e29f255995ed3741423bb499fbc4b581.1517497017.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=924
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADI (Application Data Integrity) feature on M7 and newer processors
adds new fault types for hypervisor - Invalid ASI and MCD disabled.
This patch expands data access exception handler to handle these
faults.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v7:
	- new patch split off from patch 4/4 in v6

 arch/sparc/kernel/traps_64.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index fc73baa588f6..d273a65a0a10 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -397,12 +397,35 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 	if (is_no_fault_exception(regs))
 		return;
 
-	info.si_signo = SIGSEGV;
+	/* MCD (Memory Corruption Detection) disabled trap (TT=0x19) in HV
+	 * is vectored thorugh data access exception trap with fault type
+	 * set to HV_FAULT_TYPE_MCD_DIS. Check for MCD disabled trap.
+	 * Accessing an address with invalid ASI for the address, for
+	 * example setting an ADI tag on an address with ASI_MCD_PRIMARY
+	 * when TTE.mcd is not set for the VA, is also vectored into
+	 * kerbel by HV as data access exception with fault type set to
+	 * HV_FAULT_TYPE_INV_ASI.
+	 */
 	info.si_errno = 0;
-	info.si_code = SEGV_MAPERR;
 	info.si_addr = (void __user *) addr;
 	info.si_trapno = 0;
-	force_sig_info(SIGSEGV, &info, current);
+	switch (type) {
+	case HV_FAULT_TYPE_INV_ASI:
+		info.si_signo = SIGILL;
+		info.si_code = ILL_ILLADR;
+		force_sig_info(SIGILL, &info, current);
+		break;
+	case HV_FAULT_TYPE_MCD_DIS:
+		info.si_signo = SIGSEGV;
+		info.si_code = SEGV_ACCADI;
+		force_sig_info(SIGSEGV, &info, current);
+		break;
+	default:
+		info.si_signo = SIGSEGV;
+		info.si_code = SEGV_MAPERR;
+		force_sig_info(SIGSEGV, &info, current);
+		break;
+	}
 }
 
 void sun4v_data_access_exception_tl1(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
-- 
2.11.0
