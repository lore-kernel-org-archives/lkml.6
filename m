Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B893C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC69A208E2
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRmlSBK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC69A208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936553AbeFQCKD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:10:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933933AbeFQCBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=06qd/xlJg/OzH4I18kD3SK7TPii4ugk5m7Ua6YGXEhI=; b=ZRmlSBK92lq0ByjszBgzabJBy
        aN+v+EI3JNlMVXilNUWIQFVrfnJW3WWV80YUVEOmF/MeDPK2aYwOmxGlpmgR0+CBwALn0TRsOSQgh
        YTgKc7CZvvGIwIDDu0udK860oheV4TKYTQnDcoNf33oPV0YMk9UgyVZLb3jQXD+4IRRf1Xu4hFtOC
        jUpEWOWfOkpnmczEkeOjirw7TGBaQAJa2U9NEV3kVWdiCcpRUpS3cx9Q3PWtu8r52SmaRSrIaWacN
        sKTeeRUK12AvQWdFXuJmVfN5VfAzTrrswe1Y05hw6yfj6JRdP5z/I9RX0W2HCPN/YR9KKqsof817B
        mpdXxOE4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUMzw-0001GW-Qs; Sun, 17 Jun 2018 02:00:56 +0000
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
Subject: [PATCH v14 15/74] xarray: Destroy an XArray
Date:   Sat, 16 Jun 2018 18:59:53 -0700
Message-Id: <20180617020052.4759-16-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function frees all the internal memory allocated to the xarray
and reinitialises it to be empty.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/xarray.h |  1 +
 lib/xarray.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 6f398732b664..fa36a0670988 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -229,6 +229,7 @@ void *xa_find_after(struct xarray *xa, unsigned long *index,
 		unsigned long max, xa_tag_t) __attribute__((nonnull(2)));
 unsigned int xa_extract(struct xarray *, void **dst, unsigned long start,
 		unsigned long max, unsigned int n, xa_tag_t);
+void xa_destroy(struct xarray *);
 
 /**
  * xa_init() - Initialise an empty XArray.
diff --git a/lib/xarray.c b/lib/xarray.c
index 1e15ead40d78..e90ba76404ae 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1493,6 +1493,34 @@ unsigned int xa_extract(struct xarray *xa, void **dst, unsigned long start,
 }
 EXPORT_SYMBOL(xa_extract);
 
+/**
+ * xa_destroy() - Free all internal data structures.
+ * @xa: XArray.
+ *
+ * After calling this function, the XArray is empty and has freed all memory
+ * allocated for its internal data structures.  You are responsible for
+ * freeing the objects referenced by the XArray.
+ *
+ * Context: Any context.  Takes and releases the xa_lock, interrupt-safe.
+ */
+void xa_destroy(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+	unsigned long flags;
+	void *entry;
+
+	xas.xa_node = NULL;
+	xas_lock_irqsave(&xas, flags);
+	entry = xa_head_locked(xa);
+	RCU_INIT_POINTER(xa->xa_head, NULL);
+	xas_init_tags(&xas);
+	/* lockdep checks we're still holding the lock in xas_free_nodes() */
+	if (xa_is_node(entry))
+		xas_free_nodes(&xas, xa_to_node(entry));
+	xas_unlock_irqrestore(&xas, flags);
+}
+EXPORT_SYMBOL(xa_destroy);
+
 #ifdef XA_DEBUG
 void xa_dump_node(const struct xa_node *node)
 {
-- 
2.17.1

