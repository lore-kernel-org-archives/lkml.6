Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbeCMP4N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:56:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39887 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932400AbeCMP4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:56:09 -0400
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] livepatch: Initialize shadow variables by init function safely
Date: Tue, 13 Mar 2018 16:54:47 +0100
Message-Id: <20180313155448.1998-2-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180313155448.1998-1-pmladek@suse.com>
References: <20180313155448.1998-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing API allows to pass a sample data to initialize the shadow
data. It works well when the data are position independent. But it fails
miserably when we need to set a pointer to the shadow structure itself.

Unfortunately, we might need to initialize the pointer surprisingly
often because of struct list_head. It is even worse because the list
might be hidden in other common structures, for example, struct mutex,
struct wait_queue_head.

This patch makes the API more safe. A custom init function and data
are passed to klp_shadow_*alloc() functions instead of the sample data.

Note that the init_data are not longer a template for the shadow->data.
It might point to any data that might be necessary when the init
function is called.

In addition, the newly allocated shadow structure is initialized
only when it is really used. For this, the init function must be
called under klp_shadow_lock. On one hand, this adds a risk of
ABBA deadlocks. On the other hand, it allows to do some operations
safely. For example, we could add the new structure into an
existing list.

Reported-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/livepatch/shadow-vars.txt   | 32 +++++++++++++++------
 include/linux/livepatch.h                 | 17 ++++++++---
 kernel/livepatch/shadow.c                 | 48 +++++++++++++++++++++----------
 samples/livepatch/livepatch-shadow-fix1.c | 19 +++++++++++-
 samples/livepatch/livepatch-shadow-fix2.c |  6 ++--
 5 files changed, 89 insertions(+), 33 deletions(-)

diff --git a/Documentation/livepatch/shadow-vars.txt b/Documentation/livepatch/shadow-vars.txt
index 89c66634d600..23441c570042 100644
--- a/Documentation/livepatch/shadow-vars.txt
+++ b/Documentation/livepatch/shadow-vars.txt
@@ -34,9 +34,14 @@ meta-data and shadow-data:
   - data[] - storage for shadow data
 
 It is important to note that the klp_shadow_alloc() and
-klp_shadow_get_or_alloc() calls, described below, store a *copy* of the
-data that the functions are provided.  Callers should provide whatever
-mutual exclusion is required of the shadow data.
+klp_shadow_get_or_alloc() are zeroing the variable by default.
+They also allow to call a custom init function when a non-zero
+value is needed. Callers should provide whatever mutual exclusion
+is required.
+
+Note that the init function is called under klp_shadow_lock spinlock.
+It allows to do actions that can be done only once when a new variable is
+allocated.
 
 * klp_shadow_get() - retrieve a shadow variable data pointer
   - search hashtable for <obj, id> pair
@@ -47,7 +52,7 @@ mutual exclusion is required of the shadow data.
     - WARN and return NULL
   - if <obj, id> doesn't already exist
     - allocate a new shadow variable
-    - copy data into the new shadow variable
+    - initialize the variable using custom init function and data when provided
     - add <obj, id> to the global hashtable
 
 * klp_shadow_get_or_alloc() - get existing or alloc a new shadow variable
@@ -56,7 +61,7 @@ mutual exclusion is required of the shadow data.
     - return existing shadow variable
   - if <obj, id> doesn't already exist
     - allocate a new shadow variable
-    - copy data into the new shadow variable
+    - initialize the variable using custom init function and data when provided
     - add <obj, id> pair to the global hashtable
 
 * klp_shadow_free() - detach and free a <obj, id> shadow variable
@@ -107,7 +112,8 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta = kzalloc(sizeof(*sta) + hw->sta_data_size, gfp);
 
 	/* Attach a corresponding shadow variable, then initialize it */
-	ps_lock = klp_shadow_alloc(sta, PS_LOCK, NULL, sizeof(*ps_lock), gfp);
+	ps_lock = klp_shadow_alloc(sta, PS_LOCK, sizeof(*ps_lock), gfp,
+				   NULL, NULL);
 	if (!ps_lock)
 		goto shadow_fail;
 	spin_lock_init(ps_lock);
@@ -148,16 +154,24 @@ shadow variables to parents already in-flight.
 For commit 1d147bfa6429, a good spot to allocate a shadow spinlock is
 inside ieee80211_sta_ps_deliver_wakeup():
 
+int ps_lock_shadow_init(void *obj, void *shadow_data, void *data)
+{
+	spinlock_t *lock = shadow_data;
+
+	spin_lock_init(lock);
+	return 0;
+}
+
 #define PS_LOCK 1
 void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 {
-	DEFINE_SPINLOCK(ps_lock_fallback);
 	spinlock_t *ps_lock;
 
 	/* sync with ieee80211_tx_h_unicast_ps_buf */
 	ps_lock = klp_shadow_get_or_alloc(sta, PS_LOCK,
-			&ps_lock_fallback, sizeof(ps_lock_fallback),
-			GFP_ATOMIC);
+			sizeof(ps_lock_fallback), GFP_ATOMIC,
+			ps_lock_shadow_init, NULL);
+
 	if (ps_lock)
 		spin_lock(ps_lock);
 	...
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 4754f01c1abb..fc7c64ce0992 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -186,11 +186,20 @@ static inline bool klp_have_reliable_stack(void)
 	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
 }
 
+struct klp_shadow;
+typedef int (*klp_shadow_init_func_t)(void *obj,
+				      void *shadow_data,
+				      void *init_data);
+
 void *klp_shadow_get(void *obj, unsigned long id);
-void *klp_shadow_alloc(void *obj, unsigned long id, void *data,
-		       size_t size, gfp_t gfp_flags);
-void *klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
-			      size_t size, gfp_t gfp_flags);
+void *klp_shadow_alloc(void *obj, unsigned long id,
+		       size_t size, gfp_t gfp_flags,
+		       klp_shadow_init_func_t init_func,
+		       void *init_data);
+void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
+			      size_t size, gfp_t gfp_flags,
+			      klp_shadow_init_func_t init_func,
+			      void *init_data);
 void klp_shadow_free(void *obj, unsigned long id);
 void klp_shadow_free_all(unsigned long id);
 
diff --git a/kernel/livepatch/shadow.c b/kernel/livepatch/shadow.c
index fdac27588d60..3821e19ab834 100644
--- a/kernel/livepatch/shadow.c
+++ b/kernel/livepatch/shadow.c
@@ -113,8 +113,10 @@ void *klp_shadow_get(void *obj, unsigned long id)
 }
 EXPORT_SYMBOL_GPL(klp_shadow_get);
 
-static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
-		       size_t size, gfp_t gfp_flags, bool warn_on_exist)
+static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id,
+				       size_t size, gfp_t gfp_flags,
+				       klp_shadow_init_func_t init_func,
+				       void *init_data, bool warn_on_exist)
 {
 	struct klp_shadow *new_shadow;
 	void *shadow_data;
@@ -130,13 +132,6 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
 	if (!new_shadow)
 		return NULL;
 
-	new_shadow->obj = obj;
-	new_shadow->id = id;
-
-	/* Initialize the shadow variable if data provided */
-	if (data)
-		memcpy(new_shadow->data, data, size);
-
 	/* Look for <obj, id> again under the lock */
 	spin_lock_irqsave(&klp_shadow_lock, flags);
 	shadow_data = klp_shadow_get(obj, id);
@@ -150,6 +145,23 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
 		goto exists;
 	}
 
+	new_shadow->obj = obj;
+	new_shadow->id = id;
+
+	if (init_func) {
+		int err;
+
+		err = init_func(obj, new_shadow->data, init_data);
+		if (err) {
+			spin_unlock_irqrestore(&klp_shadow_lock, flags);
+			kfree(new_shadow);
+			WARN(1,
+			     "Failed to initialize shadow variable <%p, %lx>\n",
+			     obj, id);
+			return NULL;
+		}
+	}
+
 	/* No <obj, id> found, so attach the newly allocated one */
 	hash_add_rcu(klp_shadow_hash, &new_shadow->node,
 		     (unsigned long)new_shadow->obj);
@@ -186,10 +198,13 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
  * Return: the shadow variable data element, NULL on duplicate or
  * failure.
  */
-void *klp_shadow_alloc(void *obj, unsigned long id, void *data,
-		       size_t size, gfp_t gfp_flags)
+void *klp_shadow_alloc(void *obj, unsigned long id,
+		       size_t size, gfp_t gfp_flags,
+		       klp_shadow_init_func_t init_func,
+		       void *init_data)
 {
-	return __klp_shadow_get_or_alloc(obj, id, data, size, gfp_flags, true);
+	return __klp_shadow_get_or_alloc(obj, id, size, gfp_flags,
+					 init_func, init_data, true);
 }
 EXPORT_SYMBOL_GPL(klp_shadow_alloc);
 
@@ -212,10 +227,13 @@ EXPORT_SYMBOL_GPL(klp_shadow_alloc);
  *
  * Return: the shadow variable data element, NULL on failure.
  */
-void *klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
-			       size_t size, gfp_t gfp_flags)
+void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
+			      size_t size, gfp_t gfp_flags,
+			      klp_shadow_init_func_t init_func,
+			      void *init_data)
 {
-	return __klp_shadow_get_or_alloc(obj, id, data, size, gfp_flags, false);
+	return __klp_shadow_get_or_alloc(obj, id, size, gfp_flags,
+					 init_func, init_data, false);
 }
 EXPORT_SYMBOL_GPL(klp_shadow_get_or_alloc);
 
diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 830c55514f9f..598e39ac7d10 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -56,6 +56,22 @@ struct dummy {
 	unsigned long jiffies_expire;
 };
 
+/*
+ * The shadow_init function makes more sense together with
+ * klp_shadow_get_or_alloc(). In this example, it would be safe
+ * to assign the pointer also to the shadow variable returned by
+ * klp_shadow_alloc(). But we wanted to show the more complicated
+ * use of the API.
+ */
+static int shadow_leak_init(void *obj, void *shadow_data, void *init_data)
+{
+	void **shadow_leak = shadow_data;
+	void *leak = init_data;
+
+	*shadow_leak = leak;
+	return 0;
+}
+
 struct dummy *livepatch_fix1_dummy_alloc(void)
 {
 	struct dummy *d;
@@ -74,7 +90,8 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
 	 * pointer to handle resource release.
 	 */
 	leak = kzalloc(sizeof(int), GFP_KERNEL);
-	klp_shadow_alloc(d, SV_LEAK, &leak, sizeof(leak), GFP_KERNEL);
+	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
+			 shadow_leak_init, leak);
 
 	pr_info("%s: dummy @ %p, expires @ %lx\n",
 		__func__, d, d->jiffies_expire);
diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
index ff9948f0ec00..d6c62844dc15 100644
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -53,17 +53,15 @@ struct dummy {
 bool livepatch_fix2_dummy_check(struct dummy *d, unsigned long jiffies)
 {
 	int *shadow_count;
-	int count;
 
 	/*
 	 * Patch: handle in-flight dummy structures, if they do not
 	 * already have a SV_COUNTER shadow variable, then attach a
 	 * new one.
 	 */
-	count = 0;
 	shadow_count = klp_shadow_get_or_alloc(d, SV_COUNTER,
-					       &count, sizeof(count),
-					       GFP_NOWAIT);
+				sizeof(*shadow_count), GFP_NOWAIT,
+				NULL, NULL);
 	if (shadow_count)
 		*shadow_count += 1;
 
-- 
2.13.6
