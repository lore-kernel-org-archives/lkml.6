Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeFAEpx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:45:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34063 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbeFAEpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:49 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 07/18] rhashtable: use cmpxchg() to protect ->future_tbl.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824954.30340.10107132482367263068.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
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
 lib/rhashtable.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index e209069f1d74..b5d17bce19ff 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -297,21 +297,14 @@ static int rhashtable_rehash_attach(struct rhashtable *ht,
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
+	 * As cmpxchg() provides strong barriers, we do not need
+	 * rcu_assign_pointer().
 	 */
-	rcu_assign_pointer(old_tbl->future_tbl, new_tbl);
 
-	spin_unlock_bh(old_tbl->locks);
+	if (cmpxchg(&old_tbl->future_tbl, NULL, new_tbl) != NULL)
+		return -EEXIST;
 
 	return 0;
 }
