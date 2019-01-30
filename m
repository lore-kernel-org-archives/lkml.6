Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD0DC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B275E21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfA3ERU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:17:20 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:46667 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730045AbfA3ERU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:17:20 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 30 Jan 2019 14:47:14 +1030
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gohJJ-0000dS-L5; Wed, 30 Jan 2019 15:17:13 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92-RC4)
        (envelope-from <david@fromorbit.com>)
        id 1gohJJ-0007eF-JI; Wed, 30 Jan 2019 15:17:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     guro@fb.com, akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Subject: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached pages"
Date:   Wed, 30 Jan 2019 15:17:06 +1100
Message-Id: <20190130041707.27750-2-david@fromorbit.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130041707.27750-1-david@fromorbit.com>
References: <20190130041707.27750-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

This reverts commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0.

This change causes serious changes to page cache and inode cache
behaviour and balance, resulting in major performance regressions
when combining worklaods such as large file copies and kernel
compiles.

https://bugzilla.kernel.org/show_bug.cgi?id=202441

This change is a hack to work around the problems introduced by
changing how agressive shrinkers are on small caches in commit
172b06c32b94 ("mm: slowly shrink slabs with a relatively small
number of objects"). It creates more problems than it solves, wasn't
adequately reviewed or tested, so it needs to be reverted.

cc: <stable@vger.kernel.org>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0cd47fe0dbe5..73432e64f874 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -730,11 +730,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		return LRU_REMOVED;
 	}
 
-	/*
-	 * Recently referenced inodes and inodes with many attached pages
-	 * get one more pass.
-	 */
-	if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {
+	/* recently referenced inodes get one more pass */
+	if (inode->i_state & I_REFERENCED) {
 		inode->i_state &= ~I_REFERENCED;
 		spin_unlock(&inode->i_lock);
 		return LRU_ROTATE;
-- 
2.20.1

