Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E8ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412D520880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSBs8g1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412D520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbeISM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:28:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34817 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeISM2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:28:46 -0400
Received: by mail-it0-f67.google.com with SMTP id 139-v6so6401236itf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ve/tzdX0J+Uuck6FHDdYfUVN2t3T9LHXWJmCGGfmOhA=;
        b=XSBs8g1FXx8+MYOqu4x8BUS5rCmHRqZYI9aGmmBiXo0QwJ2kIR6WDnc9UUL/Bu+m+y
         zVeou4wFWxg8G6IoGz4AeO3MicrYY+zjoYV6Eiy/DHCjJnu8y++FAsajVh0ji7RNYmex
         cJ5/VtZNVe4avLVH3jZwR66wSdQsdSIkkVsjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ve/tzdX0J+Uuck6FHDdYfUVN2t3T9LHXWJmCGGfmOhA=;
        b=PqQAkswS+5zRwTHVLK5m6xSSsACA4XeeHBUk/8BG6b9GjZrjrBNwGA2ytEpbBV6+pr
         X8J77y863Y0rzxVm+nsfhb3oU9+zBTjUgF4xGPqGtX4PS+5GVaa62a0sFlpwRIyMGGcH
         6hMKb+q81EE6ODCRSRuPLmdO8FITO4ONsu8CZakWFXW9FQ3NNiqiceEYby5KxJoBVPUB
         QDCDVNfSY158XQmr/YZ1I+E6frq3v/d1mm5JGuKBIefNeMlk8x+weVZn4RpfnB62ow45
         nNFBjAT3mtB5OV0YURHqaXLW++QWl+qmEx/Rq/FawmU8RhN9VkHQHQ7s+3p7qiDd25OR
         zoPQ==
X-Gm-Message-State: APzg51CUkCw7A0Uw0XyUlk+HyLMirZ36xHyqlwZHkmFoT6wRxZE+IrgS
        4dcxyXcMSSSxazgsfpBVXHo0o+NkKQCJoQ==
X-Google-Smtp-Source: ANB0VdaxaSE7+lLZp2sHqUZazu+Y8NwzM6CBX7SKJH/HJqGnlPtID1ZOU+qbIx9RvxvuX94U/rYaZA==
X-Received: by 2002:a24:6e0f:: with SMTP id w15-v6mr20900860itc.77.1537339936033;
        Tue, 18 Sep 2018 23:52:16 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:15 -0700 (PDT)
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
Subject: [PATCH v3 2/9] kernel/jump_label: implement generic support for relative references
Date:   Tue, 18 Sep 2018 23:51:37 -0700
Message-Id: <20180919065144.25010-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
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
index 6801123932a5..9d329608913e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -359,6 +359,9 @@ config HAVE_PERF_USER_STACK_DUMP
 config HAVE_ARCH_JUMP_LABEL
 	bool
 
+config HAVE_ARCH_JUMP_LABEL_RELATIVE
+	bool
+
 config HAVE_RCU_TABLE_FREE
 	bool
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2eadff9b3b90..2768a925bafa 100644
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
index 834e43de0daf..898a1d0c38dc 100644
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

