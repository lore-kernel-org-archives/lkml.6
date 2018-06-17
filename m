Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACEEC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0752086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F2UOjdbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0752086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934278AbeFQCO2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:14:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933731AbeFQCBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P3h7Y608mo+07Z2krzf3Bqsbr7SfCi8zVrrr+t6coas=; b=F2UOjdbTw2i9qdS3E2SubsrR+
        9uToOeetXYMEmnxqc4b4KJ0RAL1TCiC41Vn2NUOBd9QzJ2BUJr7yf47ygmymxZiSYVvaT9bABK8Lv
        6Y8HJZ21X/C92Rx1GLRcHZooTDeL+7udSzJ/71ZEVvE1YN3JBUMRMQcWWSLbI9ueV380+AmnSVZgD
        SbbKSGhlLJaezilKE/IYUgFNrCSCN0PDzSiiHT70k+DSNPajCEJXlObSkPdrp7l8QtVSuI36nMiIO
        l6VZ+pJJ/ctSdzITsetLrR2RyWYotD/BhteaFYJ4GWFC+l6pWEAQzE0iiA4Wg7T5y4K/gPRqCYXX/
        2E7TME9kQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUMzw-0001GJ-Bn; Sun, 17 Jun 2018 02:00:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 12/74] xarray: Add XArray conditional store operations
Date:   Sat, 16 Jun 2018 18:59:50 -0700
Message-Id: <20180617020052.4759-13-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like cmpxchg(), xa_cmpxchg will only store to the index if the current
entry matches the old entry.  It returns the current entry, which is
usually more useful than the errno returned by radix_tree_insert().
For the users who really only want the errno, the xa_insert() wrapper
provides a more convenient calling convention.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/xarray.h | 60 +++++++++++++++++++++++++++++++++++
 lib/test_xarray.c      | 20 ++++++++++++
 lib/xarray.c           | 71 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 13e5c4084dcd..94b7f454a6a0 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -218,6 +218,8 @@ struct xarray {
 void xa_init_flags(struct xarray *, gfp_t flags);
 void *xa_load(struct xarray *, unsigned long index);
 void *xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
+void *xa_cmpxchg(struct xarray *, unsigned long index,
+			void *old, void *entry, gfp_t);
 bool xa_get_tag(struct xarray *, unsigned long index, xa_tag_t);
 void xa_set_tag(struct xarray *, unsigned long index, xa_tag_t);
 void xa_clear_tag(struct xarray *, unsigned long index, xa_tag_t);
@@ -277,6 +279,34 @@ static inline void *xa_erase(struct xarray *xa, unsigned long index)
 	return xa_store(xa, index, NULL, 0);
 }
 
+/**
+ * xa_insert() - Store this entry in the XArray unless another entry is
+ *			already present.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * If you would rather see the existing entry in the array, use xa_cmpxchg().
+ * This function is for users who don't care what the entry is, only that
+ * one is present.
+ *
+ * Context: Process context.  Takes and releases the xa_lock.
+ *	    May sleep if the @gfp flags permit.
+ * Return: 0 if the store succeeded.  -EEXIST if another entry was present.
+ * 	   -ENOMEM if memory could not be allocated.
+ */
+static inline int xa_insert(struct xarray *xa, unsigned long index,
+		void *entry, gfp_t gfp)
+{
+	void *curr = xa_cmpxchg(xa, index, NULL, entry, gfp);
+	if (!curr)
+		return 0;
+	if (xa_is_err(curr))
+		return xa_err(curr);
+	return -EEXIST;
+}
+
 #define xa_trylock(xa)		spin_trylock(&(xa)->xa_lock)
 #define xa_lock(xa)		spin_lock(&(xa)->xa_lock)
 #define xa_unlock(xa)		spin_unlock(&(xa)->xa_lock)
@@ -296,9 +326,39 @@ static inline void *xa_erase(struct xarray *xa, unsigned long index)
  */
 void *__xa_erase(struct xarray *, unsigned long index);
 void *__xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
+void *__xa_cmpxchg(struct xarray *, unsigned long index, void *old,
+		void *entry, gfp_t);
 void __xa_set_tag(struct xarray *, unsigned long index, xa_tag_t);
 void __xa_clear_tag(struct xarray *, unsigned long index, xa_tag_t);
 
+/**
+ * __xa_insert() - Store this entry in the XArray unless another entry is
+ *			already present.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * If you would rather see the existing entry in the array, use __xa_cmpxchg().
+ * This function is for users who don't care what the entry is, only that
+ * one is present.
+ *
+ * Context: Any context.  Expects xa_lock to be held on entry.  May
+ *	    release and reacquire xa_lock if the @gfp flags permit.
+ * Return: 0 if the store succeeded.  -EEXIST if another entry was present.
+ *	   -ENOMEM if memory could not be allocated.
+ */
+static inline int __xa_insert(struct xarray *xa, unsigned long index,
+		void *entry, gfp_t gfp)
+{
+	void *curr = __xa_cmpxchg(xa, index, NULL, entry, gfp);
+	if (!curr)
+		return 0;
+	if (xa_is_err(curr))
+		return xa_err(curr);
+	return -EEXIST;
+}
+
 /* Everything below here is the Advanced API.  Proceed with caution. */
 
 /*
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index cb6e9910e369..35fca5e23cbc 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -181,6 +181,25 @@ static void check_xa_shrink(struct xarray *xa)
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
+static void check_cmpxchg(struct xarray *xa)
+{
+	void *FIVE = xa_mk_value(5);
+	void *SIX = xa_mk_value(6);
+	void *LOTS = xa_mk_value(12345678);
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(xa, xa_store_value(xa, 12345678, GFP_KERNEL) != NULL);
+	XA_BUG_ON(xa, xa_insert(xa, 12345678, xa, GFP_KERNEL) != -EEXIST);
+	XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, SIX, FIVE, GFP_KERNEL) != LOTS);
+	XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, LOTS, FIVE, GFP_KERNEL) != LOTS);
+	XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, FIVE, LOTS, GFP_KERNEL) != FIVE);
+	XA_BUG_ON(xa, xa_cmpxchg(xa, 5, FIVE, NULL, GFP_KERNEL) != NULL);
+	XA_BUG_ON(xa, xa_cmpxchg(xa, 5, NULL, FIVE, GFP_KERNEL) != NULL);
+	xa_erase_value(xa, 12345678);
+	xa_erase_value(xa, 5);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
 static void check_multi_store(struct xarray *xa)
 {
 	unsigned long i, j, k;
@@ -248,6 +267,7 @@ static int xarray_checks(void)
 	check_xa_load(&array);
 	check_xa_tag(&array);
 	check_xa_shrink(&array);
+	check_cmpxchg(&array);
 	check_multi_store(&array);
 
 	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
diff --git a/lib/xarray.c b/lib/xarray.c
index 18043aee8a91..1a3a256cbb37 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -962,6 +962,77 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 }
 EXPORT_SYMBOL(__xa_store);
 
+/**
+ * xa_cmpxchg() - Conditionally replace an entry in the XArray.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @old: Old value to test against.
+ * @entry: New value to place in array.
+ * @gfp: Memory allocation flags.
+ *
+ * If the entry at @index is the same as @old, replace it with @entry.
+ * If the return value is equal to @old, then the exchange was successful.
+ *
+ * Context: Process context.  Takes and releases the xa_lock.  May sleep
+ * if the @gfp flags permit.
+ * Return: The old value at this index or xa_err() if an error happened.
+ */
+void *xa_cmpxchg(struct xarray *xa, unsigned long index,
+			void *old, void *entry, gfp_t gfp)
+{
+	XA_STATE(xas, xa, index);
+	void *curr;
+
+	if (WARN_ON_ONCE(xa_is_internal(entry)))
+		return XA_ERROR(-EINVAL);
+
+	do {
+		xas_lock(&xas);
+		curr = xas_load(&xas);
+		if (curr == old)
+			xas_store(&xas, entry);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	return xas_result(&xas, curr);
+}
+EXPORT_SYMBOL(xa_cmpxchg);
+
+/**
+ * __xa_cmpxchg() - Store this entry in the XArray.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @old: Old value to test against.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * You must already be holding the xa_lock when calling this function.
+ * It will drop the lock if needed to allocate memory, and then reacquire
+ * it afterwards.
+ *
+ * Context: Any context.  Expects xa_lock to be held on entry.  May
+ * release and reacquire xa_lock if @gfp flags permit.
+ * Return: The old entry at this index or xa_err() if an error happened.
+ */
+void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
+			void *old, void *entry, gfp_t gfp)
+{
+	XA_STATE(xas, xa, index);
+	void *curr;
+
+	if (WARN_ON_ONCE(xa_is_internal(entry)))
+		return XA_ERROR(-EINVAL);
+
+	do {
+		curr = xas_load(&xas);
+		if (curr == old)
+			xas_store(&xas, entry);
+	} while (__xas_nomem(&xas, gfp));
+
+	return xas_result(&xas, curr);
+}
+EXPORT_SYMBOL(__xa_cmpxchg);
+
 /**
  * __xa_set_tag() - Set this tag on this entry while locked.
  * @xa: XArray.
-- 
2.17.1

