Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848BFC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AC025D3F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJd/8Yyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AC025D3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965682AbeF0QHB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:07:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33955 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935065AbeF0QGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:06:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so18434174wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3yRjPsLxkB46VvOLi+86pNrf3CoOWXbFse0Dmkmvc3s=;
        b=dJd/8Yyxskiuc9hVUV5Gfebg3Y4+xz/jCiFF1KxcKQSG52XBlC+lTLyMk2p8oPrGG3
         KmsT5bX8P+tY1kJZmQGtm6EgEYtf29u8fShb3/iUI1R2lnezr+6CZn00weWsHco3D7F/
         +LKJ4oW6Qi4mWcz25rt1dZmJvl26KrnPeURcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3yRjPsLxkB46VvOLi+86pNrf3CoOWXbFse0Dmkmvc3s=;
        b=gqra1e9LSbACLQARq8hNiI0QPl5HzsDTdq+gJWFbgYBy6Z+mWP5OhfJ9+4okCeW0n/
         V4GAeWmN5LgnLBCqQfJQLyef8vNMj8hXZdepQGxzh0JrsQaXIt+5LhQgukznLTwWjzQ5
         tAIRndZEL3R75vmLlqIhflyzAdNfVK9mazeaAflG+/UfIVCxsM/mf7Jic8nQ5fFvekCv
         WgC6ISxGGgDq2Krs8yUQ4rmckfJjnHvlllhFBR7SliCBgDw07yZyu2QMWoOtLdIZ6IVr
         dYtpFAUJPE6neaO5lkx/ofTdUMg9VcAxZ2c8Qi+ncdim+cdEBXL+bzOGFJS7tB55JyKT
         cHzA==
X-Gm-Message-State: APt69E3csB+3dlGot0j2FklVIVc2p3OyhSsjaYIqyqIU6GtCZNkdOiwv
        VqStsIFGdThouXzRx6NiqnnC++su/bg=
X-Google-Smtp-Source: AAOMgpf9G7gd1KRY4fu3ItjJD1auo+SpbRqj/+tvzT9A7b9mjDeeZTM8FVH+1gtaxsvatqK82e2nkQ==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr5286896wme.141.1530115574543;
        Wed, 27 Jun 2018 09:06:14 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:4d04:66e:dea8:5b23])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7055000wrn.75.2018.06.27.09.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:06:13 -0700 (PDT)
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
Subject: [PATCH 5/5] x86/kernel: jump_table: use relative references
Date:   Wed, 27 Jun 2018 18:06:04 +0200
Message-Id: <20180627160604.8154-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
relative references rather than 64-bit absolute ones when emitting
struct jump_entry instances. Not only does this reduce the memory
footprint of the entries themselves by 50%, it also removes the need
for carrying relocation metadata on relocatable builds (i.e., for KASLR)
which saves a fair chunk of .init space as well (although the savings
are not as dramatic as on arm64)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/jump_label.h | 28 ++++++--------------
 tools/objtool/special.c           |  4 +--
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e10a3542db7e..dd71258ec1cc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -118,6 +118,7 @@ config X86
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..d0f1f25b41d5 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -36,8 +36,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -52,8 +52,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -62,18 +62,6 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
-#ifdef CONFIG_X86_64
-typedef u64 jump_label_t;
-#else
-typedef u32 jump_label_t;
-#endif
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
@@ -87,8 +75,8 @@ struct jump_entry {
 	.byte		STATIC_KEY_INIT_NOP
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key - .
 	.popsection
 .endm
 
@@ -103,8 +91,8 @@ struct jump_entry {
 .Lstatic_jump_after_\@:
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key + 1 - .
 	.popsection
 .endm
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..98ae55b39037 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -30,9 +30,9 @@
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
 
-#define JUMP_ENTRY_SIZE		24
+#define JUMP_ENTRY_SIZE		12
 #define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		8
+#define JUMP_NEW_OFFSET		4
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
-- 
2.11.0

