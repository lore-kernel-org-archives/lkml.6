Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Sec+HtCDHluRFwAAmS7hNA
	; Mon, 11 Jun 2018 14:16:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 714A6607A4; Mon, 11 Jun 2018 14:16:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jq8BOrbU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 045CC60351;
	Mon, 11 Jun 2018 14:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 045CC60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934058AbeFKOQS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:16:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933558AbeFKOHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0EjsrGiMt0AMBHCpmZhDE2s/mYuVDVXAXqW03asYwq0=; b=jq8BOrbUjd88V+j+k026qIkdn
        iSyF90b76zY7jssORf8MpW1fP1/GPaH7/EJv9cUywaRdzjCYreCKUcZAb3IVbiqK+0XQ0p7oZBFSZ
        eaMxqjlmHIqLnx+J1k4VBbBtux2xXQHA533229i/CEitjmcjF9PkgUhitcEcp3OOZTsCl7v7tNYfi
        4nELIbDLMnbTtCwHeIYXMiL/1q4ZERTpbjET/A9atIxATtrzSK/C7NMCSLK94CGoMjUcLkiXteooK
        xGYb6AeKysRK9DqOM06pJyRz8hL4LEuzKIRpITsZrYqP4VhWEmeCp7llRjokOfUj5LpBwih29byI0
        T/erpetLQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTH-0004oe-FF; Mon, 11 Jun 2018 14:06:59 +0000
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
Subject: [PATCH v13 43/72] mm: Convert khugepaged_scan_shmem to XArray
Date: Mon, 11 Jun 2018 07:06:10 -0700
Message-Id: <20180611140639.17215-44-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Slightly shorter and easier to read code.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/khugepaged.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 43598cc5998b..28579ad0c5fe 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1538,8 +1538,7 @@ static void khugepaged_scan_shmem(struct mm_struct *mm,
 		pgoff_t start, struct page **hpage)
 {
 	struct page *page = NULL;
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, start);
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	int result = SCAN_SUCCEED;
@@ -1548,17 +1547,11 @@ static void khugepaged_scan_shmem(struct mm_struct *mm,
 	swap = 0;
 	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
 	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
-		if (iter.index >= start + HPAGE_PMD_NR)
-			break;
-
-		page = radix_tree_deref_slot(slot);
-		if (radix_tree_deref_retry(page)) {
-			slot = radix_tree_iter_retry(&iter);
+	xas_for_each(&xas, page, start + HPAGE_PMD_NR - 1) {
+		if (xas_retry(&xas, page))
 			continue;
-		}
 
-		if (radix_tree_exception(page)) {
+		if (xa_is_value(page)) {
 			if (++swap > khugepaged_max_ptes_swap) {
 				result = SCAN_EXCEED_SWAP_PTE;
 				break;
@@ -1597,7 +1590,7 @@ static void khugepaged_scan_shmem(struct mm_struct *mm,
 		present++;
 
 		if (need_resched()) {
-			slot = radix_tree_iter_resume(slot, &iter);
+			xas_pause(&xas);
 			cond_resched_rcu();
 		}
 	}
-- 
2.17.1
