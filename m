Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeEUEVc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:21:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751019AbeEUEV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:21:26 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
        cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 1/3] powerpc/sstep: Introduce GETTYPE macro
Date: Mon, 21 May 2018 09:51:06 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
References: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052104-0020-0000-0000-0000041F6246
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052104-0021-0000-0000-000042B4937A
Message-Id: <20180521042108.8318-2-ravi.bangoria@linux.ibm.com>
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

Replace 'op->type & INSTR_TYPE_MASK' expression with GETTYPE(op->type)
macro.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/sstep.h | 2 ++
 arch/powerpc/kernel/align.c      | 2 +-
 arch/powerpc/lib/sstep.c         | 6 +++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index ab9d849644d0..9a2dfee26f9f 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -97,6 +97,8 @@ enum instruction_type {
 #define SIZE(n)		((n) << 12)
 #define GETSIZE(w)	((w) >> 12)
 
+#define GETTYPE(t)	((t) & INSTR_TYPE_MASK)
+
 #define MKOP(t, f, s)	((t) | (f) | SIZE(s))
 
 struct instruction_op {
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 3e6c0744c174..11550a3d1ac2 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -339,7 +339,7 @@ int fix_alignment(struct pt_regs *regs)
 	if (r < 0)
 		return -EINVAL;
 
-	type = op.type & INSTR_TYPE_MASK;
+	type = GETTYPE(op.type);
 	if (!OP_IS_LOAD_STORE(type)) {
 		if (op.type != CACHEOP + DCBZ)
 			return -EINVAL;
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 34d68f1b1b40..db6bba259d91 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2641,7 +2641,7 @@ void emulate_update_regs(struct pt_regs *regs, struct instruction_op *op)
 	unsigned long next_pc;
 
 	next_pc = truncate_if_32bit(regs->msr, regs->nip + 4);
-	switch (op->type & INSTR_TYPE_MASK) {
+	switch (GETTYPE(op->type)) {
 	case COMPUTE:
 		if (op->type & SETREG)
 			regs->gpr[op->reg] = op->val;
@@ -2739,7 +2739,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 
 	err = 0;
 	size = GETSIZE(op->type);
-	type = op->type & INSTR_TYPE_MASK;
+	type = GETTYPE(op->type);
 	cross_endian = (regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
 	ea = truncate_if_32bit(regs->msr, op->ea);
 
@@ -3001,7 +3001,7 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 	}
 
 	err = 0;
-	type = op.type & INSTR_TYPE_MASK;
+	type = GETTYPE(op.type);
 
 	if (OP_IS_LOAD_STORE(type)) {
 		err = emulate_loadstore(regs, &op);
-- 
2.16.2
