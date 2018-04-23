Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeDWW34 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:29:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbeDWW3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:29:52 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date: Tue, 24 Apr 2018 08:29:13 +1000
Subject: [PATCH 2/4] rhashtable: Revise incorrect comment on r{hl,
 hash}table_walk_enter()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152452255344.1456.125137119770267098.stgit@noble>
In-Reply-To: <152452244405.1456.8175298512483573078.stgit@noble>
References: <152452244405.1456.8175298512483573078.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither rhashtable_walk_enter() or rhltable_walk_enter() sleep, though
they do take a spinlock without irq protection.
So revise the comments to accurately state the contexts in which
these functions can be called.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    5 +++--
 lib/rhashtable.c           |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 87d443a5b11d..4e1f535c2034 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -1268,8 +1268,9 @@ static inline int rhashtable_walk_init(struct rhashtable *ht,
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
  *
- * This function may sleep so you must not call it from interrupt
- * context or with spin locks held.
+ * This function may be called from any process context, including
+ * non-preemptable context, but cannot be called from softirq or
+ * hardirq context.
  *
  * You must call rhashtable_walk_exit after this function returns.
  */
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 2b2b79974b61..6d490f51174e 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -668,8 +668,9 @@ EXPORT_SYMBOL_GPL(rhashtable_insert_slow);
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
  *
- * This function may sleep so you must not call it from interrupt
- * context or with spin locks held.
+ * This function may be called from any process context, including
+ * non-preemptable context, but cannot be called from softirq or
+ * hardirq context.
  *
  * You must call rhashtable_walk_exit after this function returns.
  */
