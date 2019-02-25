Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF372173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129441;
	bh=oxHi62vcc5eRpEsbEBTfnyakjwZO3GarMPpc5/v+1iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u1+BwKpvoyt9CsgrAEShpCG2NWgt1JT8v8ixh1Lu0uuWtS9rd+5hNUpIqeBrHJbCQ
	 UEWiqga+7WasrJ+w5t3QlnozunKi/OL5FhATAwceEXdZ/KSXsWv0k32OFrvSScHbz3
	 ZcVwI8lrnTSrIqevVMWYh7nys0iBLEVuD3DdIA6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfBYVRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:17:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbfBYVRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:17:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF412147C;
        Mon, 25 Feb 2019 21:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129435;
        bh=oxHi62vcc5eRpEsbEBTfnyakjwZO3GarMPpc5/v+1iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zD2HH8GfekLJVZpa+J0w7Rxh35bHFNY+R1A/lT/FywE/5gnMz6kQO/8KxiRSFIUHP
         fLxwVA92Plyu+9sCvT9nxT0fdbG5cec+2aNJh1DjwHXaV6QDyNvHJb/g8HFJIpiNQb
         zUic6+/nysG1+v4xeoxk+Q85f0iKTPZracx5gCz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.14 03/71] MIPS: eBPF: Always return sign extended 32b values
Date:   Mon, 25 Feb 2019 22:11:05 +0100
Message-Id: <20190225195034.822431691@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -348,12 +348,15 @@ static int build_int_epilogue(struct jit
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


