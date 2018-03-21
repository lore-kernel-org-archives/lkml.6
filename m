Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeCUPCW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:02:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752305AbeCUPCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:02:15 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 1/2] bpf: Remove struct bpf_verifier_env argument from print_bpf_insn
Date: Wed, 21 Mar 2018 16:02:11 +0100
Message-Id: <20180321150212.5586-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use print_bpf_insn in user space (bpftool and soon perf),
so it'd be nice to keep it generic and strip it off the kernel
struct bpf_verifier_env argument.

This argument can be safely removed, because its users can
use the struct bpf_insn_cbs::private_data to pass it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/disasm.c   | 52 +++++++++++++++++++++++++--------------------------
 kernel/bpf/disasm.h   |  5 +----
 kernel/bpf/verifier.c |  6 +++---
 3 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 8740406df2cd..d6b76377cb6e 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -113,16 +113,16 @@ static const char *const bpf_jmp_string[16] = {
 };
 
 static void print_bpf_end_insn(bpf_insn_print_t verbose,
-			       struct bpf_verifier_env *env,
+			       void *private_data,
 			       const struct bpf_insn *insn)
 {
-	verbose(env, "(%02x) r%d = %s%d r%d\n", insn->code, insn->dst_reg,
+	verbose(private_data, "(%02x) r%d = %s%d r%d\n",
+		insn->code, insn->dst_reg,
 		BPF_SRC(insn->code) == BPF_TO_BE ? "be" : "le",
 		insn->imm, insn->dst_reg);
 }
 
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
-		    struct bpf_verifier_env *env,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
 {
@@ -132,23 +132,23 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 	if (class == BPF_ALU || class == BPF_ALU64) {
 		if (BPF_OP(insn->code) == BPF_END) {
 			if (class == BPF_ALU64)
-				verbose(env, "BUG_alu64_%02x\n", insn->code);
+				verbose(cbs->private_data, "BUG_alu64_%02x\n", insn->code);
 			else
-				print_bpf_end_insn(verbose, env, insn);
+				print_bpf_end_insn(verbose, cbs->private_data, insn);
 		} else if (BPF_OP(insn->code) == BPF_NEG) {
-			verbose(env, "(%02x) r%d = %s-r%d\n",
+			verbose(cbs->private_data, "(%02x) r%d = %s-r%d\n",
 				insn->code, insn->dst_reg,
 				class == BPF_ALU ? "(u32) " : "",
 				insn->dst_reg);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
-			verbose(env, "(%02x) %sr%d %s %sr%d\n",
+			verbose(cbs->private_data, "(%02x) %sr%d %s %sr%d\n",
 				insn->code, class == BPF_ALU ? "(u32) " : "",
 				insn->dst_reg,
 				bpf_alu_string[BPF_OP(insn->code) >> 4],
 				class == BPF_ALU ? "(u32) " : "",
 				insn->src_reg);
 		} else {
-			verbose(env, "(%02x) %sr%d %s %s%d\n",
+			verbose(cbs->private_data, "(%02x) %sr%d %s %s%d\n",
 				insn->code, class == BPF_ALU ? "(u32) " : "",
 				insn->dst_reg,
 				bpf_alu_string[BPF_OP(insn->code) >> 4],
@@ -157,46 +157,46 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		}
 	} else if (class == BPF_STX) {
 		if (BPF_MODE(insn->code) == BPF_MEM)
-			verbose(env, "(%02x) *(%s *)(r%d %+d) = r%d\n",
+			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = r%d\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
 				insn->off, insn->src_reg);
 		else if (BPF_MODE(insn->code) == BPF_XADD)
-			verbose(env, "(%02x) lock *(%s *)(r%d %+d) += r%d\n",
+			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) += r%d\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
 		else
-			verbose(env, "BUG_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 	} else if (class == BPF_ST) {
 		if (BPF_MODE(insn->code) != BPF_MEM) {
-			verbose(env, "BUG_st_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_st_%02x\n", insn->code);
 			return;
 		}
-		verbose(env, "(%02x) *(%s *)(r%d %+d) = %d\n",
+		verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = %d\n",
 			insn->code,
 			bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 			insn->dst_reg,
 			insn->off, insn->imm);
 	} else if (class == BPF_LDX) {
 		if (BPF_MODE(insn->code) != BPF_MEM) {
-			verbose(env, "BUG_ldx_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_ldx_%02x\n", insn->code);
 			return;
 		}
-		verbose(env, "(%02x) r%d = *(%s *)(r%d %+d)\n",
+		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)\n",
 			insn->code, insn->dst_reg,
 			bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 			insn->src_reg, insn->off);
 	} else if (class == BPF_LD) {
 		if (BPF_MODE(insn->code) == BPF_ABS) {
-			verbose(env, "(%02x) r0 = *(%s *)skb[%d]\n",
+			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[%d]\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->imm);
 		} else if (BPF_MODE(insn->code) == BPF_IND) {
-			verbose(env, "(%02x) r0 = *(%s *)skb[r%d + %d]\n",
+			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[r%d + %d]\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->src_reg, insn->imm);
@@ -212,12 +212,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			if (map_ptr && !allow_ptr_leaks)
 				imm = 0;
 
-			verbose(env, "(%02x) r%d = %s\n",
+			verbose(cbs->private_data, "(%02x) r%d = %s\n",
 				insn->code, insn->dst_reg,
 				__func_imm_name(cbs, insn, imm,
 						tmp, sizeof(tmp)));
 		} else {
-			verbose(env, "BUG_ld_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_ld_%02x\n", insn->code);
 			return;
 		}
 	} else if (class == BPF_JMP) {
@@ -227,35 +227,35 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			char tmp[64];
 
 			if (insn->src_reg == BPF_PSEUDO_CALL) {
-				verbose(env, "(%02x) call pc%s\n",
+				verbose(cbs->private_data, "(%02x) call pc%s\n",
 					insn->code,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)));
 			} else {
 				strcpy(tmp, "unknown");
-				verbose(env, "(%02x) call %s#%d\n", insn->code,
+				verbose(cbs->private_data, "(%02x) call %s#%d\n", insn->code,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)),
 					insn->imm);
 			}
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
-			verbose(env, "(%02x) goto pc%+d\n",
+			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
-			verbose(env, "(%02x) exit\n", insn->code);
+			verbose(cbs->private_data, "(%02x) exit\n", insn->code);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
-			verbose(env, "(%02x) if r%d %s r%d goto pc%+d\n",
+			verbose(cbs->private_data, "(%02x) if r%d %s r%d goto pc%+d\n",
 				insn->code, insn->dst_reg,
 				bpf_jmp_string[BPF_OP(insn->code) >> 4],
 				insn->src_reg, insn->off);
 		} else {
-			verbose(env, "(%02x) if r%d %s 0x%x goto pc%+d\n",
+			verbose(cbs->private_data, "(%02x) if r%d %s 0x%x goto pc%+d\n",
 				insn->code, insn->dst_reg,
 				bpf_jmp_string[BPF_OP(insn->code) >> 4],
 				insn->imm, insn->off);
 		}
 	} else {
-		verbose(env, "(%02x) %s\n",
+		verbose(cbs->private_data, "(%02x) %s\n",
 			insn->code, bpf_class_string[class]);
 	}
 }
diff --git a/kernel/bpf/disasm.h b/kernel/bpf/disasm.h
index 266fe8ee542b..e1324a834a24 100644
--- a/kernel/bpf/disasm.h
+++ b/kernel/bpf/disasm.h
@@ -22,14 +22,12 @@
 #include <string.h>
 #endif
 
-struct bpf_verifier_env;
-
 extern const char *const bpf_alu_string[16];
 extern const char *const bpf_class_string[8];
 
 const char *func_id_name(int id);
 
-typedef __printf(2, 3) void (*bpf_insn_print_t)(struct bpf_verifier_env *env,
+typedef __printf(2, 3) void (*bpf_insn_print_t)(void *private_data,
 						const char *, ...);
 typedef const char *(*bpf_insn_revmap_call_t)(void *private_data,
 					      const struct bpf_insn *insn);
@@ -45,7 +43,6 @@ struct bpf_insn_cbs {
 };
 
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
-		    struct bpf_verifier_env *env,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks);
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c6eff108aa99..9f27d3fa7259 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -202,8 +202,7 @@ EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
  * generic for symbol export. The function was renamed, but not the calls in
  * the verifier to avoid complicating backports. Hence the alias below.
  */
-static __printf(2, 3) void verbose(struct bpf_verifier_env *env,
-				   const char *fmt, ...)
+static __printf(2, 3) void verbose(void *private_data, const char *fmt, ...)
 	__attribute__((alias("bpf_verifier_log_write")));
 
 static bool type_is_pkt_pointer(enum bpf_reg_type type)
@@ -4601,10 +4600,11 @@ static int do_check(struct bpf_verifier_env *env)
 		if (env->log.level) {
 			const struct bpf_insn_cbs cbs = {
 				.cb_print	= verbose,
+				.private_data	= env,
 			};
 
 			verbose(env, "%d: ", insn_idx);
-			print_bpf_insn(&cbs, env, insn, env->allow_ptr_leaks);
+			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 		}
 
 		if (bpf_prog_is_dev_bound(env->prog->aux)) {
-- 
2.13.6
