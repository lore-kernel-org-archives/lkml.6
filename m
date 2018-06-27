Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20953C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C535025CC8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LonVhfcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C535025CC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935092AbeF0QGS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:06:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44565 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935050AbeF0QGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:06:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so2585645wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bihw6AeKi0fURk5bIT2bV23QoQQq88ujufV07nqCrwI=;
        b=LonVhfcj1q+ksxpCU58rrgajQcfmWDqT+Bll21pKsV9uhxz5VJ8XnjkVJnjuU/IGur
         vIxc5ptaVzTPUzbcCQZ1cBBYd3q9hfKITxtMAe5i4QIKTHVnT6oXhezpETTv7r7ZbvhB
         fD4+TxebhU3/GkEZPgvGqpWKNzYbVtIHbv9kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bihw6AeKi0fURk5bIT2bV23QoQQq88ujufV07nqCrwI=;
        b=JdlJQmfdanbZZwivI8QlBOmpAIeNl8dKN2JpTIXLpiLykt9h9Kotsk5tcE4rtWXCse
         ARNFS7owzDpXLu2o0PtUCI2TwVt+a+/Xjqv0nMhNXPOA/QSlp2XvhEGzyVClAPFlttlN
         cSrDGBEYV7RJImXtHCVr3uERbvEd37qVzDKCr/UR5DA7F92MnVImUd/sn8XpReOeEQGw
         pUrC4k5UxC1VLVHdS4D/yRMydNsWWYH8TpF5eRU2pA0a7dp0HUJfMlp+l6RZPYcFv0ja
         AYw3EY2z6Pc+7Dk8bweA9RlxDo5vdYfuVxmlNBUcmI5g6kdV55X4+QXregkta128tWQy
         nJLQ==
X-Gm-Message-State: APt69E0dDAKw8D12r1wUlYc+rpIoDCk9wtk17WwPnx1ea9YBiJEr6IYa
        JcGQ48mK5KTrRoiMrAWJ82LpEBT7U4k=
X-Google-Smtp-Source: AAOMgpeqC5nXj+MHnmsFg4y9lmR+hlhvOmbeGJdVL0mQHK4A4P947ZX9aPyvvMe/RGvJn53SgnJ/Jw==
X-Received: by 2002:adf:9883:: with SMTP id w3-v6mr6056390wrb.9.1530115571547;
        Wed, 27 Jun 2018 09:06:11 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:4d04:66e:dea8:5b23])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7055000wrn.75.2018.06.27.09.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:06:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/5] arm64/kernel: jump_label: switch to relative references
Date:   Wed, 27 Jun 2018 18:06:02 +0200
Message-Id: <20180627160604.8154-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
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
references: this reduces the size of the __jump_table by 50%, and gets
rid of the RELA section entirely.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/jump_label.h | 16 ++++------------
 arch/arm64/kernel/jump_label.c      |  6 +++---
 3 files changed, 8 insertions(+), 15 deletions(-)

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
index 1b5e0e843c3a..5e3e31df3805 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -30,8 +30,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 {
 	asm goto("1: nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
+		 ".align 2\n\t"
+		 ".long 1b - ., %l[l_yes] - ., %c0 - .\n\t"
 		 ".popsection\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
@@ -44,8 +44,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm goto("1: b %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
+		 ".align 2\n\t"
+		 ".long 1b - ., %l[l_yes] - ., %c0 - .\n\t"
 		 ".popsection\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
@@ -54,13 +54,5 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
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
2.11.0

