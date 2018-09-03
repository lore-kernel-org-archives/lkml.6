Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32980C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA66B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA66B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeICVhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbeICVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:32 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47E94D09;
        Mon,  3 Sep 2018 17:16:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 028/165] bpf, ppc64: fix unexpected r0=0 exit path inside bpf_xadd
Date:   Mon,  3 Sep 2018 18:55:14 +0200
Message-Id: <20180903165656.458583929@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit b9c1e60e7bf4e64ac1b4f4d6d593f0bb57886973 ]

None of the JITs is allowed to implement exit paths from the BPF
insn mappings other than BPF_JMP | BPF_EXIT. In the BPF core code
we have a couple of rewrites in eBPF (e.g. LD_ABS / LD_IND) and
in eBPF to cBPF translation to retain old existing behavior where
exceptions may occur; they are also tightly controlled by the
verifier where it disallows some of the features such as BPF to
BPF calls when legacy LD_ABS / LD_IND ops are present in the BPF
program. During recent review of all BPF_XADD JIT implementations
I noticed that the ppc64 one is buggy in that it contains two
jumps to exit paths. This is problematic as this can bypass verifier
expectations e.g. pointed out in commit f6b1b3bf0d5f ("bpf: fix
subprog verifier bypass by div/mod by 0 exception"). The first
exit path is obsoleted by the fix in ca36960211eb ("bpf: allow xadd
only on aligned memory") anyway, and for the second one we need to
do a fetch, add and store loop if the reservation from lwarx/ldarx
was lost in the meantime.

Fixes: 156d0e290e96 ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Tested-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp64.c |   29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -322,6 +322,7 @@ static int bpf_jit_build_body(struct bpf
 		u64 imm64;
 		u8 *func;
 		u32 true_cond;
+		u32 tmp_idx;
 
 		/*
 		 * addrs[] maps a BPF bytecode address into a real offset from
@@ -681,11 +682,7 @@ emit_clear:
 		case BPF_STX | BPF_XADD | BPF_W:
 			/* Get EA into TMP_REG_1 */
 			PPC_ADDI(b2p[TMP_REG_1], dst_reg, off);
-			/* error if EA is not word-aligned */
-			PPC_ANDI(b2p[TMP_REG_2], b2p[TMP_REG_1], 0x03);
-			PPC_BCC_SHORT(COND_EQ, (ctx->idx * 4) + 12);
-			PPC_LI(b2p[BPF_REG_0], 0);
-			PPC_JMP(exit_addr);
+			tmp_idx = ctx->idx * 4;
 			/* load value from memory into TMP_REG_2 */
 			PPC_BPF_LWARX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1], 0);
 			/* add value from src_reg into this */
@@ -693,32 +690,16 @@ emit_clear:
 			/* store result back */
 			PPC_BPF_STWCX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1]);
 			/* we're done if this succeeded */
-			PPC_BCC_SHORT(COND_EQ, (ctx->idx * 4) + (7*4));
-			/* otherwise, let's try once more */
-			PPC_BPF_LWARX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1], 0);
-			PPC_ADD(b2p[TMP_REG_2], b2p[TMP_REG_2], src_reg);
-			PPC_BPF_STWCX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1]);
-			/* exit if the store was not successful */
-			PPC_LI(b2p[BPF_REG_0], 0);
-			PPC_BCC(COND_NE, exit_addr);
+			PPC_BCC_SHORT(COND_NE, tmp_idx);
 			break;
 		/* *(u64 *)(dst + off) += src */
 		case BPF_STX | BPF_XADD | BPF_DW:
 			PPC_ADDI(b2p[TMP_REG_1], dst_reg, off);
-			/* error if EA is not doubleword-aligned */
-			PPC_ANDI(b2p[TMP_REG_2], b2p[TMP_REG_1], 0x07);
-			PPC_BCC_SHORT(COND_EQ, (ctx->idx * 4) + (3*4));
-			PPC_LI(b2p[BPF_REG_0], 0);
-			PPC_JMP(exit_addr);
-			PPC_BPF_LDARX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1], 0);
-			PPC_ADD(b2p[TMP_REG_2], b2p[TMP_REG_2], src_reg);
-			PPC_BPF_STDCX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1]);
-			PPC_BCC_SHORT(COND_EQ, (ctx->idx * 4) + (7*4));
+			tmp_idx = ctx->idx * 4;
 			PPC_BPF_LDARX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1], 0);
 			PPC_ADD(b2p[TMP_REG_2], b2p[TMP_REG_2], src_reg);
 			PPC_BPF_STDCX(b2p[TMP_REG_2], 0, b2p[TMP_REG_1]);
-			PPC_LI(b2p[BPF_REG_0], 0);
-			PPC_BCC(COND_NE, exit_addr);
+			PPC_BCC_SHORT(COND_NE, tmp_idx);
 			break;
 
 		/*


