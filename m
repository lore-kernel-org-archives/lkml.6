Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA15C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E299F20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763519;
	bh=Fqgs80eSr6RF928HjQpJUxqvFIR+xDsu1GmPY3DrYrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMmeqBF55Hl+oHBtAQLLFrjGhEzv+0UzhQ7JMYXVhYLEcH6riXiIMMGaosNsZbWhp
	 9Y+IA8juPz3IKLF8vmg9JZc/AzoEPSSFtyfekYWoDeRYUB3JrCKG3TGCrtHvAHvsqo
	 C+g2QBWF0myvNgX3aDR9XHRtcIxSlb+yQh491s64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfA2LmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfA2LmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F8720856;
        Tue, 29 Jan 2019 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762131;
        bh=Fqgs80eSr6RF928HjQpJUxqvFIR+xDsu1GmPY3DrYrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sh4F0pZO8wa52MolCOkNpPHgM+z+rIkklzQjJDNSnvBzT0LoHw9YamEZJ9X5296wJ
         JqFOIHk1wIc+N3RsF2d/4EJzTLl/O229M/tOFISExBf4qbuHxDYSJdrsHJsUqm4MNo
         PH+yEc9n/rjBVfDMRMhYY0nxSSu2RS2WGTha4y80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 101/117] bpf: restrict unknown scalars of mixed signed bounds for unprivileged
Date:   Tue, 29 Jan 2019 12:35:52 +0100
Message-Id: <20190129113212.414924803@linuxfoundation.org>
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
 kernel/bpf/verifier.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dc9c57f1a153..8e90e795ca68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2997,8 +2997,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
 	u64 umin_val = off_reg->umin_value, umax_val = off_reg->umax_value,
 	    umin_ptr = ptr_reg->umin_value, umax_ptr = ptr_reg->umax_value;
+	u32 dst = insn->dst_reg, src = insn->src_reg;
 	u8 opcode = BPF_OP(insn->code);
-	u32 dst = insn->dst_reg;
 
 	dst_reg = &regs[dst];
 
@@ -3031,6 +3031,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str[ptr_reg->type]);
 		return -EACCES;
+	case PTR_TO_MAP_VALUE:
+		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
+			verbose(env, "R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
+				off_reg == dst_reg ? dst : src);
+			return -EACCES;
+		}
+		/* fall-through */
 	default:
 		break;
 	}
-- 
2.19.1



