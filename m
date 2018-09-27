Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B6CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE5F21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE5F21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeI0WX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:23:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeI0WX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:23:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RG4EL8085120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 09:04:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RG4EmK085117;
        Thu, 27 Sep 2018 09:04:14 -0700
Date:   Thu, 27 Sep 2018 09:04:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-19483677684b6ca01606f58503cb79cdfbbc7c72@git.kernel.org>
Cc:     arnd@arndb.de, heiko.carstens@de.ibm.com, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org, hpa@zytor.com,
        catalin.marinas@arm.com, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        schwidefsky@de.ibm.com, mingo@kernel.org
Reply-To: keescook@chromium.org, heiko.carstens@de.ibm.com, arnd@arndb.de,
          rostedt@goodmis.org, catalin.marinas@arm.com,
          peterz@infradead.org, hpa@zytor.com, will.deacon@arm.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jeyu@kernel.org, ard.biesheuvel@linaro.org, mingo@kernel.org,
          schwidefsky@de.ibm.com
In-Reply-To: <20180919065144.25010-8-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-8-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] jump_label: Annotate entries that operate on __init
 code earlier
Git-Commit-ID: 19483677684b6ca01606f58503cb79cdfbbc7c72
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  19483677684b6ca01606f58503cb79cdfbbc7c72
Gitweb:     https://git.kernel.org/tip/19483677684b6ca01606f58503cb79cdfbbc7c72
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 18 Sep 2018 23:51:42 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 17:56:48 +0200

jump_label: Annotate entries that operate on __init code earlier

Jump table entries are mostly read-only, with the exception of the
init and module loader code that defuses entries that point into init
code when the code being referred to is freed.

For robustness, it would be better to move these entries into the
ro_after_init section, but clearing the 'code' member of each jump
table entry referring to init code at module load time races with the
module_enable_ro() call that remaps the ro_after_init section read
only, so we'd like to do it earlier.

So given that whether such an entry refers to init code can be decided
much earlier, we can pull this check forward. Since we may still need
the code entry at this point, let's switch to setting a low bit in the
'key' member just like we do to annotate the default state of a jump
table entry.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Link: https://lkml.kernel.org/r/20180919065144.25010-8-ard.biesheuvel@linaro.org

---
 include/linux/jump_label.h | 11 ++++-------
 init/main.c                |  1 -
 kernel/jump_label.c        | 48 ++++++++++++++--------------------------------
 3 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2768a925bafa..5df6a621e464 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -141,7 +141,7 @@ static inline unsigned long jump_entry_target(const struct jump_entry *entry)
 
 static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 {
-	long offset = entry->key & ~1L;
+	long offset = entry->key & ~3L;
 
 	return (struct static_key *)((unsigned long)&entry->key + offset);
 }
@@ -160,7 +160,7 @@ static inline unsigned long jump_entry_target(const struct jump_entry *entry)
 
 static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 {
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+	return (struct static_key *)((unsigned long)entry->key & ~3UL);
 }
 
 #endif
@@ -172,12 +172,12 @@ static inline bool jump_entry_is_branch(const struct jump_entry *entry)
 
 static inline bool jump_entry_is_init(const struct jump_entry *entry)
 {
-	return entry->code == 0;
+	return (unsigned long)entry->key & 2UL;
 }
 
 static inline void jump_entry_set_init(struct jump_entry *entry)
 {
-	entry->code = 0;
+	entry->key |= 2;
 }
 
 #endif
@@ -213,7 +213,6 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
-extern void jump_label_invalidate_initmem(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
@@ -261,8 +260,6 @@ static __always_inline void jump_label_init(void)
 	static_key_initialized = true;
 }
 
-static inline void jump_label_invalidate_initmem(void) {}
-
 static __always_inline bool static_key_false(struct static_key *key)
 {
 	if (unlikely(static_key_count(key) > 0))
diff --git a/init/main.c b/init/main.c
index 18f8f0140fa0..a664246450d1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1064,7 +1064,6 @@ static int __ref kernel_init(void *unused)
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
 	ftrace_free_init_mem();
-	jump_label_invalidate_initmem();
 	free_initmem();
 	mark_readonly();
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 898a1d0c38dc..e8cf3ff3149c 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -373,14 +373,15 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
-				struct jump_entry *stop)
+				struct jump_entry *stop,
+				bool init)
 {
 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
 		/*
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
 		 */
-		if (!jump_entry_is_init(entry)) {
+		if (init || !jump_entry_is_init(entry)) {
 			if (kernel_text_address(jump_entry_code(entry)))
 				arch_jump_label_transform(entry, jump_label_type(entry));
 			else
@@ -420,6 +421,9 @@ void __init jump_label_init(void)
 		if (jump_label_type(iter) == JUMP_LABEL_NOP)
 			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
 
+		if (init_section_contains((void *)jump_entry_code(iter), 1))
+			jump_entry_set_init(iter);
+
 		iterk = jump_entry_key(iter);
 		if (iterk == key)
 			continue;
@@ -432,19 +436,6 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
-/* Disable any jump label entries in __init/__exit code */
-void __init jump_label_invalidate_initmem(void)
-{
-	struct jump_entry *iter_start = __start___jump_table;
-	struct jump_entry *iter_stop = __stop___jump_table;
-	struct jump_entry *iter;
-
-	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (init_section_contains((void *)jump_entry_code(iter), 1))
-			jump_entry_set_init(iter);
-	}
-}
-
 #ifdef CONFIG_MODULES
 
 static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
@@ -524,7 +515,8 @@ static void __jump_label_mod_update(struct static_key *key)
 			stop = __stop___jump_table;
 		else
 			stop = m->jump_entries + m->num_jump_entries;
-		__jump_label_update(key, mod->entries, stop);
+		__jump_label_update(key, mod->entries, stop,
+				    m->state == MODULE_STATE_COMING);
 	}
 }
 
@@ -570,6 +562,9 @@ static int jump_label_add_module(struct module *mod)
 	for (iter = iter_start; iter < iter_stop; iter++) {
 		struct static_key *iterk;
 
+		if (within_module_init(jump_entry_code(iter), mod))
+			jump_entry_set_init(iter);
+
 		iterk = jump_entry_key(iter);
 		if (iterk == key)
 			continue;
@@ -605,7 +600,7 @@ static int jump_label_add_module(struct module *mod)
 
 		/* Only update if we've changed from our initial state */
 		if (jump_label_type(iter) != jump_label_init_type(iter))
-			__jump_label_update(key, iter, iter_stop);
+			__jump_label_update(key, iter, iter_stop, true);
 	}
 
 	return 0;
@@ -661,19 +656,6 @@ static void jump_label_del_module(struct module *mod)
 	}
 }
 
-/* Disable any jump label entries in module init code */
-static void jump_label_invalidate_module_init(struct module *mod)
-{
-	struct jump_entry *iter_start = mod->jump_entries;
-	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
-	struct jump_entry *iter;
-
-	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (within_module_init(jump_entry_code(iter), mod))
-			jump_entry_set_init(iter);
-	}
-}
-
 static int
 jump_label_module_notify(struct notifier_block *self, unsigned long val,
 			 void *data)
@@ -695,9 +677,6 @@ jump_label_module_notify(struct notifier_block *self, unsigned long val,
 	case MODULE_STATE_GOING:
 		jump_label_del_module(mod);
 		break;
-	case MODULE_STATE_LIVE:
-		jump_label_invalidate_module_init(mod);
-		break;
 	}
 
 	jump_label_unlock();
@@ -767,7 +746,8 @@ static void jump_label_update(struct static_key *key)
 	entry = static_key_entries(key);
 	/* if there are no users, entry can be NULL */
 	if (entry)
-		__jump_label_update(key, entry, stop);
+		__jump_label_update(key, entry, stop,
+				    system_state < SYSTEM_RUNNING);
 }
 
 #ifdef CONFIG_STATIC_KEYS_SELFTEST
