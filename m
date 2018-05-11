Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeEKAlM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:41:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbeEKAlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:41:11 -0400
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>
Date: Fri, 11 May 2018 10:37:14 +1000
Subject: [PATCH 5/6] staging: lustre: remove lock from key register/degister
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152599903436.19824.3009972326055034014.stgit@noble>
In-Reply-To: <152599874625.19824.11344372150811845854.stgit@noble>
References: <152599874625.19824.11344372150811845854.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lu_context_key_register() doesn't really need locking.
It can use cmpxchg() to atomically install a key, and
check the result to see if it succeeded.
This requires the key to be completely ready before we
try to install it, so lct_used and lct_reference are
set up first, then reverted on failure.

With this done, lu_context_key_degister() no longer
needs locking.  It just need to set the slot to NULL.
This is done with suitable memory barriers so that the
slot cannot be reused until we are completely finished
with it.

Note that I added a warning if the slot holds NULL.
The code currently tested that code, but I don't think it
can really happen.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   37 +++++++++-----------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index f1c35a71c413..1c874781066d 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -1345,19 +1345,23 @@ int lu_context_key_register(struct lu_context_key *key)
 	LASSERT(key->lct_tags != 0);
 
 	result = -ENFILE;
-	write_lock(&lu_keys_guard);
+	atomic_set(&key->lct_used, 1);
+	lu_ref_init(&key->lct_reference);
 	for (i = 0; i < ARRAY_SIZE(lu_keys); ++i) {
-		if (!lu_keys[i]) {
-			key->lct_index = i;
-			atomic_set(&key->lct_used, 1);
-			lu_keys[i] = key;
-			lu_ref_init(&key->lct_reference);
-			result = 0;
-			atomic_inc(&key_set_version);
-			break;
-		}
+		if (lu_keys[i])
+			continue;
+		key->lct_index = i;
+		if (cmpxchg(&lu_keys[i], NULL, key) != NULL)
+			continue;
+
+		result = 0;
+		atomic_inc(&key_set_version);
+		break;
+	}
+	if (result) {
+		lu_ref_fini(&key->lct_reference);
+		atomic_set(&key->lct_used, 0);
 	}
-	write_unlock(&lu_keys_guard);
 	return result;
 }
 EXPORT_SYMBOL(lu_context_key_register);
@@ -1400,16 +1404,9 @@ void lu_context_key_degister(struct lu_context_key *key)
 	atomic_dec(&key->lct_used);
 	wait_var_event(&key->lct_used, atomic_read(&key->lct_used) == 0);
 
-	write_lock(&lu_keys_guard);
-	if (lu_keys[key->lct_index]) {
-		lu_keys[key->lct_index] = NULL;
+	if (!WARN_ON(lu_keys[key->lct_index] == NULL))
 		lu_ref_fini(&key->lct_reference);
-	}
-	write_unlock(&lu_keys_guard);
-
-	LASSERTF(atomic_read(&key->lct_used) == 0,
-		 "key has instances: %d\n",
-		 atomic_read(&key->lct_used));
+	smp_store_release(&lu_keys[key->lct_index], NULL);
 }
 EXPORT_SYMBOL(lu_context_key_degister);
 
