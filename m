Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA415C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77E12064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77E12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJOUX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:23:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:52416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726499AbeJOUWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58BEFAE65;
        Mon, 15 Oct 2018 12:37:35 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v13 07/12] livepatch: Use lists to manage patches, objects and functions
Date:   Mon, 15 Oct 2018 14:37:08 +0200
Message-Id: <20181015123713.25868-8-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
---
 include/linux/livepatch.h | 19 +++++++++++++++++--
 kernel/livepatch/core.c   | 31 ++++++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 17ceb81beedf..e4629309916e 100644
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
  * @old_addr:	the address of the function being patched
  * @kobj:	kobject for sysfs resources
+ * @node:	list node for klp_object func_list
  * @stack_node:	list node for klp_ops func_stack list
  * @old_size:	size of the old function
  * @new_size:	size of the new function
@@ -79,6 +81,7 @@ struct klp_func {
 	/* internal */
 	unsigned long old_addr;
 	struct kobject kobj;
+	struct list_head node;
 	struct list_head stack_node;
 	unsigned long old_size, new_size;
 	bool patched;
@@ -117,6 +120,8 @@ struct klp_callbacks {
  * @kobj:	kobject for sysfs resources
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
+ * @func_list:	dynamic list of the function entries
+ * @node:	list node for klp_patch obj_list
  * @patched:	the object's funcs have been added to the klp_ops list
  */
 struct klp_object {
@@ -127,6 +132,8 @@ struct klp_object {
 
 	/* internal */
 	struct kobject kobj;
+	struct list_head func_list;
+	struct list_head node;
 	struct module *mod;
 	bool patched;
 };
@@ -137,6 +144,7 @@ struct klp_object {
  * @objs:	object entries for kernel objects to be patched
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
+ * @obj_list:	dynamic list of the object entries
  * @enabled:	the patch is enabled (but operation may be incomplete)
  * @module_put: module reference taken and patch not forced
  * @free_work:  work freeing the patch that has to be done in another context
@@ -150,6 +158,7 @@ struct klp_patch {
 	/* internal */
 	struct list_head list;
 	struct kobject kobj;
+	struct list_head obj_list;
 	bool enabled;
 	bool module_put;
 	struct work_struct free_work;
@@ -196,14 +205,20 @@ struct klp_patch {
 	}
 #define KLP_OBJECT_END { }
 
-#define klp_for_each_object(patch, obj) \
+#define klp_for_each_object_static(patch, obj) \
 	for (obj = patch->objs; obj->funcs || obj->name; obj++)
 
-#define klp_for_each_func(obj, func) \
+#define klp_for_each_object(patch, obj)	\
+	list_for_each_entry(obj, &patch->obj_list, node)
+
+#define klp_for_each_func_static(obj, func) \
 	for (func = obj->funcs; \
 	     func->old_name || func->new_addr || func->old_sympos; \
 	     func++)
 
+#define klp_for_each_func(obj, func)	\
+	list_for_each_entry(func, &obj->func_list, node)
+
 int klp_enable_patch(struct klp_patch *);
 
 void arch_klp_init_object_loaded(struct klp_patch *patch,
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 76c5b08ffacf..96ff7820fe24 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -50,6 +50,29 @@ LIST_HEAD(klp_patches);
 
 static struct kobject *klp_root_kobj;
 
+static int klp_init_lists(struct klp_patch *patch)
+{
+	struct klp_object *obj;
+	struct klp_func *func;
+
+	INIT_LIST_HEAD(&patch->obj_list);
+	if (!patch->objs)
+		return -EINVAL;
+
+	klp_for_each_object_static(patch, obj) {
+		list_add(&obj->node, &patch->obj_list);
+
+		INIT_LIST_HEAD(&obj->func_list);
+		if (!obj->funcs)
+			return -EINVAL;
+
+		klp_for_each_func_static(obj, func)
+			list_add(&func->node, &obj->func_list);
+	}
+
+	return 0;
+}
+
 static bool klp_is_module(struct klp_object *obj)
 {
 	return obj->name;
@@ -609,9 +632,6 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 	int ret;
 	const char *name;
 
-	if (!obj->funcs)
-		return -EINVAL;
-
 	if (klp_is_module(obj) && strlen(obj->name) >= MODULE_NAME_LEN)
 		return -EINVAL;
 
@@ -649,8 +669,9 @@ static int klp_init_patch(struct klp_patch *patch)
 	INIT_WORK(&patch->free_work, klp_free_patch_fn);
 	init_completion(&patch->finish);
 
-	if (!patch->objs)
-		return -EINVAL;
+	ret = klp_init_lists(patch);
+	if (ret)
+		return ret;
 
 	/*
 	 * A reference is taken on the patch module to prevent it from being
-- 
2.13.7

