Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C6C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771AB20874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hsny3N4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771AB20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933830AbeFQCBD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:01:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933326AbeFQCA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=czrxuIIJmcJc5dHPTHEXxpepAs+QdQPljzwWCR9U87A=; b=Hsny3N4kY5Ch5Pu3+ULFuFKbd
        vCHGbdRxXLIGL/YjZIjqu4A7YoLS0skexHwJSphnEv2fQ6IoWpIm8atcuo/fPYqWzQ/ttB4uRpB3L
        3hzsVYtux/ObykIqaGXzUXzpfufZWfFYZZYbpPmzsWNI8C+Exa1I93D4JNzfQlVzKiz8Os1kYcsN6
        P4GJC559codJhX/9GnghOk10DhfLw22SkSKfUmpaxrBDJTc8+XmPRDXtgwvmMZE4E592nqCl0fmLC
        15LfjptxlVi+eRYP3sPGZbTClvL66C2sy/lPMgS/j5CIBgMuC7ieUODYOxt9m34TbrG64rWtkEwYq
        bTKc8fwOA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUMzx-0001Ga-0r; Sun, 17 Jun 2018 02:00:57 +0000
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
Subject: [PATCH v14 16/74] xarray: Step through an XArray
Date:   Sat, 16 Jun 2018 18:59:54 -0700
Message-Id: <20180617020052.4759-17-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xas_next and xas_prev functions move the xas index by one position,
and adjust the rest of the iterator state to match it.  This is more
efficient than calling xas_set() as it keeps the iterator at the leaves
of the tree instead of walking the iterator from the root each time.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/xarray.h |  67 +++++++++++++++++++++++++
 lib/test_xarray.c      | 109 +++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           |  74 ++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index fa36a0670988..921d41034d7d 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -719,6 +719,12 @@ static inline bool xas_not_node(struct xa_node *node)
 	return ((unsigned long)node & 3) || !node;
 }
 
+/* True if the node represents RESTART or an error */
+static inline bool xas_frozen(struct xa_node *node)
+{
+	return (unsigned long)node & 2;
+}
+
 /* True if the node represents head-of-tree, RESTART or BOUNDS */
 static inline bool xas_top(struct xa_node *node)
 {
@@ -977,6 +983,67 @@ enum {
 	for (entry = xas_find_tagged(xas, max, tag); entry; \
 	     entry = xas_next_tagged(xas, max, tag))
 
+void *__xas_next(struct xa_state *);
+void *__xas_prev(struct xa_state *);
+
+/**
+ * xas_prev() - Move iterator to previous index.
+ * @xas: XArray operation state.
+ *
+ * If the @xas was in an error state, it will remain in an error state
+ * and this function will return %NULL.  If the @xas has never been walked,
+ * it will have the effect of calling xas_load().  Otherwise one will be
+ * subtracted from the index and the state will be walked to the correct
+ * location in the array for the next operation.
+ *
+ * If the iterator was referencing index 0, this function wraps
+ * around to %ULONG_MAX.
+ *
+ * Return: The entry at the new index.  This may be %NULL or an internal
+ * entry.
+ */
+static inline void *xas_prev(struct xa_state *xas)
+{
+	struct xa_node *node = xas->xa_node;
+
+	if (unlikely(xas_not_node(node) || node->shift ||
+				xas->xa_offset == 0))
+		return __xas_prev(xas);
+
+	xas->xa_index--;
+	xas->xa_offset--;
+	return xa_entry(xas->xa, node, xas->xa_offset);
+}
+
+/**
+ * xas_next() - Move state to next index.
+ * @xas: XArray operation state.
+ *
+ * If the @xas was in an error state, it will remain in an error state
+ * and this function will return %NULL.  If the @xas has never been walked,
+ * it will have the effect of calling xas_load().  Otherwise one will be
+ * added to the index and the state will be walked to the correct
+ * location in the array for the next operation.
+ *
+ * If the iterator was referencing index %ULONG_MAX, this function wraps
+ * around to 0.
+ *
+ * Return: The entry at the new index.  This may be %NULL or an internal
+ * entry.
+ */
+static inline void *xas_next(struct xa_state *xas)
+{
+	struct xa_node *node = xas->xa_node;
+
+	if (unlikely(xas_not_node(node) || node->shift ||
+				xas->xa_offset == XA_CHUNK_MASK))
+		return __xas_next(xas);
+
+	xas->xa_index++;
+	xas->xa_offset++;
+	return xa_entry(xas->xa, node, xas->xa_offset);
+}
+
 /* Internal functions, mostly shared between radix-tree.c, xarray.c and idr.c */
 void xas_destroy(struct xa_state *);
 
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index a6a3705165ca..e74ade12c663 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -384,6 +384,114 @@ static void check_find(struct xarray *xa)
 	check_multi_find(xa);
 }
 
+static void check_move_small(struct xarray *xa, unsigned long idx)
+{
+	XA_STATE(xas, xa, 0);
+	unsigned long i;
+
+	xa_store_value(xa, 0, GFP_KERNEL);
+	xa_store_value(xa, idx, GFP_KERNEL);
+
+	for (i = 0; i < idx * 4; i++) {
+		void *entry = xas_next(&xas);
+		if (i <= idx)
+			XA_BUG_ON(xa, xas.xa_node == XAS_RESTART);
+		XA_BUG_ON(xa, xas.xa_index != i);
+		if (i == 0 || i == idx)
+			XA_BUG_ON(xa, entry != xa_mk_value(i));
+		else
+			XA_BUG_ON(xa, entry != NULL);
+	}
+	xas_next(&xas);
+	XA_BUG_ON(xa, xas.xa_index != i);
+
+	do {
+		void *entry = xas_prev(&xas);
+		i--;
+		if (i <= idx)
+			XA_BUG_ON(xa, xas.xa_node == XAS_RESTART);
+		XA_BUG_ON(xa, xas.xa_index != i);
+		if (i == 0 || i == idx)
+			XA_BUG_ON(xa, entry != xa_mk_value(i));
+		else
+			XA_BUG_ON(xa, entry != NULL);
+	} while (i > 0);
+
+	xas_set(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, xas_next(&xas) != NULL);
+	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
+	XA_BUG_ON(xa, xas_next(&xas) != xa_mk_value(0));
+	XA_BUG_ON(xa, xas.xa_index != 0);
+	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
+	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
+
+	xa_erase_value(xa, 0);
+	xa_erase_value(xa, idx);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
+static void check_move(struct xarray *xa)
+{
+	XA_STATE(xas, xa, (1 << 16) - 1);
+	unsigned long i;
+
+	for (i = 0; i < (1 << 16); i++)
+		XA_BUG_ON(xa, xa_store_value(xa, i, GFP_KERNEL) != NULL);
+
+	do {
+		void *entry = xas_prev(&xas);
+		i--;
+		XA_BUG_ON(xa, entry != xa_mk_value(i));
+		XA_BUG_ON(xa, i != xas.xa_index);
+	} while (i != 0);
+
+	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
+	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
+
+	do {
+		void *entry = xas_next(&xas);
+		XA_BUG_ON(xa, entry != xa_mk_value(i));
+		XA_BUG_ON(xa, i != xas.xa_index);
+		i++;
+	} while (i < (1 << 16));
+
+	for (i = (1 << 8); i < (1 << 15); i++)
+		xa_erase_value(xa, i);
+
+	i = xas.xa_index;
+
+	do {
+		void *entry = xas_prev(&xas);
+		i--;
+		if ((i < (1 << 8)) || (i >= (1 << 15)))
+			XA_BUG_ON(xa, entry != xa_mk_value(i));
+		else
+			XA_BUG_ON(xa, entry != NULL);
+		XA_BUG_ON(xa, i != xas.xa_index);
+	} while (i != 0);
+
+	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
+	XA_BUG_ON(xa, xas.xa_index != ULONG_MAX);
+
+	do {
+		void *entry = xas_next(&xas);
+		if ((i < (1 << 8)) || (i >= (1 << 15)))
+			XA_BUG_ON(xa, entry != xa_mk_value(i));
+		else
+			XA_BUG_ON(xa, entry != NULL);
+		XA_BUG_ON(xa, i != xas.xa_index);
+		i++;
+	} while (i < (1 << 16));
+
+	xa_destroy(xa);
+
+	for (i = 0; i < 16; i++)
+		check_move_small(xa, 1UL << i);
+
+	for (i = 2; i < 16; i++)
+		check_move_small(xa, (1UL << i) - 1);
+}
+
 static int xarray_checks(void)
 {
 	DEFINE_XARRAY(array);
@@ -397,6 +505,7 @@ static int xarray_checks(void)
 	check_cmpxchg(&array);
 	check_multi_store(&array);
 	check_find(&array);
+	check_move(&array);
 
 	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/lib/xarray.c b/lib/xarray.c
index e90ba76404ae..ab1b6786711e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -863,6 +863,80 @@ void xas_pause(struct xa_state *xas)
 }
 EXPORT_SYMBOL_GPL(xas_pause);
 
+/*
+ * __xas_prev() - Find the previous entry in the XArray.
+ * @xas: XArray operation state.
+ *
+ * Helper function for xas_prev() which handles all the complex cases
+ * out of line.
+ */
+void *__xas_prev(struct xa_state *xas)
+{
+	void *entry;
+
+	if (!xas_frozen(xas->xa_node))
+		xas->xa_index--;
+	if (xas_not_node(xas->xa_node))
+		return xas_load(xas);
+
+	if (xas->xa_offset != get_offset(xas->xa_index, xas->xa_node))
+		xas->xa_offset--;
+
+	while (xas->xa_offset == 255) {
+		xas->xa_offset = xas->xa_node->offset - 1;
+		xas->xa_node = xa_parent(xas->xa, xas->xa_node);
+		if (!xas->xa_node)
+			return set_bounds(xas);
+	}
+
+	for (;;) {
+		entry = xa_entry(xas->xa, xas->xa_node, xas->xa_offset);
+		if (!xa_is_node(entry))
+			return entry;
+
+		xas->xa_node = xa_to_node(entry);
+		xas_set_offset(xas);
+	}
+}
+EXPORT_SYMBOL_GPL(__xas_prev);
+
+/*
+ * __xas_next() - Find the next entry in the XArray.
+ * @xas: XArray operation state.
+ *
+ * Helper function for xas_next() which handles all the complex cases
+ * out of line.
+ */
+void *__xas_next(struct xa_state *xas)
+{
+	void *entry;
+
+	if (!xas_frozen(xas->xa_node))
+		xas->xa_index++;
+	if (xas_not_node(xas->xa_node))
+		return xas_load(xas);
+
+	if (xas->xa_offset != get_offset(xas->xa_index, xas->xa_node))
+		xas->xa_offset++;
+
+	while (xas->xa_offset == XA_CHUNK_SIZE) {
+		xas->xa_offset = xas->xa_node->offset + 1;
+		xas->xa_node = xa_parent(xas->xa, xas->xa_node);
+		if (!xas->xa_node)
+			return set_bounds(xas);
+	}
+
+	for (;;) {
+		entry = xa_entry(xas->xa, xas->xa_node, xas->xa_offset);
+		if (!xa_is_node(entry))
+			return entry;
+
+		xas->xa_node = xa_to_node(entry);
+		xas_set_offset(xas);
+	}
+}
+EXPORT_SYMBOL_GPL(__xas_next);
+
 /**
  * xas_find() - Find the next present entry in the XArray.
  * @xas: XArray operation state.
-- 
2.17.1

