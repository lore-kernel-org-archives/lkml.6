Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7008A219EB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7008A219EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeGFHNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:13:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753604AbeGFHNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:13:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3E8BAD80;
        Fri,  6 Jul 2018 07:13:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Date:   Fri, 06 Jul 2018 17:11:32 +1000
Subject: [PATCH 2/3] rhashtable: add rhashtable_walk_last_seen()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086109260.2825.1459722786871837620.stgit@noble>
In-Reply-To: <153086101070.2825.6850140624411927465.stgit@noble>
References: <153086101070.2825.6850140624411927465.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_walk_last_seen() returns the object returned by
the previous rhashtable_walk_next(), providing it is still in the
table (or was during this grace period).
This works even if rhashtable_walk_stop() and rhashtable_talk_start()
have been called since the last rhashtable_walk_next().

If there have been no calls to rhashtable_walk_next(), or if the
object is gone from the table, then NULL is returned.

This can usefully be used in a seq_file ->start() function.
If the pos is the same as was returned by the last ->next() call,
then rhashtable_walk_last_seen() can be used to re-establish the
current location in the table.  If it returns NULL, then
rhashtable_walk_next() should be used.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    1 +
 lib/rhashtable.c           |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 657e37ae314c..d63b472e9d50 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -248,6 +248,7 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
 void *rhashtable_walk_peek(struct rhashtable_iter *iter);
+void *rhashtable_walk_last_seen(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
 
 void rhashtable_free_and_destroy(struct rhashtable *ht,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 36f97d0c69ce..2d0227822262 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -947,6 +947,36 @@ void *rhashtable_walk_peek(struct rhashtable_iter *iter)
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_peek);
 
+/**
+ * rhashtable_walk_last_seen - Return the previously returned object, if available
+ * @iter:	Hash table iterator
+ *
+ * If rhashtable_walk_next() has previously been called and the object
+ * it returned is still in the hash table, that object is returned again,
+ * otherwise %NULL is returned.
+ *
+ * If the recent rhashtable_walk_next() call was since the most recent
+ * rhashtable_walk_start() call then the returned object may not, strictly
+ * speaking, still be in the table.  It will be safe to dereference.
+ *
+ * Note that the iterator is not changed.
+ */
+void *rhashtable_walk_last_seen(struct rhashtable_iter *iter)
+{
+	struct rhashtable *ht = iter->ht;
+	struct rhash_head *p = iter->p;
+
+	if (!p)
+		return NULL;
+	if (!iter->p_is_unsafe || ht->rhlist)
+		return p;
+	rht_for_each_rcu(p, iter->walker.tbl, iter->slot)
+		if (p == iter->p)
+			return p;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(rhashtable_walk_last_seen);
+
 /**
  * rhashtable_walk_stop - Finish a hash table walk
  * @iter:	Hash table iterator


