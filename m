Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754540AbeEUVda (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:33:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754318AbeEUVd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:33:27 -0400
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To: "David S . Miller" <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] bpf: prevent memory disambiguation attack
Date: Mon, 21 May 2018 14:17:43 -0700
Message-ID: <20180521211743.1492305-1-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect code patterns where malicious 'speculative store bypass' can be used
and sanitize such patterns.

 39: (bf) r3 = r10
 40: (07) r3 += -216
 41: (79) r8 = *(u64 *)(r7 +0)   // slow read
 42: (7a) *(u64 *)(r10 -72) = 0  // verifier inserts this instruction
 43: (7b) *(u64 *)(r8 +0) = r3   // this store becomes slow due to r8
 44: (79) r1 = *(u64 *)(r6 +0)   // cpu speculatively executes this load
 45: (71) r2 = *(u8 *)(r1 +0)    // speculatively arbitrary 'load byte'
                                 // is now sanitized

Above code after x86 JIT becomes:
 e5: mov    %rbp,%rdx
 e8: add    $0xffffffffffffff28,%rdx
 ef: mov    0x0(%r13),%r14
 f3: movq   $0x0,-0x48(%rbp)
 fb: mov    %rdx,0x0(%r14)
 ff: mov    0x0(%rbx),%rdi
103: movzbq 0x0(%rdi),%rsi

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 59 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7e61c395fddf..65cfc2f59db9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -146,6 +146,7 @@ struct bpf_insn_aux_data {
 		s32 call_imm;			/* saved imm field of call insn */
 	};
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
+	int sanitize_stack_off; /* stack slot to be cleared */
 	bool seen; /* this insn was processed by the verifier */
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5dd1dcb902bf..2ce967a63ede 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -978,7 +978,7 @@ static bool register_is_null(struct bpf_reg_state *reg)
  */
 static int check_stack_write(struct bpf_verifier_env *env,
 			     struct bpf_func_state *state, /* func where register points to */
-			     int off, int size, int value_regno)
+			     int off, int size, int value_regno, int insn_idx)
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
@@ -1017,8 +1017,33 @@ static int check_stack_write(struct bpf_verifier_env *env,
 		state->stack[spi].spilled_ptr = cur->regs[value_regno];
 		state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
-		for (i = 0; i < BPF_REG_SIZE; i++)
+		for (i = 0; i < BPF_REG_SIZE; i++) {
+			if (state->stack[spi].slot_type[i] == STACK_MISC &&
+			    !env->allow_ptr_leaks) {
+				int *poff = &env->insn_aux_data[insn_idx].sanitize_stack_off;
+				int soff = (-spi - 1) * BPF_REG_SIZE;
+
+				/* detected reuse of integer stack slot with a pointer
+				 * which means either llvm is reusing stack slot or
+				 * an attacker is trying to exploit CVE-2018-3639
+				 * (speculative store bypass)
+				 * Have to sanitize that slot with preemptive
+				 * store of zero.
+				 */
+				if (*poff && *poff != soff) {
+					/* disallow programs where single insn stores
+					 * into two different stack slots, since verifier
+					 * cannot sanitize them
+					 */
+					verbose(env,
+						"insn %d cannot access two stack slots fp%d and fp%d",
+						insn_idx, *poff, soff);
+					return -EINVAL;
+				}
+				*poff = soff;
+			}
 			state->stack[spi].slot_type[i] = STACK_SPILL;
+		}
 	} else {
 		u8 type = STACK_MISC;
 
@@ -1694,7 +1719,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 		if (t == BPF_WRITE)
 			err = check_stack_write(env, state, off, size,
-						value_regno);
+						value_regno, insn_idx);
 		else
 			err = check_stack_read(env, state, off, size,
 					       value_regno);
@@ -5169,6 +5194,34 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		else
 			continue;
 
+		if (type == BPF_WRITE &&
+		    env->insn_aux_data[i + delta].sanitize_stack_off) {
+			struct bpf_insn patch[] = {
+				/* Sanitize suspicious stack slot with zero.
+				 * There are no memory dependencies for this store,
+				 * since it's only using frame pointer and immediate
+				 * constant of zero
+				 */
+				BPF_ST_MEM(BPF_DW, BPF_REG_FP,
+					   env->insn_aux_data[i + delta].sanitize_stack_off,
+					   0),
+				/* the original STX instruction will immediately
+				 * overwrite the same stack slot with appropriate value
+				 */
+				*insn,
+			};
+
+			cnt = ARRAY_SIZE(patch);
+			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
 		if (env->insn_aux_data[i + delta].ptr_type != PTR_TO_CTX)
 			continue;
 
-- 
2.9.5
