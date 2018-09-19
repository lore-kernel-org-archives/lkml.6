Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB22CECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D672146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhK3obIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D672146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbeISM2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:28:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43766 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeISM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:28:42 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so3588947ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FZJNEVNflrAxT+1Z0Hv5uIC0eQ5VzZc2FwvWytlu3MQ=;
        b=EhK3obIXXfTsziRS4vydKb2tw/b8QbSumbZwfBdocf8KWlnGbvytD6YkoFzpwgpz8o
         YW5z7ju0gy9iwK67mFRVf1NQlXfH+qCIOW+LgDoyAhmatpvTE7mGtXg7VqGeuSes5EKK
         N6syiiph9gKTA+xyTGgM1CO1Gvw/wJNtuCdgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FZJNEVNflrAxT+1Z0Hv5uIC0eQ5VzZc2FwvWytlu3MQ=;
        b=bMBaXinzDWcQQ34yQ9nOKUvOH4qRG7Y7LnHpKx1K+0+lyUYpw33Nl/yGRkF77o+H8d
         LsmIMJyvXPN+BZQb6cypZoZEqBXZzzxaQSUjZwFlKH/IN0AlonD6P3nrFxZNf89gCPjq
         JYMNKteBogBQMtied5wwYDzGSRy7y6N8MPRKWne48WGEyO/rsIbF/eI0xls5kIH6h8Ud
         9lds8QAlfX4a/YXHCHwOInWqArK8Dg7yRu1XBsQFxLuiq+pzN4I+Dnv+mRTbQTxmesQD
         wy55yexrLBgxMtPs8HknjqibOe5vw6MeDlyM4l1LFurZpRzz/rELhLfjfJCSCH8FLOYq
         dHYA==
X-Gm-Message-State: APzg51CfyMY6Zev93XztpZaMmS4a3vHCle9Ch0DE+H/qblI9vsXOTiKo
        R0X4Q6DSckiVtfM4bod3rZNRZkifimM6cw==
X-Google-Smtp-Source: ANB0VdaIiJrzgxXWBxuIAnUhl/0ErBhuYUX5OmCNWJXtIloBOoTXwE50R1pAazveXxSMGzcWHXk2rA==
X-Received: by 2002:a6b:9d95:: with SMTP id g143-v6mr28303195ioe.46.1537339931935;
        Tue, 18 Sep 2018 23:52:11 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:11 -0700 (PDT)
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
Subject: [PATCH v3 1/9] kernel/jump_label: abstract jump_entry member accessors
Date:   Tue, 18 Sep 2018 23:51:36 -0700
Message-Id: <20180919065144.25010-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of allowing architectures to use relative references
in jump_label entries [which can dramatically reduce the memory
footprint], introduce abstractions for references to the 'code' and
'key' members of struct jump_entry.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/jump_label.h | 34 +++++++++++++++++
 kernel/jump_label.c        | 40 ++++++++------------
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 1a0b6f17a5d6..2eadff9b3b90 100644
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
index 2e62503bea0d..834e43de0daf 100644
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

