Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79F7208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79F7208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936854AbeFRKPA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:15:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934242AbeFRIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04237C50;
        Mon, 18 Jun 2018 08:16:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 034/279] livepatch: Initialize shadow variables safely by a custom callback
Date:   Mon, 18 Jun 2018 10:10:19 +0200
Message-Id: <20180618080610.235382382@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Mladek <pmladek@suse.com>

[ Upstream commit e91c2518a5d22a07642f35d85f39001ad379dae4 ]

The existing API allows to pass a sample data to initialize the shadow
data. It works well when the data are position independent. But it fails
miserably when we need to set a pointer to the shadow structure itself.

Unfortunately, we might need to initialize the pointer surprisingly
often because of struct list_head. It is even worse because the list
might be hidden in other common structures, for example, struct mutex,
struct wait_queue_head.

For example, this was needed to fix races in ALSA sequencer. It required
to add mutex into struct snd_seq_client. See commit b3defb791b26ea06
("ALSA: seq: Make ioctls race-free") and commit d15d662e89fc667b9
("ALSA: seq: Fix racy pool initializations")

This patch makes the API more safe. A custom constructor function and data
are passed to klp_shadow_*alloc() functions instead of the sample data.

Note that ctor_data are no longer a template for shadow->data. It might
point to any data that might be necessary when the constructor is called.

Also note that the constructor is called under klp_shadow_lock. It is
an internal spin_lock that synchronizes alloc() vs. get() operations,
see klp_shadow_get_or_alloc(). On one hand, this adds a risk of ABBA
deadlocks. On the other hand, it allows to do some operations safely.
For example, we could add the new structure into an existing list.
This must be done only once when the structure is allocated.

Reported-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/livepatch/shadow-vars.txt   |   31 +++++++----
 include/linux/livepatch.h                 |   14 +++--
 kernel/livepatch/shadow.c                 |   84 +++++++++++++++++++-----------
 samples/livepatch/livepatch-shadow-fix1.c |   18 ++++++
 samples/livepatch/livepatch-shadow-fix2.c |    6 --
 5 files changed, 105 insertions(+), 48 deletions(-)

--- a/Documentation/livepatch/shadow-vars.txt
+++ b/Documentation/livepatch/shadow-vars.txt
@@ -34,9 +34,13 @@ meta-data and shadow-data:
   - data[] - storage for shadow data
 
 It is important to note that the klp_shadow_alloc() and
-klp_shadow_get_or_alloc() calls, described below, store a *copy* of the
-data that the functions are provided.  Callers should provide whatever
-mutual exclusion is required of the shadow data.
+klp_shadow_get_or_alloc() are zeroing the variable by default.
+They also allow to call a custom constructor function when a non-zero
+value is needed. Callers should provide whatever mutual exclusion
+is required.
+
+Note that the constructor is called under klp_shadow_lock spinlock. It allows
+to do actions that can be done only once when a new variable is allocated.
 
 * klp_shadow_get() - retrieve a shadow variable data pointer
   - search hashtable for <obj, id> pair
@@ -47,7 +51,7 @@ mutual exclusion is required of the shad
     - WARN and return NULL
   - if <obj, id> doesn't already exist
     - allocate a new shadow variable
-    - copy data into the new shadow variable
+    - initialize the variable using a custom constructor and data when provided
     - add <obj, id> to the global hashtable
 
 * klp_shadow_get_or_alloc() - get existing or alloc a new shadow variable
@@ -56,7 +60,7 @@ mutual exclusion is required of the shad
     - return existing shadow variable
   - if <obj, id> doesn't already exist
     - allocate a new shadow variable
-    - copy data into the new shadow variable
+    - initialize the variable using a custom constructor and data when provided
     - add <obj, id> pair to the global hashtable
 
 * klp_shadow_free() - detach and free a <obj, id> shadow variable
@@ -107,7 +111,8 @@ struct sta_info *sta_info_alloc(struct i
 	sta = kzalloc(sizeof(*sta) + hw->sta_data_size, gfp);
 
 	/* Attach a corresponding shadow variable, then initialize it */
-	ps_lock = klp_shadow_alloc(sta, PS_LOCK, NULL, sizeof(*ps_lock), gfp);
+	ps_lock = klp_shadow_alloc(sta, PS_LOCK, sizeof(*ps_lock), gfp,
+				   NULL, NULL);
 	if (!ps_lock)
 		goto shadow_fail;
 	spin_lock_init(ps_lock);
@@ -148,16 +153,24 @@ shadow variables to parents already in-f
 For commit 1d147bfa6429, a good spot to allocate a shadow spinlock is
 inside ieee80211_sta_ps_deliver_wakeup():
 
+int ps_lock_shadow_ctor(void *obj, void *shadow_data, void *ctor_data)
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
+			sizeof(*ps_lock), GFP_ATOMIC,
+			ps_lock_shadow_ctor, NULL);
+
 	if (ps_lock)
 		spin_lock(ps_lock);
 	...
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -186,11 +186,17 @@ static inline bool klp_have_reliable_sta
 	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
 }
 
+typedef int (*klp_shadow_ctor_t)(void *obj,
+				 void *shadow_data,
+				 void *ctor_data);
+
 void *klp_shadow_get(void *obj, unsigned long id);
-void *klp_shadow_alloc(void *obj, unsigned long id, void *data,
-		       size_t size, gfp_t gfp_flags);
-void *klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
-			      size_t size, gfp_t gfp_flags);
+void *klp_shadow_alloc(void *obj, unsigned long id,
+		       size_t size, gfp_t gfp_flags,
+		       klp_shadow_ctor_t ctor, void *ctor_data);
+void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
+			      size_t size, gfp_t gfp_flags,
+			      klp_shadow_ctor_t ctor, void *ctor_data);
 void klp_shadow_free(void *obj, unsigned long id);
 void klp_shadow_free_all(unsigned long id);
 
--- a/kernel/livepatch/shadow.c
+++ b/kernel/livepatch/shadow.c
@@ -113,8 +113,10 @@ void *klp_shadow_get(void *obj, unsigned
 }
 EXPORT_SYMBOL_GPL(klp_shadow_get);
 
-static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
-		       size_t size, gfp_t gfp_flags, bool warn_on_exist)
+static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id,
+				       size_t size, gfp_t gfp_flags,
+				       klp_shadow_ctor_t ctor, void *ctor_data,
+				       bool warn_on_exist)
 {
 	struct klp_shadow *new_shadow;
 	void *shadow_data;
@@ -125,18 +127,15 @@ static void *__klp_shadow_get_or_alloc(v
 	if (shadow_data)
 		goto exists;
 
-	/* Allocate a new shadow variable for use inside the lock below */
+	/*
+	 * Allocate a new shadow variable.  Fill it with zeroes by default.
+	 * More complex setting can be done by @ctor function.  But it is
+	 * called only when the buffer is really used (under klp_shadow_lock).
+	 */
 	new_shadow = kzalloc(size + sizeof(*new_shadow), gfp_flags);
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
@@ -150,6 +149,22 @@ static void *__klp_shadow_get_or_alloc(v
 		goto exists;
 	}
 
+	new_shadow->obj = obj;
+	new_shadow->id = id;
+
+	if (ctor) {
+		int err;
+
+		err = ctor(obj, new_shadow->data, ctor_data);
+		if (err) {
+			spin_unlock_irqrestore(&klp_shadow_lock, flags);
+			kfree(new_shadow);
+			pr_err("Failed to construct shadow variable <%p, %lx> (%d)\n",
+			       obj, id, err);
+			return NULL;
+		}
+	}
+
 	/* No <obj, id> found, so attach the newly allocated one */
 	hash_add_rcu(klp_shadow_hash, &new_shadow->node,
 		     (unsigned long)new_shadow->obj);
@@ -170,26 +185,32 @@ exists:
  * klp_shadow_alloc() - allocate and add a new shadow variable
  * @obj:	pointer to parent object
  * @id:		data identifier
- * @data:	pointer to data to attach to parent
  * @size:	size of attached data
  * @gfp_flags:	GFP mask for allocation
+ * @ctor:	custom constructor to initialize the shadow data (optional)
+ * @ctor_data:	pointer to any data needed by @ctor (optional)
  *
- * Allocates @size bytes for new shadow variable data using @gfp_flags
- * and copies @size bytes from @data into the new shadow variable's own
- * data space.  If @data is NULL, @size bytes are still allocated, but
- * no copy is performed.  The new shadow variable is then added to the
- * global hashtable.
- *
- * If an existing <obj, id> shadow variable can be found, this routine
- * will issue a WARN, exit early and return NULL.
+ * Allocates @size bytes for new shadow variable data using @gfp_flags.
+ * The data are zeroed by default.  They are further initialized by @ctor
+ * function if it is not NULL.  The new shadow variable is then added
+ * to the global hashtable.
+ *
+ * If an existing <obj, id> shadow variable can be found, this routine will
+ * issue a WARN, exit early and return NULL.
+ *
+ * This function guarantees that the constructor function is called only when
+ * the variable did not exist before.  The cost is that @ctor is called
+ * in atomic context under a spin lock.
  *
  * Return: the shadow variable data element, NULL on duplicate or
  * failure.
  */
-void *klp_shadow_alloc(void *obj, unsigned long id, void *data,
-		       size_t size, gfp_t gfp_flags)
+void *klp_shadow_alloc(void *obj, unsigned long id,
+		       size_t size, gfp_t gfp_flags,
+		       klp_shadow_ctor_t ctor, void *ctor_data)
 {
-	return __klp_shadow_get_or_alloc(obj, id, data, size, gfp_flags, true);
+	return __klp_shadow_get_or_alloc(obj, id, size, gfp_flags,
+					 ctor, ctor_data, true);
 }
 EXPORT_SYMBOL_GPL(klp_shadow_alloc);
 
@@ -197,25 +218,28 @@ EXPORT_SYMBOL_GPL(klp_shadow_alloc);
  * klp_shadow_get_or_alloc() - get existing or allocate a new shadow variable
  * @obj:	pointer to parent object
  * @id:		data identifier
- * @data:	pointer to data to attach to parent
  * @size:	size of attached data
  * @gfp_flags:	GFP mask for allocation
+ * @ctor:	custom constructor to initialize the shadow data (optional)
+ * @ctor_data:	pointer to any data needed by @ctor (optional)
  *
  * Returns a pointer to existing shadow data if an <obj, id> shadow
  * variable is already present.  Otherwise, it creates a new shadow
  * variable like klp_shadow_alloc().
  *
- * This function guarantees that only one shadow variable exists with
- * the given @id for the given @obj.  It also guarantees that the shadow
- * variable will be initialized by the given @data only when it did not
- * exist before.
+ * This function guarantees that only one shadow variable exists with the given
+ * @id for the given @obj.  It also guarantees that the constructor function
+ * will be called only when the variable did not exist before.  The cost is
+ * that @ctor is called in atomic context under a spin lock.
  *
  * Return: the shadow variable data element, NULL on failure.
  */
-void *klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
-			       size_t size, gfp_t gfp_flags)
+void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
+			      size_t size, gfp_t gfp_flags,
+			      klp_shadow_ctor_t ctor, void *ctor_data)
 {
-	return __klp_shadow_get_or_alloc(obj, id, data, size, gfp_flags, false);
+	return __klp_shadow_get_or_alloc(obj, id, size, gfp_flags,
+					 ctor, ctor_data, false);
 }
 EXPORT_SYMBOL_GPL(klp_shadow_get_or_alloc);
 
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -56,6 +56,21 @@ struct dummy {
 	unsigned long jiffies_expire;
 };
 
+/*
+ * The constructor makes more sense together with klp_shadow_get_or_alloc().
+ * In this example, it would be safe to assign the pointer also to the shadow
+ * variable returned by klp_shadow_alloc().  But we wanted to show the more
+ * complicated use of the API.
+ */
+static int shadow_leak_ctor(void *obj, void *shadow_data, void *ctor_data)
+{
+	void **shadow_leak = shadow_data;
+	void *leak = ctor_data;
+
+	*shadow_leak = leak;
+	return 0;
+}
+
 struct dummy *livepatch_fix1_dummy_alloc(void)
 {
 	struct dummy *d;
@@ -74,7 +89,8 @@ struct dummy *livepatch_fix1_dummy_alloc
 	 * pointer to handle resource release.
 	 */
 	leak = kzalloc(sizeof(int), GFP_KERNEL);
-	klp_shadow_alloc(d, SV_LEAK, &leak, sizeof(leak), GFP_KERNEL);
+	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
+			 shadow_leak_ctor, leak);
 
 	pr_info("%s: dummy @ %p, expires @ %lx\n",
 		__func__, d, d->jiffies_expire);
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
 


