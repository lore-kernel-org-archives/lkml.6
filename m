Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7F4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1D620880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NB7mskp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1D620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeISM3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:29:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45074 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbeISM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:29:03 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so3584993iok.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XGRY1T3h+gs2S6eNeT9ZaVSn/BnvjE5DrD6FeDRoeQ4=;
        b=NB7mskp/qv9FTKKiv/NIH3QElhQgT74KLCGGPtWIXEbKuGh+Mn7QgIY8P0rP2earA6
         HGPls0WytLUlXWc6UX60x6rMJgjdziPfxccBg+oM7l/vTE9ydrroiYYiRC+mZAFx3Pl3
         mkSPKyvp48KYUfPkN/+fCiXjZWlfxNVTGFUGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XGRY1T3h+gs2S6eNeT9ZaVSn/BnvjE5DrD6FeDRoeQ4=;
        b=nhEVl0+Imvl2ss0frVxWykOEsNL4mm9DszTvNqXzLG6SBPShmGDhhsD9A48WyrLCvP
         FO6aHI890kojMK8tSQqdV++u/4qVHXffWBMngMPWxB9txa/lq1H08iukh9sXtsBDGr+7
         Ly8MdN/d4D60jd6BwILfqxheprLKfNToGtBGSjFsgYvMZx1Jc4SEiDsz6/GZ81leO0Rf
         GIMyThYgtvEujrdzXAPybkbq4bE9gmaBVDB/Qu3AEkzTtsdQveFOqm5Mew19e7R577Rj
         9NNvyf44bdp6nD33kExpn87oP6yjHTD/X72aHU+BeWXjvqVPu8WwwYzJgN0MtUcDMVXH
         Td1A==
X-Gm-Message-State: APzg51Bj7oxrM3GcAzTlL69SySxhQ6Ts76SGBqyL+r0SA5ffjWiigQgb
        LxeDDSVKkHmMch7k/qpFZ+A/QLrc5g82Fw==
X-Google-Smtp-Source: ANB0VdYZmcooAa65xYvgxeEeJ184S8IKmJEkvPLtm2qYaaQ5RGALeFjwN9NBwKVhneUZCfdB/VsYSQ==
X-Received: by 2002:a5e:db07:: with SMTP id q7-v6mr28850533iop.81.1537339953658;
        Tue, 18 Sep 2018 23:52:33 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:33 -0700 (PDT)
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
Subject: [PATCH v3 6/9] x86/kernel: jump_table: use relative references
Date:   Tue, 18 Sep 2018 23:51:41 -0700
Message-Id: <20180919065144.25010-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
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
index 1a0be022f91d..603f374f871d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -119,6 +119,7 @@ config X86
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

