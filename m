Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57909C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC3F20878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+jL9H7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC3F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJCINg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeJCINf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:13:35 -0400
Received: from localhost (unknown [104.132.0.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E9320835;
        Wed,  3 Oct 2018 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538530047;
        bh=2YLRInbgOC4MxRin+7M4+E30CXoW0iZVZwx/sOSonvI=;
        h=From:To:Cc:Subject:Date:From;
        b=R+jL9H7k3zV+iPqqSBygK2ODqsAjhVG5iq/FOaa975JaXANgjRDwMB+2XPUktqYEk
         quixWA5nS5LQPnBD9V2FpNtVRnTe+onaIg/+3ATlDe4tVbGU9qVtnZHufY0RHgkykq
         Fmkrw5smILQ+HalSlAW0jL6XRrlTl4/mZ2RmzoX4=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow to mount, if quota is failed
Date:   Tue,  2 Oct 2018 18:27:25 -0700
Message-Id: <20181003012725.37670-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we can use the filesystem without quotas till next boot.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b39f60d57120..828a71a77799 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3282,11 +3282,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* Enable quota usage during mount */
 	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
 		err = f2fs_enable_quotas(sb);
-		if (err) {
+		if (err)
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot turn on quotas: error %d", err);
-			goto free_sysfs;
-		}
 	}
 #endif
 	/* if there are nt orphan nodes free them */
@@ -3387,9 +3385,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
 	truncate_inode_pages_final(META_MAPPING(sbi));
-#ifdef CONFIG_QUOTA
-free_sysfs:
-#endif
 	f2fs_unregister_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
-- 
2.19.0.605.g01d371f741-goog

