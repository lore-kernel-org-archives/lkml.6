Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeFAEpR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33991 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeFAEpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:10 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 01/18] rhashtable: silence RCU warning in rhashtable_test.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824927.30340.12281188634659526226.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

print_ht in rhashtable_test calls rht_dereference() with neither
RCU protection or the mutex.  This triggers an RCU warning.
So take the mutex to silence the warning.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/test_rhashtable.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index f4000c137dbe..bf92b7aa2a49 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -499,6 +499,8 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 	unsigned int i, cnt = 0;
 
 	ht = &rhlt->ht;
+	/* Take the mutex to avoid RCU warning */
+	mutex_lock(&ht->mutex);
 	tbl = rht_dereference(ht->tbl, ht);
 	for (i = 0; i < tbl->size; i++) {
 		struct rhash_head *pos, *next;
@@ -532,6 +534,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 		}
 	}
 	printk(KERN_ERR "\n---- ht: ----%s\n-------------\n", buff);
+	mutex_unlock(&ht->mutex);
 
 	return cnt;
 }
