Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4191C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFA321852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762380;
	bh=9iKJRyXLSpYYneVMsWgLeWsXsoRNH0zz3RxFbdCG60E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R6N3HlDayFqEOuG+vG3cXN+NNRKSvjJmkDm5WZFhL0fUWhGKbfs1PcedH8U4XD9E6
	 Y0LDSZo4BhdT8+QG8iNg1cLy1uD8LxYVXdGpBsECTnU6LlckNvZWDCLcqAjxp6xtID
	 xXJC1+W1/PI1+B3c3J4VrIRmAwpVrk/00SMV++IE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfA2LqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730962AbfA2LqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E7D52083B;
        Tue, 29 Jan 2019 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762374;
        bh=9iKJRyXLSpYYneVMsWgLeWsXsoRNH0zz3RxFbdCG60E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZYoIK9D4qspUlyiB7Gy7/ZOsfdwzglgbodQf9sZ/tm7A5acjYtPfEj5BoZ6GChfu
         cDKwZqgouat3fTSVkvvYuNq/nwCU0hHXlsXBljK6UomDJfbpcLgcLbWTqu/Rcs6lQN
         FjUBFsE7vQ7UTdmLjXPQPzxgfcv1LXz1Z63AMc6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Edward Cree <ecree@solarflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/103] bpf: improve verifier branch analysis
Date:   Tue, 29 Jan 2019 12:36:03 +0100
Message-Id: <20190129113206.687170032@linuxfoundation.org>
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

[ commit 4f7b3e82589e0de723780198ec7983e427144c0a upstream ]

pathological bpf programs may try to force verifier to explode in
the number of branch states:
  20: (d5) if r1 s<= 0x24000028 goto pc+0
  21: (b5) if r0 <= 0xe1fa20 goto pc+2
  22: (d5) if r1 s<= 0x7e goto pc+0
  23: (b5) if r0 <= 0xe880e000 goto pc+0
  24: (c5) if r0 s< 0x2100ecf4 goto pc+0
  25: (d5) if r1 s<= 0xe880e000 goto pc+1
  26: (c5) if r0 s< 0xf4041810 goto pc+0
  27: (d5) if r1 s<= 0x1e007e goto pc+0
  28: (b5) if r0 <= 0xe86be000 goto pc+0
  29: (07) r0 += 16614
  30: (c5) if r0 s< 0x6d0020da goto pc+0
  31: (35) if r0 >= 0x2100ecf4 goto pc+0

Teach verifier to recognize always taken and always not taken branches.
This analysis is already done for == and != comparison.
Expand it to all other branches.

It also helps real bpf programs to be verified faster:
                       before  after
bpf_lb-DLB_L3.o         2003    1940
bpf_lb-DLB_L4.o         3173    3089
bpf_lb-DUNKNOWN.o       1080    1065
bpf_lxc-DDROP_ALL.o     29584   28052
bpf_lxc-DUNKNOWN.o      36916   35487
bpf_netdev.o            11188   10864
bpf_overlay.o           6679    6643
bpf_lcx_jit.o           39555   38437

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 93 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 341806668f03..3d093003c723 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3475,6 +3475,79 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	}
 }
 
+/* compute branch direction of the expression "if (reg opcode val) goto target;"
+ * and return:
+ *  1 - branch will be taken and "goto target" will be executed
+ *  0 - branch will not be taken and fall-through to next insn
+ * -1 - unknown. Example: "if (reg < 5)" is unknown when register value range [0,10]
+ */
+static int is_branch_taken(struct bpf_reg_state *reg, u64 val, u8 opcode)
+{
+	if (__is_pointer_value(false, reg))
+		return -1;
+
+	switch (opcode) {
+	case BPF_JEQ:
+		if (tnum_is_const(reg->var_off))
+			return !!tnum_equals_const(reg->var_off, val);
+		break;
+	case BPF_JNE:
+		if (tnum_is_const(reg->var_off))
+			return !tnum_equals_const(reg->var_off, val);
+		break;
+	case BPF_JGT:
+		if (reg->umin_value > val)
+			return 1;
+		else if (reg->umax_value <= val)
+			return 0;
+		break;
+	case BPF_JSGT:
+		if (reg->smin_value > (s64)val)
+			return 1;
+		else if (reg->smax_value < (s64)val)
+			return 0;
+		break;
+	case BPF_JLT:
+		if (reg->umax_value < val)
+			return 1;
+		else if (reg->umin_value >= val)
+			return 0;
+		break;
+	case BPF_JSLT:
+		if (reg->smax_value < (s64)val)
+			return 1;
+		else if (reg->smin_value >= (s64)val)
+			return 0;
+		break;
+	case BPF_JGE:
+		if (reg->umin_value >= val)
+			return 1;
+		else if (reg->umax_value < val)
+			return 0;
+		break;
+	case BPF_JSGE:
+		if (reg->smin_value >= (s64)val)
+			return 1;
+		else if (reg->smax_value < (s64)val)
+			return 0;
+		break;
+	case BPF_JLE:
+		if (reg->umax_value <= val)
+			return 1;
+		else if (reg->umin_value > val)
+			return 0;
+		break;
+	case BPF_JSLE:
+		if (reg->smax_value <= (s64)val)
+			return 1;
+		else if (reg->smin_value > (s64)val)
+			return 0;
+		break;
+	}
+
+	return -1;
+}
+
 /* Adjusts the register min/max values in the case that the dst_reg is the
  * variable register that we are working on, and src_reg is a constant or we're
  * simply doing a BPF_K check.
@@ -3868,21 +3941,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 	dst_reg = &regs[insn->dst_reg];
 
-	/* detect if R == 0 where R was initialized to zero earlier */
-	if (BPF_SRC(insn->code) == BPF_K &&
-	    (opcode == BPF_JEQ || opcode == BPF_JNE) &&
-	    dst_reg->type == SCALAR_VALUE &&
-	    tnum_is_const(dst_reg->var_off)) {
-		if ((opcode == BPF_JEQ && dst_reg->var_off.value == insn->imm) ||
-		    (opcode == BPF_JNE && dst_reg->var_off.value != insn->imm)) {
-			/* if (imm == imm) goto pc+off;
-			 * only follow the goto, ignore fall-through
-			 */
+	if (BPF_SRC(insn->code) == BPF_K) {
+		int pred = is_branch_taken(dst_reg, insn->imm, opcode);
+
+		if (pred == 1) {
+			 /* only follow the goto, ignore fall-through */
 			*insn_idx += insn->off;
 			return 0;
-		} else {
-			/* if (imm != imm) goto pc+off;
-			 * only follow fall-through branch, since
+		} else if (pred == 0) {
+			/* only follow fall-through branch, since
 			 * that's where the program will go
 			 */
 			return 0;
-- 
2.19.1



