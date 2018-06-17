Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855C2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A8920895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ObeYbgFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A8920895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbeFQCII (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:08:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933960AbeFQCBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UL7Dd8P+07FgmPfVgBxdWbMx7UGqU9gll23MkeO9Cj4=; b=ObeYbgFHW40CIoI9Iay9YDcWB
        R1kLjrm1K4zSgLFf60/M+hfgncpEpteXsSNjqaVrhSZvqoTB2A0s+iXwQq1cN9GVs5+sRvopf5eMH
        B703/nXeYHsQFY6Lkn2WXqx3JncFQC1iCAFeZHlG+RkpUFWs9kAyLv24VPpLXF9tyOdje0VuVPW2B
        o1I2d7ZOtcKOHNlNKbd0UjtCs+Gz4jQ23VF2GTFIX0G3jFkRjv1Jvo6LOmX9tm/xmecUSqeyfjHqz
        mz5vLYkpNOs+kyQZv7ToapcRmRYgjsF7lWY8j6fbwTiEXriorLtlJkugjjUMNw/rNpYoPWNDZoxe3
        g/CiG4N/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN09-0001OE-1u; Sun, 17 Jun 2018 02:01:09 +0000
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
Subject: [PATCH v14 49/74] shmem: Convert find_swap_entry to XArray
Date:   Sat, 16 Jun 2018 19:00:27 -0700
Message-Id: <20180617020052.4759-50-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 1:1 conversion.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/shmem.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 479e4a8e6d68..983a27656e2e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1099,34 +1099,27 @@ static void shmem_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
-static unsigned long find_swap_entry(struct radix_tree_root *root, void *item)
+static unsigned long find_swap_entry(struct xarray *xa, void *item)
 {
-	struct radix_tree_iter iter;
-	void __rcu **slot;
-	unsigned long found = -1;
+	XA_STATE(xas, xa, 0);
 	unsigned int checked = 0;
+	void *entry;
 
 	rcu_read_lock();
-	radix_tree_for_each_slot(slot, root, &iter, 0) {
-		void *entry = radix_tree_deref_slot(slot);
-
-		if (radix_tree_deref_retry(entry)) {
-			slot = radix_tree_iter_retry(&iter);
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		if (xas_retry(&xas, entry))
 			continue;
-		}
-		if (entry == item) {
-			found = iter.index;
+		if (entry == item)
 			break;
-		}
 		checked++;
-		if ((checked % 4096) != 0)
+		if ((checked % XA_CHECK_SCHED) != 0)
 			continue;
-		slot = radix_tree_iter_resume(slot, &iter);
+		xas_pause(&xas);
 		cond_resched_rcu();
 	}
-
 	rcu_read_unlock();
-	return found;
+
+	return xas_invalid(&xas) ? -1 : xas.xa_index;
 }
 
 /*
-- 
2.17.1

