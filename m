Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6E925D8F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNVV4EdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6E925D8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935118AbeF0QHe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:07:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51973 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934916AbeF0QGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:06:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id w137-v6so6477111wmw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4S8kZQAvHa84YpWVvxunUgaXp0tuBTi7qepgqm8/+QE=;
        b=bNVV4EdSWbYIG3AcgXqoPrgzHv5IuSt1y79hMVSTqlv4GSE4DswGLrww8OA0uUBI4+
         hh5hIMZh3Z4SrdgXjLmiRdIWEOb7HOj5fFV/VFoCLlL0JUQYEYCtPuvMJBX+JQBVx9/G
         tXDhyhXI8X7QnidEH3SaViXefT2ypauu6Asy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4S8kZQAvHa84YpWVvxunUgaXp0tuBTi7qepgqm8/+QE=;
        b=CNjNu8RTQN7s1LlKnevB4oZ2WBjl3rd1ISekPzCzmOqVreRYaWYJio/Fv6BmkX48y2
         QACvsMy3hXjtXflQYqSO+91eSY1zQqGy30WiofdMMoToRrlCaUmapVFxl/586kamvJo/
         nVUQPwrhBqSkCDmQyJpnyLv63+XLuvaUivpk5tm38jwxsS6LQ36bMYzbnI/IqLa8+g2V
         2caT6sp/5CXukE1r3B6PucnwuqeqVO1PT1ybrgUltSi9r0kyM7HK4ab8KW2XYgVYxFu4
         cQesd2IK7ibLNXJFaS+L8SlT025fzilRsjCnU4B4N26M6JuYkB7rKcmz21MpQjK2KVxZ
         pZWA==
X-Gm-Message-State: APt69E21Dhq9o6KV1e3FXChPxmy5aUCzFV4/HN+7n7msBNcY8PX5lIbw
        g+Yku/jUNnrl2a10EJsw5nGzCjAb/rQ=
X-Google-Smtp-Source: AAOMgpdWFyGN4KR8CEIzYOKzyXFmpA36LSoaMHgh33ZPinoLY9NOznCvWIoUCvwiAqcQLIIPFyvI+A==
X-Received: by 2002:a1c:8c55:: with SMTP id o82-v6mr5246007wmd.60.1530115570114;
        Wed, 27 Jun 2018 09:06:10 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:4d04:66e:dea8:5b23])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7055000wrn.75.2018.06.27.09.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:06:09 -0700 (PDT)
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
Subject: [PATCH 2/5] kernel/jump_label: implement generic support for relative references
Date:   Wed, 27 Jun 2018 18:06:01 +0200
Message-Id: <20180627160604.8154-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce the size taken up by absolute references in jump label
entries themselves and the associated relocation records in the
.init segment, add support for emitting them as 32-bit relative
references instead.

Note that this requires some extra care in the sorting routine, given
that the offsets change when entries are moved around in the jump_entry
table.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig               |  3 +++
 include/linux/jump_label.h | 28 ++++++++++++++++++++
 kernel/jump_label.c        | 20 +++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

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
index 86ec0652d3b1..aa203dffe72c 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -121,6 +121,32 @@ struct static_key {
 #include <asm/jump_label.h>
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
+
+struct jump_entry {
+	int code;
+	int target;
+	int key;
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
+	unsigned long key = (unsigned long)&entry->key + entry->key;
+
+	return (struct static_key *)(key & ~1UL);
+}
+
+#else
 
 struct jump_entry; /* defined by the architecture */
 
@@ -139,6 +165,8 @@ static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 	return (struct static_key *)((unsigned long)entry->key & ~1UL);
 }
 
+#endif
+
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
 {
 	return (unsigned long)entry->key & 1UL;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index c3524c9b3004..285eff13ecd1 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -49,6 +49,22 @@ static int jump_label_cmp(const void *a, const void *b)
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
@@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 
 	size = (((unsigned long)stop - (unsigned long)start)
 					/ sizeof(struct jump_entry));
-	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
+	sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
+	     IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
+							      : NULL);
 }
 
 static void jump_label_update(struct static_key *key);
-- 
2.11.0

