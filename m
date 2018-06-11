Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iEh2JfCGHlsDOQAAmS7hNA
	; Mon, 11 Jun 2018 14:29:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4651B607A4; Mon, 11 Jun 2018 14:29:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o60f3YJP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C1F556074D;
	Mon, 11 Jun 2018 14:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1F556074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934564AbeFKOZk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:25:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933457AbeFKOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zowXtexFJYg/ibOfn7aWp3ZjHxVfIK1o3juT8iBdx8U=; b=o60f3YJPM3L7yOUO6/Ib1B3db
        iANa5JGRqWuecuZlBRToIJqZQsHf58sm7j4OurE8YChRJMFXP5yXaUNo4kFXYz0m3pFvbJ6fq6jKK
        A/Hooqdo2Xjm20b0rjp5xm8KMsgXNRMTTjaqAqBdL7+9DdSemyOPYu1fD6pMGeZDxAD5jhtpGAUOa
        MTohMpOxRCxnYLe9+EcYRCyg453q/K+iBny8yV0WGc5EG6/giF1KmmtZf1kCy8ATB6c4+22rwppNo
        tGXQL8VaWaLHXKxhZpHByLqRQJZ8f1zCnRi79QsbEBgz6q0d/S7CtzAdZkyFuuj7hG7f/Gq8XdyQQ
        my0pkMikQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNSz-0004Xj-61; Mon, 11 Jun 2018 14:06:41 +0000
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
Subject: [PATCH v13 02/72] dax: Fix use of zero page
Date: Mon, 11 Jun 2018 07:05:29 -0700
Message-Id: <20180611140639.17215-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Use my_zero_pfn instead of ZERO_PAGE, and pass the vaddr to it so it
works on MIPS and s390.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 fs/dax.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4de11ed463ce..5e7b010738be 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1017,21 +1017,12 @@ static vm_fault_t dax_load_hole(struct address_space *mapping, void *entry,
 {
 	struct inode *inode = mapping->host;
 	unsigned long vaddr = vmf->address;
-	vm_fault_t ret = VM_FAULT_NOPAGE;
-	struct page *zero_page;
-	pfn_t pfn;
-
-	zero_page = ZERO_PAGE(0);
-	if (unlikely(!zero_page)) {
-		ret = VM_FAULT_OOM;
-		goto out;
-	}
+	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	vm_fault_t ret;
 
-	pfn = page_to_pfn_t(zero_page);
 	dax_insert_mapping_entry(mapping, vmf, entry, pfn, RADIX_DAX_ZERO_PAGE,
 			false);
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
-out:
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
-- 
2.17.1
