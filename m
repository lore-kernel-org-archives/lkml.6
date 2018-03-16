Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeCPPPB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:15:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753210AbeCPPO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:14:59 -0400
Date: Fri, 16 Mar 2018 10:14:56 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Li Wang <liwang@redhat.com>
Cc: jbaron@akamai.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: CPU: 0 PID: 22572 at kernel/jump_label.c:376
 __jump_label_update+0x9d/0xb0
Message-ID: <20180316151456.lx6u7xdhqm2gethx@treble>
References: <CAEemH2cvaRSOo-Jmkd=8gPSaeTtHLR44iK2p8BzfXYEqGTjNdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEemH2cvaRSOo-Jmkd=8gPSaeTtHLR44iK2p8BzfXYEqGTjNdA@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:11:54AM +0800, Li Wang wrote:
> Hi,
> 
> ltp/dynamic_debug01.sh trigger this Warning on x86_64 with
> kernel-v4.16.0-rc5.
> 
> 
> [ 8216.976433] ------------[ cut here ]------------
> [ 8216.981615] can't patch jump_label at dmi_sysfs_exit+0x0/0x2d
> [ 8216.981625] WARNING: CPU: 0 PID: 22572 at kernel/jump_label.c:376
> __jump_label_update+0x9d/0xb0

Hi Li,

Thanks for reporting it.  This seems to be caused by the pr_debug() in
dmi_sysfs_exit(), which is in the .exit.text section (assuming your
config has CONFIG_DMI_SYSFS=y, which means the function is freed during
boot.)

Can you test the following fix?

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
