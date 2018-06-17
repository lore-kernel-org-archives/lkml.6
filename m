Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B99F2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZoCgZtfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B99F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934741AbeFQCQI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:16:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933344AbeFQCBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gPrs5Xvr6/lmTcgM+ymDV8Z0qRreZjww6huepXU7wTQ=; b=ZoCgZtfYJajiqM+kKHesM7z45
        Kj7i2SLRh2j9cfQ+xHX6Ov4+o0h6xySn5M3hMiY3OFZssH3JLMMmVXzZYrJ9l12qVsVnFG5c5r0yp
        YkG4A4q+2nI3fnc7/lvV0q54/DukRlSK4QvjpW128Wm2Qg1n+f8roLCBpm92Vs7GM2DV/P9tazMFT
        5qyhtHeKxeWOdhYmB0d4vb9h5yN2kU5Jj0F9ZoLBB1AF494gRvZoP2kZugFjj/v7o708MlWrUyaeo
        gYFcm8UBt8Hh2V58PWC6kEgr+gDzo3PxADzfXH7FOB6zh2cn/Q8n5NwZSH0yDhbwZ+Y3ls0p38hqn
        FNMp5d/pQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUMzx-0001Ge-7E; Sun, 17 Jun 2018 02:00:57 +0000
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
Subject: [PATCH v14 17/74] xarray: Add xas_for_each_conflict
Date:   Sat, 16 Jun 2018 18:59:55 -0700
Message-Id: <20180617020052.4759-18-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This iterator iterates over each entry that is stored in the index or
indices specified by the xa_state.  This is intended for use for a
conditional store of a multiindex entry, or to allow entries which are
about to be removed from the xarray to be disposed of properly.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/xarray.h | 17 ++++++++++++
 lib/test_xarray.c      | 63 ++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           | 61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 921d41034d7d..0a9f66266c9a 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -769,6 +769,7 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 void *xas_load(struct xa_state *);
 void *xas_store(struct xa_state *, void *entry);
 void *xas_find(struct xa_state *, unsigned long max);
+void *xas_next_conflict(struct xa_state *);
 
 bool xas_get_tag(const struct xa_state *, xa_tag_t);
 void xas_set_tag(const struct xa_state *, xa_tag_t);
@@ -983,6 +984,22 @@ enum {
 	for (entry = xas_find_tagged(xas, max, tag); entry; \
 	     entry = xas_next_tagged(xas, max, tag))
 
+/**
+ * xas_for_each_conflict() - Iterate over a range of an XArray.
+ * @xas: XArray operation state.
+ * @entry: Entry retrieved from the array.
+ *
+ * The loop body will be executed for each entry in the XArray that lies
+ * within the range specified by @xas.  If the loop completes successfully,
+ * any entries that lie in this range will be replaced by @entry.  The caller
+ * may break out of the loop; if they do so, the contents of the XArray will
+ * be unchanged.  The operation may fail due to an out of memory condition.
+ * The caller may also call xa_set_err() to exit the loop while setting an
+ * error to record the reason.
+ */
+#define xas_for_each_conflict(xas, entry) \
+	while ((entry = xas_next_conflict(xas)))
+
 void *__xas_next(struct xa_state *);
 void *__xas_prev(struct xa_state *);
 
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e74ade12c663..818cfd8746ba 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -315,6 +315,68 @@ static void check_multi_store(struct xarray *xa)
 	}
 }
 
+static void __check_store_iter(struct xarray *xa, unsigned long start,
+			unsigned int order, unsigned int present)
+{
+	XA_STATE_ORDER(xas, xa, start, order);
+	void *entry;
+	unsigned int count = 0;
+
+retry:
+	xas_for_each_conflict(&xas, entry) {
+		XA_BUG_ON(xa, !xa_is_value(entry));
+		XA_BUG_ON(xa, entry < xa_mk_value(start));
+		XA_BUG_ON(xa, entry > xa_mk_value(start + (1UL << order) - 1));
+		count++;
+	}
+	xas_store(&xas, xa_mk_value(start));
+	if (xas_nomem(&xas, GFP_KERNEL)) {
+		count = 0;
+		goto retry;
+	}
+	XA_BUG_ON(xa, xas_error(&xas));
+	XA_BUG_ON(xa, count != present);
+	XA_BUG_ON(xa, xa_load(xa, start) != xa_mk_value(start));
+	XA_BUG_ON(xa, xa_load(xa, start + (1UL << order) - 1) !=
+			xa_mk_value(start));
+	xa_erase_value(xa, start);
+}
+
+static void check_store_iter(struct xarray *xa)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < 20; i++) {
+		unsigned int min = 1 << i;
+		unsigned int max = (2 << i) - 1;
+		__check_store_iter(xa, 0, i, 0);
+		XA_BUG_ON(xa, !xa_empty(xa));
+		__check_store_iter(xa, min, i, 0);
+		XA_BUG_ON(xa, !xa_empty(xa));
+
+		xa_store_value(xa, min, GFP_KERNEL);
+		__check_store_iter(xa, min, i, 1);
+		XA_BUG_ON(xa, !xa_empty(xa));
+		xa_store_value(xa, max, GFP_KERNEL);
+		__check_store_iter(xa, min, i, 1);
+		XA_BUG_ON(xa, !xa_empty(xa));
+
+		for (j = 0; j < min; j++)
+			xa_store_value(xa, j, GFP_KERNEL);
+		__check_store_iter(xa, 0, i, min);
+		XA_BUG_ON(xa, !xa_empty(xa));
+		for (j = 0; j < min; j++)
+			xa_store_value(xa, min + j, GFP_KERNEL);
+		__check_store_iter(xa, min, i, min);
+		XA_BUG_ON(xa, !xa_empty(xa));
+	}
+	xa_store_value(xa, 63, GFP_KERNEL);
+	xa_store_value(xa, 65, GFP_KERNEL);
+	__check_store_iter(xa, 64, 2, 1);
+	xa_erase_value(xa, 63);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
 static void check_multi_find(struct xarray *xa)
 {
 	unsigned long index;
@@ -506,6 +568,7 @@ static int xarray_checks(void)
 	check_multi_store(&array);
 	check_find(&array);
 	check_move(&array);
+	check_store_iter(&array);
 
 	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/lib/xarray.c b/lib/xarray.c
index ab1b6786711e..31c5332c8146 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1086,6 +1086,67 @@ void *xas_find_tagged(struct xa_state *xas, unsigned long max, xa_tag_t tag)
 }
 EXPORT_SYMBOL_GPL(xas_find_tagged);
 
+/**
+ * xas_next_conflict() - Step for xas_for_each_conflict().
+ * @xas: XArray operation state.
+ *
+ * This function does the work for xas_for_each_conflict().
+ *
+ * Context: Any context.  Expects xa_lock to be held.
+ * Return: The next entry in the range covered by @xas or %NULL.
+ */
+void *xas_next_conflict(struct xa_state *xas)
+{
+	void *curr;
+
+	if (xas_error(xas))
+		return NULL;
+
+	if (!xas->xa_node)
+		return NULL;
+
+	if (xas_top(xas->xa_node)) {
+		curr = xas_start(xas);
+		if (!curr)
+			return NULL;
+		while (xa_is_node(curr)) {
+			struct xa_node *node = xa_to_node(curr);
+			curr = xas_descend(xas, node);
+		}
+		if (curr)
+			return curr;
+	}
+
+	if (xas->xa_node->shift > xas->xa_shift)
+		return NULL;
+
+	for (;;) {
+		if (xas->xa_node->shift == xas->xa_shift) {
+			if ((xas->xa_offset & xas->xa_sibs) == xas->xa_sibs)
+				break;
+		} else if (xas->xa_offset == XA_CHUNK_MASK) {
+			xas->xa_offset = xas->xa_node->offset;
+			xas->xa_node = xas->xa_node->parent;
+			if (!xas->xa_node)
+				break;
+			continue;
+		}
+		curr = xa_entry_locked(xas->xa, xas->xa_node, ++xas->xa_offset);
+		if (xa_is_sibling(curr))
+			continue;
+		while (xa_is_node(curr)) {
+			xas->xa_node = xa_to_node(curr);
+			xas->xa_offset = 0;
+			curr = xa_entry_locked(xas->xa, xas->xa_node, 0);
+		}
+		if (curr)
+			return curr;
+	}
+	xas->xa_offset -= xas->xa_sibs;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(xas_next_conflict);
+
 /**
  * xa_init_flags() - Initialise an empty XArray with flags.
  * @xa: XArray.
-- 
2.17.1

