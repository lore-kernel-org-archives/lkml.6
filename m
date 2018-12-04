Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728872146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mipbr6rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728872146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeLDLJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbeLDLJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8170F2082D;
        Tue,  4 Dec 2018 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921741;
        bh=qydyTxPvKv23dsr5Kz9rMENOt+MRguSYVTC6HmISoLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mipbr6rjvRHifMJvdx895TMPInUXrs9Q8S1tzpAva+OqMCHlc2J9e+YLn4JdbjITh
         9DToybjkgKyDDufQuZ6+Lo+H3j/Ha7LiCBmIrU8+QaOLG/x9iDQTHBZLkIrXYp/bjv
         YDfi9c4y+aVw0MGFttTziMeZtfDa/S7RS0bV6iPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/50] shmem: shmem_charge: verify max_block is not exceeded before inode update
Date:   Tue,  4 Dec 2018 11:50:01 +0100
Message-Id: <20181204103714.816244132@linuxfoundation.org>
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

commit b1cc94ab2f2ba31fcb2c59df0b9cf03f6d720553 upstream.

Patch series "userfaultfd: enable zeropage support for shmem".

These patches enable support for UFFDIO_ZEROPAGE for shared memory.

The first two patches are not strictly related to userfaultfd, they are
just minor refactoring to reduce amount of code duplication.

This patch (of 7):

Currently we update inode and shmem_inode_info before verifying that
used_blocks will not exceed max_blocks.  In case it will, we undo the
update.  Let's switch the order and move the verification of the blocks
count before the inode and shmem_inode_info update.

Link: http://lkml.kernel.org/r/1497939652-16528-2-git-send-email-rppt@linux.vnet.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hillf Danton <hillf.zj@alibaba-inc.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 358a92be43eb..b26f11221ea8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -254,6 +254,14 @@ bool shmem_charge(struct inode *inode, long pages)
 
 	if (shmem_acct_block(info->flags, pages))
 		return false;
+
+	if (sbinfo->max_blocks) {
+		if (percpu_counter_compare(&sbinfo->used_blocks,
+					   sbinfo->max_blocks - pages) > 0)
+			goto unacct;
+		percpu_counter_add(&sbinfo->used_blocks, pages);
+	}
+
 	spin_lock_irqsave(&info->lock, flags);
 	info->alloced += pages;
 	inode->i_blocks += pages * BLOCKS_PER_PAGE;
@@ -261,20 +269,11 @@ bool shmem_charge(struct inode *inode, long pages)
 	spin_unlock_irqrestore(&info->lock, flags);
 	inode->i_mapping->nrpages += pages;
 
-	if (!sbinfo->max_blocks)
-		return true;
-	if (percpu_counter_compare(&sbinfo->used_blocks,
-				sbinfo->max_blocks - pages) > 0) {
-		inode->i_mapping->nrpages -= pages;
-		spin_lock_irqsave(&info->lock, flags);
-		info->alloced -= pages;
-		shmem_recalc_inode(inode);
-		spin_unlock_irqrestore(&info->lock, flags);
-		shmem_unacct_blocks(info->flags, pages);
-		return false;
-	}
-	percpu_counter_add(&sbinfo->used_blocks, pages);
 	return true;
+
+unacct:
+	shmem_unacct_blocks(info->flags, pages);
+	return false;
 }
 
 void shmem_uncharge(struct inode *inode, long pages)
-- 
2.17.1



