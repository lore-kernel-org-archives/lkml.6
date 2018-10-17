Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11821ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A8B2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="f3OBfn8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A8B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJRGbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:37 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:37565 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:36 -0400
Received: by mail-ed1-f47.google.com with SMTP id c22-v6so26419240edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7z7LzsR2mZsPPTQc2Z66Mq9s2zCB6BAtS3pNMOHEgU=;
        b=f3OBfn8WbCwU+IeGCvP+4CsQBv2gyJuaaKWRH7sBIRlo+hwdWcZLp0OzM0aMnLFBmi
         x1T3h+ZvgzX3j1QewT5p3BJWcbeURXGRwHrjk3mWt0KNuyCCvGajuutbRLgrOFecseNQ
         BbtFjFIvzUCMwwnlPtoc+BnfX/cZEtsH0NZq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7z7LzsR2mZsPPTQc2Z66Mq9s2zCB6BAtS3pNMOHEgU=;
        b=Un4SRuPUlIUr30j9zCWNU3gbBRWJnkGyZqC/Kg8WHwP8PKlXZ3zfTY8cCRbBLhqo28
         xOGicZKXWFXTqWD6Pg9K7akl2IzeMiBPXv2VYa6pnnBGRlPWTqWx+MR8+rSsPDA1PlkP
         zbUzbpylq5g/3P/3ymKkoMxyGq/mM+2mpFKzM73aMs4WHocNAojfAoRP+z+IIXtaFpFI
         Jr3hkQ3MnD5KrsULgAueNLcB4KY09rnUa6V5QB3YL6hCEo0DwC/AIJEfdgDLXudsrF/X
         wW41YKCXX1Qaq/usx7Un4cCzfSmvwXFdF7tBmB+6yr7Rv43E3ZatB5bdfIcayLRS0Tzg
         xUag==
X-Gm-Message-State: ABuFfohrqqy9b5azRwF2bGiEu7iPL1EnJjIcEtChGgGZ/Ny4r9maJkiD
        zn/HvehBy5HDabNBBo1PV05akh75nes=
X-Google-Smtp-Source: ACcGV607kw5ERH64s+j/NKCZOdRlcV7m5x41F7BECrAkTQtoklTBoMK4ggabhIZjFvImbW3Vpaw/wg==
X-Received: by 2002:a17:906:5808:: with SMTP id m8-v6mr28009716ejq.20.1539815625800;
        Wed, 17 Oct 2018 15:33:45 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 07/12] x86-64: rai: implement _rai_load
Date:   Thu, 18 Oct 2018 00:33:27 +0200
Message-Id: <20181017223332.11964-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the simplest of the rai_* operations, loading a
value. For load of an 8-byte value, I believe we do need to keep room
for a movabs, since there's no guarantee the final value can be loaded
with as an imm32 or using a %rip-relative leaq.

It wouldn't hurt to add some sanity checking in rai_patch_one, e.g. at
least check that the immediate we are replacing is the dummy 0x12345678
we used in the .rai_templ section.

That the patching works can be seen in a quick virtme session.  gdb on
vmlinux and /proc/kcore shows

(gdb) x/16i rai_proc_show
   0xffffffff8108c120 <rai_proc_show>:  mov    $0xffffffff81fd9ad4,%rsi
   0xffffffff8108c127 <rai_proc_show+7>:        jmpq   0xffffffff819652e9
   0xffffffff8108c12c <rai_proc_show+12>:       nop
   0xffffffff8108c12d <rai_proc_show+13>:       nop
   0xffffffff8108c12e <rai_proc_show+14>:       nop
   0xffffffff8108c12f <rai_proc_show+15>:       nop
   0xffffffff8108c130 <rai_proc_show+16>:       nop
   0xffffffff8108c131 <rai_proc_show+17>:       jmpq   0xffffffff819652f5
   0xffffffff8108c136 <rai_proc_show+22>:       jmpq   0xffffffff81965300
   0xffffffff8108c13b <rai_proc_show+27>:       callq  0xffffffff81238bb0 <seq_printf>
   0xffffffff8108c140 <rai_proc_show+32>:       mov    $0xffffffffffffffff,%rax
   0xffffffff8108c147 <rai_proc_show+39>:       mov    %rax,0x17b228a(%rip)        # 0xffffffff8283e3d8 <three>
   0xffffffff8108c14e <rai_proc_show+46>:       mov    %eax,0x17b228c(%rip)        # 0xffffffff8283e3e0 <two>
   0xffffffff8108c154 <rai_proc_show+52>:       mov    %eax,0x17b228a(%rip)        # 0xffffffff8283e3e4 <one>
   0xffffffff8108c15a <rai_proc_show+58>:       xor    %eax,%eax
   0xffffffff8108c15c <rai_proc_show+60>:       retq
(gdb) x/16i 0xffffffff96e8c120
   0xffffffff96e8c120:  mov    $0xffffffff97dd9ad4,%rsi
   0xffffffff96e8c127:  movabs $0x3,%r8
   0xffffffff96e8c131:  mov    $0x2,%ecx
   0xffffffff96e8c136:  mov    $0x1,%edx
   0xffffffff96e8c13b:  callq  0xffffffff97038bb0
   0xffffffff96e8c140:  mov    $0xffffffffffffffff,%rax
   0xffffffff96e8c147:  mov    %rax,0x17b228a(%rip)        # 0xffffffff9863e3d8
   0xffffffff96e8c14e:  mov    %eax,0x17b228c(%rip)        # 0xffffffff9863e3e0
   0xffffffff96e8c154:  mov    %eax,0x17b228a(%rip)        # 0xffffffff9863e3e4
   0xffffffff96e8c15a:  xor    %eax,%eax
   0xffffffff96e8c15c:  retq
   0xffffffff96e8c15d:  nopl   (%rax)
   0xffffffff96e8c160:  push   %rbx
   0xffffffff96e8c161:  mov    $0xffffffff9804c240,%rdi
   0xffffffff96e8c168:  mov    $0xffffffff97e9fccc,%rbx
   0xffffffff96e8c16f:  callq  0xffffffff9776b230

where we also see that gcc chooses the destination registers rather
intelligently. As expected, repeated "cat /proc/rai" continues to print
"one: 1, two: 2, three: 3".

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/rai.S | 42 +++++++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/rai.h | 30 ++++++++++++++++++++++++++-
 arch/x86/kernel/rai.c      | 18 ++++++++++++++++
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/rai.S b/arch/x86/include/asm/rai.S
index 253d27453416..f42cdd8db876 100644
--- a/arch/x86/include/asm/rai.S
+++ b/arch/x86/include/asm/rai.S
@@ -8,11 +8,51 @@
 	.long \templ_end - \templ
 	.long \thunk - .
 .endm
-	
+
 .macro rai_entry_pad start end
 	.ifgt STRUCT_RAI_ENTRY_SIZE-(\end-\start)
 	.skip STRUCT_RAI_ENTRY_SIZE-(\end-\start), 0x00
 	.endif
 .endm
 
+.macro rai_load dst, var, type
+	.pushsection .rai_templ, "aw"
+10:
+	.ifeq \type - RAI_LOAD_8
+	movabs $0x1234567812345678, \dst
+	.else
+	mov $0x12345678, \dst
+	.endif
+11:
+	.popsection
+
+	/* Even if the mov \var, \dst is short enough to fit in the
+	 * space we reserve in .text, we still need the thunk for when
+	 * we do the immediate patching. */
+	.pushsection .text.rai_thunk, "ax"
+20:
+	mov \var(%rip), \dst
+	jmp 32f
+21:
+	.popsection
+
+	/* The part that goes into .text */
+30:
+	/* silence objtool by actually using the thunk for now */
+	jmp 20b
+	/* mov \var(%rip), \dst */
+31:
+	.skip -(((11b - 10b)-(31b - 30b)) > 0)*((11b - 10b)-(31b - 30b)), 0x90
+32:
+
+	.pushsection .rai_data, "a"
+40:
+	rai_entry \type 30b 32b 10b 11b 20b
+	.quad \var   /* .load.addr */
+41:
+	rai_entry_pad 40b 41b
+	.popsection
+.endm /* rai_load */
+
+
 #endif
diff --git a/arch/x86/include/asm/rai.h b/arch/x86/include/asm/rai.h
index 269d696255b0..b57494c98d0f 100644
--- a/arch/x86/include/asm/rai.h
+++ b/arch/x86/include/asm/rai.h
@@ -1,7 +1,10 @@
 #ifndef _ASM_X86_RAI_H
 #define _ASM_X86_RAI_H
 
-#define STRUCT_RAI_ENTRY_SIZE 24
+#define RAI_LOAD_4 0
+#define RAI_LOAD_8 1
+
+#define STRUCT_RAI_ENTRY_SIZE 32
 
 /* Put the asm macros in a separate file for easier editing. */
 #include <asm/rai.S>
@@ -16,10 +19,35 @@ struct rai_entry {
 	s32 templ_len;    /* length of template */
 	s32 thunk_offset; /* member-relative offset to ool thunk */
 	/* type-specific data follows */
+	union {
+		struct {
+			void *addr;
+		} load;
+	};
 };
 _Static_assert(sizeof(struct rai_entry) == STRUCT_RAI_ENTRY_SIZE,
 	       "please update STRUCT_RAI_ENTRY_SIZE");
 
+#define _rai_load(var) ({						\
+		typeof(var) ret__;					\
+		switch(sizeof(var)) {					\
+		case 4:							\
+			asm("rai_load %0, %c1, %c2"			\
+			    : "=r" (ret__)				\
+			    : "i" (&(var)), "i" (RAI_LOAD_4));		\
+			break;						\
+		case 8:							\
+			asm("rai_load %0, %c1, %c2"			\
+			    : "=r" (ret__)				\
+			    : "i" (&(var)), "i" (RAI_LOAD_8));		\
+			break;						\
+		default:						\
+			ret__ = _rai_load_fallback(var);		\
+			break;						\
+		}							\
+		ret__;							\
+	})
+
 #endif /* !__ASSEMBLY */
 
 #endif /* _ASM_X86_RAI_H */
diff --git a/arch/x86/kernel/rai.c b/arch/x86/kernel/rai.c
index 819d03a025e3..e55e85f11a2e 100644
--- a/arch/x86/kernel/rai.c
+++ b/arch/x86/kernel/rai.c
@@ -14,6 +14,24 @@ rai_patch_one(const struct rai_entry *r)
 	u8 *thunk = (u8*)&r->thunk_offset + r->thunk_offset;
 
 	switch (r->type) {
+	case RAI_LOAD_4: {
+		const u32 *imm = r->load.addr;
+		/*
+		 * The immediate is the last 4 bytes of the template,
+		 * regardless of the operand encoding.
+		 */
+		memcpy(templ + r->templ_len - sizeof(*imm), imm, sizeof(*imm));
+		break;
+	}
+	case RAI_LOAD_8: {
+		const u64 *imm = r->load.addr;
+		/*
+		 * The immediate is the last 8 bytes of the template,
+		 * regardless of the operand encoding.
+		 */
+		memcpy(templ + r->templ_len - sizeof(*imm), imm, sizeof(*imm));
+		break;
+	}
 	default:
 		WARN_ONCE(1, "unhandled RAI type %d\n", r->type);
 		return;
-- 
2.19.1.6.gbde171bbf5

