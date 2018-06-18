Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DBFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78DA208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78DA208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934384AbeFRIQY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:16:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934284AbeFRIQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11F4AC50;
        Mon, 18 Jun 2018 08:16:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 035/279] livepatch: Allow to call a custom callback when freeing shadow variables
Date:   Mon, 18 Jun 2018 10:10:20 +0200
Message-Id: <20180618080610.269664585@linuxfoundation.org>
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

[ Upstream commit 3b2c77d000fe9f7d02e9e726e00dccf9f92b256f ]

We might need to do some actions before the shadow variable is freed.
For example, we might need to remove it from a list or free some data
that it points to.

This is already possible now. The user can get the shadow variable
by klp_shadow_get(), do the necessary actions, and then call
klp_shadow_free().

This patch allows to do it a more elegant way. The user could implement
the needed actions in a callback that is passed to klp_shadow_free()
as a parameter. The callback usually does reverse operations to
the constructor callback that can be called by klp_shadow_*alloc().

It is especially useful for klp_shadow_free_all(). There we need to do
these extra actions for each found shadow variable with the given ID.

Note that the memory used by the shadow variable itself is still released
later by rcu callback. It is needed to protect internal structures that
keep all shadow variables. But the destructor is called immediately.
The shadow variable must not be access anyway after klp_shadow_free()
is called. The user is responsible to protect this any suitable way.

Be aware that the destructor is called under klp_shadow_lock. It is
the same as for the contructor in klp_shadow_alloc().

Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/livepatch/shadow-vars.txt   |   10 +++++++---
 include/linux/livepatch.h                 |    5 +++--
 kernel/livepatch/shadow.c                 |   26 ++++++++++++++++++--------
 samples/livepatch/livepatch-shadow-fix1.c |   25 +++++++++++++++----------
 samples/livepatch/livepatch-shadow-fix2.c |   27 ++++++++++++++++-----------
 5 files changed, 59 insertions(+), 34 deletions(-)

--- a/Documentation/livepatch/shadow-vars.txt
+++ b/Documentation/livepatch/shadow-vars.txt
@@ -65,11 +65,15 @@ to do actions that can be done only once
 
 * klp_shadow_free() - detach and free a <obj, id> shadow variable
   - find and remove a <obj, id> reference from global hashtable
-    - if found, free shadow variable
+    - if found
+      - call destructor function if defined
+      - free shadow variable
 
 * klp_shadow_free_all() - detach and free all <*, id> shadow variables
   - find and remove any <*, id> references from global hashtable
-    - if found, free shadow variable
+    - if found
+      - call destructor function if defined
+      - free shadow variable
 
 
 2. Use cases
@@ -136,7 +140,7 @@ variable:
 
 void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 {
-	klp_shadow_free(sta, PS_LOCK);
+	klp_shadow_free(sta, PS_LOCK, NULL);
 	kfree(sta);
 	...
 
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -189,6 +189,7 @@ static inline bool klp_have_reliable_sta
 typedef int (*klp_shadow_ctor_t)(void *obj,
 				 void *shadow_data,
 				 void *ctor_data);
+typedef void (*klp_shadow_dtor_t)(void *obj, void *shadow_data);
 
 void *klp_shadow_get(void *obj, unsigned long id);
 void *klp_shadow_alloc(void *obj, unsigned long id,
@@ -197,8 +198,8 @@ void *klp_shadow_alloc(void *obj, unsign
 void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
 			      size_t size, gfp_t gfp_flags,
 			      klp_shadow_ctor_t ctor, void *ctor_data);
-void klp_shadow_free(void *obj, unsigned long id);
-void klp_shadow_free_all(unsigned long id);
+void klp_shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor);
+void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor);
 
 #else /* !CONFIG_LIVEPATCH */
 
--- a/kernel/livepatch/shadow.c
+++ b/kernel/livepatch/shadow.c
@@ -243,15 +243,26 @@ void *klp_shadow_get_or_alloc(void *obj,
 }
 EXPORT_SYMBOL_GPL(klp_shadow_get_or_alloc);
 
+static void klp_shadow_free_struct(struct klp_shadow *shadow,
+				   klp_shadow_dtor_t dtor)
+{
+	hash_del_rcu(&shadow->node);
+	if (dtor)
+		dtor(shadow->obj, shadow->data);
+	kfree_rcu(shadow, rcu_head);
+}
+
 /**
  * klp_shadow_free() - detach and free a <obj, id> shadow variable
  * @obj:	pointer to parent object
  * @id:		data identifier
+ * @dtor:	custom callback that can be used to unregister the variable
+ *		and/or free data that the shadow variable points to (optional)
  *
  * This function releases the memory for this <obj, id> shadow variable
  * instance, callers should stop referencing it accordingly.
  */
-void klp_shadow_free(void *obj, unsigned long id)
+void klp_shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor)
 {
 	struct klp_shadow *shadow;
 	unsigned long flags;
@@ -263,8 +274,7 @@ void klp_shadow_free(void *obj, unsigned
 			       (unsigned long)obj) {
 
 		if (klp_shadow_match(shadow, obj, id)) {
-			hash_del_rcu(&shadow->node);
-			kfree_rcu(shadow, rcu_head);
+			klp_shadow_free_struct(shadow, dtor);
 			break;
 		}
 	}
@@ -276,11 +286,13 @@ EXPORT_SYMBOL_GPL(klp_shadow_free);
 /**
  * klp_shadow_free_all() - detach and free all <*, id> shadow variables
  * @id:		data identifier
+ * @dtor:	custom callback that can be used to unregister the variable
+ *		and/or free data that the shadow variable points to (optional)
  *
  * This function releases the memory for all <*, id> shadow variable
  * instances, callers should stop referencing them accordingly.
  */
-void klp_shadow_free_all(unsigned long id)
+void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor)
 {
 	struct klp_shadow *shadow;
 	unsigned long flags;
@@ -290,10 +302,8 @@ void klp_shadow_free_all(unsigned long i
 
 	/* Delete all <*, id> from hash */
 	hash_for_each(klp_shadow_hash, i, shadow, node) {
-		if (klp_shadow_match(shadow, shadow->obj, id)) {
-			hash_del_rcu(&shadow->node);
-			kfree_rcu(shadow, rcu_head);
-		}
+		if (klp_shadow_match(shadow, shadow->obj, id))
+			klp_shadow_free_struct(shadow, dtor);
 	}
 
 	spin_unlock_irqrestore(&klp_shadow_lock, flags);
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -98,9 +98,19 @@ struct dummy *livepatch_fix1_dummy_alloc
 	return d;
 }
 
+static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
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
@@ -109,15 +119,10 @@ void livepatch_fix1_dummy_free(struct du
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
+		klp_shadow_free(d, SV_LEAK, livepatch_fix1_dummy_leak_dtor);
+	else
 		pr_info("%s: dummy @ %p leaked!\n", __func__, d);
-	}
 
 	kfree(d);
 }
@@ -163,7 +168,7 @@ static int livepatch_shadow_fix1_init(vo
 static void livepatch_shadow_fix1_exit(void)
 {
 	/* Cleanup any existing SV_LEAK shadow variables */
-	klp_shadow_free_all(SV_LEAK);
+	klp_shadow_free_all(SV_LEAK, livepatch_fix1_dummy_leak_dtor);
 
 	WARN_ON(klp_unregister_patch(&patch));
 }
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -68,22 +68,27 @@ bool livepatch_fix2_dummy_check(struct d
 	return time_after(jiffies, d->jiffies_expire);
 }
 
+static void livepatch_fix2_dummy_leak_dtor(void *obj, void *shadow_data)
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
+		klp_shadow_free(d, SV_LEAK, livepatch_fix2_dummy_leak_dtor);
+	else
 		pr_info("%s: dummy @ %p leaked!\n", __func__, d);
-	}
 
 	/*
 	 * Patch: fetch the SV_COUNTER shadow variable and display
@@ -93,7 +98,7 @@ void livepatch_fix2_dummy_free(struct du
 	if (shadow_count) {
 		pr_info("%s: dummy @ %p, check counter = %d\n",
 			__func__, d, *shadow_count);
-		klp_shadow_free(d, SV_COUNTER);
+		klp_shadow_free(d, SV_COUNTER, NULL);
 	}
 
 	kfree(d);
@@ -140,7 +145,7 @@ static int livepatch_shadow_fix2_init(vo
 static void livepatch_shadow_fix2_exit(void)
 {
 	/* Cleanup any existing SV_COUNTER shadow variables */
-	klp_shadow_free_all(SV_COUNTER);
+	klp_shadow_free_all(SV_COUNTER, NULL);
 
 	WARN_ON(klp_unregister_patch(&patch));
 }


