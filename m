Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7161CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D5E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763221;
	bh=p9iYTQIm+ByiBAc63LlyPyPIGkcUuexu9C4liW3wOrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGyONad9eoeXfTqmZuTTK/RHEfveg17J3/SkjVOmaxGmcnSPJPRlXuR1R0enF8t/+
	 x/XamNsaQeAMKKMbjkv22/JPULB9HC740X2o3r2wSPGMaZEoo1IqA9/U+poVyQKzN/
	 IKA3bBxWC8jHPZi4sfKqoI4rCpXi637gKPu31Svc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfA2MAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbfA2Lq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D5FC21852;
        Tue, 29 Jan 2019 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762388;
        bh=p9iYTQIm+ByiBAc63LlyPyPIGkcUuexu9C4liW3wOrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDMu1IVjMqrjrLcMZ7mVsMTwWlkpFLQiP0CfUmtV55Fl22fVua8pQWiFnBYYJcTGv
         lPnIFvJevj/eMAV4IpNe/WJlSED4gNmwH+hPSTMuCsNpBenT+KSk8XI+JcvH9jt+6H
         IjGGkR/lgMg6oDZP7xyMti2ZP2RxzIojWV8SwSxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 090/103] bpf: enable access to ax register also from verifier rewrite
Date:   Tue, 29 Jan 2019 12:36:07 +0100
Message-Id: <20190129113206.944105287@linuxfoundation.org>
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

[ commit 9b73bfdd08e73231d6a90ae6db4b46b3fbf56c30 upstream ]

Right now we are using BPF ax register in JIT for constant blinding as
well as in interpreter as temporary variable. Verifier will not be able
to use it simply because its use will get overridden from the former in
bpf_jit_blind_insn(). However, it can be made to work in that blinding
will be skipped if there is prior use in either source or destination
register on the instruction. Taking constraints of ax into account, the
verifier is then open to use it in rewrites under some constraints. Note,
ax register already has mappings in every eBPF JIT.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h |  7 +------
 kernel/bpf/core.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 81420a0efdbe..1a39d57eb88f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -53,12 +53,7 @@ struct sock_reuseport;
 #define BPF_REG_D	BPF_REG_8	/* data, callee-saved */
 #define BPF_REG_H	BPF_REG_9	/* hlen, callee-saved */
 
-/* Kernel hidden auxiliary/helper register for hardening step.
- * Only used by eBPF JITs. It's nothing more than a temporary
- * register that JITs use internally, only that here it's part
- * of eBPF instructions that have been rewritten for blinding
- * constants. See JIT pre-step in bpf_jit_blind_constants().
- */
+/* Kernel hidden auxiliary/helper register. */
 #define BPF_REG_AX		MAX_BPF_REG
 #define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
 #define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index aefc62ae4a1e..474525e3a9db 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -643,6 +643,26 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 	BUILD_BUG_ON(BPF_REG_AX  + 1 != MAX_BPF_JIT_REG);
 	BUILD_BUG_ON(MAX_BPF_REG + 1 != MAX_BPF_JIT_REG);
 
+	/* Constraints on AX register:
+	 *
+	 * AX register is inaccessible from user space. It is mapped in
+	 * all JITs, and used here for constant blinding rewrites. It is
+	 * typically "stateless" meaning its contents are only valid within
+	 * the executed instruction, but not across several instructions.
+	 * There are a few exceptions however which are further detailed
+	 * below.
+	 *
+	 * Constant blinding is only used by JITs, not in the interpreter.
+	 * The interpreter uses AX in some occasions as a local temporary
+	 * register e.g. in DIV or MOD instructions.
+	 *
+	 * In restricted circumstances, the verifier can also use the AX
+	 * register for rewrites as long as they do not interfere with
+	 * the above cases!
+	 */
+	if (from->dst_reg == BPF_REG_AX || from->src_reg == BPF_REG_AX)
+		goto out;
+
 	if (from->imm == 0 &&
 	    (from->code == (BPF_ALU   | BPF_MOV | BPF_K) ||
 	     from->code == (BPF_ALU64 | BPF_MOV | BPF_K))) {
-- 
2.19.1



