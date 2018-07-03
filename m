Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B604EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756624DE1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7756624DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeGCELk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:11:40 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50649 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751237AbeGCELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:11:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0T3scjyw_1530591079;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3scjyw_1530591079)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Jul 2018 12:11:27 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mgorman@techsingularity.net, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        dchinner@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs: ext4: use BUG_ON if writepage call comes from direct reclaim
Date:   Tue,  3 Jul 2018 12:11:18 +0800
Message-Id: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

direct reclaim doesn't write out filesystem page, only kswapd could do
it. So, if the call comes from direct reclaim, it is definitely a bug.

And, Mel Gormane also mentioned "Ultimately, this will be a BUG_ON." In
commit 94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct
reclaim tries to writeback pages").

Although it is for xfs, ext4 has the similar behavior, so elevate
WARN_ON to BUG_ON.

And, correct the comment accordingly.

Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 fs/ext4/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ea07ef..089e388 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2071,7 +2071,7 @@ static int __ext4_journalled_writepage(struct page *page,
  * This function can get called via...
  *   - ext4_writepages after taking page lock (have journal handle)
  *   - journal_submit_inode_data_buffers (no journal handle)
- *   - shrink_page_list via the kswapd/direct reclaim (no journal handle)
+ *   - shrink_page_list via the kswapd (no journal handle)
  *   - grab_page_cache when doing write_begin (have journal handle)
  *
  * We don't do any block allocation in this function. If we have page with
@@ -2148,10 +2148,10 @@ static int ext4_writepage(struct page *page,
 		    (inode->i_sb->s_blocksize == PAGE_SIZE)) {
 			/*
 			 * For memory cleaning there's no point in writing only
-			 * some buffers. So just bail out. Warn if we came here
-			 * from direct reclaim.
+			 * some buffers. So just bail out. It is a bug if we
+			 * came here from direct reclaim.
 			 */
-			WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD))
+			BUG_ON((current->flags & (PF_MEMALLOC|PF_KSWAPD))
 							== PF_MEMALLOC);
 			unlock_page(page);
 			return 0;
-- 
1.8.3.1

