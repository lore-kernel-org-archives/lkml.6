Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B615C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D892083B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLdBsiKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D892083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeGBSNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:13:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45533 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753392AbeGBSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id u7-v6so16423599wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7ZgdBdHSh65TnBtMV8VfmyEs0kgJc5Pfx1hmdMEX3g=;
        b=FLdBsiKwQ9szv78kIWndu3Hz8IIvvO7FXMKscslgC2tgl9L9/n9Hb1iUaVlXKY02uI
         4x8+w+oT5OV/+Q6RthuEO13DIgB+cWxmieYol+xyO0Rt4R6vyLUuhD/MvjMMmDSnYrpy
         NPI5FJkO5YJq4yOsj0IscLAF76B10J09kuSgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7ZgdBdHSh65TnBtMV8VfmyEs0kgJc5Pfx1hmdMEX3g=;
        b=Z51n03UnxmRfqizmSSg5+6+uL5UrCzW+y2g2aD/1RgnWHdTMS4ZipMhO5Azm1G5BiO
         Lyh5oiymqRkpozFmd6XUzK8OzHp/MbRUcAGu/TpMyKylMJrbsbaJnzdeyCxrMAgA2Dr3
         y+BhO2dE6+9m/pHstPGTzwab9fRIaGqQY1OucBS7mFE3YfbeByyo9om9kpdGyfX65Y7Y
         Rq1wZGHbNg2xT+SQM/1k7Wds4fXX5LfV95vpYe6fmOGJZZJ09d+lEI6fh4mcczb0/zDE
         lB/Qo8YIRuESzTE1a9yjul3a8THTlm9bLxKsEo6yjQO2JTE1E8XF2ZTWtPysgp2Lqmpm
         M/sQ==
X-Gm-Message-State: APt69E36rSUHmjW+OfVl+7j8eLJ38kUgyWi/Q0CxjYaQjZw8BsXVuG+O
        2zF5heooUwInT0cQA3tY+VX3EA==
X-Google-Smtp-Source: AAOMgpcA29fboRDRrKw39eE1RtNN3OjgyCP6v3BH0dVdFnvv+uxwCzsZTz8ducOeTY+kB9vVNHGRdg==
X-Received: by 2002:adf:b90a:: with SMTP id k10-v6mr3724078wrf.169.1530555125951;
        Mon, 02 Jul 2018 11:12:05 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:12:05 -0700 (PDT)
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
Subject: [PATCH v2 6/8] x86/kernel: jump_table: use relative references
Date:   Mon,  2 Jul 2018 20:11:43 +0200
Message-Id: <20180702181145.4799-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the arm64 case, 64-bit x86 can benefit from using relative
references rather than absolute ones when emitting struct jump_entry
instances. Not only does this reduce the memory footprint of the entries
themselves by 33%, it also removes the need for carrying relocation
metadata on relocatable builds (i.e., for KASLR) which saves a fair
chunk of .init space as well (although the savings are not as dramatic
as on arm64)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/jump_label.h | 24 +++++++-------------
 tools/objtool/special.c           |  4 ++--
 3 files changed, 11 insertions(+), 18 deletions(-)

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
index 8c0de4282659..21efc9d07ed9 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -37,7 +37,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -53,7 +54,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -62,18 +64,6 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
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
@@ -88,7 +78,8 @@ struct jump_entry {
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key - .
 	.popsection
 .endm
 
@@ -104,7 +95,8 @@ struct jump_entry {
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key + 1 - .
 	.popsection
 .endm
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..50af4e1274b3 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -30,9 +30,9 @@
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
 
-#define JUMP_ENTRY_SIZE		24
+#define JUMP_ENTRY_SIZE		16
 #define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		8
+#define JUMP_NEW_OFFSET		4
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
-- 
2.17.1

