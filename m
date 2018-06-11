Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kM8CNWuEHlsUGwAAmS7hNA
	; Mon, 11 Jun 2018 14:19:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 27BFB607E7; Mon, 11 Jun 2018 14:19:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ti2BeWGG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A09D960791;
	Mon, 11 Jun 2018 14:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A09D960791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934188AbeFKOTy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:19:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933503AbeFKOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sqW1jfi9fXH0Wb9SlzcbfFhp+ufIQamOcMd7GrKgp30=; b=ti2BeWGG2O8VtFgPTXfuBL08A
        fYuk5wfFSIALiyRyiOVZYMYGq+cmtU7k/7WXmu/wpYRpkoqK/AbVGMoB/HOQ4tqx3PvwRRjOUurEe
        JI5AJhhxiDZt2xzHTex3R+REArl+nCwQmFWVa3J0S4I63THIuPrc8ogqn7p6LwNx6ZkxWgRHtq0ku
        5tNiZUKBM26rVuzmNRYclzQueBCbuMka4yXBMeKWR08d2DxcTmJ2hg21SWBs6jeNwjwR8uW9n1MmE
        ewJyWeyMdDWApJSBc9BXzQW3QdLeCg5G9kOiJFQf/I03iUZ6UEEZ9tymI2JW/Fh9/gA/dWQrrfvuh
        J8mFNoFmQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTC-0004jI-4s; Mon, 11 Jun 2018 14:06:54 +0000
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
Subject: [PATCH v13 33/72] page cache: Convert filemap_range_has_page to XArray
Date: Mon, 11 Jun 2018 07:06:00 -0700
Message-Id: <20180611140639.17215-34-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Instead of calling find_get_pages_range() and putting any reference,
use xas_find() to iterate over any entries in the range, skipping the
shadow/swap entries.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/filemap.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e447dd2d0f5c..68890327d1f2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -455,20 +455,30 @@ EXPORT_SYMBOL(filemap_flush);
 bool filemap_range_has_page(struct address_space *mapping,
 			   loff_t start_byte, loff_t end_byte)
 {
-	pgoff_t index = start_byte >> PAGE_SHIFT;
-	pgoff_t end = end_byte >> PAGE_SHIFT;
 	struct page *page;
+	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
+	pgoff_t max = end_byte >> PAGE_SHIFT;
 
 	if (end_byte < start_byte)
 		return false;
 
-	if (mapping->nrpages == 0)
-		return false;
+	rcu_read_lock();
+	do {
+		page = xas_find(&xas, max);
+		if (xas_retry(&xas, page))
+			continue;
+		/* Shadow entries don't count */
+		if (xa_is_value(page))
+			continue;
+		/*
+		 * We don't need to try to pin this page; we're about to
+		 * release the RCU lock anyway.  It is enough to know that
+		 * there was a page here recently.
+		 */
+	} while (0);
+	rcu_read_unlock();
 
-	if (!find_get_pages_range(mapping, &index, end, 1, &page))
-		return false;
-	put_page(page);
-	return true;
+	return page != NULL;
 }
 EXPORT_SYMBOL(filemap_range_has_page);
 
-- 
2.17.1
