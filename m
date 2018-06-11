Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bVkxFCSCHltsBAAAmS7hNA
	; Mon, 11 Jun 2018 14:08:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 567A7607E4; Mon, 11 Jun 2018 14:08:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NVzQ8Jfb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 05B16608CE;
	Mon, 11 Jun 2018 14:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05B16608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933706AbeFKOHY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:07:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933619AbeFKOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v9f28GFQA2H3oC5e4oSJdUQ6ulwZ8LP6rBgFxUSnZbQ=; b=NVzQ8JfboRksaatDhR28UyFzc
        srz+6VG06sLl8lXo52AjSVvyVjf3Krhrw5S5I22lVVv3BcQUWGWVG8d8qXwqCWJoOG/LbcJAKozXG
        mRKklXRrOp3wuV/V6LLLKJsMXubcj5XqlDffWb6LTYwdRF6UlXBv+IaCZJWZ6mNMe6pn5+5LqJn1v
        qhm4C663AbDtqbaw6TlaRxjkqxtCoKc5WiDoXSw3Xvvbhy8l01lcSXJzRfx3v1P5YB2mlGjTX6729
        O+5ggehLYXDd3tbCqvLxq9OciF0I3+8r6EG1jaRFfBA2MxiAQTB0I8eBGTCNX2jcg78fFNnMy+1xO
        Jn3yU3Ozw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTP-0004wo-6u; Mon, 11 Jun 2018 14:07:07 +0000
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
Subject: [PATCH v13 56/72] btrfs: Convert page cache to XArray
Date: Mon, 11 Jun 2018 07:06:23 -0700
Message-Id: <20180611140639.17215-57-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 4 +---
 fs/btrfs/extent_io.c   | 8 +++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8db29f791984..1d051d841cb7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -444,9 +444,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (pg_index > end_index)
 			break;
 
-		rcu_read_lock();
-		page = radix_tree_lookup(&mapping->i_pages, pg_index);
-		rcu_read_unlock();
+		page = xa_load(&mapping->i_pages, pg_index);
 		if (page && !xa_is_value(page)) {
 			misses++;
 			if (misses > 4)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 489fe673fbba..115ff9777364 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5286,11 +5286,9 @@ void clear_extent_buffer_dirty(struct extent_buffer *eb)
 
 		clear_page_dirty_for_io(page);
 		xa_lock_irq(&page->mapping->i_pages);
-		if (!PageDirty(page)) {
-			radix_tree_tag_clear(&page->mapping->i_pages,
-						page_index(page),
-						PAGECACHE_TAG_DIRTY);
-		}
+		if (!PageDirty(page))
+			__xa_clear_tag(&page->mapping->i_pages,
+					page_index(page), PAGECACHE_TAG_DIRTY);
 		xa_unlock_irq(&page->mapping->i_pages);
 		ClearPageError(page);
 		unlock_page(page);
-- 
2.17.1
