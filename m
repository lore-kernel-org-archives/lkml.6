Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC51C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5168E208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5168E208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJOUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:22:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeJOUWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 014F0AE19;
        Mon, 15 Oct 2018 12:37:34 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v13 06/12] livepatch: Simplify API by removing registration step
Date:   Mon, 15 Oct 2018 14:37:07 +0200
Message-Id: <20181015123713.25868-7-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The possibility to re-enable a registered patch was useful for immediate
patches where the livepatch module had to stay until the system reboot.
The improved consistency model allows to achieve the same result by
unloading and loading the livepatch module again.

Also we are going to add a feature called atomic replace. It will allow
to create a patch that would replace all already registered patches.
The aim is to handle dependent patches more securely. It will obsolete
the stack of patches that helped to handle the dependencies so far.
Then it might be unclear when a cumulative patch re-enabling is safe.

It would be complicated to support the many modes. Instead we could
actually make the API and code easier to understand.

This patch removes the two step public API. All the checks and init calls
are moved from klp_register_patch() to klp_enabled_patch(). Also the patch
is automatically freed, including the sysfs interface when the transition
to the disabled state is completed.

As a result, there is never a disabled patch on the top of the stack.
Therefore we do not need to check the stack in __klp_enable_patch().
And we could simplify the check in __klp_disable_patch().

Also the API and logic is much easier. It is enough to call
klp_enable_patch() in module_init() call. The patch patch can be disabled
by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
can be removed once the transition finishes and sysfs interface is freed.

The only problem is how to free the structures and kobjects a safe way.
The operation is triggered from the sysfs interface. We could not put
the related kobject from there because it would cause lock inversion
between klp_mutex and kernfs locks, see kn->count lockdep map.

This patch solved the problem by offloading the free task to
a workqueue. It is perfectly fine:

  + The patch cannot not longer be used in the livepatch operations.

  + The module could not be removed until the free operation finishes
    and module_put() is called.

  + The operation is asynchronous already when the first
    klp_try_complete_transition() fails and another call
    is queued with a delay.

This patch does the following to keep the code sane:

  + patch->forced is replaced with patch->module_put and an inverted logic.
    Then we could call it in klp_enable_patch() error path even before
    the reference is taken.

  + try_module_get() is called before initializing patch->kobj. It makes
    it more symmetric with the moved module_put().

  + module_put() is the last action also in klp_free_patch_sync_end().
    It makes it safe for an use outside module_init().

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/livepatch/livepatch.txt        | 121 +++++-------
 include/linux/livepatch.h                    |   9 +-
 kernel/livepatch/core.c                      | 280 +++++++++------------------
 kernel/livepatch/core.h                      |   2 +
 kernel/livepatch/transition.c                |  22 ++-
 samples/livepatch/livepatch-callbacks-demo.c |  13 +-
 samples/livepatch/livepatch-sample.c         |  13 +-
 samples/livepatch/livepatch-shadow-fix1.c    |  14 +-
 samples/livepatch/livepatch-shadow-fix2.c    |  14 +-
 9 files changed, 164 insertions(+), 324 deletions(-)

diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 2d7ed09dbd59..35ac37eba9a7 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -14,10 +14,8 @@ Table of Contents:
    4.2. Metadata
    4.3. Livepatch module handling
 5. Livepatch life-cycle
-   5.1. Registration
-   5.2. Enabling
-   5.3. Disabling
-   5.4. Unregistration
+   5.1. Enabling
+   5.2. Disabling
 6. Sysfs
 7. Limitations
 
@@ -303,9 +301,8 @@ into three levels:
 
 The usual behavior is that the new functions will get used when
 the livepatch module is loaded. For this, the module init() function
-has to register the patch (struct klp_patch) and enable it. See the
-section "Livepatch life-cycle" below for more details about these
-two operations.
+has to enable the patch (struct klp_patch). See the section "Livepatch
+life-cycle" below for more details.
 
 Module removal is only safe when there are no users of the underlying
 functions. This is the reason why the force feature permanently disables
@@ -319,96 +316,66 @@ forced it is guaranteed that no task sleeps or runs in the old code.
 5. Livepatch life-cycle
 =======================
 
-Livepatching defines four basic operations that define the life cycle of each
-live patch: registration, enabling, disabling and unregistration.  There are
-several reasons why it is done this way.
+Livepatches get automatically enabled when the respective module is loaded.
+On the other hand, the module can be removed only after the patch was
+successfully disabled via the sysfs interface.
 
-First, the patch is applied only when all patched symbols for already
-loaded objects are found. The error handling is much easier if this
-check is done before particular functions get redirected.
 
-Second, it might take some time until the entire system is migrated with
-the hybrid consistency model being used. The patch revert might block
-the livepatch module removal for too long. Therefore it is useful to
-revert the patch using a separate operation that might be called
-explicitly. But it does not make sense to remove all information until
-the livepatch module is really removed.
-
-
-5.1. Registration
------------------
-
-Each patch first has to be registered using klp_register_patch(). This makes
-the patch known to the livepatch framework. Also it does some preliminary
-computing and checks.
-
-In particular, the patch is added into the list of known patches. The
-addresses of the patched functions are found according to their names.
-The special relocations, mentioned in the section "New functions", are
-applied. The relevant entries are created under
-/sys/kernel/livepatch/<name>. The patch is rejected when any operation
-fails.
-
-
-5.2. Enabling
+5.1. Enabling
 -------------
 
-Registered patches might be enabled either by calling klp_enable_patch() or
-by writing '1' to /sys/kernel/livepatch/<name>/enabled. The system will
-start using the new implementation of the patched functions at this stage.
+Livepatch modules have to call klp_enable_patch() in module_init() callback.
+This function is rather complex and might even fail in the early phase.
 
-When a patch is enabled, livepatch enters into a transition state where
-tasks are converging to the patched state.  This is indicated by a value
-of '1' in /sys/kernel/livepatch/<name>/transition.  Once all tasks have
-been patched, the 'transition' value changes to '0'.  For more
-information about this process, see the "Consistency model" section.
+First, the addresses of the patched functions are found according to their
+names. The special relocations, mentioned in the section "New functions",
+are applied. The relevant entries are created under
+/sys/kernel/livepatch/<name>. The patch is rejected when any above
+operation fails.
 
-If an original function is patched for the first time, a function
-specific struct klp_ops is created and an universal ftrace handler is
-registered.
+Second, livepatch enters into a transition state where tasks are converging
+to the patched state. If an original function is patched for the first
+time, a function specific struct klp_ops is created and an universal
+ftrace handler is registered[*]. This stage is indicated by a value of '1'
+in /sys/kernel/livepatch/<name>/transition. For more information about
+this process, see the "Consistency model" section.
 
-Functions might be patched multiple times. The ftrace handler is registered
-only once for the given function. Further patches just add an entry to the
-list (see field `func_stack`) of the struct klp_ops. The last added
-entry is chosen by the ftrace handler and becomes the active function
-replacement.
+Finally, once all tasks have been patched, the 'transition' value changes
+to '0'.
 
-Note that the patches might be enabled in a different order than they were
-registered.
+[*] Note that functions might be patched multiple times. The ftrace handler
+    is registered only once for a given function. Further patches just add
+    an entry to the list (see field `func_stack`) of the struct klp_ops.
+    The right implementation is selected by the ftrace handler, see
+    the "Consistency model" section.
 
 
-5.3. Disabling
+5.2. Disabling
 --------------
 
-Enabled patches might get disabled either by calling klp_disable_patch() or
-by writing '0' to /sys/kernel/livepatch/<name>/enabled. At this stage
-either the code from the previously enabled patch or even the original
-code gets used.
+Enabled patches might get disabled by writing '0' to
+/sys/kernel/livepatch/<name>/enabled.
 
-When a patch is disabled, livepatch enters into a transition state where
-tasks are converging to the unpatched state.  This is indicated by a
-value of '1' in /sys/kernel/livepatch/<name>/transition.  Once all tasks
-have been unpatched, the 'transition' value changes to '0'.  For more
-information about this process, see the "Consistency model" section.
+First, livepatch enters into a transition state where tasks are converging
+to the unpatched state. The system starts using either the code from
+the previously enabled patch or even the original one. This stage is
+indicated by a value of '1' in /sys/kernel/livepatch/<name>/transition.
+For more information about this process, see the "Consistency model"
+section.
 
-Here all the functions (struct klp_func) associated with the to-be-disabled
+Second, once all tasks have been unpatched, the 'transition' value changes
+to '0'. All the functions (struct klp_func) associated with the to-be-disabled
 patch are removed from the corresponding struct klp_ops. The ftrace handler
 is unregistered and the struct klp_ops is freed when the func_stack list
 becomes empty.
 
-Patches must be disabled in exactly the reverse order in which they were
-enabled. It makes the problem and the implementation much easier.
-
-
-5.4. Unregistration
--------------------
+Third, the sysfs interface is destroyed.
 
-Disabled patches might be unregistered by calling klp_unregister_patch().
-This can be done only when the patch is disabled and the code is no longer
-used. It must be called before the livepatch module gets unloaded.
+Finally, the module can be removed if the transition was not forced and the
+last sysfs entry has gone.
 
-At this stage, all the relevant sys-fs entries are removed and the patch
-is removed from the list of known patches.
+Note that patches must be disabled in exactly the reverse order in which
+they were enabled. It makes the problem and the implementation much easier.
 
 
 6. Sysfs
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 77fce7d385df..17ceb81beedf 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -138,7 +138,8 @@ struct klp_object {
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
  * @enabled:	the patch is enabled (but operation may be incomplete)
- * @forced:	was involved in a forced transition
+ * @module_put: module reference taken and patch not forced
+ * @free_work:  work freeing the patch that has to be done in another context
  * @finish:	for waiting till it is safe to remove the patch module
  */
 struct klp_patch {
@@ -150,7 +151,8 @@ struct klp_patch {
 	struct list_head list;
 	struct kobject kobj;
 	bool enabled;
-	bool forced;
+	bool module_put;
+	struct work_struct free_work;
 	struct completion finish;
 };
 
@@ -202,10 +204,7 @@ struct klp_patch {
 	     func->old_name || func->new_addr || func->old_sympos; \
 	     func++)
 
-int klp_register_patch(struct klp_patch *);
-int klp_unregister_patch(struct klp_patch *);
 int klp_enable_patch(struct klp_patch *);
-int klp_disable_patch(struct klp_patch *);
 
 void arch_klp_init_object_loaded(struct klp_patch *patch,
 				 struct klp_object *obj);
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index f38637326ac2..76c5b08ffacf 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -45,7 +45,7 @@
  */
 DEFINE_MUTEX(klp_mutex);
 
-/* Registered patches */
+/* Actively used patches. */
 LIST_HEAD(klp_patches);
 
 static struct kobject *klp_root_kobj;
@@ -83,17 +83,6 @@ static void klp_find_object_module(struct klp_object *obj)
 	mutex_unlock(&module_mutex);
 }
 
-static bool klp_is_patch_registered(struct klp_patch *patch)
-{
-	struct klp_patch *mypatch;
-
-	list_for_each_entry(mypatch, &klp_patches, list)
-		if (mypatch == patch)
-			return true;
-
-	return false;
-}
-
 static bool klp_initialized(void)
 {
 	return !!klp_root_kobj;
@@ -292,7 +281,6 @@ static int klp_write_object_relocations(struct module *pmod,
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
  */
 static int __klp_disable_patch(struct klp_patch *patch);
-static int __klp_enable_patch(struct klp_patch *patch);
 
 static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 			     const char *buf, size_t count)
@@ -309,40 +297,33 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_registered(patch)) {
-		/*
-		 * Module with the patch could either disappear meanwhile or is
-		 * not properly initialized yet.
-		 */
-		ret = -EINVAL;
-		goto err;
-	}
-
 	if (patch->enabled == enabled) {
 		/* already in requested state */
 		ret = -EINVAL;
-		goto err;
+		goto out;
 	}
 
-	if (patch == klp_transition_patch) {
+	/*
+	 * Allow to reverse a pending transition in both ways. It might be
+	 * necessary to complete the transition without forcing and breaking
+	 * the system integrity.
+	 *
+	 * Do not allow to re-enable a disabled patch because this interface
+	 * is being destroyed.
+	 */
+	if (patch == klp_transition_patch)
 		klp_reverse_transition();
-	} else if (enabled) {
-		ret = __klp_enable_patch(patch);
-		if (ret)
-			goto err;
-	} else {
+	else if (!enabled)
 		ret = __klp_disable_patch(patch);
-		if (ret)
-			goto err;
-	}
+	else
+		ret = -EINVAL;
 
+out:
 	mutex_unlock(&klp_mutex);
 
+	if (ret)
+		return ret;
 	return count;
-
-err:
-	mutex_unlock(&klp_mutex);
-	return ret;
 }
 
 static ssize_t enabled_show(struct kobject *kobj,
@@ -502,6 +483,9 @@ static void klp_free_objects(struct klp_patch *patch)
 }
 
 /*
+ * The synchronous variant is needed when the patch is freed in
+ * the klp_enable_patch() error paths.
+ *
  * Some operations are synchronized by klp_mutex, e.g. the access to
  * klp_patches list. But the caller has to put patch->kobj outside
  * the lock. Otherwise, there might be a deadlock with sysfs operations
@@ -510,7 +494,7 @@ static void klp_free_objects(struct klp_patch *patch)
  * This function implements the free part that has to be called under
  * klp_mutex.
  */
-static void klp_free_patch_start(struct klp_patch *patch)
+void klp_free_patch_start(struct klp_patch *patch)
 {
 	if (!list_empty(&patch->list))
 		list_del(&patch->list);
@@ -528,6 +512,23 @@ static void klp_free_patch_finish(struct klp_patch *patch)
 		kobject_put(&patch->kobj);
 		wait_for_completion(&patch->finish);
 	}
+
+	/* Put the module after the last access to struct klp_patch. */
+	if (patch->module_put)
+		module_put(patch->mod);
+}
+
+/*
+ * The livepatch might be freed from sysfs interface created by the patch.
+ * This work allows to wait until the interface is destroyed in a separate
+ * context.
+ */
+static void klp_free_patch_fn(struct work_struct *work)
+{
+	struct klp_patch *patch =
+		container_of(work, struct klp_patch, free_work);
+
+	klp_free_patch_finish(patch);
 }
 
 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
@@ -642,116 +643,38 @@ static int klp_init_patch(struct klp_patch *patch)
 	struct klp_object *obj;
 	int ret;
 
-	if (!patch->objs)
-		return -EINVAL;
-
-	mutex_lock(&klp_mutex);
-
 	patch->enabled = false;
-	patch->forced = false;
+	patch->module_put = false;
 	INIT_LIST_HEAD(&patch->list);
+	INIT_WORK(&patch->free_work, klp_free_patch_fn);
 	init_completion(&patch->finish);
 
+	if (!patch->objs)
+		return -EINVAL;
+
+	/*
+	 * A reference is taken on the patch module to prevent it from being
+	 * unloaded.
+	 */
+	if (!try_module_get(patch->mod))
+		return -ENODEV;
+	patch->module_put = true;
+
 	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
 				   klp_root_kobj, "%s", patch->mod->name);
-	if (ret) {
-		mutex_unlock(&klp_mutex);
+	if (ret)
 		return ret;
-	}
 
 	klp_for_each_object(patch, obj) {
 		ret = klp_init_object(patch, obj);
 		if (ret)
-			goto free;
+			return ret;
 	}
 
 	list_add_tail(&patch->list, &klp_patches);
 
-	mutex_unlock(&klp_mutex);
-
-	return 0;
-
-free:
-	klp_free_patch_start(patch);
-
-	mutex_unlock(&klp_mutex);
-
-	klp_free_patch_finish(patch);
-
-	return ret;
-}
-
-/**
- * klp_unregister_patch() - unregisters a patch
- * @patch:	Disabled patch to be unregistered
- *
- * Frees the data structures and removes the sysfs interface.
- *
- * Return: 0 on success, otherwise error
- */
-int klp_unregister_patch(struct klp_patch *patch)
-{
-	int ret;
-
-	mutex_lock(&klp_mutex);
-
-	if (!klp_is_patch_registered(patch)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	if (patch->enabled) {
-		ret = -EBUSY;
-		goto err;
-	}
-
-	klp_free_patch_start(patch);
-
-	mutex_unlock(&klp_mutex);
-
-	klp_free_patch_finish(patch);
-
 	return 0;
-err:
-	mutex_unlock(&klp_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(klp_unregister_patch);
-
-/**
- * klp_register_patch() - registers a patch
- * @patch:	Patch to be registered
- *
- * Initializes the data structure associated with the patch and
- * creates the sysfs interface.
- *
- * There is no need to take the reference on the patch module here. It is done
- * later when the patch is enabled.
- *
- * Return: 0 on success, otherwise error
- */
-int klp_register_patch(struct klp_patch *patch)
-{
-	if (!patch || !patch->mod)
-		return -EINVAL;
-
-	if (!is_livepatch_module(patch->mod)) {
-		pr_err("module %s is not marked as a livepatch module\n",
-		       patch->mod->name);
-		return -EINVAL;
-	}
-
-	if (!klp_initialized())
-		return -ENODEV;
-
-	if (!klp_have_reliable_stack()) {
-		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
-		return -ENOSYS;
-	}
-
-	return klp_init_patch(patch);
 }
-EXPORT_SYMBOL_GPL(klp_register_patch);
 
 static int __klp_disable_patch(struct klp_patch *patch)
 {
@@ -764,8 +687,7 @@ static int __klp_disable_patch(struct klp_patch *patch)
 		return -EBUSY;
 
 	/* enforce stacking: only the last enabled patch can be disabled */
-	if (!list_is_last(&patch->list, &klp_patches) &&
-	    list_next_entry(patch, list)->enabled)
+	if (!list_is_last(&patch->list, &klp_patches))
 		return -EBUSY;
 
 	klp_init_transition(patch, KLP_UNPATCHED);
@@ -784,44 +706,12 @@ static int __klp_disable_patch(struct klp_patch *patch)
 	smp_wmb();
 
 	klp_start_transition();
-	klp_try_complete_transition();
 	patch->enabled = false;
+	klp_try_complete_transition();
 
 	return 0;
 }
 
-/**
- * klp_disable_patch() - disables a registered patch
- * @patch:	The registered, enabled patch to be disabled
- *
- * Unregisters the patched functions from ftrace.
- *
- * Return: 0 on success, otherwise error
- */
-int klp_disable_patch(struct klp_patch *patch)
-{
-	int ret;
-
-	mutex_lock(&klp_mutex);
-
-	if (!klp_is_patch_registered(patch)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	if (!patch->enabled) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	ret = __klp_disable_patch(patch);
-
-err:
-	mutex_unlock(&klp_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(klp_disable_patch);
-
 static int __klp_enable_patch(struct klp_patch *patch)
 {
 	struct klp_object *obj;
@@ -833,17 +723,8 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	if (WARN_ON(patch->enabled))
 		return -EINVAL;
 
-	/* enforce stacking: only the first disabled patch can be enabled */
-	if (patch->list.prev != &klp_patches &&
-	    !list_prev_entry(patch, list)->enabled)
-		return -EBUSY;
-
-	/*
-	 * A reference is taken on the patch module to prevent it from being
-	 * unloaded.
-	 */
-	if (!try_module_get(patch->mod))
-		return -ENODEV;
+	if (!patch->kobj.state_initialized)
+		return -EINVAL;
 
 	pr_notice("enabling patch '%s'\n", patch->mod->name);
 
@@ -878,8 +759,8 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	}
 
 	klp_start_transition();
-	klp_try_complete_transition();
 	patch->enabled = true;
+	klp_try_complete_transition();
 
 	return 0;
 err:
@@ -890,11 +771,15 @@ static int __klp_enable_patch(struct klp_patch *patch)
 }
 
 /**
- * klp_enable_patch() - enables a registered patch
- * @patch:	The registered, disabled patch to be enabled
+ * klp_enable_patch() - enable the livepatch
+ * @patch:	patch to be enabled
+ *
+ * Initializes the data structure associated with the patch, creates the sysfs
+ * interface, performs the needed symbol lookups and code relocations,
+ * registers the patched functions with ftrace.
  *
- * Performs the needed symbol lookups and code relocations,
- * then registers the patched functions with ftrace.
+ * This function is supposed to be called from the livepatch module_init()
+ * callback.
  *
  * Return: 0 on success, otherwise error
  */
@@ -902,17 +787,44 @@ int klp_enable_patch(struct klp_patch *patch)
 {
 	int ret;
 
+	if (!patch || !patch->mod)
+		return -EINVAL;
+
+	if (!is_livepatch_module(patch->mod)) {
+		pr_err("module %s is not marked as a livepatch module\n",
+		       patch->mod->name);
+		return -EINVAL;
+	}
+
+	if (!klp_initialized())
+		return -ENODEV;
+
+	if (!klp_have_reliable_stack()) {
+		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
+		return -ENOSYS;
+	}
+
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_registered(patch)) {
-		ret = -EINVAL;
+	ret = klp_init_patch(patch);
+	if (ret)
 		goto err;
-	}
 
 	ret = __klp_enable_patch(patch);
+	if (ret)
+		goto err;
+
+	mutex_unlock(&klp_mutex);
+
+	return 0;
 
 err:
+	klp_free_patch_start(patch);
+
 	mutex_unlock(&klp_mutex);
+
+	klp_free_patch_finish(patch);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(klp_enable_patch);
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index d0cb5390e247..d4eefc520c08 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -7,6 +7,8 @@
 extern struct mutex klp_mutex;
 extern struct list_head klp_patches;
 
+void klp_free_patch_start(struct klp_patch *patch);
+
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
 	return !obj->name || obj->mod;
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 30a28634c88c..93e594bd1e9a 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -134,13 +134,6 @@ static void klp_complete_transition(void)
 	pr_notice("'%s': %s complete\n", klp_transition_patch->mod->name,
 		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
 
-	/*
-	 * patch->forced set implies unbounded increase of module's ref count if
-	 * the module is disabled/enabled in a loop.
-	 */
-	if (!klp_transition_patch->forced && klp_target_state == KLP_UNPATCHED)
-		module_put(klp_transition_patch->mod);
-
 	klp_target_state = KLP_UNDEFINED;
 	klp_transition_patch = NULL;
 }
@@ -357,6 +350,7 @@ void klp_try_complete_transition(void)
 {
 	unsigned int cpu;
 	struct task_struct *g, *task;
+	struct klp_patch *patch;
 	bool complete = true;
 
 	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
@@ -405,7 +399,18 @@ void klp_try_complete_transition(void)
 	}
 
 	/* we're done, now cleanup the data structures */
+	patch = klp_transition_patch;
 	klp_complete_transition();
+
+	/*
+	 * It would make more sense to free the patch in
+	 * klp_complete_transition() but it is called also
+	 * from klp_cancel_transition().
+	 */
+	if (!patch->enabled) {
+		klp_free_patch_start(patch);
+		schedule_work(&patch->free_work);
+	}
 }
 
 /*
@@ -632,6 +637,7 @@ void klp_force_transition(void)
 	for_each_possible_cpu(cpu)
 		klp_update_patch_state(idle_task(cpu));
 
+	/* Refuse unloading all livepatches. The code might be in use. */
 	list_for_each_entry(patch, &klp_patches, list)
-		patch->forced = true;
+		patch->module_put = false;
 }
diff --git a/samples/livepatch/livepatch-callbacks-demo.c b/samples/livepatch/livepatch-callbacks-demo.c
index 001a0c672251..4264f3862313 100644
--- a/samples/livepatch/livepatch-callbacks-demo.c
+++ b/samples/livepatch/livepatch-callbacks-demo.c
@@ -184,22 +184,11 @@ static struct klp_patch patch = {
 
 static int livepatch_callbacks_demo_init(void)
 {
-	int ret;
-
-	ret = klp_register_patch(&patch);
-	if (ret)
-		return ret;
-	ret = klp_enable_patch(&patch);
-	if (ret) {
-		WARN_ON(klp_unregister_patch(&patch));
-		return ret;
-	}
-	return 0;
+	return klp_enable_patch(&patch);
 }
 
 static void livepatch_callbacks_demo_exit(void)
 {
-	WARN_ON(klp_unregister_patch(&patch));
 }
 
 module_init(livepatch_callbacks_demo_init);
diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
index de30d1ba4791..88afb708a48d 100644
--- a/samples/livepatch/livepatch-sample.c
+++ b/samples/livepatch/livepatch-sample.c
@@ -66,22 +66,11 @@ static struct klp_patch patch = {
 
 static int livepatch_init(void)
 {
-	int ret;
-
-	ret = klp_register_patch(&patch);
-	if (ret)
-		return ret;
-	ret = klp_enable_patch(&patch);
-	if (ret) {
-		WARN_ON(klp_unregister_patch(&patch));
-		return ret;
-	}
-	return 0;
+	return klp_enable_patch(&patch);
 }
 
 static void livepatch_exit(void)
 {
-	WARN_ON(klp_unregister_patch(&patch));
 }
 
 module_init(livepatch_init);
diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 8f337b4a9108..c3053f6a93e9 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -148,25 +148,13 @@ static struct klp_patch patch = {
 
 static int livepatch_shadow_fix1_init(void)
 {
-	int ret;
-
-	ret = klp_register_patch(&patch);
-	if (ret)
-		return ret;
-	ret = klp_enable_patch(&patch);
-	if (ret) {
-		WARN_ON(klp_unregister_patch(&patch));
-		return ret;
-	}
-	return 0;
+	return klp_enable_patch(&patch);
 }
 
 static void livepatch_shadow_fix1_exit(void)
 {
 	/* Cleanup any existing SV_LEAK shadow variables */
 	klp_shadow_free_all(SV_LEAK, livepatch_fix1_dummy_leak_dtor);
-
-	WARN_ON(klp_unregister_patch(&patch));
 }
 
 module_init(livepatch_shadow_fix1_init);
diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
index e8c0c0467bc0..fbde6cb5c68e 100644
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -125,25 +125,13 @@ static struct klp_patch patch = {
 
 static int livepatch_shadow_fix2_init(void)
 {
-	int ret;
-
-	ret = klp_register_patch(&patch);
-	if (ret)
-		return ret;
-	ret = klp_enable_patch(&patch);
-	if (ret) {
-		WARN_ON(klp_unregister_patch(&patch));
-		return ret;
-	}
-	return 0;
+	return klp_enable_patch(&patch);
 }
 
 static void livepatch_shadow_fix2_exit(void)
 {
 	/* Cleanup any existing SV_COUNTER shadow variables */
 	klp_shadow_free_all(SV_COUNTER, NULL);
-
-	WARN_ON(klp_unregister_patch(&patch));
 }
 
 module_init(livepatch_shadow_fix2_init);
-- 
2.13.7

