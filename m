Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeERMfu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeERMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:25 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 08/11] xfs: have sync_fs op report writeback errors when passed a since pointer
Date: Fri, 18 May 2018 08:34:12 -0400
Message-Id: <20180518123415.28181-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/xfs/xfs_super.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 9255de2767b4..7dc847f48f9f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1092,6 +1092,7 @@ xfs_fs_sync_fs(
 	int			wait,
 	errseq_t		*since)
 {
+	int			ret;
 	struct xfs_mount	*mp = XFS_M(sb);
 
 	/*
@@ -1110,7 +1111,13 @@ xfs_fs_sync_fs(
 		flush_delayed_work(&mp->m_log->l_work);
 	}
 out:
-	return __sync_blockdev(sb->s_bdev, wait);
+	ret = __sync_blockdev(sb->s_bdev, wait);
+	if (since) {
+		int ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
+		if (ret == 0)
+			ret = ret2;
+	}
+	return ret;
 }
 
 STATIC int
-- 
2.17.0
