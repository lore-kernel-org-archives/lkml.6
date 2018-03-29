Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeC2BUq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:20:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44285 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC2BUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:20:44 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 29 Mar 2018 12:19:09 +1100
Subject: [PATCH 1/2] rhashtable: fix insertion of in rhltable when duplicate
 found.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152228634995.16370.12793320017578882447.stgit@noble>
In-Reply-To: <152228607974.16370.14544827502467836789.stgit@noble>
References: <152228607974.16370.14544827502467836789.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rhltable_insert() finds an entry with the same key,
it splices the new entry at the start of a list of entries with the
same key.
It stores the address of the new object in *pprev, but in general this
is *not* the location where the match was found (though in a common
case where the hash chain has one element, it will be).
To fix this, pprev should be updated every time we find an object that
doesn't match.

This patch changes the behaviour for non-slow insertion in that now
insertion happens at the end of a chain rather than at the head.
I don't think this is an important change.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    4 +++-
 lib/rhashtable.c           |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index c9df2527e0cd..668a21f04b09 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -766,8 +766,10 @@ static inline void *__rhashtable_insert_fast(
 		if (!key ||
 		    (params.obj_cmpfn ?
 		     params.obj_cmpfn(&arg, rht_obj(ht, head)) :
-		     rhashtable_compare(&arg, rht_obj(ht, head))))
+		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
+			pprev = &head->next;
 			continue;
+		}
 
 		data = rht_obj(ht, head);
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 394de09a162c..72e56f89e20c 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -506,8 +506,10 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		if (!key ||
 		    (ht->p.obj_cmpfn ?
 		     ht->p.obj_cmpfn(&arg, rht_obj(ht, head)) :
-		     rhashtable_compare(&arg, rht_obj(ht, head))))
+		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
+			pprev = &head->next;
 			continue;
+		}
 
 		if (!ht->rhlist)
 			return rht_obj(ht, head);
