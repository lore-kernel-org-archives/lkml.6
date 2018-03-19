Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970972AbeCSTxb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S969418AbeCSSTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:19:32 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>, Li Wang <liwang@redhat.com>
Subject: [PATCH] jump_label: Disable jump labels in __exit code
Date: Mon, 19 Mar 2018 13:18:57 -0500
Message-Id: <7121e6e595374f06616c505b6e690e275c0054d1.1521483452.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following commit:

  333522447063 ("jump_label: Explicitly disable jump labels in __init code")

... we explicitly disabled jump labels in __init code, so they could be
detected and not warned about in the following commit:

  dc1dd184c2f0 ("jump_label: Warn on failed jump_label patching attempt")

In-kernel __exit code has the same issue.  It's never used, so it's
freed along with the rest of initmem.  But jump label entries in __exit
code aren't explicitly disabled, so we get the following warning when
enabling pr_debug() in __exit code:

  can't patch jump_label at dmi_sysfs_exit+0x0/0x2d
  WARNING: CPU: 0 PID: 22572 at kernel/jump_label.c:376 __jump_label_update+0x9d/0xb0

Fix the warning by disabling all jump labels in initmem (which includes
both __init and __exit code).

Reported-and-tested-by: Li Wang <liwang@redhat.com>
Fixes: dc1dd184c2f0 ("jump_label: Warn on failed jump_label patching attempt")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/jump_label.h | 4 ++--
 init/main.c                | 2 +-
 kernel/jump_label.c        | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2168cc6b8b30..b46b541c67c4 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -151,7 +151,7 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
-extern void jump_label_invalidate_init(void);
+extern void jump_label_invalidate_initmem(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
@@ -199,7 +199,7 @@ static __always_inline void jump_label_init(void)
 	static_key_initialized = true;
 }
 
-static inline void jump_label_invalidate_init(void) {}
+static inline void jump_label_invalidate_initmem(void) {}
 
 static __always_inline bool static_key_false(struct static_key *key)
 {
diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..21efbf6ace93 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1001,7 +1001,7 @@ static int __ref kernel_init(void *unused)
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
 	ftrace_free_init_mem();
-	jump_label_invalidate_init();
+	jump_label_invalidate_initmem();
 	free_initmem();
 	mark_readonly();
 	system_state = SYSTEM_RUNNING;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 52a0a7af8640..b44ab1273456 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -16,6 +16,7 @@
 #include <linux/jump_label_ratelimit.h>
 #include <linux/bug.h>
 #include <linux/cpu.h>
+#include <asm/sections.h>
 
 #ifdef HAVE_JUMP_LABEL
 
@@ -420,15 +421,15 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
-/* Disable any jump label entries in __init code */
-void __init jump_label_invalidate_init(void)
+/* Disable any jump label entries in __init/__exit code */
+void __init jump_label_invalidate_initmem(void)
 {
 	struct jump_entry *iter_start = __start___jump_table;
 	struct jump_entry *iter_stop = __stop___jump_table;
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (init_kernel_text(iter->code))
+		if (init_section_contains((void *)(unsigned long)iter->code, 1))
 			iter->code = 0;
 	}
 }
-- 
2.14.3
