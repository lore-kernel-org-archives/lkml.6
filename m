Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D5B214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789766;
	bh=m+zIM6n1rDG23MPrC6DN9I4eVhYA1RjTvNailiUXD/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvrHpwZoFI2q0kbguhtJdkVoj+1sDrNTzPHCUqnkKExyyEs5OBEetptgrM3yjoG1A
	 P4CpflgusRPCmapff14i3Noe1tli0V+JY1xmQbqEGR4jaweF3GKL28Z4rvfuSUpTS9
	 QhD9sHLuE/jtciGN/2QTBO7StvnU2/1bVqZ748Fs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D5B214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbeLNMQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732649AbeLNMPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B232133F;
        Fri, 14 Dec 2018 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789753;
        bh=m+zIM6n1rDG23MPrC6DN9I4eVhYA1RjTvNailiUXD/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLMBtZXJA0KC7s21Il/cr5fgnD3QD4ifNU8vLiMaiGz5XW67snL7rUi6VLtge5bda
         0Dt8A/nfiAco7cdaPkJ+qpIRvC+lJA68eNwB3R0glE98A2zwNkddOVrm4ocKSeozCl
         pNC/+vnLFbaS+rl/vV5nOiqAWqE6gQ9SOjTD3HDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 64/88] bpf/verifier: Pass instruction index to check_mem_access() and check_xadd()
Date:   Fri, 14 Dec 2018 13:00:38 +0100
Message-Id: <20181214115707.623225928@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Extracted from commit 31fd85816dbe "bpf: permits narrower load from
bpf program context fields".

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -694,7 +694,7 @@ static bool is_ctx_reg(struct verifier_e
  * if t==write && value_regno==-1, some unknown value is stored into memory
  * if t==read && value_regno==-1, don't care what we read from memory
  */
-static int check_mem_access(struct verifier_env *env, u32 regno, int off,
+static int check_mem_access(struct verifier_env *env, int insn_idx, u32 regno, int off,
 			    int bpf_size, enum bpf_access_type t,
 			    int value_regno)
 {
@@ -758,7 +758,7 @@ static int check_mem_access(struct verif
 	return err;
 }
 
-static int check_xadd(struct verifier_env *env, struct bpf_insn *insn)
+static int check_xadd(struct verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
 	struct reg_state *regs = env->cur_state.regs;
 	int err;
@@ -791,13 +791,13 @@ static int check_xadd(struct verifier_en
 	}
 
 	/* check whether atomic_add can read the memory */
-	err = check_mem_access(env, insn->dst_reg, insn->off,
+	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1);
 	if (err)
 		return err;
 
 	/* check whether atomic_add can write into the same memory */
-	return check_mem_access(env, insn->dst_reg, insn->off,
+	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 				BPF_SIZE(insn->code), BPF_WRITE, -1);
 }
 
@@ -1836,7 +1836,7 @@ static int do_check(struct verifier_env
 			/* check that memory (src_reg + off) is readable,
 			 * the state of dst_reg will be updated by this func
 			 */
-			err = check_mem_access(env, insn->src_reg, insn->off,
+			err = check_mem_access(env, insn_idx, insn->src_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_READ,
 					       insn->dst_reg);
 			if (err)
@@ -1875,7 +1875,7 @@ static int do_check(struct verifier_env
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_XADD) {
-				err = check_xadd(env, insn);
+				err = check_xadd(env, insn_idx, insn);
 				if (err)
 					return err;
 				insn_idx++;
@@ -1894,7 +1894,7 @@ static int do_check(struct verifier_env
 			dst_reg_type = regs[insn->dst_reg].type;
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn->dst_reg, insn->off,
+			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_WRITE,
 					       insn->src_reg);
 			if (err)
@@ -1929,7 +1929,7 @@ static int do_check(struct verifier_env
 			}
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn->dst_reg, insn->off,
+			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_WRITE,
 					       -1);
 			if (err)


