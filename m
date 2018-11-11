Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC7DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F3B20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="szhGnv44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F3B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeKLJZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388309AbeKLIUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:05 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DAB92241B;
        Sun, 11 Nov 2018 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975409;
        bh=8n/RxwtyYATdZyKOrp6BhPk7hd8WvhbgIR1YzNIGBgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szhGnv44WR/RD5yZspto/qTcL2RDGZGArpXW5xQjkCLtq57a92IeVM80A+Cvpp7CU
         +bUh3QpyfTj9mRLXlE3UZqz8QfC7drpxVsK8kTsGMC4MkgW2M/qrv2nvO7y1A7fwgq
         R+jb/hwqGKbiaqFeCEFJmBTv6HcT3EH/5soY8J7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 117/350] bpf/verifier: fix verifier instability
Date:   Sun, 11 Nov 2018 14:19:41 -0800
Message-Id: <20181111221712.012812958@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -553,7 +553,9 @@ static void __mark_reg_not_init(struct b
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
@@ -572,7 +574,6 @@ static void __mark_reg_known_zero(struct
 static void __mark_reg_const_zero(struct bpf_reg_state *reg)
 {
 	__mark_reg_known(reg, 0);
-	reg->off = 0;
 	reg->type = SCALAR_VALUE;
 }
 
@@ -683,9 +684,12 @@ static void __mark_reg_unbounded(struct
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
@@ -1726,9 +1730,6 @@ static int check_mem_access(struct bpf_v
 			else
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-			regs[value_regno].id = 0;
-			regs[value_regno].off = 0;
-			regs[value_regno].range = 0;
 			regs[value_regno].type = reg_type;
 		}
 
@@ -2549,7 +2550,6 @@ static int check_helper_call(struct bpf_
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].off = 0;
 		/* remember map_ptr, so that check_map_access()
 		 * can check 'value_size' boundary of memory access
 		 * to map element returned from bpf_map_lookup_elem()


