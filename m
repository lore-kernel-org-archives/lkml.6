Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8FCECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840142083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1DNNpz3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840142083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbeITE1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725755AbeITE1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:27:48 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7D021521;
        Wed, 19 Sep 2018 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537397261;
        bh=2EmGrOLY/YUL+/P99MkHA1hofs9qqAV2j6TuUnhCIFs=;
        h=From:To:Cc:Subject:Date:From;
        b=1DNNpz3ljB3BSmbd+5GdYhgcvYzZD3u5n3TVr5phKO7WdI+er0/2K7BNBjgm0VbBE
         u6imK7HqJKK9KYFp0rngwt/8Tgnfgv9XviKPfYKrKvG7Sr9nW0xCRMbiGprMLwhcl1
         Cmu4d9C1scoLVxrG1iNWWFCL3NbGdb8L5VNwXB3Y=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid infinite loop in f2fs_alloc_nid
Date:   Wed, 19 Sep 2018 15:47:40 -0700
Message-Id: <20180919224740.80917-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have an error in f2fs_build_free_nids, we're able to fall into a loop
to find free nids.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 79b6fee354f7..e24f8acbea82 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2356,8 +2356,9 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	f2fs_build_free_nids(sbi, true, false);
-	goto retry;
+	if (!f2fs_build_free_nids(sbi, true, false))
+		goto retry;
+	return false;
 }
 
 /*
-- 
2.17.0.441.gb46fe60e1d-goog

