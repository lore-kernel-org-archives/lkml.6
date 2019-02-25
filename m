Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD052146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130122;
	bh=FRBkAyEGXQd8zE350xzeCZYOsP/7sQUcZqCfov/qF0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQwg2flYoRGGvGGzapb73M/MW/3Ytz/gn6yOijZfjy6QTqt9egHGOHuCfG+rbMoPj
	 my80t5DlrR2YtZkszEhrk4ikiIU06Un2e1xwoZ0W+zYi8STzJ/+QSIcya83PIOqfx7
	 VXE0no7z66LKphboHnMaGueH4/mOZU619gj+VQL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbfBYV2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbfBYV2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C38F20C01;
        Mon, 25 Feb 2019 21:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130113;
        bh=FRBkAyEGXQd8zE350xzeCZYOsP/7sQUcZqCfov/qF0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dx9maqFYevyCkQd2g10RKgdjNgMXmYZFc3qAsupPLQLoon8d6OtXJcpdbTqmVjqJI
         9942F/pw6WVCSlUEoxna2j5xoP4Mb/nSzz2oNODPiDxPr9nfpucG39N+dxZIn73gXf
         JYxcY1eOFXBBuBTTUsbFxgY0N3IQRcloNYEs4aGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.20 004/183] MIPS: eBPF: Always return sign extended 32b values
Date:   Mon, 25 Feb 2019 22:09:37 +0100
Message-Id: <20190225195055.405011105@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Paul Burton <paul.burton@mips.com>

commit 13443154f6cac61d148471ede6d7f1f6b5ea946a upstream.

The function prototype used to call JITed eBPF code (ie. the type of the
struct bpf_prog bpf_func field) returns an unsigned int. The MIPS n64
ABI that MIPS64 kernels target defines that 32 bit integers should
always be sign extended when passed in registers as either arguments or
return values.

This means that when returning any value which may not already be sign
extended (ie. of type REG_64BIT or REG_32BIT_ZERO_EX) we need to perform
that sign extension in order to comply with the n64 ABI. Without this we
see strange looking test failures from test_bpf.ko, such as:

  test_bpf: #65 ALU64_MOV_X:
    dst = 4294967295 jited:1 ret -1 != -1 FAIL (1 times)

Although the return value printed matches the expected value, this is
only because printf is only examining the least significant 32 bits of
the 64 bit register value we returned. The register holding the expected
value is sign extended whilst the v0 register was set to a zero extended
value by our JITed code, so when compared by a conditional branch
instruction the values are not equal.

We already handle this when the return value register is of type
REG_32BIT_ZERO_EX, so simply extend this to also cover REG_64BIT.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/net/ebpf_jit.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -343,12 +343,15 @@ static int build_int_epilogue(struct jit
 	const struct bpf_prog *prog = ctx->skf;
 	int stack_adjust = ctx->stack_size;
 	int store_offset = stack_adjust - 8;
+	enum reg_val_type td;
 	int r0 = MIPS_R_V0;
 
-	if (dest_reg == MIPS_R_RA &&
-	    get_reg_val_type(ctx, prog->len, BPF_REG_0) == REG_32BIT_ZERO_EX)
+	if (dest_reg == MIPS_R_RA) {
 		/* Don't let zero extended value escape. */
-		emit_instr(ctx, sll, r0, r0, 0);
+		td = get_reg_val_type(ctx, prog->len, BPF_REG_0);
+		if (td == REG_64BIT || td == REG_32BIT_ZERO_EX)
+			emit_instr(ctx, sll, r0, r0, 0);
+	}
 
 	if (ctx->flags & EBPF_SAVE_RA) {
 		emit_instr(ctx, ld, MIPS_R_RA, store_offset, MIPS_R_SP);


