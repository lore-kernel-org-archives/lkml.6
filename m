Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225JCJUIRAjY5huc8qe37AGv0fPACIF8gpkIw6jhVJ8ImCnfhhDyfPR53xmjWmcaeFkCCmJ8
ARC-Seal: i=1; a=rsa-sha256; t=1517591539; cv=none;
        d=google.com; s=arc-20160816;
        b=Yqro3xb72NoIQ13w6JeftNpMtxnC+l+9J1xGZ3w7LmP8Afq1QPXu4baEXbukhgSKVo
         Yj+1pId9ws00kLCV6F/pejVHmyO/CbFPOUyx14hTbvwIqjdPOftIn9P1BMNAXgS3kCQl
         0udRAJs4dyeerqmZY6xCIV5or9EWJrQDs5tM7mjRZsJRBOjcYSnFkRZxVxHK0cpE67XN
         C/jJRBLAZAYF0js7Ebt6Hv1lsP1CCq4RJnmHnK2O98aW2V/5p6wNo5bLTvnfKr2K+H5u
         wHrmHw6MeB9c+QeEE6v2Fdj66VoEfbJOuRVBLCsg1qKIxdibMx6GwtZFrY3PePvBK3co
         qF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ehk9no+DiRLmGHKIRTO+iWAV7p6/g/BFmm60ZuDpHJY=;
        b=TGByRqFrTdClr2vOEpeDhSEmy40LksXF6YARF9/7DRD4dnjkedEano9kBIOGLQyrYT
         I/BvZokvcyx9523579/0QYMH3vCgU64H84gI5BwMKaBuYyAF9Ajvo0elVFauJEyjzPs3
         iJkKSRtjRoA0wFKWcdwkd6UWmoLPrzYzv1zc4eT1HcLL+z5QdsBoo7GYGpKimFQWb36i
         /WgHs/fR6WtiPSLp7qn3itTeY+L5M4UEYSm5dWTuwYgcoNsp5uygsOFoYbFube/qmiBc
         Xl7V+PSoWRItKQPVE2Mryx+nFmhWH4znZbG3C0ARA8ALO4VR0Lp6lMB9KFpzgJt886YH
         lFZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 115/156] xfs: Properly retry failed dquot items in case of error during buffer writeback
Date: Fri,  2 Feb 2018 17:58:16 +0100
Message-Id: <20180202140845.374368195@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309635796993610?=
X-GMAIL-MSGID: =?utf-8?q?1591310066656528143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Maiolino <cmaiolino@redhat.com>


[ Upstream commit 373b0589dc8d58bc09c9a28d03611ae4fb216057 ]

Once the inode item writeback errors is already fixed, it's time to fix the same
problem in dquot code.

Although there were no reports of users hitting this bug in dquot code (at least
none I've seen), the bug is there and I was already planning to fix it when the
correct approach to fix the inodes part was decided.

This patch aims to fix the same problem in dquot code, regarding failed buffers
being unable to be resubmitted once they are flush locked.

Tested with the recently test-case sent to fstests list by Hou Tao.

Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_dquot.c      |   14 +++++++++++---
 fs/xfs/xfs_dquot_item.c |   40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 5 deletions(-)

--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -987,14 +987,22 @@ xfs_qm_dqflush_done(
 	 * holding the lock before removing the dquot from the AIL.
 	 */
 	if ((lip->li_flags & XFS_LI_IN_AIL) &&
-	    lip->li_lsn == qip->qli_flush_lsn) {
+	    ((lip->li_lsn == qip->qli_flush_lsn) ||
+	     (lip->li_flags & XFS_LI_FAILED))) {
 
 		/* xfs_trans_ail_delete() drops the AIL lock. */
 		spin_lock(&ailp->xa_lock);
-		if (lip->li_lsn == qip->qli_flush_lsn)
+		if (lip->li_lsn == qip->qli_flush_lsn) {
 			xfs_trans_ail_delete(ailp, lip, SHUTDOWN_CORRUPT_INCORE);
-		else
+		} else {
+			/*
+			 * Clear the failed state since we are about to drop the
+			 * flush lock
+			 */
+			if (lip->li_flags & XFS_LI_FAILED)
+				xfs_clear_li_failed(lip);
 			spin_unlock(&ailp->xa_lock);
+		}
 	}
 
 	/*
--- a/fs/xfs/xfs_dquot_item.c
+++ b/fs/xfs/xfs_dquot_item.c
@@ -137,6 +137,26 @@ xfs_qm_dqunpin_wait(
 	wait_event(dqp->q_pinwait, (atomic_read(&dqp->q_pincount) == 0));
 }
 
+/*
+ * Callback used to mark a buffer with XFS_LI_FAILED when items in the buffer
+ * have been failed during writeback
+ *
+ * this informs the AIL that the dquot is already flush locked on the next push,
+ * and acquires a hold on the buffer to ensure that it isn't reclaimed before
+ * dirty data makes it to disk.
+ */
+STATIC void
+xfs_dquot_item_error(
+	struct xfs_log_item	*lip,
+	struct xfs_buf		*bp)
+{
+	struct xfs_dquot	*dqp;
+
+	dqp = DQUOT_ITEM(lip)->qli_dquot;
+	ASSERT(!completion_done(&dqp->q_flush));
+	xfs_set_li_failed(lip, bp);
+}
+
 STATIC uint
 xfs_qm_dquot_logitem_push(
 	struct xfs_log_item	*lip,
@@ -144,13 +164,28 @@ xfs_qm_dquot_logitem_push(
 					      __acquires(&lip->li_ailp->xa_lock)
 {
 	struct xfs_dquot	*dqp = DQUOT_ITEM(lip)->qli_dquot;
-	struct xfs_buf		*bp = NULL;
+	struct xfs_buf		*bp = lip->li_buf;
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
 	if (atomic_read(&dqp->q_pincount) > 0)
 		return XFS_ITEM_PINNED;
 
+	/*
+	 * The buffer containing this item failed to be written back
+	 * previously. Resubmit the buffer for IO
+	 */
+	if (lip->li_flags & XFS_LI_FAILED) {
+		if (!xfs_buf_trylock(bp))
+			return XFS_ITEM_LOCKED;
+
+		if (!xfs_buf_resubmit_failed_buffers(bp, lip, buffer_list))
+			rval = XFS_ITEM_FLUSHING;
+
+		xfs_buf_unlock(bp);
+		return rval;
+	}
+
 	if (!xfs_dqlock_nowait(dqp))
 		return XFS_ITEM_LOCKED;
 
@@ -242,7 +277,8 @@ static const struct xfs_item_ops xfs_dqu
 	.iop_unlock	= xfs_qm_dquot_logitem_unlock,
 	.iop_committed	= xfs_qm_dquot_logitem_committed,
 	.iop_push	= xfs_qm_dquot_logitem_push,
-	.iop_committing = xfs_qm_dquot_logitem_committing
+	.iop_committing = xfs_qm_dquot_logitem_committing,
+	.iop_error	= xfs_dquot_item_error
 };
 
 /*
