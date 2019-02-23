Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1D62085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956249;
	bh=ZQYzZvmYleW+xDwpweidtAETk2kj9F9L3xPKu/RQjcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dSsDiOgKacOAgZPPVCj5FcMgQlvSJWpYrAdkh9NwAMLNB/dWdGMkJj3BC3TE/PbDR
	 eXTep7tth9pYJyiBxRaO3PfNEDCEXd1fB5WOeK0QrJiMp+jRdJm+a+HqujFpbWmtJP
	 qeq7DEE8/So+BUHrnSK1QLFvyN1z6jBYVp8i7Ey8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfBWVKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfBWVKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:10:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EB32085A;
        Sat, 23 Feb 2019 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956242;
        bh=ZQYzZvmYleW+xDwpweidtAETk2kj9F9L3xPKu/RQjcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwtTbUieyY8oDVu0G4w8PO9ZNdNiuUCt6eWVQ+pHaM9RPMV4F3WRW6AHrjxHCVfEM
         4Rc6POoj0u5QXOIwixoPXhrSU5K3p+kmh00p3hE9QnqU0gqcnGwB1j9im3zKHcZEmK
         qYc2R4+O59oJXP80nTn2Au40xfmwSAkVGHLgCk1A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 30/32] fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
Date:   Sat, 23 Feb 2019 16:09:49 -0500
Message-Id: <20190223210951.202268-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210951.202268-1-sashal@kernel.org>
References: <20190223210951.202268-1-sashal@kernel.org>
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

