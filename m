Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51B7214ED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vWgXS+F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51B7214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeLDLCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeLDLCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 274E0214DA;
        Tue,  4 Dec 2018 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921324;
        bh=QwHZyuX1TCAuA89e1Vpb7/E4vv1lJ8rD8BGZSd7OYxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWgXS+F0m8H4Hiv70/alJ9dl4kLO3UaWYx8M2NzZlhZeFcFrAfjdQrxRZJrKr3drL
         zXIGXIR6HevU5pJhPKl04hIyX4unrxeg+OtgMGoU0k/Q8dVpuAaRiqSokB6+ELfIJN
         8f/AhDKLtEOCavLNEcBE6Z9UiLLEdMr0Lb4WqhUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 006/146] mm/khugepaged: fix crashes due to misaccounted holes
Date:   Tue,  4 Dec 2018 11:48:12 +0100
Message-Id: <20181204103727.031955979@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit aaa52e340073b7f4593b3c4ddafcafa70cf838b5 upstream.

Huge tmpfs testing on a shortish file mapped into a pmd-rounded extent
hit shmem_evict_inode()'s WARN_ON(inode->i_blocks) followed by
clear_inode()'s BUG_ON(inode->i_data.nrpages) when the file was later
closed and unlinked.

khugepaged's collapse_shmem() was forgetting to update mapping->nrpages
on the rollback path, after it had added but then needs to undo some
holes.

There is indeed an irritating asymmetry between shmem_charge(), whose
callers want it to increment nrpages after successfully accounting
blocks, and shmem_uncharge(), when __delete_from_page_cache() already
decremented nrpages itself: oh well, just add a comment on that to them
both.

And shmem_recalc_inode() is supposed to be called when the accounting is
expected to be in balance (so it can deduce from imbalance that reclaim
discarded some pages): so change shmem_charge() to update nrpages
earlier (though it's rare for the difference to matter at all).

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261523450.2275@eggly.anvils
Fixes: 800d8c63b2e98 ("shmem: add huge pages support")
Fixes: f3f0e1d2150b2 ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 4 +++-
 mm/shmem.c      | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d4a06afbeda4..be7b0863e33c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1539,8 +1539,10 @@ static void collapse_shmem(struct mm_struct *mm,
 		*hpage = NULL;
 	} else {
 		/* Something went wrong: rollback changes to the radix-tree */
-		shmem_uncharge(mapping->host, nr_none);
 		spin_lock_irq(&mapping->tree_lock);
+		mapping->nrpages -= nr_none;
+		shmem_uncharge(mapping->host, nr_none);
+
 		radix_tree_for_each_slot(slot, &mapping->page_tree, &iter,
 				start) {
 			if (iter.index >= end)
diff --git a/mm/shmem.c b/mm/shmem.c
index fa08f56fd5e5..177fef62cbbd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -296,12 +296,14 @@ bool shmem_charge(struct inode *inode, long pages)
 	if (!shmem_inode_acct_block(inode, pages))
 		return false;
 
+	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
+	inode->i_mapping->nrpages += pages;
+
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced += pages;
 	inode->i_blocks += pages * BLOCKS_PER_PAGE;
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
-	inode->i_mapping->nrpages += pages;
 
 	return true;
 }
@@ -311,6 +313,8 @@ void shmem_uncharge(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long flags;
 
+	/* nrpages adjustment done by __delete_from_page_cache() or caller */
+
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced -= pages;
 	inode->i_blocks -= pages * BLOCKS_PER_PAGE;
-- 
2.17.1



