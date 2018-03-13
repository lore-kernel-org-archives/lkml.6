Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934484AbeCMP4T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:56:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:39902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932400AbeCMP4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:56:15 -0400
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] livepatch: Allow to unregister or free shadow data using a custom function
Date: Tue, 13 Mar 2018 16:54:48 +0100
Message-Id: <20180313155448.1998-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180313155448.1998-1-pmladek@suse.com>
References: <20180313155448.1998-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We might need to do some actions before the shadow variable is freed.
For example, we might need to remove it from a list or free some data
that it points to.

This is already possible now. The user can get the shadow variable
by klp_shadow_get(), do the necessary actions, and then call
klp_shadow_free().

This patch allow to do this a more elegant way. The user could implement
the needed actions in a callback that is passed to klp_shadow_free()
as a parameter. The callback usually does reverse operations to
the init_func that can be called by klp_shadow_*alloc().

It is especially useful for klp_shadow_free_all(). There we need to do
these extra actions for each found shadow variable with the given ID.

Note that the memory used by the shadow variable itself is still released
later by rcu callback. It is needed to protect internal structures that
keep all shadow variables. But free_func is called immediately. The shadow
variable must not be access anyway after klp_shadow_free() is called.
The user is responsible to protect this any suitable way.

Be aware that free_func callback is called under klp_shadow_lock. It is
the same as for init_func in klp_shadow_alloc().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/livepatch/shadow-vars.txt   | 10 +++++++---
 include/linux/livepatch.h                 |  6 ++++--
 kernel/livepatch/shadow.c                 | 27 +++++++++++++++++++--------
 samples/livepatch/livepatch-shadow-fix1.c | 25 +++++++++++++++----------
 samples/livepatch/livepatch-shadow-fix2.c | 27 ++++++++++++++++-----------
 5 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/Documentation/livepatch/shadow-vars.txt b/Documentation/livepatch/shadow-vars.txt
index 23441c570042..48b7416d89e1 100644
--- a/Documentation/livepatch/shadow-vars.txt
+++ b/Documentation/livepatch/shadow-vars.txt
@@ -66,11 +66,15 @@ allocated.
 
 * klp_shadow_free() - detach and free a <obj, id> shadow variable
   - find and remove a <obj, id> reference from global hashtable
-    - if found, free shadow variable
+    - if found
+      - call free_func if defined
+      - free shadow variable
 
 * klp_shadow_free_all() - detach and free all <*, id> shadow variables
   - find and remove any <*, id> references from global hashtable
-    - if found, free shadow variable
+    - if found
+      - call free_func if defined
+      - free shadow variable
 
 
 2. Use cases
@@ -137,7 +141,7 @@ variable:
 
 void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 {
-	klp_shadow_free(sta, PS_LOCK);
+	klp_shadow_free(sta, PS_LOCK, NULL);
 	kfree(sta);
 	...
 
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index fc7c64ce0992..aa217ba66a1a 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -190,6 +190,7 @@ struct klp_shadow;
 typedef int (*klp_shadow_init_func_t)(void *obj,
 				      void *shadow_data,
 				      void *init_data);
+typedef void (*klp_shadow_free_func_t)(void *obj, void *shadow_data);
 
 void *klp_shadow_get(void *obj, unsigned long id);
 void *klp_shadow_alloc(void *obj, unsigned long id,
@@ -200,8 +201,9 @@ void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
 			      size_t size, gfp_t gfp_flags,
 			      klp_shadow_init_func_t init_func,
 			      void *init_data);
-void klp_shadow_free(void *obj, unsigned long id);
-void klp_shadow_free_all(unsigned long id);
+void klp_shadow_free(void *obj, unsigned long id,
+		     klp_shadow_free_func_t free_func);
+void klp_shadow_free_all(unsigned long id, klp_shadow_free_func_t free_func);
 
 #else /* !CONFIG_LIVEPATCH */
 
diff --git a/kernel/livepatch/shadow.c b/kernel/livepatch/shadow.c
index 3821e19ab834..64e2687fafb7 100644
--- a/kernel/livepatch/shadow.c
+++ b/kernel/livepatch/shadow.c
@@ -237,15 +237,27 @@ void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
 }
 EXPORT_SYMBOL_GPL(klp_shadow_get_or_alloc);
 
+static void klp_shadow_free_struct(struct klp_shadow *shadow,
+				   klp_shadow_free_func_t free_func)
+{
+	hash_del_rcu(&shadow->node);
+	if (free_func)
+		free_func(shadow->obj, shadow->data);
+	kfree_rcu(shadow, rcu_head);
+}
+
 /**
  * klp_shadow_free() - detach and free a <obj, id> shadow variable
  * @obj:	pointer to parent object
  * @id:		data identifier
+ * @free_func:  optional callback that might be used to unregister the variable
+ *		and/or free data that the shadow variable points to
  *
  * This function releases the memory for this <obj, id> shadow variable
  * instance, callers should stop referencing it accordingly.
  */
-void klp_shadow_free(void *obj, unsigned long id)
+void klp_shadow_free(void *obj, unsigned long id,
+		     klp_shadow_free_func_t free_func)
 {
 	struct klp_shadow *shadow;
 	unsigned long flags;
@@ -257,8 +269,7 @@ void klp_shadow_free(void *obj, unsigned long id)
 			       (unsigned long)obj) {
 
 		if (klp_shadow_match(shadow, obj, id)) {
-			hash_del_rcu(&shadow->node);
-			kfree_rcu(shadow, rcu_head);
+			klp_shadow_free_struct(shadow, free_func);
 			break;
 		}
 	}
@@ -270,11 +281,13 @@ EXPORT_SYMBOL_GPL(klp_shadow_free);
 /**
  * klp_shadow_free_all() - detach and free all <*, id> shadow variables
  * @id:		data identifier
+ * @free_func:  optional callback that might be used to unregister the variable
+ *		and/or free data that the shadow variable points to
  *
  * This function releases the memory for all <*, id> shadow variable
  * instances, callers should stop referencing them accordingly.
  */
-void klp_shadow_free_all(unsigned long id)
+void klp_shadow_free_all(unsigned long id, klp_shadow_free_func_t free_func)
 {
 	struct klp_shadow *shadow;
 	unsigned long flags;
@@ -284,10 +297,8 @@ void klp_shadow_free_all(unsigned long id)
 
 	/* Delete all <*, id> from hash */
 	hash_for_each(klp_shadow_hash, i, shadow, node) {
-		if (klp_shadow_match(shadow, shadow->obj, id)) {
-			hash_del_rcu(&shadow->node);
-			kfree_rcu(shadow, rcu_head);
-		}
+		if (klp_shadow_match(shadow, shadow->obj, id))
+			klp_shadow_free_struct(shadow, free_func);
 	}
 
 	spin_unlock_irqrestore(&klp_shadow_lock, flags);
diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 598e39ac7d10..65b55b54ff2a 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -99,9 +99,19 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
 	return d;
 }
 
+static void livepatch_fix1_dummy_leak_free(void *obj, void *shadow_data)
+{
+	void *d = obj;
+	void **shadow_leak = shadow_data;
+
+	kfree(*shadow_leak);
+	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
+			 __func__, d, *shadow_leak);
+}
+
 void livepatch_fix1_dummy_free(struct dummy *d)
 {
-	void **shadow_leak, *leak;
+	void **shadow_leak;
 
 	/*
 	 * Patch: fetch the saved SV_LEAK shadow variable, detach and
@@ -110,15 +120,10 @@ void livepatch_fix1_dummy_free(struct dummy *d)
 	 * was loaded.)
 	 */
 	shadow_leak = klp_shadow_get(d, SV_LEAK);
-	if (shadow_leak) {
-		leak = *shadow_leak;
-		klp_shadow_free(d, SV_LEAK);
-		kfree(leak);
-		pr_info("%s: dummy @ %p, prevented leak @ %p\n",
-			 __func__, d, leak);
-	} else {
+	if (shadow_leak)
+		klp_shadow_free(d, SV_LEAK, livepatch_fix1_dummy_leak_free);
+	else
 		pr_info("%s: dummy @ %p leaked!\n", __func__, d);
-	}
 
 	kfree(d);
 }
@@ -164,7 +169,7 @@ static int livepatch_shadow_fix1_init(void)
 static void livepatch_shadow_fix1_exit(void)
 {
 	/* Cleanup any existing SV_LEAK shadow variables */
-	klp_shadow_free_all(SV_LEAK);
+	klp_shadow_free_all(SV_LEAK, livepatch_fix1_dummy_leak_free);
 
 	WARN_ON(klp_unregister_patch(&patch));
 }
diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
index d6c62844dc15..41ff9a645d3e 100644
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -68,22 +68,27 @@ bool livepatch_fix2_dummy_check(struct dummy *d, unsigned long jiffies)
 	return time_after(jiffies, d->jiffies_expire);
 }
 
+static void livepatch_fix2_dummy_leak_free(void *obj, void *shadow_data)
+{
+	void *d = obj;
+	void **shadow_leak = shadow_data;
+
+	kfree(*shadow_leak);
+	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
+			 __func__, d, *shadow_leak);
+}
+
 void livepatch_fix2_dummy_free(struct dummy *d)
 {
-	void **shadow_leak, *leak;
+	void **shadow_leak;
 	int *shadow_count;
 
 	/* Patch: copy the memory leak patch from the fix1 module. */
 	shadow_leak = klp_shadow_get(d, SV_LEAK);
-	if (shadow_leak) {
-		leak = *shadow_leak;
-		klp_shadow_free(d, SV_LEAK);
-		kfree(leak);
-		pr_info("%s: dummy @ %p, prevented leak @ %p\n",
-			 __func__, d, leak);
-	} else {
+	if (shadow_leak)
+		klp_shadow_free(d, SV_LEAK, livepatch_fix2_dummy_leak_free);
+	else
 		pr_info("%s: dummy @ %p leaked!\n", __func__, d);
-	}
 
 	/*
 	 * Patch: fetch the SV_COUNTER shadow variable and display
@@ -93,7 +98,7 @@ void livepatch_fix2_dummy_free(struct dummy *d)
 	if (shadow_count) {
 		pr_info("%s: dummy @ %p, check counter = %d\n",
 			__func__, d, *shadow_count);
-		klp_shadow_free(d, SV_COUNTER);
+		klp_shadow_free(d, SV_COUNTER, NULL);
 	}
 
 	kfree(d);
@@ -140,7 +145,7 @@ static int livepatch_shadow_fix2_init(void)
 static void livepatch_shadow_fix2_exit(void)
 {
 	/* Cleanup any existing SV_COUNTER shadow variables */
-	klp_shadow_free_all(SV_COUNTER);
+	klp_shadow_free_all(SV_COUNTER, NULL);
 
 	WARN_ON(klp_unregister_patch(&patch));
 }
-- 
2.13.6
