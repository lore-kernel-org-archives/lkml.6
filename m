Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PP5/KqOAHlsncgAAmS7hNA
	; Mon, 11 Jun 2018 14:10:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 260B1607A4; Mon, 11 Jun 2018 14:10:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LozaAukS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AD78060351;
	Mon, 11 Jun 2018 14:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD78060351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933846AbeFKOJs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:09:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933636AbeFKOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rkKDu3vTH95GYyX6Q7oTKTgCqcU3ZiAjGwWtWlGisVY=; b=LozaAukSqaOLKf9BKzR5XnhLn
        TQ1Q/54HKr3xYSppi9uWakcDM6HeUF7aRKv251JJbg6AAROh9sFKY/HqovaOVtc5LKErsre/Sb3Ky
        ezTrA+BtIGgfQpWjagzIblxOVGen1Da25+KPCT8dFgZb2fVeucNxtmpeNRu7Wz//FZeG7Nq3T5VEV
        L6xsDUFYOTY4zFU+mYi+wYuYGMVjpcr8SEy+sB2ZEjrm7gSvDD/d9O7UoyABk8olkN5v6IPgJ95RF
        rkH3Fh1LBpkrde4lqkrNAzQMnaxswBp5z/2k6nugiVV+9D8IdJugN0Wq9f+RD8xN5Zx41XzCvI/4L
        QVZHXyBkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTW-000544-6F; Mon, 11 Jun 2018 14:07:14 +0000
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
Subject: [PATCH v13 68/72] page cache: Finish XArray conversion
Date: Mon, 11 Jun 2018 07:06:35 -0700
Message-Id: <20180611140639.17215-69-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

With no more radix tree API users left, we can drop the GFP flags
and use xa_init() instead of INIT_RADIX_TREE().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/inode.c      | 2 +-
 mm/swap_state.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bdc5e952ebbb..4ea629d7d32c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(inc_nlink);
 
 static void __address_space_init_once(struct address_space *mapping)
 {
-	INIT_RADIX_TREE(&mapping->i_pages, GFP_ATOMIC | __GFP_ACCOUNT);
+	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ);
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->private_list);
 	spin_lock_init(&mapping->private_lock);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 84595e1a4cd7..eee052936b66 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -596,7 +596,7 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		return -ENOMEM;
 	for (i = 0; i < nr; i++) {
 		space = spaces + i;
-		INIT_RADIX_TREE(&space->i_pages, GFP_ATOMIC|__GFP_NOWARN);
+		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
 		atomic_set(&space->i_mmap_writable, 0);
 		space->a_ops = &swap_aops;
 		/* swap cache doesn't use writeback related tags */
-- 
2.17.1
