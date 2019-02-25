Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0646D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qFHtWjQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBYNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:21:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfBYNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LSaiudI9zMFRYwqyfTbYs2Hi81Jc0hIhsm+H3pY+7wo=; b=qFHtWjQrZ76I+mb73nV4DaXMpe
        kpqeHQf6WNXzN2/D1mA6BLaQzvP/e2uZ+fbDeN+He7i5N+ayTQVFjmN5CGFXoWWFmwBWyJ8Ig5d95
        qYbKp7Sgzr8LXwo0M8aiex4QNZBCxk3CWk8LL3TMlZ4UqbCx8VdcuTmd/xuRATr7Hr6dqZo2BhJ9x
        I+23UHAH8kBh247CUF2iLwjSPpnvj7EENTmjstQNTuvRWqQus2CiRNHiFveummIQy7h3AboXBfB5+
        de8HsdoictYy/xzC6uZExvp1scl74cemdd2JJbTbAK0/U/+PP+wtNFLxT12AxaBp7n9oJyJpnKeQ8
        kYItUXWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyGBu-0001wS-DG; Mon, 25 Feb 2019 13:21:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A112F236F9A0D; Mon, 25 Feb 2019 14:21:03 +0100 (CET)
Date:   Mon, 25 Feb 2019 14:21:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190225132103.GD32494@hirez.programming.kicks-ass.net>
References: <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com>
 <20190223083942.GF32477@hirez.programming.kicks-ass.net>
 <15DE0017-9AE5-4E7A-96CD-E5E9F5B72516@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15DE0017-9AE5-4E7A-96CD-E5E9F5B72516@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:47:00AM -0800, hpa@zytor.com wrote:
> It doesn't have to understand the contents of the memop, but it seems
> that the presence of a modrm with mode ≠ 3 should be plenty. It needs
> to know that much in order to know the length of instructions anyway.
> For extra credit, ignore LEA or hinting instructions.

A little something like so then?

arch/x86/kernel/fpu/signal.o: warning: objtool: .altinstr_replacement+0x9c: UACCESS disable without MEMOPs: copy_fpstate_to_sigframe()

00000000023c  000200000002 R_X86_64_PC32     0000000000000000 .text + 604
000000000240  000700000002 R_X86_64_PC32     0000000000000000 .altinstr_replacement + 99
000000000249  000200000002 R_X86_64_PC32     0000000000000000 .text + 610
00000000024d  000700000002 R_X86_64_PC32     0000000000000000 .altinstr_replacement + 9c

.text

604:   90                      nop
605:   90                      nop
606:   90                      nop
607:   83 ce 03                or     $0x3,%esi
60a:   89 b3 00 02 00 00       mov    %esi,0x200(%rbx)
610:   90                      nop
611:   90                      nop
612:   90                      nop

.altinstr_replacement

99:   0f 01 cb                stac
9c:   0f 01 ca                clac

Which looks like the tool failed to recognise that MOV as a memop.



---
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -37,7 +37,8 @@
 #define INSN_CLAC		12
 #define INSN_STD		13
 #define INSN_CLD		14
-#define INSN_OTHER		15
+#define INSN_MEMOP		15
+#define INSN_OTHER		16
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -123,6 +123,9 @@ int arch_decode_instruction(struct elf *
 		modrm_mod = X86_MODRM_MOD(modrm);
 		modrm_reg = X86_MODRM_REG(modrm);
 		modrm_rm = X86_MODRM_RM(modrm);
+
+		if (modrm_mod != 3)
+			*type = INSN_MEMOP;
 	}
 
 	if (insn.sib.nbytes)
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2047,6 +2047,7 @@ static int validate_branch(struct objtoo
 				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
 
 			state.uaccess = true;
+			state.memop = false;
 			break;
 
 		case INSN_CLAC:
@@ -2058,6 +2059,9 @@ static int validate_branch(struct objtoo
 				break;
 			}
 
+			if (!state.memop && insn->func)
+				WARN_FUNC("UACCESS disable without MEMOPs: %s()", sec, insn->offset, insn->func->name);
+
 			state.uaccess = false;
 			break;
 
@@ -2075,6 +2079,10 @@ static int validate_branch(struct objtoo
 			state.df = false;
 			break;
 
+		case INSN_MEMOP:
+			state.memop = true;
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
-	bool drap, end, uaccess, uaccess_safe, df;
+	bool drap, end, uaccess, uaccess_safe, df, memop;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
