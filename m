Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF96C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC3D2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762394;
	bh=YX6RU71wyCjSw2LXp9VR3Z3M6/DJAGQrcU2auUs0ZaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rj/2KUKiJeZmVQNmPe+4BcxsEah9X6B6FrbBiWbKkeYg89kJKQHarpeY4VyUCapx6
	 JITrjw8vz5mHKW+oIIOytdmlMR8WPt+mpcVhAFgkEAD/K6eArNPzmm5aSAfrKE/LCK
	 Dl+11IRVnOkJgAh6phWf6FkQz1xnk5XmnSDTyhu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfA2Lqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbfA2Lq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7AEA214DA;
        Tue, 29 Jan 2019 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762385;
        bh=YX6RU71wyCjSw2LXp9VR3Z3M6/DJAGQrcU2auUs0ZaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A472eODDXZSy+4GVrsId3nN+/hRB8kEUbH4tUfF6TPLtkiokMNYZNMWYWNB+eHt39
         lPrOigyagGQLCsSBApzb/y5UAHUkcFlZ14+P1HgymVCvVQ1nCQ2OOoeN/zenRNgGO/
         aMhkIe57LPD4x+87E8dWDDnvQSrYVgn7dNfdHx6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/103] bpf: move tmp variable into ax register in interpreter
Date:   Tue, 29 Jan 2019 12:36:06 +0100
Message-Id: <20190129113206.885554524@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ commit 144cd91c4c2bced6eb8a7e25e590f6618a11e854 upstream ]

This change moves the on-stack 64 bit tmp variable in ___bpf_prog_run()
into the hidden ax register. The latter is currently only used in JITs
for constant blinding as a temporary scratch register, meaning the BPF
interpreter will never see the use of ax. Therefore it is safe to use
it for the cases where tmp has been used earlier. This is needed to later
on allow restricted hidden use of ax in both interpreter and JITs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h |  3 ++-
 kernel/bpf/core.c      | 34 +++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index ec90d5255cf7..81420a0efdbe 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -60,7 +60,8 @@ struct sock_reuseport;
  * constants. See JIT pre-step in bpf_jit_blind_constants().
  */
 #define BPF_REG_AX		MAX_BPF_REG
-#define MAX_BPF_JIT_REG		(MAX_BPF_REG + 1)
+#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
+#define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG
 
 /* unused opcode to mark special call to bpf_tail_call() helper */
 #define BPF_TAIL_CALL	0xf0
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3f5bf1af0826..aefc62ae4a1e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -52,6 +52,7 @@
 #define DST	regs[insn->dst_reg]
 #define SRC	regs[insn->src_reg]
 #define FP	regs[BPF_REG_FP]
+#define AX	regs[BPF_REG_AX]
 #define ARG1	regs[BPF_REG_ARG1]
 #define CTX	regs[BPF_REG_CTX]
 #define IMM	insn->imm
@@ -971,7 +972,6 @@ bool bpf_opcode_in_insntable(u8 code)
  */
 static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 {
-	u64 tmp;
 #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
 #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
 	static const void *jumptable[256] = {
@@ -1045,36 +1045,36 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 		(*(s64 *) &DST) >>= IMM;
 		CONT;
 	ALU64_MOD_X:
-		div64_u64_rem(DST, SRC, &tmp);
-		DST = tmp;
+		div64_u64_rem(DST, SRC, &AX);
+		DST = AX;
 		CONT;
 	ALU_MOD_X:
-		tmp = (u32) DST;
-		DST = do_div(tmp, (u32) SRC);
+		AX = (u32) DST;
+		DST = do_div(AX, (u32) SRC);
 		CONT;
 	ALU64_MOD_K:
-		div64_u64_rem(DST, IMM, &tmp);
-		DST = tmp;
+		div64_u64_rem(DST, IMM, &AX);
+		DST = AX;
 		CONT;
 	ALU_MOD_K:
-		tmp = (u32) DST;
-		DST = do_div(tmp, (u32) IMM);
+		AX = (u32) DST;
+		DST = do_div(AX, (u32) IMM);
 		CONT;
 	ALU64_DIV_X:
 		DST = div64_u64(DST, SRC);
 		CONT;
 	ALU_DIV_X:
-		tmp = (u32) DST;
-		do_div(tmp, (u32) SRC);
-		DST = (u32) tmp;
+		AX = (u32) DST;
+		do_div(AX, (u32) SRC);
+		DST = (u32) AX;
 		CONT;
 	ALU64_DIV_K:
 		DST = div64_u64(DST, IMM);
 		CONT;
 	ALU_DIV_K:
-		tmp = (u32) DST;
-		do_div(tmp, (u32) IMM);
-		DST = (u32) tmp;
+		AX = (u32) DST;
+		do_div(AX, (u32) IMM);
+		DST = (u32) AX;
 		CONT;
 	ALU_END_TO_BE:
 		switch (IMM) {
@@ -1330,7 +1330,7 @@ STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
-	u64 regs[MAX_BPF_REG]; \
+	u64 regs[MAX_BPF_EXT_REG]; \
 \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \
@@ -1343,7 +1343,7 @@ static u64 PROG_NAME_ARGS(stack_size)(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5, \
 				      const struct bpf_insn *insn) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
-	u64 regs[MAX_BPF_REG]; \
+	u64 regs[MAX_BPF_EXT_REG]; \
 \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	BPF_R1 = r1; \
-- 
2.19.1



