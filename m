Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CEC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5019120883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL4mhand"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5019120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbeFUOjJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932514AbeFUOjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:39:08 -0400
Received: from localhost.localdomain (unknown [49.65.250.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B08220652;
        Thu, 21 Jun 2018 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529591948;
        bh=0SVb91ytzSKlJ7BEtMehbvpxyNs/iNSsX+/+QKWXHaI=;
        h=From:To:Cc:Subject:Date:From;
        b=EL4mhandOfTZ3yyVuvYucaj+YeqDq0t5N89ebxyCFSf0hTJswhdGzEyyLzMyUZVDc
         4Q9GTb3DVQPx5NxFrGtQZY7Hp65/1BWiq7WiwNnqRVFkaLEtBlSlN0Av5Wjw7ID4+Q
         kyKbLlSzqZ54OOvrFtU0i61MsNN5VQGPiR+40t+Q=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to wait on page writeback before updating page
Date:   Thu, 21 Jun 2018 22:38:28 +0800
Message-Id: <20180621143828.3844-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In error path of f2fs_move_rehashed_dirents, inode page could be writeback
state, so we should wait on inode page writeback before updating it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a6d6d340211a..d0d430ad79ff 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -477,6 +477,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	return 0;
 recover:
 	lock_page(ipage);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA(dir));
 	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA(dir));
-- 
2.16.2.17.g38e79b1fd

