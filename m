Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeFEC1R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 22:27:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeFEC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 22:27:13 -0400
Date: Mon, 4 Jun 2018 19:27:12 -0700
From: Matthew Wilcox <willy@infradead.org>
To: John Johansen <john.johansen@canonical.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use an IDR to allocate apparmor secids
Message-ID: <20180605022712.GB32444@bombadil.infradead.org>
References: <20180522093259.GA30182@bombadil.infradead.org>
 <20180528170108.GA5448@bombadil.infradead.org>
 <862d03b6-ba2f-3ec0-d45e-d8fcf16f9edf@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <862d03b6-ba2f-3ec0-d45e-d8fcf16f9edf@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 06:27:09PM -0700, John Johansen wrote:
> hey Mathew,
> 
> I've pulled this into apparmor-next and done the retuning of
> AA_SECID_INVALID a follow on patch. The reworking of the api to
> return the specific error type can wait for another cycle.

Oh ... here's what I currently have.  I decided that AA_SECID_INVALID
wasn't needed.

>From 4e43853a7d984d7b16fd68f356aef1b686a05298 Mon Sep 17 00:00:00 2001
From: Matthew Wilcox <mawilcox@microsoft.com>
Date: Tue, 22 May 2018 05:37:19 -0400
Subject: [PATCH] Use an IDR to allocate apparmor secids

Replace the custom usage of the radix tree to store a list of free IDs
with the IDR.  Change the aa_alloc_secid() API to store the secid in the
label while holding the spinlock to ensure that a simultaneous lookup
cannot find an uninitialised secid.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 security/apparmor/include/secid.h |   5 +-
 security/apparmor/label.c         |   3 +-
 security/apparmor/secid.c         | 135 ++++++------------------------
 3 files changed, 28 insertions(+), 115 deletions(-)

diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index 686de8e50a79..a8ba767b2d2c 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -19,16 +19,13 @@
 
 struct aa_label;
 
-/* secid value that will not be allocated */
-#define AA_SECID_INVALID 0
-
 struct aa_label *aa_secid_to_label(u32 secid);
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
 
-u32 aa_alloc_secid(struct aa_label *label, gfp_t gfp);
+int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
 void aa_free_secid(u32 secid);
 void aa_secid_update(u32 secid, struct aa_label *label);
 
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index a17574df611b..ba11bdf9043a 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -407,8 +407,7 @@ bool aa_label_init(struct aa_label *label, int size, gfp_t gfp)
 	AA_BUG(!label);
 	AA_BUG(size < 1);
 
-	label->secid = aa_alloc_secid(label, gfp);
-	if (label->secid == AA_SECID_INVALID)
+	if (aa_alloc_secid(label, gfp) < 0)
 		return false;
 
 	label->size = size;			/* doesn't include null */
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index c2f0c1571156..bc9f8e101b65 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -30,18 +31,10 @@
 /*
  * secids - do not pin labels with a refcount. They rely on the label
  * properly updating/freeing them
- *
- * A singly linked free list is used to track secids that have been
- * freed and reuse them before allocating new ones
  */
 
-#define FREE_LIST_HEAD 1
-
-static RADIX_TREE(aa_secids_map, GFP_ATOMIC);
+static DEFINE_IDR(aa_secids);
 static DEFINE_SPINLOCK(secid_lock);
-static u32 alloced_secid = FREE_LIST_HEAD;
-static u32 free_list = FREE_LIST_HEAD;
-static unsigned long free_count;
 
 /*
  * TODO: allow policy to reserve a secid range?
@@ -49,65 +42,6 @@ static unsigned long free_count;
  * TODO: use secid_update in label replace
  */
 
-#define SECID_MAX U32_MAX
-
-/* TODO: mark free list as exceptional */
-static void *to_ptr(u32 secid)
-{
-	return (void *)
-		((((unsigned long) secid) << RADIX_TREE_EXCEPTIONAL_SHIFT));
-}
-
-static u32 to_secid(void *ptr)
-{
-	return (u32) (((unsigned long) ptr) >> RADIX_TREE_EXCEPTIONAL_SHIFT);
-}
-
-
-/* TODO: tag free_list entries to mark them as different */
-static u32 __pop(struct aa_label *label)
-{
-	u32 secid = free_list;
-	void __rcu **slot;
-	void *entry;
-
-	if (free_list == FREE_LIST_HEAD)
-		return AA_SECID_INVALID;
-
-	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
-	AA_BUG(!slot);
-	entry = radix_tree_deref_slot_protected(slot, &secid_lock);
-	free_list = to_secid(entry);
-	radix_tree_replace_slot(&aa_secids_map, slot, label);
-	free_count--;
-
-	return secid;
-}
-
-static void __push(u32 secid)
-{
-	void __rcu **slot;
-
-	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
-	AA_BUG(!slot);
-	radix_tree_replace_slot(&aa_secids_map, slot, to_ptr(free_list));
-	free_list = secid;
-	free_count++;
-}
-
-static struct aa_label * __secid_update(u32 secid, struct aa_label *label)
-{
-	struct aa_label *old;
-	void __rcu **slot;
-
-	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
-	AA_BUG(!slot);
-	old = radix_tree_deref_slot_protected(slot, &secid_lock);
-	radix_tree_replace_slot(&aa_secids_map, slot, label);
-
-	return old;
-}
-
 /**
  * aa_secid_update - update a secid mapping to a new label
  * @secid: secid to update
@@ -115,11 +49,10 @@ static struct aa_label * __secid_update(u32 secid, struct aa_label *label)
  */
 void aa_secid_update(u32 secid, struct aa_label *label)
 {
-	struct aa_label *old;
 	unsigned long flags;
 
 	spin_lock_irqsave(&secid_lock, flags);
-	old = __secid_update(secid, label);
+	idr_replace(&aa_secids, label, secid);
 	spin_unlock_irqrestore(&secid_lock, flags);
 }
 
@@ -132,7 +65,7 @@ struct aa_label *aa_secid_to_label(u32 secid)
 	struct aa_label *label;
 
 	rcu_read_lock();
-	label = radix_tree_lookup(&aa_secids_map, secid);
+	label = idr_find(&aa_secids, secid);
 	rcu_read_unlock();
 
 	return label;
@@ -167,7 +100,6 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
-
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	struct aa_label *label;
@@ -186,46 +118,31 @@ void apparmor_release_secctx(char *secdata, u32 seclen)
 	kfree(secdata);
 }
 
-
 /**
- * aa_alloc_secid - allocate a new secid for a profile
+ * aa_alloc_secid - Allocate a new secid for a profile.
+ * @label: Freshly allocated label.
+ * @gfp: Memory allocation flags.
+ *
+ * Initialises the label's secid with an unused ID.
+ *
+ * Context: Any context.
+ * Return: 0 if the label's secid has been successfully initialised.  If
+ * memory allocation failed, returns -ENOMEM.  If no more IDs are
+ * available, returns -ENOSPC.
  */
-u32 aa_alloc_secid(struct aa_label *label, gfp_t gfp)
+int aa_alloc_secid(struct aa_label *label, gfp_t gfp)
 {
 	unsigned long flags;
-	u32 secid;
-
-	/* racey, but at worst causes new allocation instead of reuse */
-	if (free_list == FREE_LIST_HEAD) {
-		bool preload = 0;
-		int res;
-
-retry:
-		if (gfpflags_allow_blocking(gfp) && !radix_tree_preload(gfp))
-			preload = 1;
-		spin_lock_irqsave(&secid_lock, flags);
-		if (alloced_secid != SECID_MAX) {
-			secid = ++alloced_secid;
-			res = radix_tree_insert(&aa_secids_map, secid, label);
-			AA_BUG(res == -EEXIST);
-		} else {
-			secid = AA_SECID_INVALID;
-		}
-		spin_unlock_irqrestore(&secid_lock, flags);
-		if (preload)
-			radix_tree_preload_end();
-	} else {
-		spin_lock_irqsave(&secid_lock, flags);
-		/* remove entry from free list */
-		secid = __pop(label);
-		if (secid == AA_SECID_INVALID) {
-			spin_unlock_irqrestore(&secid_lock, flags);
-			goto retry;
-		}
-		spin_unlock_irqrestore(&secid_lock, flags);
-	}
-
-	return secid;
+	int err;
+
+	idr_preload(gfp);
+	spin_lock_irqsave(&secid_lock, flags);
+	err = idr_alloc_u32(&aa_secids, label, &label->secid, UINT_MAX,
+			GFP_ATOMIC);
+	spin_unlock_irqrestore(&secid_lock, flags);
+	idr_preload_end();
+
+	return err;
 }
 
 /**
@@ -237,6 +154,6 @@ void aa_free_secid(u32 secid)
 	unsigned long flags;
 
 	spin_lock_irqsave(&secid_lock, flags);
-	__push(secid);
+	idr_remove(&aa_secids, secid);
 	spin_unlock_irqrestore(&secid_lock, flags);
 }
-- 
2.17.0
