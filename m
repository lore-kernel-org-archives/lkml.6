Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F78ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7FE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTURQcqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7FE20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeKAII7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbeKAII5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B002085A;
        Wed, 31 Oct 2018 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027325;
        bh=BrQPcVoAHCI6jQ0h5msgKcwzkfTyzK1W/QwvYH/d7qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTURQcqVOkvQ5p1Tp/Q9OmNFgN7Asr0sO0IhDUudfXMeEKNYli+njU7g5yncbxz/t
         HTrphXF9eGEF99sKaAgGEbN5YCZqQXE0H7NzKfETyzuqF8TX9ircQHvohupl+pJWo4
         y+Bh44QGe+2Su6ec99lX1weNxZYd4fMLeSzJmn2c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 056/126] bpf/verifier: fix verifier instability
Date:   Wed, 31 Oct 2018 19:06:44 -0400
Message-Id: <20181031230754.29029-56-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit a9c676bc8fc58d00eea9836fb14ee43c0346416a ]

Edward Cree says:
In check_mem_access(), for the PTR_TO_CTX case, after check_ctx_access()
has supplied a reg_type, the other members of the register state are set
appropriately.  Previously reg.range was set to 0, but as it is in a
union with reg.map_ptr, which is larger, upper bytes of the latter were
left in place.  This then caused the memcmp() in regsafe() to fail,
preventing some branches from being pruned (and occasionally causing the
same program to take a varying number of processed insns on repeated
verifier runs).

Fix the instability by clearing bpf_reg_state in __mark_reg_[un]known()

Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
Debugged-by: Edward Cree <ecree@solarflare.com>
Acked-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 82e8edef6ea0..b594d630f8ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -553,7 +553,9 @@ static void __mark_reg_not_init(struct bpf_reg_state *reg);
  */
 static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
-	reg->id = 0;
+	/* Clear id, off, and union(map_ptr, range) */
+	memset(((u8 *)reg) + sizeof(reg->type), 0,
+	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->var_off = tnum_const(imm);
 	reg->smin_value = (s64)imm;
 	reg->smax_value = (s64)imm;
@@ -572,7 +574,6 @@ static void __mark_reg_known_zero(struct bpf_reg_state *reg)
 static void __mark_reg_const_zero(struct bpf_reg_state *reg)
 {
 	__mark_reg_known(reg, 0);
-	reg->off = 0;
 	reg->type = SCALAR_VALUE;
 }
 
@@ -683,9 +684,12 @@ static void __mark_reg_unbounded(struct bpf_reg_state *reg)
 /* Mark a register as having a completely unknown (scalar) value. */
 static void __mark_reg_unknown(struct bpf_reg_state *reg)
 {
+	/*
+	 * Clear type, id, off, and union(map_ptr, range) and
+	 * padding between 'type' and union
+	 */
+	memset(reg, 0, offsetof(struct bpf_reg_state, var_off));
 	reg->type = SCALAR_VALUE;
-	reg->id = 0;
-	reg->off = 0;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
 	__mark_reg_unbounded(reg);
@@ -1726,9 +1730,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			else
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-			regs[value_regno].id = 0;
-			regs[value_regno].off = 0;
-			regs[value_regno].range = 0;
 			regs[value_regno].type = reg_type;
 		}
 
@@ -2549,7 +2550,6 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].off = 0;
 		/* remember map_ptr, so that check_map_access()
 		 * can check 'value_size' boundary of memory access
 		 * to map element returned from bpf_map_lookup_elem()
-- 
2.17.1

