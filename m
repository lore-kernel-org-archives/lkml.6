Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeEUEVz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:21:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751050AbeEUEVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:21:31 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
        cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 2/3] powerpc/sstep: Fix kernel crash if VSX is not present
Date: Mon, 21 May 2018 09:51:07 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
References: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052104-0008-0000-0000-000004F8A56F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052104-0009-0000-0000-00001E8D2B40
Message-Id: <20180521042108.8318-3-ravi.bangoria@linux.ibm.com>
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

emulate_step() is not checking runtime VSX feature flag before
emulating an instruction. This is causing kernel crash when kernel
is compiled with CONFIG_VSX=y but running on a machine where VSX
is not supported or disabled. Ex, while running emulate_step tests
on P6 machine:

  Oops: Exception in kernel mode, sig: 4 [#1]
  NIP [c000000000095c24] .load_vsrn+0x28/0x54
  LR [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
  Call Trace:
    0x40fe240c7ae147ae (unreliable)
    .emulate_loadstore+0x167c/0x17b0
    .emulate_step+0x25c/0x5bc
    .test_lxvd2x_stxvd2x+0x64/0x154
    .test_emulate_step+0x38/0x4c
    .do_one_initcall+0x5c/0x2c0
    .kernel_init_freeable+0x314/0x4cc
    .kernel_init+0x24/0x160
    .ret_from_kernel_thread+0x58/0xb4

With fix:
  emulate_step_test: lxvd2x         : FAIL
  emulate_step_test: stxvd2x        : FAIL

Fixes: https://github.com/linuxppc/linux/issues/148

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index db6bba259d91..23b7ddf04521 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2544,6 +2544,15 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #endif /* __powerpc64__ */
 
 	}
+
+#ifdef CONFIG_VSX
+	if ((GETTYPE(op->type) == LOAD_VSX ||
+	     GETTYPE(op->type) == STORE_VSX) &&
+	    !cpu_has_feature(CPU_FTR_VSX)) {
+		return -1;
+	}
+#endif /* CONFIG_VSX */
+
 	return 0;
 
  logical_done:
-- 
2.16.2
