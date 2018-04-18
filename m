Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDRHOy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:14:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbeDRHOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:14:52 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 18 Apr 2018 16:47:01 +1000
Subject: [PATCH 3/6] rhashtable: reset iter when rhashtable_walk_start sees
 new table
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152403402196.16895.5006460406668610375.stgit2@noble>
In-Reply-To: <152403346237.16895.8767189357062722046.stgit2@noble>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation claims that when rhashtable_walk_start_check()
detects a resize event, it will rewind back to the beginning
of the table.  This is not true.  We need to set ->slot and
->skip to be zero for it to be true.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 19db8e563c40..28e1be9f681b 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -733,6 +733,8 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 
 	if (!iter->walker.tbl && !iter->end_of_table) {
 		iter->walker.tbl = rht_dereference_rcu(ht->tbl, ht);
+		iter->slot = 0;
+		iter->skip = 0;
 		return -EAGAIN;
 	}
 
