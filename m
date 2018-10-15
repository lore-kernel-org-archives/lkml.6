Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD913C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6813320881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6813320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJOUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:22:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:52386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbeJOUWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 483F2AE65;
        Mon, 15 Oct 2018 12:37:40 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v13 11/12] livepatch: Remove ordering and refuse loading conflicting patches
Date:   Mon, 15 Oct 2018 14:37:12 +0200
Message-Id: <20181015123713.25868-12-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic replace and cumulative patches were introduced as a more secure
way to handle dependent patches. They simplify the logic:

  + Any new cumulative patch is supposed to take over shadow variables
    and changes made by callbacks from previous livepatches.

  + All replaced patches are discarded and the modules can be unloaded.
    As a result, there is only one scenario when a cumulative livepatch
    gets disabled.

The different handling of "normal" and cumulative patches might cause
confusion. It would make sense to keep only one mode. On the other hand,
it would be rude to enforce using the cumulative livepatches even for
trivial and independent (hot) fixes.

This patch removes the stack of patches. The list of enabled patches
is still needed but the ordering is not longer enforced.

Note that it is not possible to catch all possible dependencies. It is
the responsibility of the livepatch authors to decide.

Nevertheless this patch prevents having two patches for the same function
enabled at the same time after the transition finishes. It might help
to catch obvious mistakes. But more importantly, we do not need to
handle situation when a patch in the middle of the function stack
(ops->func_stack) is being removed.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/livepatch/cumulative-patches.txt | 11 ++---
 Documentation/livepatch/livepatch.txt          | 30 +++++++------
 kernel/livepatch/core.c                        | 60 ++++++++++++++++++++++----
 3 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/Documentation/livepatch/cumulative-patches.txt b/Documentation/livepatch/cumulative-patches.txt
index a8089f7fe306..ca1fbb4351c8 100644
--- a/Documentation/livepatch/cumulative-patches.txt
+++ b/Documentation/livepatch/cumulative-patches.txt
@@ -7,8 +7,8 @@ to do different changes to the same function(s) then we need to define
 an order in which the patches will be installed. And function implementations
 from any newer livepatch must be done on top of the older ones.
 
-This might become a maintenance nightmare. Especially if anyone would want
-to remove a patch that is in the middle of the stack.
+This might become a maintenance nightmare. Especially when more patches
+modified the same function in different ways.
 
 An elegant solution comes with the feature called "Atomic Replace". It allows
 to create so called "Cumulative Patches". They include all wanted changes
@@ -26,11 +26,9 @@ for example:
 		.replace = true,
 	};
 
-Such a patch is added on top of the livepatch stack when enabled.
-
 All processes are then migrated to use the code only from the new patch.
 Once the transition is finished, all older patches are automatically
-disabled and removed from the stack of patches.
+disabled.
 
 Ftrace handlers are transparently removed from functions that are no
 longer modified by the new cumulative patch.
@@ -57,8 +55,7 @@ The atomic replace allows:
   + Remove eventual performance impact caused by core redirection
     for functions that are no longer patched.
 
-  + Decrease user confusion about stacking order and what code
-    is actually in use.
+  + Decrease user confusion about dependencies between livepatches.
 
 
 Limitations:
diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 35ac37eba9a7..c292b9788945 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -141,9 +141,9 @@ without HAVE_RELIABLE_STACKTRACE are not considered fully supported by
 the kernel livepatching.
 
 The /sys/kernel/livepatch/<patch>/transition file shows whether a patch
-is in transition.  Only a single patch (the topmost patch on the stack)
-can be in transition at a given time.  A patch can remain in transition
-indefinitely, if any of the tasks are stuck in the initial patch state.
+is in transition.  Only a single patch can be in transition at a given
+time.  A patch can remain in transition indefinitely, if any of the tasks
+are stuck in the initial patch state.
 
 A transition can be reversed and effectively canceled by writing the
 opposite value to the /sys/kernel/livepatch/<patch>/enabled file while
@@ -327,9 +327,10 @@ successfully disabled via the sysfs interface.
 Livepatch modules have to call klp_enable_patch() in module_init() callback.
 This function is rather complex and might even fail in the early phase.
 
-First, the addresses of the patched functions are found according to their
-names. The special relocations, mentioned in the section "New functions",
-are applied. The relevant entries are created under
+First, possible conflicts are checked for non-cummulative patches with
+disabled replace flag. The addresses of the patched functions are found
+according to their names. The special relocations, mentioned in the section
+"New functions", are applied. The relevant entries are created under
 /sys/kernel/livepatch/<name>. The patch is rejected when any above
 operation fails.
 
@@ -343,11 +344,11 @@ this process, see the "Consistency model" section.
 Finally, once all tasks have been patched, the 'transition' value changes
 to '0'.
 
-[*] Note that functions might be patched multiple times. The ftrace handler
-    is registered only once for a given function. Further patches just add
-    an entry to the list (see field `func_stack`) of the struct klp_ops.
-    The right implementation is selected by the ftrace handler, see
-    the "Consistency model" section.
+[*] Note that two patches might modify the same function during the transition
+    to a new cumulative patch. The ftrace handler is registered only once
+    for a given function. The new patch just adds an entry to the list
+    (see field `func_stack`) of the struct klp_ops. The right implementation
+    is selected by the ftrace handler, see the "Consistency model" section.
 
 
 5.2. Disabling
@@ -374,8 +375,11 @@ Third, the sysfs interface is destroyed.
 Finally, the module can be removed if the transition was not forced and the
 last sysfs entry has gone.
 
-Note that patches must be disabled in exactly the reverse order in which
-they were enabled. It makes the problem and the implementation much easier.
+Note that any patch dependencies have to be handled by the atomic replace
+and cumulative patches, see Documentation/livepatch/cumulative-patches.txt.
+Therefore there is usually only one patch enabled on the system. There is
+still possibility to have more trivial and independent livepatches enabled
+at the same time. These can be enabled and disabled in any order.
 
 
 6. Sysfs
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index f260568714db..10e4037e8bc5 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -145,6 +145,47 @@ static struct klp_object *klp_find_object(struct klp_patch *patch,
 	return NULL;
 }
 
+static int klp_check_obj_conflict(struct klp_patch *patch,
+				  struct klp_object *old_obj)
+{
+	struct klp_object *obj;
+	struct klp_func *func, *old_func;
+
+	obj = klp_find_object(patch, old_obj);
+	if (!obj)
+		return 0;
+
+	klp_for_each_func(old_obj, old_func) {
+		func = klp_find_func(obj, old_func);
+		if (!func)
+			continue;
+
+		pr_err("Function '%s,%lu' in object '%s' has already been livepatched.\n",
+		       func->old_name, func->old_sympos ? func->old_sympos : 1,
+		       obj->name ? obj->name : "vmlinux");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int klp_check_patch_conflict(struct klp_patch *patch)
+{
+	struct klp_patch *old_patch;
+	struct klp_object *old_obj;
+	int ret;
+
+	list_for_each_entry(old_patch, &klp_patches, list) {
+		klp_for_each_object(old_patch, old_obj) {
+			ret = klp_check_obj_conflict(patch, old_obj);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 struct klp_find_arg {
 	const char *objname;
 	const char *name;
@@ -878,10 +919,6 @@ static int klp_init_patch(struct klp_patch *patch)
 	INIT_WORK(&patch->free_work, klp_free_patch_fn);
 	init_completion(&patch->finish);
 
-	ret = klp_init_lists(patch);
-	if (ret)
-		return ret;
-
 	/*
 	 * A reference is taken on the patch module to prevent it from being
 	 * unloaded.
@@ -922,10 +959,6 @@ static int __klp_disable_patch(struct klp_patch *patch)
 	if (klp_transition_patch)
 		return -EBUSY;
 
-	/* enforce stacking: only the last enabled patch can be disabled */
-	if (!list_is_last(&patch->list, &klp_patches))
-		return -EBUSY;
-
 	klp_init_transition(patch, KLP_UNPATCHED);
 
 	klp_for_each_object(patch, obj)
@@ -1040,8 +1073,19 @@ int klp_enable_patch(struct klp_patch *patch)
 		return -ENOSYS;
 	}
 
+	/* Allow to use the dynamic lists in the check for conflicts. */
+	ret = klp_init_lists(patch);
+	if (ret)
+		return ret;
+
 	mutex_lock(&klp_mutex);
 
+	if (!patch->replace && klp_check_patch_conflict(patch)) {
+		pr_err("Use cumulative livepatches for dependent changes.\n");
+		mutex_unlock(&klp_mutex);
+		return -EINVAL;
+	}
+
 	ret = klp_init_patch(patch);
 	if (ret)
 		goto err;
-- 
2.13.7

