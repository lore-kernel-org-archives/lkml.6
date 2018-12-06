Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2507C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D1C20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107931;
	bh=sJz/RWqnB9EtBpGchCNI1N7NyEqQIrnP5+XTOUyQNow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q957lOd4BdyohyTdHEDSP6ldUWiGr8aIOkBW9tOSFmma0fhma1DUv8VabWzB+fwxM
	 rZYYoJo4AVzfdvHwM2O/EDVUSUDRhC5TcxD0E+2OzagVFTNOquZulWxD5R/PV4Dhlz
	 qrmYlkEqBRRofy0il4aI2DxEACf42C81uC7kHr+c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D1C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLFOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbeLFOqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ACE620661;
        Thu,  6 Dec 2018 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107579;
        bh=sJz/RWqnB9EtBpGchCNI1N7NyEqQIrnP5+XTOUyQNow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qazl+xnvB5BwuX9Z41nK1PX8WvR/0Eqr2ppx+zeD7TzqjDh5I0bpfi8Atu5UPmje7
         io/Pz09NbrvvAM6LrAvfnrTSKckIOK33VUx7B3iZoxPsbdR3MBNqaDlfcgB2zvNySm
         sqSvL0owv6cqujpgxco16QepMvALjpJrhN4zWi4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 059/101] bpf/verifier: Pass instruction index to check_mem_access() and check_xadd()
Date:   Thu,  6 Dec 2018 15:38:58 +0100
Message-Id: <20181206143015.012735080@linuxfoundation.org>
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Extracted from commit 31fd85816dbe "bpf: permits narrower load from
bpf program context fields".

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -745,7 +745,7 @@ static int check_ptr_alignment(struct bp
  * if t==write && value_regno==-1, some unknown value is stored into memory
  * if t==read && value_regno==-1, don't care what we read from memory
  */
-static int check_mem_access(struct bpf_verifier_env *env, u32 regno, int off,
+static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regno, int off,
 			    int bpf_size, enum bpf_access_type t,
 			    int value_regno)
 {
@@ -875,7 +875,7 @@ static int check_mem_access(struct bpf_v
 	return err;
 }
 
-static int check_xadd(struct bpf_verifier_env *env, struct bpf_insn *insn)
+static int check_xadd(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
 	struct bpf_reg_state *regs = env->cur_state.regs;
 	int err;
@@ -908,13 +908,13 @@ static int check_xadd(struct bpf_verifie
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
 
@@ -1270,7 +1270,7 @@ static int check_call(struct bpf_verifie
 	 * is inferred from register state.
 	 */
 	for (i = 0; i < meta.access_size; i++) {
-		err = check_mem_access(env, meta.regno, i, BPF_B, BPF_WRITE, -1);
+		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B, BPF_WRITE, -1);
 		if (err)
 			return err;
 	}
@@ -2936,7 +2936,7 @@ static int do_check(struct bpf_verifier_
 			/* check that memory (src_reg + off) is readable,
 			 * the state of dst_reg will be updated by this func
 			 */
-			err = check_mem_access(env, insn->src_reg, insn->off,
+			err = check_mem_access(env, insn_idx, insn->src_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_READ,
 					       insn->dst_reg);
 			if (err)
@@ -2976,7 +2976,7 @@ static int do_check(struct bpf_verifier_
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_XADD) {
-				err = check_xadd(env, insn);
+				err = check_xadd(env, insn_idx, insn);
 				if (err)
 					return err;
 				insn_idx++;
@@ -2995,7 +2995,7 @@ static int do_check(struct bpf_verifier_
 			dst_reg_type = regs[insn->dst_reg].type;
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn->dst_reg, insn->off,
+			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_WRITE,
 					       insn->src_reg);
 			if (err)
@@ -3030,7 +3030,7 @@ static int do_check(struct bpf_verifier_
 			}
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn->dst_reg, insn->off,
+			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_WRITE,
 					       -1);
 			if (err)


