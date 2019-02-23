Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADC420651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956421;
	bh=ZQYzZvmYleW+xDwpweidtAETk2kj9F9L3xPKu/RQjcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mPUskEK5z6RSqySge4vQxgYUaNtT2HHaG9CKW+C7DIAkfKTXpQ/THH3gkKSdd9cQZ
	 V5/inguhefTiLPqAc2yupqSbMc/tUXolu/PtVF4N7OoHFjx0KStYE1ykDBxP99KFMd
	 lTSzOdRYxUmzIvWeziT6VvKlHhRMKsCNroXGcr9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfBWVLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbfBWVLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82E122086C;
        Sat, 23 Feb 2019 21:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956290;
        bh=ZQYzZvmYleW+xDwpweidtAETk2kj9F9L3xPKu/RQjcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJMzbjzZxnCYr3oP64HtRo2VaomfGKUVWKWvaU+yANdfMo2qBJVXttwcgHt8TXw3T
         uyPoFSQCDyL2mo1MxMaUuoSgOZtJTD6smkA0hbMCWON8IwrvcletiqR3nvIqVRD6rs
         QB7dyZOw2L12pNVpwWxlgyGRmR8TfM9Gfp/aLTOM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 24/26] fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
Date:   Sat, 23 Feb 2019 16:10:45 -0500
Message-Id: <20190223211047.202725-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit c27d82f52f75fc9d8d9d40d120d2a96fdeeada5e ]

When superblock has lots of inodes without any pagecache (like is the
case for /proc), drop_pagecache_sb() will iterate through all of them
without dropping sb->s_inode_list_lock which can lead to softlockups
(one of our customers hit this).

Fix the problem by going to the slow path and doing cond_resched() in
case the process needs rescheduling.

Link: http://lkml.kernel.org/r/20190114085343.15011-1-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/drop_caches.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d72d52b904333..280460fef0664 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -20,8 +20,13 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
+		/*
+		 * We must skip inodes in unusual state. We may also skip
+		 * inodes without pages but we deliberately won't in case
+		 * we need to reschedule to avoid softlockups.
+		 */
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
-		    (inode->i_mapping->nrpages == 0)) {
+		    (inode->i_mapping->nrpages == 0 && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -29,6 +34,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
+		cond_resched();
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 		iput(toput_inode);
 		toput_inode = inode;
-- 
2.19.1

