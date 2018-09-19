Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9866C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8806120880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RX689+zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8806120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeISM2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:28:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37522 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeISM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:28:50 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so6387970itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TGyPYi2VRIFEPcRhb8tIzZMhU5s7IYbBe3KULe7Oy1M=;
        b=RX689+zqYWhkAwVV303gAnGbrJ9CzrBF+KgU2p+y7qbKoXHWycb1HUUPkpNb3+j9xw
         nYaYaat5echYppzD0W+cO6BYfEwuoSP6FJyKDc6DONSA8nY79Jtkstw4r8B3d+GPZ+r6
         W5Ip07ogGOZ8mv9fOKV/zmGUvyGDwwqxr+AXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TGyPYi2VRIFEPcRhb8tIzZMhU5s7IYbBe3KULe7Oy1M=;
        b=M3GYe26YUsTnRH0+TgKJHuVRSlMI7h/ZfQN4OLMt6qtys3fHUzfvWt/CwRFTGd79Yi
         Np1Yw4TZkbAXrnukOiNT5pwSe91qwffpCZoh1/b+cEIv+XVoe7CoUDXV+RUI+ukXdp5a
         +Q5bJlkg+Ee8++OjwvKO0osxBZHFseK+0TtEGVyUKVVO3rc+C81u2S74saT8STUTqrDM
         XLlItlMRb33WneZXfFSe5keBxj6F5ud5EMlTZJu7V7bTnC8iCgqeuSVxYU67+oCRtKQr
         EvDpOc6DzhFsv1TIE8PCnOzW1LypBVVEXoKcuOJLKGqji+vQQHlGlf1jXgFe41bVQ2Zz
         PfGw==
X-Gm-Message-State: APzg51D4jxT+A3UPv+T5HkV19JEWcRDrHmvCMVSG5OZWLFMB2pGV0x24
        Qqs7KNJ13B1VWO8MxfqjQR0brWEmY0oD2w==
X-Google-Smtp-Source: ANB0VdagX7kllJRGS9IYdSb38gxySP9dOzV8AfuT5GxWvk5nahqxpeZSqPl8VpCjukI55T4KAqfoFQ==
X-Received: by 2002:a02:8647:: with SMTP id e65-v6mr30385365jai.62.1537339940402;
        Tue, 18 Sep 2018 23:52:20 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:19 -0700 (PDT)
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
Subject: [PATCH v3 3/9] arm64/kernel: jump_label: switch to relative references
Date:   Tue, 18 Sep 2018 23:51:38 -0700
Message-Id: <20180919065144.25010-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
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
 arch/arm64/include/asm/jump_label.h | 38 ++++++++++----------
 arch/arm64/kernel/jump_label.c      |  6 ++--
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..16e1e2c1e77b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -104,6 +104,7 @@ config ARM64
 	select HAVE_ARCH_BITREVERSE
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 7e2b3e360086..472023498d71 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -26,13 +26,16 @@
 
 #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
 
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static __always_inline bool arch_static_branch(struct static_key *key,
+					       bool branch)
 {
-	asm_volatile_goto("1: nop\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
-		 ".popsection\n\t"
+	asm_volatile_goto(
+		"1:	nop					\n\t"
+		 "	.pushsection	__jump_table, \"aw\"	\n\t"
+		 "	.align		3			\n\t"
+		 "	.long		1b - ., %l[l_yes] - .	\n\t"
+		 "	.quad		%c0 - .			\n\t"
+		 "	.popsection				\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
@@ -40,13 +43,16 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static __always_inline bool arch_static_branch_jump(struct static_key *key,
+						    bool branch)
 {
-	asm_volatile_goto("1: b %l[l_yes]\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
-		 ".popsection\n\t"
+	asm_volatile_goto(
+		"1:	b		%l[l_yes]		\n\t"
+		 "	.pushsection	__jump_table, \"aw\"	\n\t"
+		 "	.align		3			\n\t"
+		 "	.long		1b - ., %l[l_yes] - .	\n\t"
+		 "	.quad		%c0 - .			\n\t"
+		 "	.popsection				\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
@@ -54,13 +60,5 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
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
index e0756416e567..646b9562ee64 100644
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

