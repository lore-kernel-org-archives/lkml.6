Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E309C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5F220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107925;
	bh=m4sRIWw6xKXNgG6d+TQiA5bLILJ65npeX/AK0ekeQX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=akYreZjJfSGgVVufy3k3zgT5b77cnmxuSNQWT6lPIIztc0lmdJhDY2mqceC9ffVPT
	 SOF+1R+qFfaHkbUStQxYiYqws6zb5Ldrh6/+PfPoWfjEbcd1oLIRlu+duuYLW9L0lR
	 3ftsB3axeeiNCbCicHvGr3pHKP5zQdTrgILXARPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5F220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeLFOq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbeLFOqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A252082B;
        Thu,  6 Dec 2018 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107582;
        bh=m4sRIWw6xKXNgG6d+TQiA5bLILJ65npeX/AK0ekeQX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHTRPep+IhdK9WeycSHeQTQiW9KYyOeB7RgOHtcMCPFWX6+idSq3qn7tmmBzsUOZo
         FRXTyLG5MyJRxH3E68INbJpCPiJ3jbQmq2iKP78QNyg8H8zC3/6JfZw4cyTpxIq3jP
         wIi5MWbUJfzLo+cHn5gYz+uEKaQORa7s1FFfN/ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 060/101] bpf: Prevent memory disambiguation attack
Date:   Thu,  6 Dec 2018 15:38:59 +0100
Message-Id: <20181206143015.089926003@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

commit af86ca4e3088fe5eacf2f7e58c01fa68ca067672 upstream.

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 4.9:
 - Add bpf_verifier_env parameter to check_stack_write()
 - Look up stack slot_types with state->stack_slot_type[] rather than
   state->stack[].slot_type[]
 - Drop bpf_verifier_env argument to verbose()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bpf_verifier.h |    1 
 kernel/bpf/verifier.c        |   62 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 4 deletions(-)

--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -71,6 +71,7 @@ struct bpf_insn_aux_data {
 		enum bpf_reg_type ptr_type;     /* pointer type for load/store insns */
 		struct bpf_map *map_ptr;        /* pointer for call insn into lookup_elem */
 	};
+	int sanitize_stack_off; /* stack slot to be cleared */
 	bool seen; /* this insn was processed by the verifier */
 };
 
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -540,8 +540,9 @@ static bool is_spillable_regtype(enum bp
 /* check_stack_read/write functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
-static int check_stack_write(struct bpf_verifier_state *state, int off,
-			     int size, int value_regno)
+static int check_stack_write(struct bpf_verifier_env *env,
+			     struct bpf_verifier_state *state, int off,
+			     int size, int value_regno, int insn_idx)
 {
 	int i, spi = (MAX_BPF_STACK + off) / BPF_REG_SIZE;
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
@@ -560,8 +561,32 @@ static int check_stack_write(struct bpf_
 		/* save register state */
 		state->spilled_regs[spi] = state->regs[value_regno];
 
-		for (i = 0; i < BPF_REG_SIZE; i++)
+		for (i = 0; i < BPF_REG_SIZE; i++) {
+			if (state->stack_slot_type[MAX_BPF_STACK + off + i] == STACK_MISC &&
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
+					verbose("insn %d cannot access two stack slots fp%d and fp%d",
+						insn_idx, *poff, soff);
+					return -EINVAL;
+				}
+				*poff = soff;
+			}
 			state->stack_slot_type[MAX_BPF_STACK + off + i] = STACK_SPILL;
+		}
 	} else {
 		/* regular write of data into stack */
 		state->spilled_regs[spi] = (struct bpf_reg_state) {};
@@ -841,7 +866,8 @@ static int check_mem_access(struct bpf_v
 				verbose("attempt to corrupt spilled pointer on stack\n");
 				return -EACCES;
 			}
-			err = check_stack_write(state, off, size, value_regno);
+			err = check_stack_write(env, state, off, size,
+						value_regno, insn_idx);
 		} else {
 			err = check_stack_read(state, off, size, value_regno);
 		}
@@ -3367,6 +3393,34 @@ static int convert_ctx_accesses(struct b
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
 


