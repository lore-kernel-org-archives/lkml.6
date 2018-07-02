Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE4C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49E721920
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkyoYASw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49E721920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeGBSOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:14:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35747 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753328AbeGBSLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:11:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id h40-v6so5338872wrh.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bYIEjgYsFCspjdyZn23Ek0/9Xld2X4/AQrtzD7Bk1Ig=;
        b=FkyoYASwtLuwL6Ys+RF95vTBeo00E/h6AYLejkixx4YIeQU0cTYq08FQDO/RhDyvl0
         pjVysDdtmPuDQb5zTxUNpxwi9jKuDKYg4aUvAGVXc5v5b5+ozJKscnU+swtD2RuB2VXr
         MfR7HAW5r8vkudT3oYUv0kfmrzgEd+c5uvu1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bYIEjgYsFCspjdyZn23Ek0/9Xld2X4/AQrtzD7Bk1Ig=;
        b=X5kZDyAdnlBBQFkv5LDd0wF3zKlroEVAxw1iyyxKg3CQzgGPQXAj34G1yyUzBKX1xs
         2YETIgjS0MwS/5/SbXWhkzvbBzbd3hKqANiM+GTDpWvgI43F2BRx44887huYWtf+fRc0
         rrJOVGJ7TLZw1PfptJQxq3ONTFsFTx7/n1tAvelWYxxzIPiTn5bRDF2cvILnE6eqD84I
         hgWXLjLW7GTcx6Wfd2XWViY59bcAEb1tizgOupcKWtxGKr2b7t3czT7LJAO882XWmicZ
         AcNkzoJrR7Cvq3a87jrRp0VVwbECWZSh8WlqKm7c6bGdvOQ7P7mzuJyIvD/g5YY//yki
         wZkA==
X-Gm-Message-State: APt69E0Q6gy3blRGAyB3sGCBjn7RSSVtcU7AkV1KNX3LECvgGy8JX5iY
        winHotm1KZlEcaT6jEE49TjtWw==
X-Google-Smtp-Source: AAOMgpcwBTN4GfWSh4LmzewwhWn+MqQ4om1yFsH2NR/SCd1yx2z/yK8fNWZ22NgZ/oAHnGfmeWS5ew==
X-Received: by 2002:adf:de84:: with SMTP id w4-v6mr8884955wrl.270.1530555114143;
        Mon, 02 Jul 2018 11:11:54 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:11:53 -0700 (PDT)
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
Subject: [PATCH v2 1/8] kernel/jump_label: abstract jump_entry member accessors
Date:   Mon,  2 Jul 2018 20:11:38 +0200
Message-Id: <20180702181145.4799-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of allowing architectures to use relative references
in jump_label entries [which can dramatically reduce the memory
footprint], introduce abstractions for references to the 'code',
'target' and 'key' members of struct jump_entry.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/jump_label.h | 34 +++++++++++++++++
 kernel/jump_label.c        | 40 ++++++++------------
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b46b541c67c4..4603a1c88e48 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -119,6 +119,40 @@ struct static_key {
 
 #ifdef HAVE_JUMP_LABEL
 #include <asm/jump_label.h>
+
+#ifndef __ASSEMBLY__
+
+static inline unsigned long jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline unsigned long jump_entry_target(const struct jump_entry *entry)
+{
+	return entry->target;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#endif
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..8a3ac4f5f490 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -38,10 +38,10 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
-	if (jea->key < jeb->key)
+	if (jump_entry_key(jea) < jump_entry_key(jeb))
 		return -1;
 
-	if (jea->key > jeb->key)
+	if (jump_entry_key(jea) > jump_entry_key(jeb))
 		return 1;
 
 	return 0;
@@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit);
 
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
-	if (entry->code <= (unsigned long)end &&
-		entry->code + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	if (jump_entry_code(entry) <= (unsigned long)end &&
+	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
 		return 1;
 
 	return 0;
@@ -321,16 +321,6 @@ static inline void static_key_set_linked(struct static_key *key)
 	key->type |= JUMP_TYPE_LINKED;
 }
 
-static inline struct static_key *jump_entry_key(struct jump_entry *entry)
-{
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
-}
-
-static bool jump_entry_branch(struct jump_entry *entry)
-{
-	return (unsigned long)entry->key & 1UL;
-}
-
 /***
  * A 'struct static_key' uses a union such that it either points directly
  * to a table of 'struct jump_entry' or to a linked list of modules which in
@@ -355,7 +345,7 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool enabled = static_key_enabled(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return enabled ^ branch;
@@ -370,12 +360,12 @@ static void __jump_label_update(struct static_key *key,
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
 		 */
-		if (entry->code) {
-			if (kernel_text_address(entry->code))
+		if (!jump_entry_is_init(entry)) {
+			if (kernel_text_address(jump_entry_code(entry)))
 				arch_jump_label_transform(entry, jump_label_type(entry));
 			else
 				WARN_ONCE(1, "can't patch jump_label at %pS",
-					  (void *)(unsigned long)entry->code);
+					  (void *)jump_entry_code(entry));
 		}
 	}
 }
@@ -430,8 +420,8 @@ void __init jump_label_invalidate_initmem(void)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (init_section_contains((void *)(unsigned long)iter->code, 1))
-			iter->code = 0;
+		if (init_section_contains((void *)jump_entry_code(iter), 1))
+			jump_entry_set_init(iter);
 	}
 }
 
@@ -441,7 +431,7 @@ static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool type = static_key_type(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return type ^ branch;
@@ -565,7 +555,7 @@ static int jump_label_add_module(struct module *mod)
 			continue;
 
 		key = iterk;
-		if (within_module(iter->key, mod)) {
+		if (within_module((unsigned long)key, mod)) {
 			static_key_set_entries(key, iter);
 			continue;
 		}
@@ -615,7 +605,7 @@ static void jump_label_del_module(struct module *mod)
 
 		key = jump_entry_key(iter);
 
-		if (within_module(iter->key, mod))
+		if (within_module((unsigned long)key, mod))
 			continue;
 
 		/* No memory during module load */
@@ -659,8 +649,8 @@ static void jump_label_invalidate_module_init(struct module *mod)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (within_module_init(iter->code, mod))
-			iter->code = 0;
+		if (within_module_init(jump_entry_code(iter), mod))
+			jump_entry_set_init(iter);
 	}
 }
 
-- 
2.17.1

