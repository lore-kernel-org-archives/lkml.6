Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeEDDyt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:54:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEDDyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:54:47 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 May 2018 13:54:14 +1000
Subject: [PATCH 1/8] rhashtable: silence RCU warning in rhashtable_test.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152540605424.18473.310003836978239224.stgit@noble>
In-Reply-To: <152540595840.18473.11298241115621799037.stgit@noble>
References: <152540595840.18473.11298241115621799037.stgit@noble>
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
