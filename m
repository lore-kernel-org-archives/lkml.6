Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751065AbeCIEtE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 23:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbeCIEtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 23:49:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8797E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid selinux denial on CAP_SYS_RESOURCE
Date: Thu,  8 Mar 2018 20:49:00 -0800
Message-Id: <20180309044900.39677-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes CAP_SYS_RESOURCE denial of selinux when using resgid.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6dc70666ebb..3d12277fbe9e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1607,13 +1607,13 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 		return false;
 	if (IS_NOQUOTA(inode))
 		return true;
-	if (capable(CAP_SYS_RESOURCE))
-		return true;
 	if (uid_eq(sbi->s_resuid, current_fsuid()))
 		return true;
 	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
 					in_group_p(sbi->s_resgid))
 		return true;
+	if (capable(CAP_SYS_RESOURCE))
+		return true;
 	return false;
 }
 
-- 
2.15.0.531.g2ccb3012c9-goog
