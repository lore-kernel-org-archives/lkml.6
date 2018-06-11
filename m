Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /O13GxuEHltbGQAAmS7hNA
	; Mon, 11 Jun 2018 14:17:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 90EDE607E4; Mon, 11 Jun 2018 14:17:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oeORb1zk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F2EC60791;
	Mon, 11 Jun 2018 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F2EC60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933716AbeFKORI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:17:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933534AbeFKOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MujQtudD6HapXlrwSi8huMmGpeKkjTkBkrUZuiJikXE=; b=oeORb1zkr0yVfKJawkiF8tapz
        AP283ohq5CrZArgIGTWnvMCIr8sfI3jNzzfxmmQ9fD+AbFJKaKb8ZREua/EzVkPyErflY/DfaReCs
        rgzrDHCyo4jU+nseYGNF7ybp3CxQkfWrN6PXsONZYBtGv8e616D9KXlg3kBWPtEorGlakzOd4wRkb
        UAy70hJFoIYsui4qBhNL9KnBopPmd+zunjg7yYGCietgss5AcobvIiEGOO0tziaAa6SdDPdELVPOM
        rQwtM+v7XaDX5tLNQnBOE+uaDpRWkxq1PffuCjrgUjHazMoPA9DC+YDW/yyrsJRQ00p5kWB6wu9qU
        UM1uOmuIA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTE-0004mW-UX; Mon, 11 Jun 2018 14:06:56 +0000
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
Subject: [PATCH v13 39/72] mm: Convert __do_page_cache_readahead to XArray
Date: Mon, 11 Jun 2018 07:06:06 -0700
Message-Id: <20180611140639.17215-40-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

This one is trivial.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/readahead.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 59998ca31f2a..07f9734dc79f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -174,9 +174,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
 		if (page_offset > end_index)
 			break;
 
-		rcu_read_lock();
-		page = radix_tree_lookup(&mapping->i_pages, page_offset);
-		rcu_read_unlock();
+		page = xa_load(&mapping->i_pages, page_offset);
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch of
-- 
2.17.1
