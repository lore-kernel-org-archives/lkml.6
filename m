Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeDWWaF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:30:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:54620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932628AbeDWW36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:29:58 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date: Tue, 24 Apr 2018 08:29:13 +1000
Subject: [PATCH 3/4] rhashtable: reset iter when rhashtable_walk_start sees
 new table
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152452255348.1456.1629211529227597992.stgit@noble>
In-Reply-To: <152452244405.1456.8175298512483573078.stgit@noble>
References: <152452244405.1456.8175298512483573078.stgit@noble>
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
index 6d490f51174e..81edf1ab38ab 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -737,6 +737,8 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 
 	if (!iter->walker.tbl && !iter->end_of_table) {
 		iter->walker.tbl = rht_dereference_rcu(ht->tbl, ht);
+		iter->slot = 0;
+		iter->skip = 0;
 		return -EAGAIN;
 	}
 
