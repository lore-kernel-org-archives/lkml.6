Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD39C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517A320880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763213;
	bh=FhO8a7yFAyukCJ7Fqa6fZ4EeSBX3y53BpJOK20fg6+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJ+A4AdfgOC6dtOTdXjrF2WaRc6crDbJwhO5oN/cEC0AgBw87f8+7Iv92O2+vCMcT
	 IQyW8JW/StxJykEEirvz0ZXTVVl30tBDZO1ekx52aAybmKuGSAq2e8d2YOMqNJ2BuC
	 ZGv9Ixm9BR9rWIVdTSsrFhBJ2dvfernMsyD9iATU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfA2MAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbfA2Lqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0E42083B;
        Tue, 29 Jan 2019 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762396;
        bh=FhO8a7yFAyukCJ7Fqa6fZ4EeSBX3y53BpJOK20fg6+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNiz7hoR/ZK2+E0n5UMAcw23KUie6LANwHXDePP9SmvlNm6IwxLDWKdH0JrABcNN0
         zceRoznoPDmqly0/UwLVrbAXKEkJyLO47rYskZAhrEIXagHgktZWG/qjcQRwxyy7k9
         yKtF28iCvcsbb+MplckFvz3H61tu9ka7Nt0I+D14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/103] bpf: restrict unknown scalars of mixed signed bounds for unprivileged
Date:   Tue, 29 Jan 2019 12:36:10 +0100
Message-Id: <20190129113207.112130352@linuxfoundation.org>
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

[ commit 9d7eceede769f90b66cfa06ad5b357140d5141ed upstream ]

For unknown scalars of mixed signed bounds, meaning their smin_value is
negative and their smax_value is positive, we need to reject arithmetic
with pointer to map value. For unprivileged the goal is to mask every
map pointer arithmetic and this cannot reliably be done when it is
unknown at verification time whether the scalar value is negative or
positive. Given this is a corner case, the likelihood of breaking should
be very small.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aa2944d54e7a..fbaa3b9e1d71 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2712,8 +2712,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
 	u64 umin_val = off_reg->umin_value, umax_val = off_reg->umax_value,
 	    umin_ptr = ptr_reg->umin_value, umax_ptr = ptr_reg->umax_value;
+	u32 dst = insn->dst_reg, src = insn->src_reg;
 	u8 opcode = BPF_OP(insn->code);
-	u32 dst = insn->dst_reg;
 
 	dst_reg = &regs[dst];
 
@@ -2749,6 +2749,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst);
 		return -EACCES;
 	}
+	if (ptr_reg->type == PTR_TO_MAP_VALUE &&
+	    !env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
+		verbose(env, "R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
+			off_reg == dst_reg ? dst : src);
+		return -EACCES;
+	}
 
 	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
 	 * The id may be overwritten later if we create a new variable offset.
-- 
2.19.1



