Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A64C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86792146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hX3BTpM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86792146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbeISM3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:29:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53974 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbeISM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:29:16 -0400
Received: by mail-it0-f66.google.com with SMTP id p79-v6so6840240itp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iA34PvoXnv/5jnydRzA1GyetmcM2pytY3HL8SIbi1DA=;
        b=hX3BTpM6OFVDYHhbaduRyiEvKVa1h5kwWbYpjAoXCspqeB/8w7+LnC7RvhgfoKauDh
         K/qeYeiNjLC3g0sGJS48hHaypqf2IsTsjQVJVmwnZUT1yHVeaa9UqpQsRT936/9JiXi2
         dZmpGMvJAVhcNCShHhhW5p2Y0X6JZN8AwlEvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iA34PvoXnv/5jnydRzA1GyetmcM2pytY3HL8SIbi1DA=;
        b=f8yyqeeYKsk0RMmS6I2YwgVs8ffLW746d7DXyLYqmKyWsM4vpR9CYZZc9/Y5etG+Kh
         VUqxCDEAOoMdFH2CB3NgBvVumXmiZMmNpL7kwAwuUSMA4x+Ag/wxfq5SlYPbyyVsuIdM
         hUHZlQy4C3/inWzNoy+9OqR3STSTdETATDIHtbZgk+IwHE7JKfQkNp/Fmj0/x07kmehx
         lJQoatDYho9Tv0a7BGZl84sgOq72DLizd9+ao1wmGxPfEYda8qWlVd4uGh0LPL9NqwNz
         j4xKVcGaCVOL1CfvFqTmd2O/5OfrjEvqko4n/UvYL2TLjIDiPzoKTI+6ZqmzkItVG3/h
         7iJA==
X-Gm-Message-State: APzg51CYVLE+La4WgtntG5gP0lfOo1z1EYznJ9nMenWR7kcuvsdPLPch
        37dOI2ehW5wA1E5d11nmj4+3xTKwDj1iFQ==
X-Google-Smtp-Source: ANB0VdbHgyQN/E94/b0fZazm9JVFBSMPzoF08/jTJct0BqxIbnvWsEkdPNxM/CD6Iz4TD2PbVPjMNg==
X-Received: by 2002:a24:cf06:: with SMTP id y6-v6mr19881811itf.5.1537339966590;
        Tue, 18 Sep 2018 23:52:46 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:45 -0700 (PDT)
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
Subject: [PATCH v3 9/9] s390/jump_label: switch to relative references
Date:   Tue, 18 Sep 2018 23:51:44 -0700
Message-Id: <20180919065144.25010-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Enable support for relative references in jump_label entries.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/jump_label.h | 40 ++++++++------------
 arch/s390/kernel/jump_label.c      | 11 +++---
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9a9c7a6fe925..12dc4c1af96c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -120,6 +120,7 @@ config S390
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 40f651292aa7..e2d3e6c43395 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -14,41 +14,33 @@
  * We use a brcl 0,2 instruction for jump labels at compile time so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 15, %l[label]\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl 15,%l[label]\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-typedef unsigned long jump_label_t;
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 43f8430fb67d..50a1798604a8 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -33,13 +33,13 @@ static void jump_label_make_branch(struct jump_entry *entry, struct insn *insn)
 {
 	/* brcl 15,offset */
 	insn->opcode = 0xc0f4;
-	insn->offset = (entry->target - entry->code) >> 1;
+	insn->offset = (jump_entry_target(entry) - jump_entry_code(entry)) >> 1;
 }
 
 static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 			   struct insn *new)
 {
-	unsigned char *ipc = (unsigned char *)entry->code;
+	unsigned char *ipc = (unsigned char *)jump_entry_code(entry);
 	unsigned char *ipe = (unsigned char *)expected;
 	unsigned char *ipn = (unsigned char *)new;
 
@@ -59,6 +59,7 @@ static void __jump_label_transform(struct jump_entry *entry,
 				   enum jump_label_type type,
 				   int init)
 {
+	void *code = (void *)jump_entry_code(entry);
 	struct insn old, new;
 
 	if (type == JUMP_LABEL_JMP) {
@@ -69,13 +70,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 		jump_label_make_nop(entry, &new);
 	}
 	if (init) {
-		if (memcmp((void *)entry->code, &orignop, sizeof(orignop)))
+		if (memcmp(code, &orignop, sizeof(orignop)))
 			jump_label_bug(entry, &orignop, &new);
 	} else {
-		if (memcmp((void *)entry->code, &old, sizeof(old)))
+		if (memcmp(code, &old, sizeof(old)))
 			jump_label_bug(entry, &old, &new);
 	}
-	s390_kernel_write((void *)entry->code, &new, sizeof(new));
+	s390_kernel_write(code, &new, sizeof(new));
 }
 
 static int __sm_arch_jump_label_transform(void *data)
-- 
2.17.1

