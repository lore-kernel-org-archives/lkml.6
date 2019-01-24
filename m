Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD612C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfAXDIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:08:50 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:40156 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAXDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:08:50 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gmVNk-0007Ke-Lm; Thu, 24 Jan 2019 11:08:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gmVNh-00038M-S6; Thu, 24 Jan 2019 11:08:41 +0800
Date:   Thu, 24 Jan 2019 11:08:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Josh Elsasser <jelsasser@appneta.com>
Cc:     "David S . Miller" <davem@davemloft.net>, josh@elsasser.ca,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] rhashtable: Still do rehash when we get EEXIST
Message-ID: <20190124030841.n4jtsqka5zji3e62@gondor.apana.org.au>
References: <20190123211758.104275-1-jelsasser@appneta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123211758.104275-1-jelsasser@appneta.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:17:58PM -0800, Josh Elsasser wrote:
> When running workloads with large bursts of fragmented packets, we've seen
> a few machines stuck returning -EEXIST from rht_shrink() and endlessly
> rescheduling their hash table's deferred work, pegging a CPU core.
> 
> Root cause is commit da20420f83ea ("rhashtable: Add nested tables"), which
> stops ignoring the return code of rhashtable_shrink() and the reallocs
> used to grow the hashtable. This uncovers a bug in the shrink logic where
> "needs to shrink" check runs against the last table but the actual shrink
> operation runs on the first bucket_table in the hashtable (see below):
> 
>  +-------+    +--------------+          +---------------+
>  | ht    |    | "first" tbl  |          | "last" tbl    |
>  | - tbl ---> | - future_tbl ---------> |  - future_tbl ---> NULL
>  +-------+    +--------------+          +---------------+
>                ^^^                          ^^^
> 	       used by rhashtable_shrink()  used by rht_shrink_below_30()
> 
> A rehash then stalls out when both the last table needs to shrink, the
> first table has more elements than the target size, but rht_shrink() hits
> a non-NULL future_tbl and returns -EEXIST. This skips the item rehashing
> and kicks off a reschedule loop, as no forward progress can be made while
> the rhashtable needs to shrink.
> 
> Extend rhashtable_shrink() with a "tbl" param to avoid endless exit-and-
> reschedules after hitting the EEXIST, allowing it to check a future_tbl
> pointer that can actually be non-NULL and make forward progress when the
> hashtable needs to shrink.
> 
> Fixes: da20420f83ea ("rhashtable: Add nested tables")
> Signed-off-by: Josh Elsasser <jelsasser@appneta.com>

Thanks for catching this!

Although I think we should fix this in a different way.  The problem
here is that the shrink cannot proceed because there was a previous
rehash that is still incomplete.  We should wait for its completion
and then reattempt a shrinnk should it still be necessary.

So something like this:

---8<---
As it stands if a shrink is delayed because of an outstanding
rehash, we will go into a rescheduling loop without ever doing
the rehash.

This patch fixes this by still carrying out the rehash and then
rescheduling so that we can shrink after the completion of the
rehash should it still be necessary.

The return value of EEXIST captures this case and other cases
(e.g., another thread expanded/rehashed the table at the same
time) where we should still proceed with the rehash.

Fixes: da20420f83ea ("rhashtable: Add nested tables")
Reported-by: Josh Elsasser <jelsasser@appneta.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 852ffa5160f1..4edcf3310513 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -416,8 +416,12 @@ static void rht_deferred_worker(struct work_struct *work)
 	else if (tbl->nest)
 		err = rhashtable_rehash_alloc(ht, tbl, tbl->size);
 
-	if (!err)
-		err = rhashtable_rehash_table(ht);
+	if (!err || err == -EEXIST) {
+		int nerr;
+
+		nerr = rhashtable_rehash_table(ht);
+		err = err ?: nerr;
+	}
 
 	mutex_unlock(&ht->mutex);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
