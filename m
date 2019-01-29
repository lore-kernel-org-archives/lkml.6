Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3CAC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1236E21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762147;
	bh=/hlyMbEdUagSAMqI7KW0WFFCCjpjunEGTdmujN9F5kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mfHQ4z+T1YDg5rg4AQu+893yyzmnH5nCCtabP9D+joB1mctyTnXqi14NrbSMAsKU1
	 DgMVh04wNgfuMgEbuq49WkbQmRIhm7lnOB/Joe983J3vBgzDB103JuhKlXNPuO05CY
	 UVJiVa3/7JuUsTmNnDO0IRz67bMmAbcIC+yaqdZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfA2LmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbfA2LmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474B920857;
        Tue, 29 Jan 2019 11:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762140;
        bh=/hlyMbEdUagSAMqI7KW0WFFCCjpjunEGTdmujN9F5kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEUhaueCRmvCiq/SOYd9TuyNqEdHHX2d2IO+nizEFB5bPkfkf7P6cVzbuakOmZZ/Y
         3kYuF4ce/N3XjWIPZegq0pn8aIX+2L5qMXxZPeSl+aj9FmjfNk5KO+3u7bUt/oHFpH
         CdPvp6sWW/kCgrw8Ee3NlcEK3trqVFLX50v6fRTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 104/117] bpf: fix sanitation of alu op with pointer / scalar type from different paths
Date:   Tue, 29 Jan 2019 12:35:55 +0100
Message-Id: <20190129113212.562705703@linuxfoundation.org>
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

[ commit d3bd7413e0ca40b60cf60d4003246d067cafdeda upstream ]

While 979d63d50c0c ("bpf: prevent out of bounds speculation on pointer
arithmetic") took care of rejecting alu op on pointer when e.g. pointer
came from two different map values with different map properties such as
value size, Jann reported that a case was not covered yet when a given
alu op is used in both "ptr_reg += reg" and "numeric_reg += reg" from
different branches where we would incorrectly try to sanitize based
on the pointer's limit. Catch this corner case and reject the program
instead.

Fixes: 979d63d50c0c ("bpf: prevent out of bounds speculation on pointer arithmetic")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 61 ++++++++++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5435bba302ed..a6349a29748c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -171,6 +171,7 @@ struct bpf_verifier_state_list {
 #define BPF_ALU_SANITIZE_SRC		1U
 #define BPF_ALU_SANITIZE_DST		2U
 #define BPF_ALU_NEG_VALUE		(1U << 2)
+#define BPF_ALU_NON_POINTER		(1U << 3)
 #define BPF_ALU_SANITIZE		(BPF_ALU_SANITIZE_SRC | \
 					 BPF_ALU_SANITIZE_DST)
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 70fa0eb6ce81..e4c826229152 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3019,6 +3019,40 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 	}
 }
 
+static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
+				    const struct bpf_insn *insn)
+{
+	return env->allow_ptr_leaks || BPF_SRC(insn->code) == BPF_K;
+}
+
+static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
+				       u32 alu_state, u32 alu_limit)
+{
+	/* If we arrived here from different branches with different
+	 * state or limits to sanitize, then this won't work.
+	 */
+	if (aux->alu_state &&
+	    (aux->alu_state != alu_state ||
+	     aux->alu_limit != alu_limit))
+		return -EACCES;
+
+	/* Corresponding fixup done in fixup_bpf_calls(). */
+	aux->alu_state = alu_state;
+	aux->alu_limit = alu_limit;
+	return 0;
+}
+
+static int sanitize_val_alu(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn)
+{
+	struct bpf_insn_aux_data *aux = cur_aux(env);
+
+	if (can_skip_alu_sanitation(env, insn))
+		return 0;
+
+	return update_alu_sanitation_state(aux, BPF_ALU_NON_POINTER, 0);
+}
+
 static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn,
 			    const struct bpf_reg_state *ptr_reg,
@@ -3033,7 +3067,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	struct bpf_reg_state tmp;
 	bool ret;
 
-	if (env->allow_ptr_leaks || BPF_SRC(insn->code) == BPF_K)
+	if (can_skip_alu_sanitation(env, insn))
 		return 0;
 
 	/* We already marked aux for masking from non-speculative
@@ -3049,19 +3083,8 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 
 	if (retrieve_ptr_limit(ptr_reg, &alu_limit, opcode, off_is_neg))
 		return 0;
-
-	/* If we arrived here from different branches with different
-	 * limits to sanitize, then this won't work.
-	 */
-	if (aux->alu_state &&
-	    (aux->alu_state != alu_state ||
-	     aux->alu_limit != alu_limit))
+	if (update_alu_sanitation_state(aux, alu_state, alu_limit))
 		return -EACCES;
-
-	/* Corresponding fixup done in fixup_bpf_calls(). */
-	aux->alu_state = alu_state;
-	aux->alu_limit = alu_limit;
-
 do_sim:
 	/* Simulate and find potential out-of-bounds access under
 	 * speculative execution from truncation as a result of
@@ -3334,6 +3357,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	s64 smin_val, smax_val;
 	u64 umin_val, umax_val;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
+	u32 dst = insn->dst_reg;
+	int ret;
 
 	if (insn_bitness == 32) {
 		/* Relevant for 32-bit RSH: Information can propagate towards
@@ -3368,6 +3393,11 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 
 	switch (opcode) {
 	case BPF_ADD:
+		ret = sanitize_val_alu(env, insn);
+		if (ret < 0) {
+			verbose(env, "R%d tried to add from different pointers or scalars\n", dst);
+			return ret;
+		}
 		if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
 		    signed_add_overflows(dst_reg->smax_value, smax_val)) {
 			dst_reg->smin_value = S64_MIN;
@@ -3387,6 +3417,11 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_add(dst_reg->var_off, src_reg.var_off);
 		break;
 	case BPF_SUB:
+		ret = sanitize_val_alu(env, insn);
+		if (ret < 0) {
+			verbose(env, "R%d tried to sub from different pointers or scalars\n", dst);
+			return ret;
+		}
 		if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
 		    signed_sub_overflows(dst_reg->smax_value, smin_val)) {
 			/* Overflow possible, we know nothing */
-- 
2.19.1



