Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2FDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D31216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D31216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeI0WVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:21:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49559 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeI0WVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:21:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RG20OO083202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 09:02:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RG20rW083199;
        Thu, 27 Sep 2018 09:02:00 -0700
Date:   Thu, 27 Sep 2018 09:02:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-c296146c058c87e9ed53001b6a3988519dbbb6a5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        schwidefsky@de.ibm.com, tglx@linutronix.de, rostedt@goodmis.org,
        arnd@arndb.de, will.deacon@arm.com, peterz@infradead.org,
        hpa@zytor.com, jeyu@kernel.org, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        keescook@chromium.org
Reply-To: keescook@chromium.org, catalin.marinas@arm.com,
          heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
          hpa@zytor.com, jeyu@kernel.org, peterz@infradead.org,
          will.deacon@arm.com, mingo@kernel.org, tglx@linutronix.de,
          schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
          rostedt@goodmis.org, arnd@arndb.de
In-Reply-To: <20180919065144.25010-4-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-4-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] arm64/kernel: jump_label: Switch to relative
 references
Git-Commit-ID: c296146c058c87e9ed53001b6a3988519dbbb6a5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c296146c058c87e9ed53001b6a3988519dbbb6a5
Gitweb:     https://git.kernel.org/tip/c296146c058c87e9ed53001b6a3988519dbbb6a5
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 18 Sep 2018 23:51:38 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 17:56:47 +0200

arm64/kernel: jump_label: Switch to relative references

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

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Link: https://lkml.kernel.org/r/20180919065144.25010-4-ard.biesheuvel@linaro.org

---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/jump_label.h | 38 ++++++++++++++++++-------------------
 arch/arm64/kernel/jump_label.c      |  6 +++---
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
@@ -40,13 +43,16 @@ l_yes:
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
@@ -54,13 +60,5 @@ l_yes:
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
