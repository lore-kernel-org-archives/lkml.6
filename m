Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9824BC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7136C206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfAIMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:44:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:42802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730721AbfAIMnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:43:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21916AF71;
        Wed,  9 Jan 2019 12:43:44 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v15 06/11] livepatch: Use lists to manage patches, objects and functions
Date:   Wed,  9 Jan 2019 13:43:24 +0100
Message-Id: <20190109124329.21991-7-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190109124329.21991-1-pmladek@suse.com>
References: <20190109124329.21991-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>

Currently klp_patch contains a pointer to a statically allocated array of
struct klp_object and struct klp_objects contains a pointer to a statically
allocated array of klp_func. In order to allow for the dynamic allocation
of objects and functions, link klp_patch, klp_object, and klp_func together
via linked lists. This allows us to more easily allocate new objects and
functions, while having the iterator be a simple linked list walk.

The static structures are added to the lists early. It allows to add
the dynamically allocated objects before klp_init_object() and
klp_init_func() calls. Therefore it reduces the further changes
to the code.

This patch does not change the existing behavior.

Signed-off-by: Jason Baron <jbaron@akamai.com>
[pmladek@suse.com: Initialize lists before init calls]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
---
 include/linux/livepatch.h | 19 +++++++++++++++++--
 kernel/livepatch/core.c   |  9 +++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 8f9c19c69744..e117e20ff771 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/ftrace.h>
 #include <linux/completion.h>
+#include <linux/list.h>
 
 #if IS_ENABLED(CONFIG_LIVEPATCH)
 
@@ -42,6 +43,7 @@
  *		can be found (optional)
  * @old_func:	pointer to the function being patched
  * @kobj:	kobject for sysfs resources
+ * @node:	list node for klp_object func_list
  * @stack_node:	list node for klp_ops func_stack list
  * @old_size:	size of the old function
  * @new_size:	size of the new function
@@ -80,6 +82,7 @@ struct klp_func {
 	/* internal */
 	void *old_func;
 	struct kobject kobj;
+	struct list_head node;
 	struct list_head stack_node;
 	unsigned long old_size, new_size;
 	bool kobj_added;
@@ -117,6 +120,8 @@ struct klp_callbacks {
  * @funcs:	function entries for functions to be patched in the object
  * @callbacks:	functions to be executed pre/post (un)patching
  * @kobj:	kobject for sysfs resources
+ * @func_list:	dynamic list of the function entries
+ * @node:	list node for klp_patch obj_list
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
  * @kobj_added: @kobj has been added and needs freeing
@@ -130,6 +135,8 @@ struct klp_object {
 
 	/* internal */
 	struct kobject kobj;
+	struct list_head func_list;
+	struct list_head node;
 	struct module *mod;
 	bool kobj_added;
 	bool patched;
@@ -141,6 +148,7 @@ struct klp_object {
  * @objs:	object entries for kernel objects to be patched
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
+ * @obj_list:	dynamic list of the object entries
  * @kobj_added: @kobj has been added and needs freeing
  * @enabled:	the patch is enabled (but operation may be incomplete)
  * @forced:	was involved in a forced transition
@@ -155,6 +163,7 @@ struct klp_patch {
 	/* internal */
 	struct list_head list;
 	struct kobject kobj;
+	struct list_head obj_list;
 	bool kobj_added;
 	bool enabled;
 	bool forced;
@@ -162,14 +171,20 @@ struct klp_patch {
 	struct completion finish;
 };
 
-#define klp_for_each_object(patch, obj) \
+#define klp_for_each_object_static(patch, obj) \
 	for (obj = patch->objs; obj->funcs || obj->name; obj++)
 
-#define klp_for_each_func(obj, func) \
+#define klp_for_each_object(patch, obj)	\
+	list_for_each_entry(obj, &patch->obj_list, node)
+
+#define klp_for_each_func_static(obj, func) \
 	for (func = obj->funcs; \
 	     func->old_name || func->new_func || func->old_sympos; \
 	     func++)
 
+#define klp_for_each_func(obj, func)	\
+	list_for_each_entry(func, &obj->func_list, node)
+
 int klp_enable_patch(struct klp_patch *);
 
 void arch_klp_init_object_loaded(struct klp_patch *patch,
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bd41b03a72d5..37d0d3645fa6 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -659,20 +659,25 @@ static int klp_init_patch_early(struct klp_patch *patch)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&patch->list);
+	INIT_LIST_HEAD(&patch->obj_list);
 	patch->kobj_added = false;
 	patch->enabled = false;
 	patch->forced = false;
 	INIT_WORK(&patch->free_work, klp_free_patch_work_fn);
 	init_completion(&patch->finish);
 
-	klp_for_each_object(patch, obj) {
+	klp_for_each_object_static(patch, obj) {
 		if (!obj->funcs)
 			return -EINVAL;
 
+		INIT_LIST_HEAD(&obj->func_list);
 		obj->kobj_added = false;
+		list_add_tail(&obj->node, &patch->obj_list);
 
-		klp_for_each_func(obj, func)
+		klp_for_each_func_static(obj, func) {
 			func->kobj_added = false;
+			list_add_tail(&func->node, &obj->func_list);
+		}
 	}
 
 	if (!try_module_get(patch->mod))
-- 
2.13.7

