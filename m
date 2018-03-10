Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641600-2-11751234759386401154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641599; b=MgQetfUUAgmIEnRZYcNbc9LSaVPEvKeV3AErlkLiJYcasXS
    WpYj68NyrAvTRDB+XBeZMfqGibaXmK6KKCQgbyYH53ER1KiG9KXsaYJUaOJleqsQ
    SnlSrXWjyBnyigyFke0ALcQBfPcpO+7XJLZWu5dvW5yLQMQ/hlZTvI90Gif6EwRw
    WUf8N8tW0ULMQ0Li1Y9ye7WlYEImZXq71zxjX8jZ0i38gpgLVERjUF6LCg+6htg0
    6R17wtsCg/UgY6Yy4eNtySn/aqJr8BDHqAUvbPLwqFqvCNnzlL2IM9U9hBwVTQqS
    T9+3araB/gpfVfic5H4IQywpD1HK//Ljoo+1bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641599; bh=N5kbdfteucCNZwa0CZdOR6NH32
    psHeENbDqeutqwJYA=; b=fnGyo1BFciXQtlsa0k06plXsRSK8XKbdGorr5BdnXJ
    SE34QcwR+iIQf8BWxI7TMBGXHDdxTlfc0Q/z9d8k/17sl5cTqRnvTkJC6WEd9aNm
    NtIkrNIxxOclWkfNtyogz39wTGl/sjB2VceekDncJaM13zfs5avTQpEqplsNNNxF
    jXztOKnslDuIuKEp63yca5jwxm54KsO39yvp4eUphNUvUufJRLoWQt319slfnDV6
    bjp+Tm6eZ5eKKaWAMMhM/rtcpIrvCS9119a7wqrPo630xA9rIISyjkmftzityT4D
    4aWMtTXcNj66g+m3WycpjI3WQi/s5HR4zPVCC/ccbX8A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933787AbeCJA0d (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:26:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934093AbeCJAX2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.14 7/9] bpf: allow xadd only on aligned memory
Date: Fri,  9 Mar 2018 16:19:12 -0800
Message-Id: <20180310001829.091684622@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001828.476933393@linuxfoundation.org>
References: <20180310001828.476933393@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit ca36960211eb228bcbc7aaebfa0d027368a94c60 ]

The requirements around atomic_add() / atomic64_add() resp. their
JIT implementations differ across architectures. E.g. while x86_64
seems just fine with BPF's xadd on unaligned memory, on arm64 it
triggers via interpreter but also JIT the following crash:

  [  830.864985] Unable to handle kernel paging request at virtual address ffff8097d7ed6703
  [...]
  [  830.916161] Internal error: Oops: 96000021 [#1] SMP
  [  830.984755] CPU: 37 PID: 2788 Comm: test_verifier Not tainted 4.16.0-rc2+ #8
  [  830.991790] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.29 07/17/2017
  [  830.998998] pstate: 80400005 (Nzcv daif +PAN -UAO)
  [  831.003793] pc : __ll_sc_atomic_add+0x4/0x18
  [  831.008055] lr : ___bpf_prog_run+0x1198/0x1588
  [  831.012485] sp : ffff00001ccabc20
  [  831.015786] x29: ffff00001ccabc20 x28: ffff8017d56a0f00
  [  831.021087] x27: 0000000000000001 x26: 0000000000000000
  [  831.026387] x25: 000000c168d9db98 x24: 0000000000000000
  [  831.031686] x23: ffff000008203878 x22: ffff000009488000
  [  831.036986] x21: ffff000008b14e28 x20: ffff00001ccabcb0
  [  831.042286] x19: ffff0000097b5080 x18: 0000000000000a03
  [  831.047585] x17: 0000000000000000 x16: 0000000000000000
  [  831.052885] x15: 0000ffffaeca8000 x14: 0000000000000000
  [  831.058184] x13: 0000000000000000 x12: 0000000000000000
  [  831.063484] x11: 0000000000000001 x10: 0000000000000000
  [  831.068783] x9 : 0000000000000000 x8 : 0000000000000000
  [  831.074083] x7 : 0000000000000000 x6 : 000580d428000000
  [  831.079383] x5 : 0000000000000018 x4 : 0000000000000000
  [  831.084682] x3 : ffff00001ccabcb0 x2 : 0000000000000001
  [  831.089982] x1 : ffff8097d7ed6703 x0 : 0000000000000001
  [  831.095282] Process test_verifier (pid: 2788, stack limit = 0x0000000018370044)
  [  831.102577] Call trace:
  [  831.105012]  __ll_sc_atomic_add+0x4/0x18
  [  831.108923]  __bpf_prog_run32+0x4c/0x70
  [  831.112748]  bpf_test_run+0x78/0xf8
  [  831.116224]  bpf_prog_test_run_xdp+0xb4/0x120
  [  831.120567]  SyS_bpf+0x77c/0x1110
  [  831.123873]  el0_svc_naked+0x30/0x34
  [  831.127437] Code: 97fffe97 17ffffec 00000000 f9800031 (885f7c31)

Reason for this is because memory is required to be aligned. In
case of BPF, we always enforce alignment in terms of stack access,
but not when accessing map values or packet data when the underlying
arch (e.g. arm64) has CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS set.

xadd on packet data that is local to us anyway is just wrong, so
forbid this case entirely. The only place where xadd makes sense in
fact are map values; xadd on stack is wrong as well, but it's been
around for much longer. Specifically enforce strict alignment in case
of xadd, so that we handle this case generically and avoid such crashes
in the first place.

Fixes: 17a5267067f3 ("bpf: verifier (add verifier core)")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c                       |   42 ++++++++++++--------
 tools/testing/selftests/bpf/test_verifier.c |   58 ++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 16 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -993,6 +993,13 @@ static bool is_ctx_reg(struct bpf_verifi
 	return reg->type == PTR_TO_CTX;
 }
 
+static bool is_pkt_reg(struct bpf_verifier_env *env, int regno)
+{
+	const struct bpf_reg_state *reg = &env->cur_state.regs[regno];
+
+	return reg->type == PTR_TO_PACKET;
+}
+
 static int check_pkt_ptr_alignment(const struct bpf_reg_state *reg,
 				   int off, int size, bool strict)
 {
@@ -1050,10 +1057,10 @@ static int check_generic_ptr_alignment(c
 }
 
 static int check_ptr_alignment(struct bpf_verifier_env *env,
-			       const struct bpf_reg_state *reg,
-			       int off, int size)
+			       const struct bpf_reg_state *reg, int off,
+			       int size, bool strict_alignment_once)
 {
-	bool strict = env->strict_alignment;
+	bool strict = env->strict_alignment || strict_alignment_once;
 	const char *pointer_desc = "";
 
 	switch (reg->type) {
@@ -1109,9 +1116,9 @@ static void coerce_reg_to_size(struct bp
  * if t==write && value_regno==-1, some unknown value is stored into memory
  * if t==read && value_regno==-1, don't care what we read from memory
  */
-static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regno, int off,
-			    int bpf_size, enum bpf_access_type t,
-			    int value_regno)
+static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regno,
+			    int off, int bpf_size, enum bpf_access_type t,
+			    int value_regno, bool strict_alignment_once)
 {
 	struct bpf_verifier_state *state = &env->cur_state;
 	struct bpf_reg_state *reg = &state->regs[regno];
@@ -1122,7 +1129,7 @@ static int check_mem_access(struct bpf_v
 		return size;
 
 	/* alignment checks will add in reg->off themselves */
-	err = check_ptr_alignment(env, reg, off, size);
+	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
 	if (err)
 		return err;
 
@@ -1265,21 +1272,23 @@ static int check_xadd(struct bpf_verifie
 		return -EACCES;
 	}
 
-	if (is_ctx_reg(env, insn->dst_reg)) {
-		verbose("BPF_XADD stores into R%d context is not allowed\n",
-			insn->dst_reg);
+	if (is_ctx_reg(env, insn->dst_reg) ||
+	    is_pkt_reg(env, insn->dst_reg)) {
+		verbose("BPF_XADD stores into R%d %s is not allowed\n",
+			insn->dst_reg, is_ctx_reg(env, insn->dst_reg) ?
+			"context" : "packet");
 		return -EACCES;
 	}
 
 	/* check whether atomic_add can read the memory */
 	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_READ, -1);
+			       BPF_SIZE(insn->code), BPF_READ, -1, true);
 	if (err)
 		return err;
 
 	/* check whether atomic_add can write into the same memory */
 	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				BPF_SIZE(insn->code), BPF_WRITE, -1);
+				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
 }
 
 /* Does this register contain a constant zero? */
@@ -1735,7 +1744,8 @@ static int check_call(struct bpf_verifie
 	 * is inferred from register state.
 	 */
 	for (i = 0; i < meta.access_size; i++) {
-		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B, BPF_WRITE, -1);
+		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
+				       BPF_WRITE, -1, false);
 		if (err)
 			return err;
 	}
@@ -3801,7 +3811,7 @@ static int do_check(struct bpf_verifier_
 			 */
 			err = check_mem_access(env, insn_idx, insn->src_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_READ,
-					       insn->dst_reg);
+					       insn->dst_reg, false);
 			if (err)
 				return err;
 
@@ -3853,7 +3863,7 @@ static int do_check(struct bpf_verifier_
 			/* check that memory (dst_reg + off) is writeable */
 			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_WRITE,
-					       insn->src_reg);
+					       insn->src_reg, false);
 			if (err)
 				return err;
 
@@ -3888,7 +3898,7 @@ static int do_check(struct bpf_verifier_
 			/* check that memory (dst_reg + off) is writeable */
 			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_WRITE,
-					       -1);
+					       -1, false);
 			if (err)
 				return err;
 
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -7880,6 +7880,64 @@ static struct bpf_test tests[] = {
 		.prog_type = BPF_PROG_TYPE_XDP,
 		.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 	},
+	{
+		"xadd/w check unaligned stack",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+			BPF_STX_XADD(BPF_W, BPF_REG_10, BPF_REG_0, -7),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+			BPF_EXIT_INSN(),
+		},
+		.result = REJECT,
+		.errstr = "misaligned stack access off",
+		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	},
+	{
+		"xadd/w check unaligned map",
+		.insns = {
+			BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_map_lookup_elem),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+			BPF_EXIT_INSN(),
+			BPF_MOV64_IMM(BPF_REG_1, 1),
+			BPF_STX_XADD(BPF_W, BPF_REG_0, BPF_REG_1, 3),
+			BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 3),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_map1 = { 3 },
+		.result = REJECT,
+		.errstr = "misaligned value access off",
+		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	},
+	{
+		"xadd/w check unaligned pkt",
+		.insns = {
+			BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+				    offsetof(struct xdp_md, data)),
+			BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+				    offsetof(struct xdp_md, data_end)),
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+			BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_3, 2),
+			BPF_MOV64_IMM(BPF_REG_0, 99),
+			BPF_JMP_IMM(BPF_JA, 0, 0, 6),
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+			BPF_ST_MEM(BPF_W, BPF_REG_2, 3, 0),
+			BPF_STX_XADD(BPF_W, BPF_REG_2, BPF_REG_0, 1),
+			BPF_STX_XADD(BPF_W, BPF_REG_2, BPF_REG_0, 2),
+			BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = REJECT,
+		.errstr = "BPF_XADD stores into R2 packet",
+		.prog_type = BPF_PROG_TYPE_XDP,
+	},
 };
 
 static int probe_filter_length(const struct bpf_insn *fp)
