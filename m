Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938575AbeE1MDf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423280AbeE1LGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carlos Maiolino <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 060/272] Force log to disk before reading the AGF during a fstrim
Date: Mon, 28 May 2018 12:01:33 +0200
Message-Id: <20180528100245.937025017@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Maiolino <cmaiolino@redhat.com>

[ Upstream commit 8c81dd46ef3c416b3b95e3020fb90dbd44e6140b ]

Forcing the log to disk after reading the agf is wrong, we might be
calling xfs_log_force with XFS_LOG_SYNC with a metadata lock held.

This can cause a deadlock when racing a fstrim with a filesystem
shutdown.

The deadlock has been identified due a miscalculation bug in device-mapper
dm-thin, which returns lack of space to its users earlier than the device itself
really runs out of space, changing the device-mapper volume into an error state.

The problem happened while filling the filesystem with a single file,
triggering the bug in device-mapper, consequently causing an IO error
and shutting down the filesystem.

If such file is removed, and fstrim executed before the XFS finishes the
shut down process, the fstrim process will end up holding the buffer
lock, and going to sleep on the cil wait queue.

At this point, the shut down process will try to wake up all the threads
waiting on the cil wait queue, but for this, it will try to hold the
same buffer log already held my the fstrim, locking up the filesystem.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_discard.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -50,19 +50,19 @@ xfs_trim_extents(
 
 	pag = xfs_perag_get(mp, agno);
 
-	error = xfs_alloc_read_agf(mp, NULL, agno, 0, &agbp);
-	if (error || !agbp)
-		goto out_put_perag;
-
-	cur = xfs_allocbt_init_cursor(mp, NULL, agbp, agno, XFS_BTNUM_CNT);
-
 	/*
 	 * Force out the log.  This means any transactions that might have freed
-	 * space before we took the AGF buffer lock are now on disk, and the
+	 * space before we take the AGF buffer lock are now on disk, and the
 	 * volatile disk cache is flushed.
 	 */
 	xfs_log_force(mp, XFS_LOG_SYNC);
 
+	error = xfs_alloc_read_agf(mp, NULL, agno, 0, &agbp);
+	if (error || !agbp)
+		goto out_put_perag;
+
+	cur = xfs_allocbt_init_cursor(mp, NULL, agbp, agno, XFS_BTNUM_CNT);
+
 	/*
 	 * Look up the longest btree in the AGF and start with it.
 	 */
