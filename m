Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37045C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A03213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KGd3tYzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBYMxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:53:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39420 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfBYMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NBP96MlGlKr2hnx+HM0NtMLBVYsDjUw9fzx338ZzwO0=; b=KGd3tYznUA+3P9zTGt5K9p1kor
        mKUYW0k2CjzMCrNCf6CK0uMOga8hUQB/ot0C/qvCL0z9/umrX7R22Wi26/RGjpYP0FeNXY59B5sEY
        hvbYz7xeTNCkcV0cDIIV7Fj71pfEsOBKgZSGYDQhYyTM9AXERHMG9LOtMZD0QkXn7rlUY4/fVBxfS
        gj2hZo1twlvwkYB5EFfJDAV3n5e0nzLZyTQPRB1Ne+vBITHaft+ZqaBSdAZsrGvpwo38m0BPcT31N
        swpjxWpfKsm4/iLIjQaub26WckL5jXykCzUhcjbOOxRQS5rf2tj4jCUCXuh/t+PVGuWCgnawbJH6V
        gujmL2mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyFkn-0006MU-W5; Mon, 25 Feb 2019 12:53:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AC109207B7F96; Mon, 25 Feb 2019 13:53:02 +0100 (CET)
Message-Id: <20190225125232.277640072@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 25 Feb 2019 13:43:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 6/6] objtool: Add Direction Flag validation
References: <20190225124330.613028745@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having DF escape is BAD(tm).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch.h            |    4 +++-
 tools/objtool/arch/x86/decode.c |    8 ++++++++
 tools/objtool/check.c           |   21 +++++++++++++++++++++
 tools/objtool/check.h           |    2 +-
 4 files changed, 33 insertions(+), 2 deletions(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -35,7 +35,9 @@
 #define INSN_NOP		10
 #define INSN_STAC		11
 #define INSN_CLAC		12
-#define INSN_OTHER		13
+#define INSN_STD		13
+#define INSN_CLD		14
+#define INSN_OTHER		15
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -456,6 +456,14 @@ int arch_decode_instruction(struct elf *
 		*type = INSN_CALL;
 		break;
 
+	case 0xfc:
+		*type = INSN_CLD;
+		break;
+
+	case 0xfd:
+		*type = INSN_STD;
+		break;
+
 	case 0xff:
 		if (modrm_reg == 2 || modrm_reg == 3)
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1950,6 +1950,9 @@ static int validate_branch(struct objtoo
 			if (state.uaccess)
 				WARN_FUNC("return with UACCESS enabled", sec, insn->offset);
 
+			if (state.df)
+				WARN_FUNC("return with DF set", sec, insn->offset);
+
 			if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
@@ -1971,6 +1974,10 @@ static int validate_branch(struct objtoo
 				WARN_FUNC("call to %s() with UACCESS enabled",
 					  sec, insn->offset, insn_dest_name(insn));
 			}
+			if (state.df) {
+				WARN_FUNC("call to %s() with DF set",
+					  sec, insn->offset, insn_dest_name(insn));
+			}
 
 			if (insn->type == INSN_CALL) {
 				if (is_fentry_call(insn))
@@ -2054,6 +2061,20 @@ static int validate_branch(struct objtoo
 			state.uaccess = false;
 			break;
 
+		case INSN_STD:
+			if (state.df)
+				WARN_FUNC("recursive STD", sec, insn->offset);
+
+			state.df = true;
+			break;
+
+		case INSN_CLD:
+			if (!state.df && insn->func)
+				WARN_FUNC("redundant CLD", sec, insn->offset);
+
+			state.df = false;
+			break;
+
 		default:
 			break;
 		}
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end, uaccess, uaccess_safe;
+	bool drap, end, uaccess, uaccess_safe, df;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };


