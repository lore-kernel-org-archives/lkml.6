Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753693AbeBUKtR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:49:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeBUKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:49:15 -0500
Date: Wed, 21 Feb 2018 02:48:30 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-48a76de86d9c882d3c5713b1fe51bbde39b833f3@git.kernel.org>
Cc: jbaron@akamai.com, torvalds@linux-foundation.org, bp@suse.de,
        jpoimboe@redhat.com, hpa@zytor.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        jpoimboe@redhat.com, bp@suse.de, torvalds@linux-foundation.org,
        jbaron@akamai.com
In-Reply-To: <c52825c73f3a174e8398b6898284ec20d4deb126.1519051220.git.jpoimboe@redhat.com>
References: <c52825c73f3a174e8398b6898284ec20d4deb126.1519051220.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] jump_label: Explicitly disable jump labels in __init
 code
Git-Commit-ID: 48a76de86d9c882d3c5713b1fe51bbde39b833f3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  48a76de86d9c882d3c5713b1fe51bbde39b833f3
Gitweb:     https://git.kernel.org/tip/48a76de86d9c882d3c5713b1fe51bbde39b833f3
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Tue, 20 Feb 2018 11:37:51 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:11:39 +0100

jump_label: Explicitly disable jump labels in __init code

After initmem has been freed, any jump labels in __init code are
prevented from being written to by the kernel_text_address() check in
__jump_label_update().  However, this check is quite broad.  If
kernel_text_address() were to return false for any other reason, the
jump label write would fail silently with no warning.

For jump labels in module init code, entry->code is set to zero to
indicate that the entry is disabled.  Do the same thing for core kernel
init code.  This makes the behavior more consistent, and will also make
it more straightforward to detect non-init jump label write failures in
the next patch.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/c52825c73f3a174e8398b6898284ec20d4deb126.1519051220.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/jump_label.h |  3 +++
 init/main.c                |  2 ++
 kernel/jump_label.c        | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b6a29c1..2168cc6 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -151,6 +151,7 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
+extern void jump_label_invalidate_init(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
@@ -198,6 +199,8 @@ static __always_inline void jump_label_init(void)
 	static_key_initialized = true;
 }
 
+static inline void jump_label_invalidate_init(void) {}
+
 static __always_inline bool static_key_false(struct static_key *key)
 {
 	if (unlikely(static_key_count(key) > 0))
diff --git a/init/main.c b/init/main.c
index a8100b9..969eaf1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -89,6 +89,7 @@
 #include <linux/io.h>
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
+#include <linux/jump_label.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1000,6 +1001,7 @@ static int __ref kernel_init(void *unused)
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
 	ftrace_free_init_mem();
+	jump_label_invalidate_init();
 	free_initmem();
 	mark_readonly();
 	system_state = SYSTEM_RUNNING;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b451709..b717765 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -16,6 +16,7 @@
 #include <linux/jump_label_ratelimit.h>
 #include <linux/bug.h>
 #include <linux/cpu.h>
+#include <asm/sections.h>
 
 #ifdef HAVE_JUMP_LABEL
 
@@ -417,6 +418,20 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
+/* Disable any jump label entries in __init code */
+void __init jump_label_invalidate_init(void)
+{
+	struct jump_entry *iter_start = __start___jump_table;
+	struct jump_entry *iter_stop = __stop___jump_table;
+	struct jump_entry *iter;
+
+	for (iter = iter_start; iter < iter_stop; iter++) {
+		if (iter->code >= (unsigned long)_sinittext &&
+		    iter->code < (unsigned long)_einittext)
+			iter->code = 0;
+	}
+}
+
 #ifdef CONFIG_MODULES
 
 static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
@@ -633,6 +648,7 @@ static void jump_label_del_module(struct module *mod)
 	}
 }
 
+/* Disable any jump label entries in module init code */
 static void jump_label_invalidate_module_init(struct module *mod)
 {
 	struct jump_entry *iter_start = mod->jump_entries;
