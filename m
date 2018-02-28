Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933752AbeB1RLv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:11:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933179AbeB1Pty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:49:54 -0500
From: Vratislav Bendel <vbendel@redhat.com>
To: linux-xfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: Correctly invert xfs_buftarg LRU isolation logic
Date: Wed, 28 Feb 2018 16:49:51 +0100
Message-Id: <20180228154951.31714-1-vbendel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function xfs_buftarg_isolate() used by xfs buffer schrinkers 
to determine whether a buffer should be isolated and disposed 
from LRU list, has inverted logic.

Excerpt from xfs_buftarg_isolate():
        /*
         * Decrement the b_lru_ref count unless the value is already
         * zero. If the value is already zero, we need to reclaim the
         * buffer, otherwise it gets another trip through the LRU.
         */
        if (!atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
                spin_unlock(&bp->b_lock);
                return LRU_ROTATE;
        }

However, as per documentation, atomic_add_unless() returns _zero_
if the atomic value was originally equal to the specified *unsless* value.

Ultimately causing a xfs_buffer with ->b_lru_ref == 0, to take another 
trip around LRU, while isolating buffers with non-zero b_lru_ref.

Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
CC: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index d1da2ee9e6db..ac669a10c62f 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1708,7 +1708,7 @@ xfs_buftarg_isolate(
 	 * zero. If the value is already zero, we need to reclaim the
 	 * buffer, otherwise it gets another trip through the LRU.
 	 */
-	if (!atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
+	if (atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
 		spin_unlock(&bp->b_lock);
 		return LRU_ROTATE;
 	}
-- 
2.14.3
