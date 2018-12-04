Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF609214F1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfiwWAxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF609214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeLDLJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbeLDLJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48749214E0;
        Tue,  4 Dec 2018 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921743;
        bh=7zTJffmiEQ2EAuUnQvFCV9mTNxtH1DopvUUFTj291vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfiwWAxyB1fto1ePIZba+4GhaWxz2uap3iMqAz7Gz414vHj6nDY+Km/2m8W+zKve6
         dD0ZTbmWHw2jtIFqU4BtV3VM6JijEch7DZ2Dd7CV8k4zKIuwyEhqN2oAAM3m68T0z6
         oUwb0nG/bSOfsd6FGM/YNb773JmSFvSuq9bZXhDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Hugh Dickins <hughd@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 07/50] shmem: introduce shmem_inode_acct_block
Date:   Tue,  4 Dec 2018 11:50:02 +0100
Message-Id: <20181204103714.874823429@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 0f0796945614b7523987f7eea32407421af4b1ee upstream.

The shmem_acct_block and the update of used_blocks are following one
another in all the places they are used.  Combine these two into a
helper function.

Link: http://lkml.kernel.org/r/1497939652-16528-3-git-send-email-rppt@linux.vnet.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hillf Danton <hillf.zj@alibaba-inc.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 82 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b26f11221ea8..e30ffaa065a4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -181,6 +181,38 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
+static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+
+	if (shmem_acct_block(info->flags, pages))
+		return false;
+
+	if (sbinfo->max_blocks) {
+		if (percpu_counter_compare(&sbinfo->used_blocks,
+					   sbinfo->max_blocks - pages) > 0)
+			goto unacct;
+		percpu_counter_add(&sbinfo->used_blocks, pages);
+	}
+
+	return true;
+
+unacct:
+	shmem_unacct_blocks(info->flags, pages);
+	return false;
+}
+
+static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+
+	if (sbinfo->max_blocks)
+		percpu_counter_sub(&sbinfo->used_blocks, pages);
+	shmem_unacct_blocks(info->flags, pages);
+}
+
 static const struct super_operations shmem_ops;
 static const struct address_space_operations shmem_aops;
 static const struct file_operations shmem_file_operations;
@@ -237,31 +269,20 @@ static void shmem_recalc_inode(struct inode *inode)
 
 	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
 	if (freed > 0) {
-		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-		if (sbinfo->max_blocks)
-			percpu_counter_add(&sbinfo->used_blocks, -freed);
 		info->alloced -= freed;
 		inode->i_blocks -= freed * BLOCKS_PER_PAGE;
-		shmem_unacct_blocks(info->flags, freed);
+		shmem_inode_unacct_blocks(inode, freed);
 	}
 }
 
 bool shmem_charge(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	unsigned long flags;
 
-	if (shmem_acct_block(info->flags, pages))
+	if (!shmem_inode_acct_block(inode, pages))
 		return false;
 
-	if (sbinfo->max_blocks) {
-		if (percpu_counter_compare(&sbinfo->used_blocks,
-					   sbinfo->max_blocks - pages) > 0)
-			goto unacct;
-		percpu_counter_add(&sbinfo->used_blocks, pages);
-	}
-
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced += pages;
 	inode->i_blocks += pages * BLOCKS_PER_PAGE;
@@ -270,16 +291,11 @@ bool shmem_charge(struct inode *inode, long pages)
 	inode->i_mapping->nrpages += pages;
 
 	return true;
-
-unacct:
-	shmem_unacct_blocks(info->flags, pages);
-	return false;
 }
 
 void shmem_uncharge(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->lock, flags);
@@ -288,9 +304,7 @@ void shmem_uncharge(struct inode *inode, long pages)
 	shmem_recalc_inode(inode);
 	spin_unlock_irqrestore(&info->lock, flags);
 
-	if (sbinfo->max_blocks)
-		percpu_counter_sub(&sbinfo->used_blocks, pages);
-	shmem_unacct_blocks(info->flags, pages);
+	shmem_inode_unacct_blocks(inode, pages);
 }
 
 /*
@@ -1423,9 +1437,10 @@ static struct page *shmem_alloc_page(gfp_t gfp,
 }
 
 static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
-		struct shmem_inode_info *info, struct shmem_sb_info *sbinfo,
+		struct inode *inode,
 		pgoff_t index, bool huge)
 {
+	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct page *page;
 	int nr;
 	int err = -ENOSPC;
@@ -1434,14 +1449,8 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
 		huge = false;
 	nr = huge ? HPAGE_PMD_NR : 1;
 
-	if (shmem_acct_block(info->flags, nr))
+	if (!shmem_inode_acct_block(inode, nr))
 		goto failed;
-	if (sbinfo->max_blocks) {
-		if (percpu_counter_compare(&sbinfo->used_blocks,
-					sbinfo->max_blocks - nr) > 0)
-			goto unacct;
-		percpu_counter_add(&sbinfo->used_blocks, nr);
-	}
 
 	if (huge)
 		page = shmem_alloc_hugepage(gfp, info, index);
@@ -1454,10 +1463,7 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
 	}
 
 	err = -ENOMEM;
-	if (sbinfo->max_blocks)
-		percpu_counter_add(&sbinfo->used_blocks, -nr);
-unacct:
-	shmem_unacct_blocks(info->flags, nr);
+	shmem_inode_unacct_blocks(inode, nr);
 failed:
 	return ERR_PTR(err);
 }
@@ -1717,10 +1723,9 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		}
 
 alloc_huge:
-		page = shmem_alloc_and_acct_page(gfp, info, sbinfo,
-				index, true);
+		page = shmem_alloc_and_acct_page(gfp, inode, index, true);
 		if (IS_ERR(page)) {
-alloc_nohuge:		page = shmem_alloc_and_acct_page(gfp, info, sbinfo,
+alloc_nohuge:		page = shmem_alloc_and_acct_page(gfp, inode,
 					index, false);
 		}
 		if (IS_ERR(page)) {
@@ -1842,10 +1847,7 @@ alloc_nohuge:		page = shmem_alloc_and_acct_page(gfp, info, sbinfo,
 	 * Error recovery.
 	 */
 unacct:
-	if (sbinfo->max_blocks)
-		percpu_counter_sub(&sbinfo->used_blocks,
-				1 << compound_order(page));
-	shmem_unacct_blocks(info->flags, 1 << compound_order(page));
+	shmem_inode_unacct_blocks(inode, 1 << compound_order(page));
 
 	if (PageTransHuge(page)) {
 		unlock_page(page);
-- 
2.17.1



