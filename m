Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEDDzI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:55:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEDDzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:55:05 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 May 2018 13:54:14 +1000
Subject: [PATCH 4/8] rhashtable: fix race in nested_table_alloc()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152540605432.18473.11813271279255176724.stgit@noble>
In-Reply-To: <152540595840.18473.11298241115621799037.stgit@noble>
References: <152540595840.18473.11298241115621799037.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If two threads run nested_table_alloc() at the same time
they could both allocate a new table.
Best case is that one of them will never be freed, leaking memory.
Worst case is hat entry get stored there before it leaks,
and the are lost from the table.

So use cmpxchg to detect the race and free the unused table.

Fixes: da20420f83ea ("rhashtable: Add nested tables")
Cc: stable@vger.kernel.org # 4.11+
Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index b73afe1dec7e..114e6090228a 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -119,6 +119,7 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 					      unsigned int nhash)
 {
 	union nested_table *ntbl;
+	union nested_table *tmp;
 	int i;
 
 	ntbl = rcu_dereference(*prev);
@@ -133,9 +134,12 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 					    (i << shifted) | nhash);
 	}
 
-	rcu_assign_pointer(*prev, ntbl);
-
-	return ntbl;
+	rcu_assign_pointer(tmp, ntbl);
+	if (cmpxchg(prev, NULL, tmp) == NULL)
+		return tmp;
+	/* Raced with another thread. */
+	kfree(ntbl);
+	return rcu_dereference(*prev);
 }
 
 static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
