Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeFAEqG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34105 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbeFAEqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:46:01 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 09/18] rhashtable: use cmpxchg() in nested_table_alloc()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824961.30340.16484931507108689498.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nested_table_alloc() relies on the fact that there is
at most one spinlock allocated for every slot in the top
level nested table, so it is not possible for two threads
to try to allocate the same table at the same time.

A future patch will change the locking and invalidate
this assumption.  So change the code to protect against
a race using cmpxchg() - if it loses, it frees the table
that it allocated.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 1737fbd049da..86c801d04d4a 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -132,9 +132,11 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 			INIT_RHT_NULLS_HEAD(ntbl[i].bucket);
 	}
 
-	rcu_assign_pointer(*prev, ntbl);
-
-	return ntbl;
+	if (cmpxchg(prev, NULL, ntbl) == NULL)
+		return ntbl;
+	/* Raced with another thread. */
+	kfree(ntbl);
+	return rcu_dereference(*prev);
 }
 
 static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
