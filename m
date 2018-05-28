Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030739AbeE1KRq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030302AbeE1KRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:17:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Piao <piaojun@huawei.com>,
        Yiwen Jiang <jiangyiwen@huawei.com>, Changwei Ge <ge.changwei@h3c.com>,
        Mark Fasheh <mfasheh@versity.com>, Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>, Joseph Qi <jiangqi903@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 048/268] ocfs2: return error when we attempt to access a dirty bh in jbd2
Date: Mon, 28 May 2018 12:00:22 +0200
Message-Id: <20180528100207.424717869@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: piaojun <piaojun@huawei.com>

[ Upstream commit d984187e3a1ad7d12447a7ab2c43ce3717a2b5b3 ]

We should not reuse the dirty bh in jbd2 directly due to the following
situation:

1. When removing extent rec, we will dirty the bhs of extent rec and
   truncate log at the same time, and hand them over to jbd2.

2. The bhs are submitted to jbd2 area successfully.

3. The write-back thread of device help flush the bhs to disk but
   encounter write error due to abnormal storage link.

4. After a while the storage link become normal. Truncate log flush
   worker triggered by the next space reclaiming found the dirty bh of
   truncate log and clear its 'BH_Write_EIO' and then set it uptodate in
   __ocfs2_journal_access():

   ocfs2_truncate_log_worker
     ocfs2_flush_truncate_log
       __ocfs2_flush_truncate_log
         ocfs2_replay_truncate_records
           ocfs2_journal_access_di
             __ocfs2_journal_access // here we clear io_error and set 'tl_bh' uptodata.

5. Then jbd2 will flush the bh of truncate log to disk, but the bh of
   extent rec is still in error state, and unfortunately nobody will
   take care of it.

6. At last the space of extent rec was not reduced, but truncate log
   flush worker have given it back to globalalloc. That will cause
   duplicate cluster problem which could be identified by fsck.ocfs2.

Sadly we can hardly revert this but set fs read-only in case of ruining
atomicity and consistency of space reclaim.

Link: http://lkml.kernel.org/r/5A6E8092.8090701@huawei.com
Fixes: acf8fdbe6afb ("ocfs2: do not BUG if buffer not uptodate in __ocfs2_journal_access")
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/journal.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -666,23 +666,24 @@ static int __ocfs2_journal_access(handle
 	/* we can safely remove this assertion after testing. */
 	if (!buffer_uptodate(bh)) {
 		mlog(ML_ERROR, "giving me a buffer that's not uptodate!\n");
-		mlog(ML_ERROR, "b_blocknr=%llu\n",
-		     (unsigned long long)bh->b_blocknr);
+		mlog(ML_ERROR, "b_blocknr=%llu, b_state=0x%lx\n",
+		     (unsigned long long)bh->b_blocknr, bh->b_state);
 
 		lock_buffer(bh);
 		/*
-		 * A previous attempt to write this buffer head failed.
-		 * Nothing we can do but to retry the write and hope for
-		 * the best.
+		 * A previous transaction with a couple of buffer heads fail
+		 * to checkpoint, so all the bhs are marked as BH_Write_EIO.
+		 * For current transaction, the bh is just among those error
+		 * bhs which previous transaction handle. We can't just clear
+		 * its BH_Write_EIO and reuse directly, since other bhs are
+		 * not written to disk yet and that will cause metadata
+		 * inconsistency. So we should set fs read-only to avoid
+		 * further damage.
 		 */
 		if (buffer_write_io_error(bh) && !buffer_uptodate(bh)) {
-			clear_buffer_write_io_error(bh);
-			set_buffer_uptodate(bh);
-		}
-
-		if (!buffer_uptodate(bh)) {
 			unlock_buffer(bh);
-			return -EIO;
+			return ocfs2_error(osb->sb, "A previous attempt to "
+					"write this buffer head failed\n");
 		}
 		unlock_buffer(bh);
 	}
