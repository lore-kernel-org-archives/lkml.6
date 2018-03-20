Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeCTJ6m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:58:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeCTJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:58:37 -0400
Date: Tue, 20 Mar 2018 02:57:50 -0700
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-c3fb3dfce2ad4e17e6f1d090b56e3d9f09a3f509@git.kernel.org>
Cc: jbaron@akamai.com, tglx@linutronix.de, jpoimboe@redhat.com,
        hpa@zytor.com, peterz@infradead.org, liwang@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de
Reply-To: bp@suse.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        liwang@redhat.com, peterz@infradead.org, hpa@zytor.com,
        jpoimboe@redhat.com, tglx@linutronix.de, jbaron@akamai.com
In-Reply-To: <7121e6e595374f06616c505b6e690e275c0054d1.1521483452.git.jpoimboe@redhat.com>
References: <7121e6e595374f06616c505b6e690e275c0054d1.1521483452.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] jump_label: Disable jump labels in __exit code
Git-Commit-ID: c3fb3dfce2ad4e17e6f1d090b56e3d9f09a3f509
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

Commit-ID:  c3fb3dfce2ad4e17e6f1d090b56e3d9f09a3f509
Gitweb:     https://git.kernel.org/tip/c3fb3dfce2ad4e17e6f1d090b56e3d9f09a3f509
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Mon, 19 Mar 2018 13:18:57 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 20 Mar 2018 10:51:25 +0100

jump_label: Disable jump labels in __exit code

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

Fixes: dc1dd184c2f0 ("jump_label: Warn on failed jump_label patching attempt")
Reported-and-tested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/7121e6e595374f06616c505b6e690e275c0054d1.1521483452.git.jpoimboe@redhat.com

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
index e7214093dcd1..01ebdf1f9f40 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -16,6 +16,7 @@
 #include <linux/jump_label_ratelimit.h>
 #include <linux/bug.h>
 #include <linux/cpu.h>
+#include <asm/sections.h>
 
 #ifdef HAVE_JUMP_LABEL
 
@@ -421,15 +422,15 @@ void __init jump_label_init(void)
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
