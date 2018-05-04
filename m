Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEDDzC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:55:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:44974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEDDy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:54:59 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 May 2018 13:54:14 +1000
Subject: [PATCH 3/8] rhashtable: use cmpxchg() to protect ->future_tbl.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152540605430.18473.11758878046224478232.stgit@noble>
In-Reply-To: <152540595840.18473.11298241115621799037.stgit@noble>
References: <152540595840.18473.11298241115621799037.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than borrowing one of the bucket locks to
protect ->future_tbl updates, use cmpxchg().
This gives more freedom to change how bucket locking
is implemented.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 4a3f94e8e8a6..b73afe1dec7e 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -298,21 +298,16 @@ static int rhashtable_rehash_attach(struct rhashtable *ht,
 				    struct bucket_table *old_tbl,
 				    struct bucket_table *new_tbl)
 {
-	/* Protect future_tbl using the first bucket lock. */
-	spin_lock_bh(old_tbl->locks);
-
-	/* Did somebody beat us to it? */
-	if (rcu_access_pointer(old_tbl->future_tbl)) {
-		spin_unlock_bh(old_tbl->locks);
-		return -EEXIST;
-	}
-
 	/* Make insertions go into the new, empty table right away. Deletions
 	 * and lookups will be attempted in both tables until we synchronize.
+	 * The use of 'tmp' is simply to ensure we get the required memory
+	 * barriers before the cmpxchg().
 	 */
-	rcu_assign_pointer(old_tbl->future_tbl, new_tbl);
+	struct bucket_table *tmp;
 
-	spin_unlock_bh(old_tbl->locks);
+	rcu_assign_pointer(tmp, new_tbl);
+	if (cmpxchg(&old_tbl->future_tbl, NULL, tmp) != NULL)
+		return -EEXIST;
 
 	return 0;
 }
