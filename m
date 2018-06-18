Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B98C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ADD208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ADD208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932442AbeFRC5F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:57:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47727 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754666AbeFRC5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:57:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16993AEBB;
        Mon, 18 Jun 2018 02:57:02 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Mon, 18 Jun 2018 12:52:50 +1000
Subject: [PATCH 7/7] rhashtable: clean up dereference of ->future_tbl.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152929037054.23173.13452024901705479237.stgit@noble>
In-Reply-To: <152929034948.23173.8671757672560065344.stgit@noble>
References: <152929034948.23173.8671757672560065344.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using rht_dereference_bucket() to dereference
->future_tbl looks like a type error, and could be confusing.
Using rht_dereference_rcu() to test a pointer for NULL
adds an unnecessary barrier - rcu_access_pointer() is preferred
for NULL tests when no lock is held.

This uses 3 different ways to access ->future_tbl.
- if we know the mutex is held, use rht_dereference()
- if we don't hold the mutex, and are only testing for NULL,
  use rcu_access_pointer()
- otherwise (using RCU protection for true dereference),
  use rht_dereference_rcu().

Note that this includes a simplification of the call to
rhashtable_last_table() - we don't do an extra dereference
before the call any more.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    2 +-
 lib/rhashtable.c           |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 3f3a182bd0b4..eb7111039247 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -595,7 +595,7 @@ static inline void *__rhashtable_insert_fast(
 	lock = rht_bucket_lock(tbl, hash);
 	spin_lock_bh(lock);
 
-	if (unlikely(rht_dereference_bucket(tbl->future_tbl, tbl, hash))) {
+	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
 		spin_unlock_bh(lock);
 		rcu_read_unlock();
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 52ec83212856..0e04947b7e0c 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -226,8 +226,7 @@ static struct bucket_table *rhashtable_last_table(struct rhashtable *ht,
 static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
-	struct bucket_table *new_tbl = rhashtable_last_table(ht,
-		rht_dereference_rcu(old_tbl->future_tbl, ht));
+	struct bucket_table *new_tbl = rhashtable_last_table(ht, old_tbl);
 	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
 	int err = -EAGAIN;
 	struct rhash_head *head, *next, *entry;
@@ -467,7 +466,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 
 fail:
 	/* Do not fail the insert if someone else did a rehash. */
-	if (likely(rcu_dereference_raw(tbl->future_tbl)))
+	if (likely(rcu_access_pointer(tbl->future_tbl)))
 		return 0;
 
 	/* Schedule async rehash to retry allocation in process context. */
@@ -540,7 +539,7 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (PTR_ERR(data) != -EAGAIN && PTR_ERR(data) != -ENOENT)
 		return ERR_CAST(data);
 
-	new_tbl = rcu_dereference(tbl->future_tbl);
+	new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 	if (new_tbl)
 		return new_tbl;
 
@@ -599,7 +598,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			break;
 
 		spin_unlock_bh(lock);
-		tbl = rcu_dereference(tbl->future_tbl);
+		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 	}
 
 	data = rhashtable_lookup_one(ht, tbl, hash, key, obj);


