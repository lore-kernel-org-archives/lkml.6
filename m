Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F78C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C3420672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cii11l+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C3420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440877AbeKXEOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:14:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440864AbeKXEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:14:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so13037241wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vsz8kXb6CVVsBzyFCRZkaXVWSBUyNLZRbPvH2/3m1zI=;
        b=Cii11l+5xtXHlR9rXHCV63qwX5vwMHzHo8g/av47h2GbA8ZB0n8xnNUVYoZix5gzSL
         EzhMannNO+RLhXEirMVjjyRDZGZlauqrsA+zseqpgT/NgjAXE7IsHm8rOLtC0hJ5mLLI
         r94bw82iV4vBldk9UgMQWQN583nbS/ZvAkQCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vsz8kXb6CVVsBzyFCRZkaXVWSBUyNLZRbPvH2/3m1zI=;
        b=s//TnxzlFnhh2dTomw0s3HpN8A0MGHNXZvVMbTm9BErcHa4qWBAaJV5FqZBdaDaQIV
         /L0CjflYxZLZgkqeamNlyR3wstXpDjkyFYjRkWI2BJ6POf8cDRykyl15zsxqH1s+gyVa
         6ULKlp/MxYPpFCrNxSvAnnu43wfek0wU0V1r2gYg6qtukz30uc5jZpXh1fM8vdUaRY3/
         5ynmDXVVUw6XQ/fvBGLP0+vEg+50IViEjL9zGqcSwbIG6l/hjFoYwzZsSzIMHe8KMlIE
         I7uSPfT0iFUOJPng80W+oDMSKq2fBwicvefXi7XbkqXwmFJP6RGIYOK1bVXyU++kXTCP
         61Mw==
X-Gm-Message-State: AA+aEWbMqp17uwtXPbXMWXq+5pyBhjiKZH9krTBvLzzkNLQ9Itc4LQnE
        oPwKn2/OKxicsp8EUxni/Jwp5Zfxjvg=
X-Google-Smtp-Source: AFSGD/W8AV7FoFifqisBZaV4fzOZN1nhgsgcHa2BfC2aXU9iZ+TBe2vik5IRRlXpJVueQD3qTlyi5A==
X-Received: by 2002:adf:c6c3:: with SMTP id c3-v6mr14341030wrh.243.1542994153948;
        Fri, 23 Nov 2018 09:29:13 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:6913:f64b:5e59:5ba5])
        by smtp.gmail.com with ESMTPSA id 125sm5041606wml.35.2018.11.23.09.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 09:29:12 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        catalin.marinas@arm.com, ast@fb.com, daniel@iogearbox.net,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64/bpf: use movn/movk/movk sequence to generate kernel addresses
Date:   Fri, 23 Nov 2018 18:29:02 +0100
Message-Id: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, all executable code is guaranteed to reside in the vmalloc
space (or the module space), and so jump targets will only use 48
bits at most, and the remaining bits are guaranteed to be 0x1.

This means we can generate an immediate jump address using a sequence
of one MOVN (move wide negated) and two MOVK instructions, where the
first one sets the lower 16 bits but also sets all top bits to 0x1.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

I looked into using ADRP/ADD pairs, but this is very fiddly, since
it requires knowledge about where the ADRP instruction ends up in
memory. (ADRP produces a PC-relative address with bits [11:0] cleared,
and so in addition to the distance between the instruction and the
target, we also need to know their offsets modulo 4096 and I wasn't
sure whether the offsets are guaranteed to be relative to the start
of a page or not)

 arch/arm64/net/bpf_jit_comp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..3b4d2c6fc133 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -134,10 +134,9 @@ static inline void emit_a64_mov_i64(const int reg, const u64 val,
 }
 
 /*
- * This is an unoptimized 64 immediate emission used for BPF to BPF call
- * addresses. It will always do a full 64 bit decomposition as otherwise
- * more complexity in the last extra pass is required since we previously
- * reserved 4 instructions for the address.
+ * Kernel addresses in the vmalloc space use at most 48 bits, and the
+ * remaining bits are guaranteed to be 0x1. So we can compose the address
+ * with a fixed length movn/movk/movk sequence.
  */
 static inline void emit_addr_mov_i64(const int reg, const u64 val,
 				     struct jit_ctx *ctx)
@@ -145,8 +144,8 @@ static inline void emit_addr_mov_i64(const int reg, const u64 val,
 	u64 tmp = val;
 	int shift = 0;
 
-	emit(A64_MOVZ(1, reg, tmp & 0xffff, shift), ctx);
-	for (;shift < 48;) {
+	emit(A64_MOVN(1, reg, ~tmp & 0xffff, shift), ctx);
+	while (shift < 32) {
 		tmp >>= 16;
 		shift += 16;
 		emit(A64_MOVK(1, reg, tmp & 0xffff, shift), ctx);
@@ -627,10 +626,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		const u8 r0 = bpf2a64[BPF_REG_0];
 		const u64 func = (u64)__bpf_call_base + imm;
 
-		if (ctx->prog->is_func)
-			emit_addr_mov_i64(tmp, func, ctx);
-		else
-			emit_a64_mov_i64(tmp, func, ctx);
+		emit_addr_mov_i64(tmp, func, ctx);
 		emit(A64_BLR(tmp), ctx);
 		emit(A64_MOV(1, r0, A64_R(0)), ctx);
 		break;
-- 
2.19.1

