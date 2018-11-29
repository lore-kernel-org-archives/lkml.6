Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B9E2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B9E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeK2Uts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:49:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbeK2Uts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:49:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7360AD64;
        Thu, 29 Nov 2018 09:44:59 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v14 01/11] livepatch: Change unsigned long old_addr -> void *old_func in struct klp_func
Date:   Thu, 29 Nov 2018 10:44:21 +0100
Message-Id: <20181129094431.7801-2-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181129094431.7801-1-pmladek@suse.com>
References: <20181129094431.7801-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of the to be patched function and new function is stored
in struct klp_func as:

	void *new_func;
	unsigned long old_addr;

The different naming scheme and type is derived from the way how
the addresses are set. @old_addr is assigned at runtime using
kallsyms-based search. @new_func is statically initialized,
for example:

  static struct klp_func funcs[] = {
	{
		.old_name = "cmdline_proc_show",
		.new_func = livepatch_cmdline_proc_show,
	}, { }
  };

This patch changes unsigned log old_addr -> void *old_func. It removes
some confusion when these address are later used in the code. It is
motivated by a followup patch that adds special NOP struct klp_func
where we want to assign func->new_func = func->old_addr respectively
func->new_func = func->old_func.

This patch does not modify the existing behavior.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/livepatch.h     |  4 ++--
 kernel/livepatch/core.c       |  6 +++---
 kernel/livepatch/patch.c      | 18 ++++++++++--------
 kernel/livepatch/patch.h      |  2 +-
 kernel/livepatch/transition.c |  4 ++--
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index aec44b1d9582..634e13876380 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -40,7 +40,7 @@
  * @new_func:	pointer to the patched function code
  * @old_sympos: a hint indicating which symbol position the old function
  *		can be found (optional)
- * @old_addr:	the address of the function being patched
+ * @old_func:	pointer to the function being patched
  * @kobj:	kobject for sysfs resources
  * @stack_node:	list node for klp_ops func_stack list
  * @old_size:	size of the old function
@@ -77,7 +77,7 @@ struct klp_func {
 	unsigned long old_sympos;
 
 	/* internal */
-	unsigned long old_addr;
+	void *old_func;
 	struct kobject kobj;
 	struct list_head stack_node;
 	unsigned long old_size, new_size;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 5b77a7314e01..cb59c7fb94cb 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -648,7 +648,7 @@ static void klp_free_object_loaded(struct klp_object *obj)
 	obj->mod = NULL;
 
 	klp_for_each_func(obj, func)
-		func->old_addr = 0;
+		func->old_func = NULL;
 }
 
 /*
@@ -721,11 +721,11 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 	klp_for_each_func(obj, func) {
 		ret = klp_find_object_symbol(obj->name, func->old_name,
 					     func->old_sympos,
-					     &func->old_addr);
+					     (unsigned long *)&func->old_func);
 		if (ret)
 			return ret;
 
-		ret = kallsyms_lookup_size_offset(func->old_addr,
+		ret = kallsyms_lookup_size_offset((unsigned long)func->old_func,
 						  &func->old_size, NULL);
 		if (!ret) {
 			pr_err("kallsyms size lookup failed for '%s'\n",
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 82d584225dc6..130002eaadb8 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -34,7 +34,7 @@
 
 static LIST_HEAD(klp_ops);
 
-struct klp_ops *klp_find_ops(unsigned long old_addr)
+struct klp_ops *klp_find_ops(void *old_func)
 {
 	struct klp_ops *ops;
 	struct klp_func *func;
@@ -42,7 +42,7 @@ struct klp_ops *klp_find_ops(unsigned long old_addr)
 	list_for_each_entry(ops, &klp_ops, node) {
 		func = list_first_entry(&ops->func_stack, struct klp_func,
 					stack_node);
-		if (func->old_addr == old_addr)
+		if (func->old_func == old_func)
 			return ops;
 	}
 
@@ -142,17 +142,18 @@ static void klp_unpatch_func(struct klp_func *func)
 
 	if (WARN_ON(!func->patched))
 		return;
-	if (WARN_ON(!func->old_addr))
+	if (WARN_ON(!func->old_func))
 		return;
 
-	ops = klp_find_ops(func->old_addr);
+	ops = klp_find_ops(func->old_func);
 	if (WARN_ON(!ops))
 		return;
 
 	if (list_is_singular(&ops->func_stack)) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc = klp_get_ftrace_location(func->old_addr);
+		ftrace_loc =
+			klp_get_ftrace_location((unsigned long)func->old_func);
 		if (WARN_ON(!ftrace_loc))
 			return;
 
@@ -174,17 +175,18 @@ static int klp_patch_func(struct klp_func *func)
 	struct klp_ops *ops;
 	int ret;
 
-	if (WARN_ON(!func->old_addr))
+	if (WARN_ON(!func->old_func))
 		return -EINVAL;
 
 	if (WARN_ON(func->patched))
 		return -EINVAL;
 
-	ops = klp_find_ops(func->old_addr);
+	ops = klp_find_ops(func->old_func);
 	if (!ops) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc = klp_get_ftrace_location(func->old_addr);
+		ftrace_loc =
+			klp_get_ftrace_location((unsigned long)func->old_func);
 		if (!ftrace_loc) {
 			pr_err("failed to find location for function '%s'\n",
 				func->old_name);
diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
index e72d8250d04b..2bc8db4e9973 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -25,7 +25,7 @@ struct klp_ops {
 	struct ftrace_ops fops;
 };
 
-struct klp_ops *klp_find_ops(unsigned long old_addr);
+struct klp_ops *klp_find_ops(void *old_func);
 
 int klp_patch_object(struct klp_object *obj);
 void klp_unpatch_object(struct klp_object *obj);
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5bc349805e03..512913c1452d 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -224,11 +224,11 @@ static int klp_check_stack_func(struct klp_func *func,
 			 * Check for the to-be-patched function
 			 * (the previous func).
 			 */
-			ops = klp_find_ops(func->old_addr);
+			ops = klp_find_ops(func->old_func);
 
 			if (list_is_singular(&ops->func_stack)) {
 				/* original function */
-				func_addr = func->old_addr;
+				func_addr = (unsigned long)func->old_func;
 				func_size = func->old_size;
 			} else {
 				/* previously patched function */
-- 
2.13.7

