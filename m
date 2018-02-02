Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ZO5HKgVBRAbHm4yC0txFCPbpo9g9MSmXasPjFVOSvOyfcD8a3+DMFEpVAOuaWcTGtKqCl
ARC-Seal: i=1; a=rsa-sha256; t=1517591129; cv=none;
        d=google.com; s=arc-20160816;
        b=tSGJDQs2i7Spj/hXwj4NJ0xPAQAEZo3bk9NR1PJyGRnJ2zlOpa1EaqTLkQSI+pDY4/
         zqlNWPgRBDPO9Ue+b8tvOrq1/jcrKKz7O8OPPIAdT5tuOqr1cqjnwFkmOgETx2BsUO+T
         r25zHIEbUj91H8xTQguA9qRkEUn0+y9GVfJ5JZ2qFBXORCfp7GwaCjjGpJBJJjAliDLh
         LtHvPLgKXRr/aBTTCgVWnvXFupWA8WO8a0aDzKlDmpPNig4cFbmfFU1lDG93K+xLTrvB
         qLi3v9IbiBYoOCUd+mE8puFAUmUI3Ii3BuLK0DGu+SOY3WZVUr3CI12m+B7zX2kWjn05
         Dt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bDjprRWQX6VVRnAfHC3gGMMsgPL5H0LhG8+NO5fs7UA=;
        b=k930klEhpuCe1c++xRxhxJuBZ+XZPUTM3lOXKi5t9nrZC30u45ewKTgga090mFoRDX
         yNFWykO/Ialhnm4KylE+vUJE9pbjqw4vQrONf5i+Oa63l+dBrqVRkGbq48jC/Ng07ASf
         XaeRhoCSJDckXAdCxObJqaWcXDdzVvw8yeNhamFP68fwbIa3ZnmgijOd1kHuFygx5Nq2
         W7WngVR9THG/fNLYg11/3QiC6el33bEp68SBI2HsAEvxYuJRd1qJFlMQMvN4h6s0BKgh
         6YpshNCjg62zMWcfcQODStcGPObl5DZhxgK4VqzPh4ZAGL18kTr0Jk1J6V6zY7OzQAeG
         0WzA==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 62/86] xfs: Properly retry failed dquot items in case of error during buffer writeback
Date: Fri,  2 Feb 2018 17:58:22 +0100
Message-Id: <20180202140828.290630135@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309635796993610?=
X-GMAIL-MSGID: =?utf-8?q?1591309635796993610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_dquot.c      |   14 +++++++++++---
 fs/xfs/xfs_dquot_item.c |   40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 5 deletions(-)

--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1004,14 +1004,22 @@ xfs_qm_dqflush_done(
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
