Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B33C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AB224FAF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MH9B829V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AB224FAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeGBSMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:12:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32779 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeGBSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id k7-v6so12933931wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6nUyftJQHbn4ADCDRiHDYhO9k2WDA48zRvsOuVLWFCc=;
        b=MH9B829VsTLGEaymnuo3lvDs2YlPFP+tCJ4WAiPdSGavKSbuibs/57DY2V9s64nv+N
         Wu5/hzTyQX4OgnsjUsQWylcvIfyPpRPM9ImXRgbF/Vb7Wo4c3RDzobRfDcLQNlFTvAD/
         CtHAKlxbhonAXmdbn45KBkVYQlAigW8Nd+8/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6nUyftJQHbn4ADCDRiHDYhO9k2WDA48zRvsOuVLWFCc=;
        b=lhPa5z6jjIW2ecI0Fd/lKeCuqszsob0JyGsjzMzWuSNSy5oAe5ws3HVQDAeM/ZYA9i
         osF8wQshF4FnOrFtzDVhwm6Z8WX4bNEWRRlOMD/7bsk6zAuUeTWAsQYjH3EZxWGMvKYT
         noh3w2tLf9lTQ//s9Ec4UEcPqQ0mKqA2hvZNXPaVgW3DPkpP6Wycb+dSvr12Lx6XkExT
         pvDZhccisdUaSVOMhvb0qsTdlUisjBWxBI9FWZ6wCeU2jqvvwPW5Jo8PetbjQ3MqUw7a
         IopNMmvg6BclOt9cppJzunsA8uRlJTUGgqIkp/ASTPo4+UoQmU2hjLv6uKN38pQz4XYD
         5T8g==
X-Gm-Message-State: APt69E0mohtSR+B41t5k93SxrL+WfnzSKq0WRicnM7McMNeWHEvp0/f6
        N+GjXyk8W4P3wRL8FiRlVhVuSQ==
X-Google-Smtp-Source: AAOMgpesmv2Ba2zn6vBjDDOjkc3I5zkakY1L5X6Xcu1PloSX8qsLRii6h5H9YlmxuLvr4fT2wRktjQ==
X-Received: by 2002:adf:f50e:: with SMTP id q14-v6mr76852wro.241.1530555121138;
        Mon, 02 Jul 2018 11:12:01 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:12:00 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 4/8] x86: add support for 64-bit place relative relocations
Date:   Mon,  2 Jul 2018 20:11:41 +0200
Message-Id: <20180702181145.4799-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for R_X86_64_PC64 relocations, which operate on 64-bit
quantities holding a relative symbol reference. This allows jump
table entries to be emitted in a way that makes them invariant under
runtime relocation, which means that no metadata needs to be emitted
into the kernel image to describe such data structures, resulting in
a size reduction.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/elf.h         |  1 +
 arch/x86/kernel/machine_kexec_64.c |  4 ++++
 arch/x86/kernel/module.c           |  6 ++++++
 arch/x86/tools/relocs.c            | 10 ++++++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..d3925d684296 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -62,6 +62,7 @@ typedef struct user_fxsr_struct elf_fpxregset_t;
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 #define R_X86_64_NUM		16
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..6638d1edb2be 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -496,6 +496,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 			value -= (u64)address;
 			*(u32 *)location = value;
 			break;
+		case R_X86_64_PC64:
+			value -= (u64)address;
+			*(u64 *)location = value;
+			break;
 		default:
 			pr_err("Unknown rela relocation: %llu\n",
 			       ELF64_R_TYPE(rel[i].r_info));
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336af095c..b052e883dd8c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -201,6 +201,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 				goto overflow;
 #endif
 			break;
+		case R_X86_64_PC64:
+			if (*(u64 *)loc != 0)
+				goto invalid_relocation;
+			val -= (u64)loc;
+			*(u64 *)loc = val;
+			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 220e97841e49..a4075bc37e8f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -195,6 +195,7 @@ static const char *rel_type(unsigned type)
 #if ELF_BITS == 64
 		REL_TYPE(R_X86_64_NONE),
 		REL_TYPE(R_X86_64_64),
+		REL_TYPE(R_X86_64_PC64),
 		REL_TYPE(R_X86_64_PC32),
 		REL_TYPE(R_X86_64_GOT32),
 		REL_TYPE(R_X86_64_PLT32),
@@ -781,6 +782,15 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			add_reloc(&relocs32neg, offset);
 		break;
 
+	case R_X86_64_PC64:
+		/*
+		 * Only used by jump labels
+		 */
+		if (is_percpu_sym(sym, symname))
+			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
+			    symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-- 
2.17.1

