Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6520841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB6520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbeHAUNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:13:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404312AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1D22101A;
        Wed,  1 Aug 2018 17:00:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 138/336] bpf: powerpc64: pad function address loads with NOPs
Date:   Wed,  1 Aug 2018 18:47:53 +0200
Message-Id: <20180801165034.415834354@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

[ Upstream commit 4ea69b2fd623dee2bbc77d3b6b7d8c0924e2026a ]

For multi-function programs, loading the address of a callee
function to a register requires emitting instructions whose
count varies from one to five depending on the nature of the
address.

Since we come to know of the callee's address only before the
extra pass, the number of instructions required to load this
address may vary from what was previously generated. This can
make the JITed image grow or shrink.

To avoid this, we should generate a constant five-instruction
when loading function addresses by padding the optimized load
sequence with NOPs.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp64.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -202,25 +202,37 @@ static void bpf_jit_build_epilogue(u32 *
 
 static void bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 func)
 {
+	unsigned int i, ctx_idx = ctx->idx;
+
+	/* Load function address into r12 */
+	PPC_LI64(12, func);
+
+	/* For bpf-to-bpf function calls, the callee's address is unknown
+	 * until the last extra pass. As seen above, we use PPC_LI64() to
+	 * load the callee's address, but this may optimize the number of
+	 * instructions required based on the nature of the address.
+	 *
+	 * Since we don't want the number of instructions emitted to change,
+	 * we pad the optimized PPC_LI64() call with NOPs to guarantee that
+	 * we always have a five-instruction sequence, which is the maximum
+	 * that PPC_LI64() can emit.
+	 */
+	for (i = ctx->idx - ctx_idx; i < 5; i++)
+		PPC_NOP();
+
 #ifdef PPC64_ELF_ABI_v1
-	/* func points to the function descriptor */
-	PPC_LI64(b2p[TMP_REG_2], func);
-	/* Load actual entry point from function descriptor */
-	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_2], 0);
-	/* ... and move it to LR */
-	PPC_MTLR(b2p[TMP_REG_1]);
 	/*
 	 * Load TOC from function descriptor at offset 8.
 	 * We can clobber r2 since we get called through a
 	 * function pointer (so caller will save/restore r2)
 	 * and since we don't use a TOC ourself.
 	 */
-	PPC_BPF_LL(2, b2p[TMP_REG_2], 8);
-#else
-	/* We can clobber r12 */
-	PPC_FUNC_ADDR(12, func);
-	PPC_MTLR(12);
+	PPC_BPF_LL(2, 12, 8);
+	/* Load actual entry point from function descriptor */
+	PPC_BPF_LL(12, 12, 0);
 #endif
+
+	PPC_MTLR(12);
 	PPC_BLRL();
 }
 


