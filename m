Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845BEC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E8524D04
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E8524D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeGCELl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:11:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44246 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751760AbeGCELj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:11:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0T3scjyw_1530591079;
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
Subject: [PATCH 2/2] fs: xfs: use BUG_ON if writepage call comes from direct reclaim
Date:   Tue,  3 Jul 2018 12:11:19 +0800
Message-Id: <1530591079-33813-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

direct reclaim doesn't write out filesystem page, only kswapd could do
this. So, if it is called from direct relaim, it is definitely a bug.

And, Mel Gorman mentioned "Ultimately, this will be a BUG_ON." in commit
94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct reclaim
tries to writeback pages"),

It has been many years since that commit, so it should be safe to
elevate WARN_ON to BUG_ON now.

Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 fs/xfs/xfs_aops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8eb3ba3..7efc2d2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1080,11 +1080,9 @@ static inline int xfs_bio_add_buffer(struct bio *bio, struct buffer_head *bh)
 	 * allow reclaim from kswapd as the stack usage there is relatively low.
 	 *
 	 * This should never happen except in the case of a VM regression so
-	 * warn about it.
+	 * BUG about it.
 	 */
-	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
-			PF_MEMALLOC))
-		goto redirty;
+	BUG_ON((current->flags & (PF_MEMALLOC|PF_KSWAPD)) == PF_MEMALLOC);
 
 	/*
 	 * Given that we do not allow direct reclaim to call us, we should
-- 
1.8.3.1

