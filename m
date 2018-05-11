Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeEKC4U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:56:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46982 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeEKC4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:56:14 -0400
X-Google-Smtp-Source: AB8JxZr38lDwqB3WX+Nimjbq98+hyujDW9LqL5AWNv2+5xGqXj6Aejhf8aOiwm0S9g4ElB/Xvk4JmA==
Date: Fri, 11 May 2018 10:52:17 +0800
From: Wang YanQing <udknight@gmail.com>
To: linux@armlinux.org.uk
Cc: daniel@iogearbox.net, ast@fb.com, illusionist.neo@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bpf, arm32: Fix inconsistent naming about
 emit_a32_lsr_r64|emit_a32_lsr_i64
Message-ID: <20180511025217.GA7621@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, linux@armlinux.org.uk,
        daniel@iogearbox.net, ast@fb.com, illusionist.neo@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The names for BPF_ALU64 | BPF_ARSH are emit_a32_arsh_*,
the names for BPF_ALU64 | BPF_LSH are emit_a32_lsh_*, but
the names for BPF_ALU64 | BPF_RSH are emit_a32_lsr_*.

For consistence reason, let's rename emit_a32_lsr_* to
emit_a32_rsh_*.

This patch also correct a wrong comment.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes v1-v2:
 1:Rewords the changelog.

 arch/arm/net/bpf_jit_32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index b5030e1..caccc78 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -708,7 +708,7 @@ static inline void emit_a32_arsh_r64(const u8 dst[], const u8 src[], bool dstk,
 }
 
 /* dst = dst >> src */
-static inline void emit_a32_lsr_r64(const u8 dst[], const u8 src[], bool dstk,
+static inline void emit_a32_rsh_r64(const u8 dst[], const u8 src[], bool dstk,
 				     bool sstk, struct jit_ctx *ctx) {
 	const u8 *tmp = bpf2a32[TMP_REG_1];
 	const u8 *tmp2 = bpf2a32[TMP_REG_2];
@@ -724,7 +724,7 @@ static inline void emit_a32_lsr_r64(const u8 dst[], const u8 src[], bool dstk,
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
 
-	/* Do LSH operation */
+	/* Do RSH operation */
 	emit(ARM_RSB_I(ARM_IP, rt, 32), ctx);
 	emit(ARM_SUBS_I(tmp2[0], rt, 32), ctx);
 	emit(ARM_MOV_SR(ARM_LR, rd, SRTYPE_LSR, rt), ctx);
@@ -774,7 +774,7 @@ static inline void emit_a32_lsh_i64(const u8 dst[], bool dstk,
 }
 
 /* dst = dst >> val */
-static inline void emit_a32_lsr_i64(const u8 dst[], bool dstk,
+static inline void emit_a32_rsh_i64(const u8 dst[], bool dstk,
 				    const u32 val, struct jit_ctx *ctx) {
 	const u8 *tmp = bpf2a32[TMP_REG_1];
 	const u8 *tmp2 = bpf2a32[TMP_REG_2];
@@ -1330,7 +1330,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		if (unlikely(imm > 63))
 			return -EINVAL;
-		emit_a32_lsr_i64(dst, dstk, imm, ctx);
+		emit_a32_rsh_i64(dst, dstk, imm, ctx);
 		break;
 	/* dst = dst << src */
 	case BPF_ALU64 | BPF_LSH | BPF_X:
@@ -1338,7 +1338,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* dst = dst >> src */
 	case BPF_ALU64 | BPF_RSH | BPF_X:
-		emit_a32_lsr_r64(dst, src, dstk, sstk, ctx);
+		emit_a32_rsh_r64(dst, src, dstk, sstk, ctx);
 		break;
 	/* dst = dst >> src (signed) */
 	case BPF_ALU64 | BPF_ARSH | BPF_X:
-- 
1.8.5.6.2.g3d8a54e.dirty
