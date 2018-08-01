Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC245C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9175C2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9175C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbeHATyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:54:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405781AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67499136B;
        Wed,  1 Aug 2018 17:13:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang YanQing <udknight@gmail.com>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 042/246] bpf, arm32: fix inconsistent naming about emit_a32_lsr_{r64,i64}
Date:   Wed,  1 Aug 2018 18:49:12 +0200
Message-Id: <20180801165013.734586676@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang YanQing <udknight@gmail.com>

[ Upstream commit 68565a1af9f7012e6f2fe2bdd612f67d2d830c28 ]

The names for BPF_ALU64 | BPF_ARSH are emit_a32_arsh_*,
the names for BPF_ALU64 | BPF_LSH are emit_a32_lsh_*, but
the names for BPF_ALU64 | BPF_RSH are emit_a32_lsr_*.

For consistence reason, let's rename emit_a32_lsr_* to
emit_a32_rsh_*.

This patch also corrects a wrong comment.

Fixes: 39c13c204bb1 ("arm: eBPF JIT compiler")
Signed-off-by: Wang YanQing <udknight@gmail.com>
Cc: Shubham Bansal <illusionist.neo@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux@armlinux.org.uk
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/net/bpf_jit_32.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -718,7 +718,7 @@ static inline void emit_a32_arsh_r64(con
 }
 
 /* dst = dst >> src */
-static inline void emit_a32_lsr_r64(const u8 dst[], const u8 src[], bool dstk,
+static inline void emit_a32_rsh_r64(const u8 dst[], const u8 src[], bool dstk,
 				     bool sstk, struct jit_ctx *ctx) {
 	const u8 *tmp = bpf2a32[TMP_REG_1];
 	const u8 *tmp2 = bpf2a32[TMP_REG_2];
@@ -734,7 +734,7 @@ static inline void emit_a32_lsr_r64(cons
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
 
-	/* Do LSH operation */
+	/* Do RSH operation */
 	emit(ARM_RSB_I(ARM_IP, rt, 32), ctx);
 	emit(ARM_SUBS_I(tmp2[0], rt, 32), ctx);
 	emit(ARM_MOV_SR(ARM_LR, rd, SRTYPE_LSR, rt), ctx);
@@ -784,7 +784,7 @@ static inline void emit_a32_lsh_i64(cons
 }
 
 /* dst = dst >> val */
-static inline void emit_a32_lsr_i64(const u8 dst[], bool dstk,
+static inline void emit_a32_rsh_i64(const u8 dst[], bool dstk,
 				    const u32 val, struct jit_ctx *ctx) {
 	const u8 *tmp = bpf2a32[TMP_REG_1];
 	const u8 *tmp2 = bpf2a32[TMP_REG_2];
@@ -1340,7 +1340,7 @@ static int build_insn(const struct bpf_i
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		if (unlikely(imm > 63))
 			return -EINVAL;
-		emit_a32_lsr_i64(dst, dstk, imm, ctx);
+		emit_a32_rsh_i64(dst, dstk, imm, ctx);
 		break;
 	/* dst = dst << src */
 	case BPF_ALU64 | BPF_LSH | BPF_X:
@@ -1348,7 +1348,7 @@ static int build_insn(const struct bpf_i
 		break;
 	/* dst = dst >> src */
 	case BPF_ALU64 | BPF_RSH | BPF_X:
-		emit_a32_lsr_r64(dst, src, dstk, sstk, ctx);
+		emit_a32_rsh_r64(dst, src, dstk, sstk, ctx);
 		break;
 	/* dst = dst >> src (signed) */
 	case BPF_ALU64 | BPF_ARSH | BPF_X:


