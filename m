Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeEPFko (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 01:40:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751151AbeEPFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 01:40:43 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, anton@samba.org, cyrilbur@gmail.com,
        matthew.brown.dev@gmail.com, sandipan@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [RFC] powerpc/emulate_step: Fix kernel crash when VSX is not present
Date: Wed, 16 May 2018 11:10:21 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18051605-0012-0000-0000-000005D703F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051605-0013-0000-0000-0000195425B7
Message-Id: <20180516054021.5328-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160057
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

emulate_step() is not checking runtime VSX feature flag before
emulating an instruction. This can cause kernel oops when kernel
is compiled with CONFIG_VSX=y but running on machine where VSX is
not supported or disabled. Ex, while running emulate_step tests on
P6 machine:

  ...
  emulate_step_test: lvx            : PASS
  emulate_step_test: stvx           : PASS
  Oops: Exception in kernel mode, sig: 4 [#1]
  NIP [c000000000095c24] .load_vsrn+0x28/0x54
  LR [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
  Call Trace:
  [c0000000494c3770] [40fe240c7ae147ae] 0x40fe240c7ae147ae (unreliable)
  [c0000000494c37f0] [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
  [c0000000494c3900] [c000000000094f6c] .emulate_step+0x25c/0x5bc
  [c0000000494c39b0] [c000000000ec90dc] .test_lxvd2x_stxvd2x+0x64/0x154
  [c0000000494c3b90] [c000000000ec9204] .test_emulate_step+0x38/0x4c
  [c0000000494c3c00] [c00000000000de2c] .do_one_initcall+0x5c/0x2c0
  [c0000000494c3cd0] [c000000000eb4bf8] .kernel_init_freeable+0x314/0x4cc
  [c0000000494c3db0] [c00000000000e1e4] .kernel_init+0x24/0x160
  [c0000000494c3e30] [c00000000000bc24] .ret_from_kernel_thread+0x58/0xb4

With fix:
  ...
  emulate_step_test: stvx           : PASS
  emulate_step_test: lxvd2x         : FAIL
  emulate_step_test: stxvd2x        : FAIL

Fixes: https://github.com/linuxppc/linux/issues/148

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
Note: VSX was first introduced on P6. But there are many VSX instructions
      which were introduced in later versions. So ideally, analyse_instr()
      should check for ISA version along with opcode.

 arch/powerpc/lib/sstep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 34d68f1b1b40..470942f9c567 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1173,6 +1173,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
 	long ival;
+	int type;
 
 	op->type = COMPUTE;
 
@@ -2544,6 +2545,15 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #endif /* __powerpc64__ */
 
 	}
+
+#ifdef CONFIG_VSX
+	type = op->type & INSTR_TYPE_MASK;
+	if ((type == LOAD_VSX || type == STORE_VSX) &&
+	    !cpu_has_feature(CPU_FTR_VSX)) {
+		return -1;
+	}
+#endif /* CONFIG_VSX */
+
 	return 0;
 
  logical_done:
-- 
2.16.2
