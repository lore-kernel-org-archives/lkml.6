Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946261AbeCBKdU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:33:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:35617 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946111AbeCBK3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:29:52 -0500
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v9 7/9] livepatch: Correctly handle atomic replace for not yet loaded modules
Date: Fri,  2 Mar 2018 11:29:33 +0100
Message-Id: <20180302102935.14564-8-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180302102935.14564-1-pmladek@suse.com>
References: <20180302102935.14564-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic replace feature uses dynamically allocated struct klp_func to
handle functions that will no longer be patched. These structures are
of the type KLP_FUNC_NOP. They cause the ftrace handler to jump to
the original code. But the address of the original code is not known
until the patched module is loaded.

This patch allows the late initialization. Also it adds a sanity check
into the ftrace handler.

Alternative solution would be not to set the address at all. The ftrace
handler could just return to the original code when NOP struct klp_func
is used. But this would require another changes. For example, in the stack
checking. Note that NOP structures might be available even when the patch
is being disabled. This would happen when the patch enable transition is
reverted.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c  | 22 ++++++++++++++++++----
 kernel/livepatch/patch.c |  5 +++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index ad508a86b2f9..ce9f40a175d9 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -781,8 +781,10 @@ static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
 		}
 	}
 	func->old_sympos = old_func->old_sympos;
-	/* NOP func is the same as using the original implementation. */
-	func->new_func = (void *)old_func->old_addr;
+	/*
+	 * func->new_func is same as func->old_addr. These addresses are
+	 * set when the object is loaded, see klp_init_object_loaded().
+	 */
 	func->ftype = KLP_FUNC_NOP;
 
 	return func;
@@ -945,8 +947,12 @@ static void klp_free_object_loaded(struct klp_object *obj)
 
 	obj->mod = NULL;
 
-	klp_for_each_func(obj, func)
+	klp_for_each_func(obj, func) {
 		func->old_addr = 0;
+
+		if (klp_is_func_type(func, KLP_FUNC_NOP))
+			func->new_func = NULL;
+	}
 }
 
 /*
@@ -984,7 +990,12 @@ static void klp_free_patch(struct klp_patch *patch)
 
 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
-	if (!func->old_name || !func->new_func)
+	if (!func->old_name)
+		return -EINVAL;
+
+	/* NOPs do not know the address until the patched module is loaded. */
+	if (!func->new_func &&
+	    (!klp_is_func_type(func, KLP_FUNC_NOP) || klp_is_object_loaded(obj)))
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&func->stack_node);
@@ -1039,6 +1050,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			return -ENOENT;
 		}
 
+		if (klp_is_func_type(func, KLP_FUNC_NOP))
+			func->new_func = (void *)func->old_addr;
+
 		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
 						  &func->new_size, NULL);
 		if (!ret) {
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 54b3c379bb0f..1f5c3eea9ee1 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -118,7 +118,12 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 		}
 	}
 
+	/* Survive ugly mistakes, for example, when handling NOPs. */
+	if (WARN_ON_ONCE(!func->new_func))
+		goto unlock;
+
 	klp_arch_set_pc(regs, (unsigned long)func->new_func);
+
 unlock:
 	preempt_enable_notrace();
 }
-- 
2.13.6
