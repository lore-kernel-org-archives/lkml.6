Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A7BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A3B25CF1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtvViJLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A3B25CF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935063AbeF0QGN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:06:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39275 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934909AbeF0QGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:06:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so6049881wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B883F5dmVQG/nVCIvlNlD4L/gAxRvgth0kf0bW+7srI=;
        b=EtvViJLKEsaJc1tUpkX0Rq3AVPZIsvTnuvmrDdheEm3Cuzmo+BdVFP1GP+C72Vhw/n
         SCeEF4dtSkdT6YmgeP8veplRNpA8xMUnT5Tlqug5UeQRyKREdWG/heVBFAABnvcyR3/x
         llqh1uRcU4ZMXTp/TU1Hvqd22ggTAs9RFmXSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B883F5dmVQG/nVCIvlNlD4L/gAxRvgth0kf0bW+7srI=;
        b=U6YfIMZJD4bCUg4JrixzH3TNTYKXw5JPhaO/vYp8/PSQEuPchAr6CtjlICVAYU9fF/
         lbrCuMyLzV1+OEFMg2M/RsH2IssSJlNXYgTS6HzWH/IJUL9kx8s2DHbT5VC9dnk2suOF
         K2/y4ve5Sg2ZEzlFflL9ENIdjc79YPToD0TG5elOvvsNUfsAshAwApB01Z6rDXiPMaaI
         AiN2qauPn/ter9k0P72IgPXrHJx1noKn62V1NZ+JACmUTQwyEWGs/tUJg78vhdPR9mfa
         sPD9uAgWhvVPBYX2GjpfHS5Q4QBHXEBrurYS5rTfn+S9tp3NBLIC1H8hVhNwaK9m/knw
         1/Dg==
X-Gm-Message-State: APt69E10b8J3uQhfgsIjLv2whomF3xjEgtqJw2jtoA1QWyl7/8sNmFq6
        AFnnePeGGAsB+RMhYmXKFqcg1Ctm4zs=
X-Google-Smtp-Source: AAOMgpf4oGIID2RYMS0n4DqJBmklyZIyMYgozHgXjUtX0V6riej/uLL+BPBmBaTC1iigxEi/5l06Tw==
X-Received: by 2002:a1c:5a08:: with SMTP id o8-v6mr5247383wmb.61.1530115568787;
        Wed, 27 Jun 2018 09:06:08 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:4d04:66e:dea8:5b23])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7055000wrn.75.2018.06.27.09.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:06:08 -0700 (PDT)
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
Subject: [PATCH 1/5] kernel/jump_label: abstract jump_entry member accessors
Date:   Wed, 27 Jun 2018 18:06:00 +0200
Message-Id: <20180627160604.8154-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
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
 include/linux/jump_label.h | 36 ++++++++++++++++++++
 kernel/jump_label.c        | 36 ++++++++------------
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b46b541c67c4..86ec0652d3b1 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -119,6 +119,42 @@ struct static_key {
 
 #ifdef HAVE_JUMP_LABEL
 #include <asm/jump_label.h>
+
+#ifndef __ASSEMBLY__
+
+struct jump_entry; /* defined by the architecture */
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
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#endif
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..c3524c9b3004 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -38,10 +38,12 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
-	if (jea->key < jeb->key)
+	if ((unsigned long)jump_entry_key(jea) <
+	    (unsigned long)jump_entry_key(jeb))
 		return -1;
 
-	if (jea->key > jeb->key)
+	if ((unsigned long)jump_entry_key(jea) >
+	    (unsigned long)jump_entry_key(jeb))
 		return 1;
 
 	return 0;
@@ -261,8 +263,8 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit);
 
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
-	if (entry->code <= (unsigned long)end &&
-		entry->code + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	if (jump_entry_code(entry) <= (unsigned long)end &&
+	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
 		return 1;
 
 	return 0;
@@ -321,16 +323,6 @@ static inline void static_key_set_linked(struct static_key *key)
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
@@ -355,7 +347,7 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool enabled = static_key_enabled(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return enabled ^ branch;
@@ -370,8 +362,8 @@ static void __jump_label_update(struct static_key *key,
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
 		 */
-		if (entry->code) {
-			if (kernel_text_address(entry->code))
+		if (!jump_entry_is_module_init(entry)) {
+			if (kernel_text_address(jump_entry_code(entry)))
 				arch_jump_label_transform(entry, jump_label_type(entry));
 			else
 				WARN_ONCE(1, "can't patch jump_label at %pS",
@@ -441,7 +433,7 @@ static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool type = static_key_type(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return type ^ branch;
@@ -565,7 +557,7 @@ static int jump_label_add_module(struct module *mod)
 			continue;
 
 		key = iterk;
-		if (within_module(iter->key, mod)) {
+		if (within_module((unsigned long)key, mod)) {
 			static_key_set_entries(key, iter);
 			continue;
 		}
@@ -615,7 +607,7 @@ static void jump_label_del_module(struct module *mod)
 
 		key = jump_entry_key(iter);
 
-		if (within_module(iter->key, mod))
+		if (within_module((unsigned long)key, mod))
 			continue;
 
 		/* No memory during module load */
@@ -659,8 +651,8 @@ static void jump_label_invalidate_module_init(struct module *mod)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (within_module_init(iter->code, mod))
-			iter->code = 0;
+		if (within_module_init(jump_entry_code(iter), mod))
+			jump_entry_set_module_init(iter);
 	}
 }
 
-- 
2.11.0

