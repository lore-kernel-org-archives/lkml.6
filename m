Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D313C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A404218C2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAn2Wztv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A404218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeGBSOe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:14:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39012 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGBSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so16422671wro.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8m2ubatinriCgE+fyFRDo1C7fsKjnxpNpjlgZpUC+Y=;
        b=OAn2Wztv72vqFNhayw1xHb7skMG8qhK6hKdeatCA5L6fGMcqW864ln6UrWAfAFCxKA
         j0Jte8u75R9lvgw8tbhVaSEiZ7nP3WDPw83Fl3bQzEhb96VlBDxh/8q2r24x4ItyMlyy
         v7kiVMHld00DBkkIwClWjSvXm3DyM2TrLJc9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o8m2ubatinriCgE+fyFRDo1C7fsKjnxpNpjlgZpUC+Y=;
        b=h6fnFWQCq7xUAvhaNKTe/yK0FSHxYwU9m2E64vnJ+B0NmPmYpdntmjlnhr8BtG+CrN
         vgIVmL9jrc7ie+4gi8JiJlh2PD/5b5kmVV3MGqVyKx2GC9r7eW/LDvKbo+9d08rNyJSe
         x57coe/U69qquFPF3iw2Dp4YF9V5nyxKiXefEwlq3X6PWEst5RsLUGUp0VLCU6V8OQlT
         rWmU4FCjJYGOrBD2AVBAbHWIe3tFIjUQ5/VYxTm4EJI852URTci9vZwPfrdc9cmmnD3U
         Mwdj5hZmS04M5gTXbHFlcew0pd+DvFuuIGp7lMeVoUU3ZrNijBDsJe79ZTxupqdPN1Wb
         8APQ==
X-Gm-Message-State: APt69E0lPJVB7Vh/+8KfBl0umVNzZGQ2RyKSz8djcGyzCEdW3IbdhKxF
        Pg+Rs9n2j1CK+qn7YkG14WLybQ==
X-Google-Smtp-Source: AAOMgpffB15mKVw3rO3zTA+MYkl7XFYW9cE8/ZZkFitPG+pVAEFPm2/L3Qv4TG+p5DYq4yLJ9gAINw==
X-Received: by 2002:adf:d181:: with SMTP id h1-v6mr20077520wri.198.1530555118810;
        Mon, 02 Jul 2018 11:11:58 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:11:58 -0700 (PDT)
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
Subject: [PATCH v2 3/8] arm64/kernel: jump_label: switch to relative references
Date:   Mon,  2 Jul 2018 20:11:40 +0200
Message-Id: <20180702181145.4799-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a randomly chosen distro kernel build for arm64, vmlinux.o shows the
following sections, containing jump label entries, and the associated
RELA relocation records, respectively:

  ...
  [38088] __jump_table      PROGBITS         0000000000000000  00e19f30
       000000000002ea10  0000000000000000  WA       0     0     8
  [38089] .rela__jump_table RELA             0000000000000000  01fd8bb0
       000000000008be30  0000000000000018   I      38178   38088     8
  ...

In other words, we have 190 KB worth of 'struct jump_entry' instances,
and 573 KB worth of RELA entries to relocate each entry's code, target
and key members. This means the RELA section occupies 10% of the .init
segment, and the two sections combined represent 5% of vmlinux's entire
memory footprint.

So let's switch from 64-bit absolute references to 32-bit relative
references for the code and target field, and a 64-bit relative
reference for the 'key' field (which may reside in another module or the
core kernel, which may be more than 4 GB way on arm64 when running with
KASLR enable): this reduces the size of the __jump_table by 33%, and
gets rid of the RELA section entirely.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/jump_label.h | 36 +++++++++-----------
 arch/arm64/kernel/jump_label.c      |  6 ++--
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1940c6405d04..d17aa9614e69 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -91,6 +91,7 @@ config ARM64
 	select HAVE_ARCH_BITREVERSE
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 1b5e0e843c3a..bb6d15b34668 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -26,13 +26,15 @@
 
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static __always_inline bool arch_static_branch(struct static_key *key,
+					       bool branch)
 {
-	asm goto("1: nop\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
-		 ".popsection\n\t"
+	asm goto("1:	nop					\n\t"
+		 "	.pushsection	__jump_table, \"aw\"	\n\t"
+		 "	.align		3			\n\t"
+		 "	.long		1b - ., %l[l_yes] - .	\n\t"
+		 "	.quad		%c0 - .			\n\t"
+		 "	.popsection				\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
@@ -40,13 +42,15 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static __always_inline bool arch_static_branch_jump(struct static_key *key,
+						    bool branch)
 {
-	asm goto("1: b %l[l_yes]\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
-		 ".popsection\n\t"
+	asm goto("1:	b		%l[l_yes]		\n\t"
+		 "	.pushsection	__jump_table, \"aw\"	\n\t"
+		 "	.align		3			\n\t"
+		 "	.long		1b - ., %l[l_yes] - .	\n\t"
+		 "	.quad		%c0 - .			\n\t"
+		 "	.popsection				\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
@@ -54,13 +58,5 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
-typedef u64 jump_label_t;
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif	/* __ASM_JUMP_LABEL_H */
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index c2dd1ad3e648..903d17023d77 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -25,12 +25,12 @@
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
-	void *addr = (void *)entry->code;
+	void *addr = (void *)jump_entry_code(entry);
 	u32 insn;
 
 	if (type == JUMP_LABEL_JMP) {
-		insn = aarch64_insn_gen_branch_imm(entry->code,
-						   entry->target,
+		insn = aarch64_insn_gen_branch_imm(jump_entry_code(entry),
+						   jump_entry_target(entry),
 						   AARCH64_INSN_BRANCH_NOLINK);
 	} else {
 		insn = aarch64_insn_gen_nop();
-- 
2.17.1

