Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BEE24FAE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L12Ji9yF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BEE24FAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeGBSMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:12:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37072 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeGBSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:11:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id q10-v6so1707126wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sN+HT57t+gSH0ShF8Th3JKe4zmSu8oRHrYwUlNvmdrc=;
        b=L12Ji9yFkOczS8LxdqLIaOyOwP4xEPBvHP1UgNpl+z3lLalzVbfYOgTI0GKhzcnrls
         UZIePyE850IJ5e69rkXOVAhCKUpEBVKr0gkM64ZjPQ/ZdROpXtXWMMfaSm7qlG5/qQWo
         draOD5nv3m+K4RcQdV/waomYm1A6BDXnXjz2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sN+HT57t+gSH0ShF8Th3JKe4zmSu8oRHrYwUlNvmdrc=;
        b=WbDaOSrD0F4PEPoi4BxQxX0zFVEfymZ95lJqVuBskyelnSeDDsip6ADDxu9u8wZMTA
         /HqV7+526jW+T8tCvHNCUr1eTE+qrFL3WhOExob7Uv8yokqmkNEjwvFjT9DWSi4sHa0O
         C9lYK62xEwGn2jfRWSetey2LHGdyT6BGTB4GhEoaqpFtN9QMYzSgDWzX+OOKc1YMNUBZ
         uoJSs0z59XK/HkL8kehWc2tEAD1KXiTS7WmWxzvnaWBItc0hFEQZZYBmZz6l3sMBurIK
         pA4twDVG1LQHtMI/NW6T5XmEyEt+4cgngeTg5g2V2kD1j6vZ9MpcoO27LWmxUznOzhky
         ZNDg==
X-Gm-Message-State: APt69E3YdcBhETmui9dNqV4vPuTJJSTQM8YGVrpyTo1uYUK/ve7Mmbbr
        rRACgteOiglyOkY2xAqXs7oauw==
X-Google-Smtp-Source: AAOMgpcQVlUUzv1TCSYXqAgcTDl5N5L0ozOlYRn4H8MCiZ+oR1eu3iA3+3NmhFVjcsYoXqFEsf+ihg==
X-Received: by 2002:adf:83a6:: with SMTP id 35-v6mr20405339wre.13.1530555116389;
        Mon, 02 Jul 2018 11:11:56 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:11:55 -0700 (PDT)
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
Subject: [PATCH v2 2/8] kernel/jump_label: implement generic support for relative references
Date:   Mon,  2 Jul 2018 20:11:39 +0200
Message-Id: <20180702181145.4799-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce the size taken up by absolute references in jump label
entries themselves and the associated relocation records in the
.init segment, add support for emitting them as relative references
instead.

Note that this requires some extra care in the sorting routine, given
that the offsets change when entries are moved around in the jump_entry
table.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig               |  3 +++
 include/linux/jump_label.h | 28 ++++++++++++++++++++
 kernel/jump_label.c        | 22 ++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2b8b70820002..22fa3792626e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -348,6 +348,9 @@ config HAVE_PERF_USER_STACK_DUMP
 config HAVE_ARCH_JUMP_LABEL
 	bool
 
+config HAVE_ARCH_JUMP_LABEL_RELATIVE
+	bool
+
 config HAVE_RCU_TABLE_FREE
 	bool
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 4603a1c88e48..871826fd0c3b 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -121,6 +121,32 @@ struct static_key {
 #include <asm/jump_label.h>
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
+
+struct jump_entry {
+	s32 code;
+	s32 target;
+	long key;	// key may be far away from the core kernel under KASLR
+};
+
+static inline unsigned long jump_entry_code(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->code + entry->code;
+}
+
+static inline unsigned long jump_entry_target(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->target + entry->target;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	long offset = entry->key & ~1L;
+
+	return (struct static_key *)((unsigned long)&entry->key + offset);
+}
+
+#else
 
 static inline unsigned long jump_entry_code(const struct jump_entry *entry)
 {
@@ -137,6 +163,8 @@ static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 	return (struct static_key *)((unsigned long)entry->key & ~1UL);
 }
 
+#endif
+
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
 {
 	return (unsigned long)entry->key & 1UL;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 8a3ac4f5f490..d424e1d22d63 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -47,14 +47,34 @@ static int jump_label_cmp(const void *a, const void *b)
 	return 0;
 }
 
+static void jump_label_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct jump_entry *jea = a;
+	struct jump_entry *jeb = b;
+	struct jump_entry tmp = *jea;
+
+	jea->code	= jeb->code - delta;
+	jea->target	= jeb->target - delta;
+	jea->key	= jeb->key - delta;
+
+	jeb->code	= tmp.code + delta;
+	jeb->target	= tmp.target + delta;
+	jeb->key	= tmp.key + delta;
+}
+
 static void
 jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 {
 	unsigned long size;
+	void *swapfn = NULL;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE))
+		swapfn = jump_label_swap;
 
 	size = (((unsigned long)stop - (unsigned long)start)
 					/ sizeof(struct jump_entry));
-	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
+	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, swapfn);
 }
 
 static void jump_label_update(struct static_key *key);
-- 
2.17.1

