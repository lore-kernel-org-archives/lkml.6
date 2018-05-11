Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeEKAlG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:41:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:37496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbeEKAlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:41:04 -0400
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>
Date: Fri, 11 May 2018 10:37:14 +1000
Subject: [PATCH 4/6] staging: lustre: use wait_event_var() in
 lu_context_key_degister()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152599903434.19824.4375447070117782717.stgit@noble>
In-Reply-To: <152599874625.19824.11344372150811845854.stgit@noble>
References: <152599874625.19824.11344372150811845854.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lu_context_key_degister() has an open coded loop which calls
schedule() without setting a new task state.  This is generally
a bad idea - it could easily just spin.

Instead, use wait_event_var() to wait for ->lct_used to be zero,
and arrange to get a wakeup when that happens.
Previously ->lct_used would only fall down to 1.  Now we decrement
it an extra time so that wake_up, which only happens when the
count reaches zero, will only happen when lu_context_key_degister()
is actually waiting for it.

Note that this patch removes key_fini() from protection by
lu_keys_guard.  key_fini() calls are not always protected
by a lock, and there seems to be no need here.  Nothing else
can be acting on the given key in that context at this point,
so no race is possible.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 7bcf5ee47e04..f1c35a71c413 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -1372,7 +1372,8 @@ static void key_fini(struct lu_context *ctx, int index)
 
 		key->lct_fini(ctx, key, ctx->lc_value[index]);
 		lu_ref_del(&key->lct_reference, "ctx", ctx);
-		atomic_dec(&key->lct_used);
+		if (atomic_dec_and_test(&key->lct_used))
+			wake_up_var(&key->lct_used);
 
 		if ((ctx->lc_tags & LCT_NOREF) == 0)
 			module_put(key->lct_owner);
@@ -1390,28 +1391,23 @@ void lu_context_key_degister(struct lu_context_key *key)
 
 	lu_context_key_quiesce(key);
 
-	write_lock(&lu_keys_guard);
 	key_fini(&lu_shrink_env.le_ctx, key->lct_index);
 
 	/**
 	 * Wait until all transient contexts referencing this key have
 	 * run lu_context_key::lct_fini() method.
 	 */
-	while (atomic_read(&key->lct_used) > 1) {
-		write_unlock(&lu_keys_guard);
-		CDEBUG(D_INFO, "%s: \"%s\" %p, %d\n",
-		       __func__, module_name(key->lct_owner),
-		       key, atomic_read(&key->lct_used));
-		schedule();
-		write_lock(&lu_keys_guard);
-	}
+	atomic_dec(&key->lct_used);
+	wait_var_event(&key->lct_used, atomic_read(&key->lct_used) == 0);
+
+	write_lock(&lu_keys_guard);
 	if (lu_keys[key->lct_index]) {
 		lu_keys[key->lct_index] = NULL;
 		lu_ref_fini(&key->lct_reference);
 	}
 	write_unlock(&lu_keys_guard);
 
-	LASSERTF(atomic_read(&key->lct_used) == 1,
+	LASSERTF(atomic_read(&key->lct_used) == 0,
 		 "key has instances: %d\n",
 		 atomic_read(&key->lct_used));
 }
