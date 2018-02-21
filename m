Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754917AbeBURT3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:19:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36618 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754761AbeBURTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:19:25 -0500
From: Khalid Aziz <khalid.aziz@oracle.com>
To: davem@davemloft.net, ebiederm@xmission.com,
        dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, anthony.yznaga@oracle.com,
        rob.gardner@oracle.com, mingo@kernel.org, jane.chu@oracle.com,
        vegard.nossum@oracle.com, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v12 11/11] sparc64: Update signal delivery to use new helper functions
Date: Wed, 21 Feb 2018 10:15:53 -0700
Message-Id: <15cfb4f72990919ff6fa16414eee7e4d1a5c7430.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f8ec66014ffd ("signal: Add send_sig_fault and force_sig_fault")
added new helper functions to streamline signal delivery. This patch
updates signal delivery for new/updated handlers for ADI related
exceptions to use the helper function.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
v12:
	- new patch

 arch/sparc/kernel/traps_64.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index f36a40217f6c..462a21abd105 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -362,7 +362,6 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 {
 	unsigned short type = (type_ctx >> 16);
 	unsigned short ctx  = (type_ctx & 0xffff);
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "data access exception", regs,
 		       0, 0x8, SIGTRAP) == NOTIFY_STOP)
@@ -406,24 +405,18 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 	 * kerbel by HV as data access exception with fault type set to
 	 * HV_FAULT_TYPE_INV_ASI.
 	 */
-	info.si_errno = 0;
-	info.si_addr = (void __user *) addr;
-	info.si_trapno = 0;
 	switch (type) {
 	case HV_FAULT_TYPE_INV_ASI:
-		info.si_signo = SIGILL;
-		info.si_code = ILL_ILLADR;
-		force_sig_info(SIGILL, &info, current);
+		force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr, 0,
+				current);
 		break;
 	case HV_FAULT_TYPE_MCD_DIS:
-		info.si_signo = SIGSEGV;
-		info.si_code = SEGV_ACCADI;
-		force_sig_info(SIGSEGV, &info, current);
+		force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr, 0,
+				current);
 		break;
 	default:
-		info.si_signo = SIGSEGV;
-		info.si_code = SEGV_MAPERR;
-		force_sig_info(SIGSEGV, &info, current);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, 0,
+				current);
 		break;
 	}
 }
@@ -2073,8 +2066,6 @@ static void sun4v_log_error(struct pt_regs *regs, struct sun4v_error_entry *ent,
  */
 void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
 {
-	siginfo_t info;
-
 	if (notify_die(DIE_TRAP, "MCD error", regs, 0, 0x34,
 		       SIGSEGV) == NOTIFY_STOP)
 		return;
@@ -2110,12 +2101,8 @@ void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
 	/* Send SIGSEGV to the userspace process with the right signal
 	 * code
 	 */
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code = SEGV_ADIDERR;
-	info.si_addr = (void __user *)ent.err_raddr;
-	info.si_trapno = 0;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_fault(SIGSEGV, SEGV_ADIDERR, (void __user *)ent.err_raddr,
+			0, current);
 }
 
 /* We run with %pil set to PIL_NORMAL_MAX and PSTATE_IE enabled in %pstate.
@@ -2748,8 +2735,6 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
 void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
 				      unsigned long context)
 {
-	siginfo_t info;
-
 	if (notify_die(DIE_TRAP, "memory corruption precise exception", regs,
 		       0, 0x8, SIGSEGV) == NOTIFY_STOP)
 		return;
@@ -2784,12 +2769,7 @@ void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	info.si_signo = SIGSEGV;
-	info.si_code = SEGV_ADIPERR;
-	info.si_errno = 0;
-	info.si_addr = (void __user *) addr;
-	info.si_trapno = 0;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr, 0, current);
 }
 
 void do_privop(struct pt_regs *regs)
-- 
2.11.0
