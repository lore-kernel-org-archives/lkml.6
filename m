Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KQDAHsqDHlt4FwAAmS7hNA
	; Mon, 11 Jun 2018 14:14:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E11D607E7; Mon, 11 Jun 2018 14:14:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aDVM7nnD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 754686074D;
	Mon, 11 Jun 2018 14:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 754686074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934036AbeFKOO4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:14:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933578AbeFKOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qEWuPFtwu1wKHPY5+RYCC+du5tnmgVj7Blxh6g8XNsw=; b=aDVM7nnDLIKJT3boYA9cuYrjl
        LdJrs80uJk6xn4yWHOCHfmPszqTRe2T5ek74FRMe09UqlF36WwIEv4Zj51BJQJj2HXU3L7yW+7R0A
        DkhBAKUdV2jNApXMYNAKb7SxrFAHAo2BB5mx2qBWCqxasE8lt9dZa8dnLuNo/p8vdfJa1OGjV6zjn
        XJ2AU49DD6Z8Ka1jkhTdm1iQRr20nWOpUJSakotFnVPqq6hauSpL08p7kARvVvJscqEW2gKRnYmYP
        M0d1ESFe2Q/T55mBXgkf6Q3tutW6EYl6/kwO4pGJGUNM0zZe4RgJ7/u2Opw58Cel5pd5f89J9KO2A
        GE+kD+i0w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTJ-0004pq-2E; Mon, 11 Jun 2018 14:07:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
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
Subject: [PATCH v13 45/72] pagevec: Use xa_tag_t
Date: Mon, 11 Jun 2018 07:06:12 -0700
Message-Id: <20180611140639.17215-46-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Removes sparse warnings.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/btrfs/extent_io.c    | 4 ++--
 fs/ext4/inode.c         | 2 +-
 fs/f2fs/data.c          | 2 +-
 fs/gfs2/aops.c          | 2 +-
 include/linux/pagevec.h | 8 +++++---
 mm/swap.c               | 4 ++--
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 53829afc2a6e..489fe673fbba 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3792,7 +3792,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	int scanned = 0;
-	int tag;
+	xa_tag_t tag;
 
 	pagevec_init(&pvec);
 	if (wbc->range_cyclic) {
@@ -3917,7 +3917,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	pgoff_t done_index;
 	int range_whole = 0;
 	int scanned = 0;
-	int tag;
+	xa_tag_t tag;
 
 	/*
 	 * We have to hold onto the inode so that ordered extents can do their
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 38214c05f204..e6c433527dce 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2615,7 +2615,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	long left = mpd->wbc->nr_to_write;
 	pgoff_t index = mpd->first_page;
 	pgoff_t end = mpd->last_page;
-	int tag;
+	xa_tag_t tag;
 	int i, err = 0;
 	int blkbits = mpd->inode->i_blkbits;
 	ext4_lblk_t lblk;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f931d699287..e5c0b1e74ce6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1942,7 +1942,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	pgoff_t last_idx = ULONG_MAX;
 	int cycled;
 	int range_whole = 0;
-	int tag;
+	xa_tag_t tag;
 
 	pagevec_init(&pvec);
 
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 35f5ee23566d..b8609bb1e2e0 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -370,7 +370,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 	pgoff_t done_index;
 	int cycled;
 	int range_whole = 0;
-	int tag;
+	xa_tag_t tag;
 
 	pagevec_init(&pvec);
 	if (wbc->range_cyclic) {
diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 6dc456ac6136..955bd6425903 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -9,6 +9,8 @@
 #ifndef _LINUX_PAGEVEC_H
 #define _LINUX_PAGEVEC_H
 
+#include <linux/xarray.h>
+
 /* 15 pointers + header align the pagevec structure to a power of two */
 #define PAGEVEC_SIZE	15
 
@@ -40,12 +42,12 @@ static inline unsigned pagevec_lookup(struct pagevec *pvec,
 
 unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		int tag);
+		xa_tag_t tag);
 unsigned pagevec_lookup_range_nr_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		int tag, unsigned max_pages);
+		xa_tag_t tag, unsigned max_pages);
 static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, int tag)
+		struct address_space *mapping, pgoff_t *index, xa_tag_t tag)
 {
 	return pagevec_lookup_range_tag(pvec, mapping, index, (pgoff_t)-1, tag);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 4c5c7fcc6e46..a7ff602213a9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1002,7 +1002,7 @@ EXPORT_SYMBOL(pagevec_lookup_range);
 
 unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		int tag)
+		xa_tag_t tag)
 {
 	pvec->nr = find_get_pages_range_tag(mapping, index, end, tag,
 					PAGEVEC_SIZE, pvec->pages);
@@ -1012,7 +1012,7 @@ EXPORT_SYMBOL(pagevec_lookup_range_tag);
 
 unsigned pagevec_lookup_range_nr_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		int tag, unsigned max_pages)
+		xa_tag_t tag, unsigned max_pages)
 {
 	pvec->nr = find_get_pages_range_tag(mapping, index, end, tag,
 		min_t(unsigned int, max_pages, PAGEVEC_SIZE), pvec->pages);
-- 
2.17.1
