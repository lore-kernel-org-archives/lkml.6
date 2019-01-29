Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31588C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AE82183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762066;
	bh=b1zPNk6UaWd6niFqvW4TjrqzSNXsj/ifdiMNjeLBkQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OaGAfQigOi8GuhRuXwMU3xzG8po3DqDeB6aUaCd/89zNCv9Kifyr6cFklxf6paRvF
	 ciWm77B6Zwq+ci6K+FIMwF+sZg6mw33IrkH/vdVv6MEszQoP1HQKqEdy8U/SFzvirf
	 HbI3tTNvjtwgWgIlVb3oPJN1AS34Cm//IEB+H238=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfA2LlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:41:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbfA2LlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E9820857;
        Tue, 29 Jan 2019 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762060;
        bh=b1zPNk6UaWd6niFqvW4TjrqzSNXsj/ifdiMNjeLBkQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZmR3PGWNr6wLS2H6AL6JiVhAML7t6eAWmBvSlf5nIZ6dXQAcdqDEuQFA+6KqkXoC
         bYYpxpePSWadebT+Fo5sm+4qgdtgcC22nOTm0+tS5O665LNFK/lNxFhDoobw1l2wsN
         fplITycdCvx2uVNv62xQBlPCPqFHJ6Bpw9xBscSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 094/117] bpf: move {prev_,}insn_idx into verifier env
Date:   Tue, 29 Jan 2019 12:35:45 +0100
Message-Id: <20190129113212.078694450@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ commit c08435ec7f2bc8f4109401f696fd55159b4b40cb upstream ]

Move prev_insn_idx and insn_idx from the do_check() function into
the verifier environment, so they can be read inside the various
helper functions for handling the instructions. It's easier to put
this into the environment rather than changing all call-sites only
to pass it along. insn_idx is useful in particular since this later
on allows to hold state in env->insn_aux_data[env->insn_idx].

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/verifier.c        | 74 ++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d93e89761a8b..b01edd2aaa7b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -210,6 +210,8 @@ struct bpf_subprog_info {
  * one verifier_env per bpf_check() call
  */
 struct bpf_verifier_env {
+	u32 insn_idx;
+	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eedc7bd4185d..05dcd313279c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5180,7 +5180,6 @@ static int do_check(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct bpf_reg_state *regs;
 	int insn_cnt = env->prog->len, i;
-	int insn_idx, prev_insn_idx = 0;
 	int insn_processed = 0;
 	bool do_print_state = false;
 
@@ -5198,19 +5197,19 @@ static int do_check(struct bpf_verifier_env *env)
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno */,
 			0 /* subprogno, zero == main subprog */);
-	insn_idx = 0;
+
 	for (;;) {
 		struct bpf_insn *insn;
 		u8 class;
 		int err;
 
-		if (insn_idx >= insn_cnt) {
+		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
-				insn_idx, insn_cnt);
+				env->insn_idx, insn_cnt);
 			return -EFAULT;
 		}
 
-		insn = &insns[insn_idx];
+		insn = &insns[env->insn_idx];
 		class = BPF_CLASS(insn->code);
 
 		if (++insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
@@ -5220,7 +5219,7 @@ static int do_check(struct bpf_verifier_env *env)
 			return -E2BIG;
 		}
 
-		err = is_state_visited(env, insn_idx);
+		err = is_state_visited(env, env->insn_idx);
 		if (err < 0)
 			return err;
 		if (err == 1) {
@@ -5228,9 +5227,9 @@ static int do_check(struct bpf_verifier_env *env)
 			if (env->log.level) {
 				if (do_print_state)
 					verbose(env, "\nfrom %d to %d: safe\n",
-						prev_insn_idx, insn_idx);
+						env->prev_insn_idx, env->insn_idx);
 				else
-					verbose(env, "%d: safe\n", insn_idx);
+					verbose(env, "%d: safe\n", env->insn_idx);
 			}
 			goto process_bpf_exit;
 		}
@@ -5243,10 +5242,10 @@ static int do_check(struct bpf_verifier_env *env)
 
 		if (env->log.level > 1 || (env->log.level && do_print_state)) {
 			if (env->log.level > 1)
-				verbose(env, "%d:", insn_idx);
+				verbose(env, "%d:", env->insn_idx);
 			else
 				verbose(env, "\nfrom %d to %d:",
-					prev_insn_idx, insn_idx);
+					env->prev_insn_idx, env->insn_idx);
 			print_verifier_state(env, state->frame[state->curframe]);
 			do_print_state = false;
 		}
@@ -5257,19 +5256,19 @@ static int do_check(struct bpf_verifier_env *env)
 				.private_data	= env,
 			};
 
-			verbose(env, "%d: ", insn_idx);
+			verbose(env, "%d: ", env->insn_idx);
 			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 		}
 
 		if (bpf_prog_is_dev_bound(env->prog->aux)) {
-			err = bpf_prog_offload_verify_insn(env, insn_idx,
-							   prev_insn_idx);
+			err = bpf_prog_offload_verify_insn(env, env->insn_idx,
+							   env->prev_insn_idx);
 			if (err)
 				return err;
 		}
 
 		regs = cur_regs(env);
-		env->insn_aux_data[insn_idx].seen = true;
+		env->insn_aux_data[env->insn_idx].seen = true;
 
 		if (class == BPF_ALU || class == BPF_ALU64) {
 			err = check_alu_op(env, insn);
@@ -5295,13 +5294,13 @@ static int do_check(struct bpf_verifier_env *env)
 			/* check that memory (src_reg + off) is readable,
 			 * the state of dst_reg will be updated by this func
 			 */
-			err = check_mem_access(env, insn_idx, insn->src_reg, insn->off,
-					       BPF_SIZE(insn->code), BPF_READ,
-					       insn->dst_reg, false);
+			err = check_mem_access(env, env->insn_idx, insn->src_reg,
+					       insn->off, BPF_SIZE(insn->code),
+					       BPF_READ, insn->dst_reg, false);
 			if (err)
 				return err;
 
-			prev_src_type = &env->insn_aux_data[insn_idx].ptr_type;
+			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
 
 			if (*prev_src_type == NOT_INIT) {
 				/* saw a valid insn
@@ -5326,10 +5325,10 @@ static int do_check(struct bpf_verifier_env *env)
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_XADD) {
-				err = check_xadd(env, insn_idx, insn);
+				err = check_xadd(env, env->insn_idx, insn);
 				if (err)
 					return err;
-				insn_idx++;
+				env->insn_idx++;
 				continue;
 			}
 
@@ -5345,13 +5344,13 @@ static int do_check(struct bpf_verifier_env *env)
 			dst_reg_type = regs[insn->dst_reg].type;
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-					       BPF_SIZE(insn->code), BPF_WRITE,
-					       insn->src_reg, false);
+			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+					       insn->off, BPF_SIZE(insn->code),
+					       BPF_WRITE, insn->src_reg, false);
 			if (err)
 				return err;
 
-			prev_dst_type = &env->insn_aux_data[insn_idx].ptr_type;
+			prev_dst_type = &env->insn_aux_data[env->insn_idx].ptr_type;
 
 			if (*prev_dst_type == NOT_INIT) {
 				*prev_dst_type = dst_reg_type;
@@ -5379,9 +5378,9 @@ static int do_check(struct bpf_verifier_env *env)
 			}
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-					       BPF_SIZE(insn->code), BPF_WRITE,
-					       -1, false);
+			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+					       insn->off, BPF_SIZE(insn->code),
+					       BPF_WRITE, -1, false);
 			if (err)
 				return err;
 
@@ -5399,9 +5398,9 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 
 				if (insn->src_reg == BPF_PSEUDO_CALL)
-					err = check_func_call(env, insn, &insn_idx);
+					err = check_func_call(env, insn, &env->insn_idx);
 				else
-					err = check_helper_call(env, insn->imm, insn_idx);
+					err = check_helper_call(env, insn->imm, env->insn_idx);
 				if (err)
 					return err;
 
@@ -5414,7 +5413,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				insn_idx += insn->off + 1;
+				env->insn_idx += insn->off + 1;
 				continue;
 
 			} else if (opcode == BPF_EXIT) {
@@ -5428,8 +5427,8 @@ static int do_check(struct bpf_verifier_env *env)
 
 				if (state->curframe) {
 					/* exit from nested function */
-					prev_insn_idx = insn_idx;
-					err = prepare_func_exit(env, &insn_idx);
+					env->prev_insn_idx = env->insn_idx;
+					err = prepare_func_exit(env, &env->insn_idx);
 					if (err)
 						return err;
 					do_print_state = true;
@@ -5459,7 +5458,8 @@ static int do_check(struct bpf_verifier_env *env)
 				if (err)
 					return err;
 process_bpf_exit:
-				err = pop_stack(env, &prev_insn_idx, &insn_idx);
+				err = pop_stack(env, &env->prev_insn_idx,
+						&env->insn_idx);
 				if (err < 0) {
 					if (err != -ENOENT)
 						return err;
@@ -5469,7 +5469,7 @@ static int do_check(struct bpf_verifier_env *env)
 					continue;
 				}
 			} else {
-				err = check_cond_jmp_op(env, insn, &insn_idx);
+				err = check_cond_jmp_op(env, insn, &env->insn_idx);
 				if (err)
 					return err;
 			}
@@ -5486,8 +5486,8 @@ static int do_check(struct bpf_verifier_env *env)
 				if (err)
 					return err;
 
-				insn_idx++;
-				env->insn_aux_data[insn_idx].seen = true;
+				env->insn_idx++;
+				env->insn_aux_data[env->insn_idx].seen = true;
 			} else {
 				verbose(env, "invalid BPF_LD mode\n");
 				return -EINVAL;
@@ -5497,7 +5497,7 @@ static int do_check(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		insn_idx++;
+		env->insn_idx++;
 	}
 
 	verbose(env, "processed %d insns (limit %d), stack depth ",
-- 
2.19.1



