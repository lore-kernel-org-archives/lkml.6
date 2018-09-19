Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE82C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ACE2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhDtIlRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9ACE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbeISM2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:28:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52726 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731001AbeISM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:28:54 -0400
Received: by mail-it0-f65.google.com with SMTP id h3-v6so6840711ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjlNGgKK+hdQ2oIOvWFpRpQO96t5oT9NlwIzOhMdM8o=;
        b=DhDtIlRo84pAR/lLfZZdTtSpY4IbWrE2M7Q3fbmY0W8iqGZiJJMONls0dIy7dmO7yE
         VpiQJ9v47+5DZd1eceatrZ7qN+PeX+XwJhjOIasK6oYUVfSk2VmSzZffnSJbDgZ302fQ
         3dX12Q4QmLBeuTPo7bvGVMxg5fjcnMLlZmt1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vjlNGgKK+hdQ2oIOvWFpRpQO96t5oT9NlwIzOhMdM8o=;
        b=G3ebBzyz9gtFnhk9OHRbcj+FsSWhYMkIMjYLVGa+BqA+7gOp/rjUdLZtVBqvGVDLk5
         +xF09XJ3bicRgT4yJa1oM6DqLOw/HJf6MMYMHYqYc36Sl44k2m+ow+hA9sqVu5kbEPS2
         QlPPv3BZW7uNVQr7o+qNtst3nIF5c4x6Zh0jO2Rrz88I+Mavh03S/BC/XH5vo7ezGggg
         uRM34voxUpZqRL78rallOGVPQXgbXJ7AsxUsun4EBIFzYm6jJK8deewzeJqfXu0NvslV
         bWspTpyjFHqXTJ0FPCd1dAwMJp+dg1bV8rWyokhcsSWhm13xetRegP3EN/y6xq/+YOqU
         hmdA==
X-Gm-Message-State: APzg51B2ZXuO2ryjkLW/v1EZLbjgsaefJq3igylb8wcQIU/1F18yJcrP
        3vcDL6LuQvECpd9jzK6progWoj9Sa03Qjg==
X-Google-Smtp-Source: ANB0VdZWATphTVUC1+4j99sUxsajCdozbe7MZlE824KEJq2nWkZ2xrHiXZt4gPP7GQ6W6ipwFJV7ZA==
X-Received: by 2002:a24:4a83:: with SMTP id k125-v6mr19923669itb.121.1537339944194;
        Tue, 18 Sep 2018 23:52:24 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:23 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v3 4/9] x86: add support for 64-bit place relative relocations
Date:   Tue, 18 Sep 2018 23:51:39 -0700
Message-Id: <20180919065144.25010-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for R_X86_64_PC64 relocations, which operate on 64-bit
quantities holding a relative symbol reference. Also remove the
definition of R_X86_64_NUM: given that it is currently unused, it
is unclear what the new value should be.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/elf.h |  3 +--
 arch/x86/kernel/module.c   |  6 ++++++
 arch/x86/tools/relocs.c    | 10 ++++++++++
 arch/x86/um/asm/elf.h      |  3 +--
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..a357031d85b5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -62,8 +62,7 @@ typedef struct user_fxsr_struct elf_fpxregset_t;
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-
-#define R_X86_64_NUM		16
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 /*
  * These are used to set parameters in the core dumps.
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
index 3a6c8ebc8032..0b08067c45f3 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -196,6 +196,7 @@ static const char *rel_type(unsigned type)
 #if ELF_BITS == 64
 		REL_TYPE(R_X86_64_NONE),
 		REL_TYPE(R_X86_64_64),
+		REL_TYPE(R_X86_64_PC64),
 		REL_TYPE(R_X86_64_PC32),
 		REL_TYPE(R_X86_64_GOT32),
 		REL_TYPE(R_X86_64_PLT32),
@@ -782,6 +783,15 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
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
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 548197212a45..413f3519d9a1 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -116,8 +116,7 @@ do {								\
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-
-#define R_X86_64_NUM		16
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
-- 
2.17.1

