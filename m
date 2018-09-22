Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C115C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88C820870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88C820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392113AbeIVGPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:15:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44166 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391936AbeIVGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:46 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BW-6s; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000ts-Ug; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Chinner" <dchinner@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>, "Wen Xu" <wen.xu@gatech.edu>,
        "Carlos Maiolino" <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.534061407@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 52/63] xfs: validate cached inodes are free when
 allocated
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

commit afca6c5b2595fc44383919fba740c194b0b76aff upstream.

A recent fuzzed filesystem image cached random dcache corruption
when the reproducer was run. This often showed up as panics in
lookup_slow() on a null inode->i_ops pointer when doing pathwalks.

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
....
Call Trace:
 lookup_slow+0x44/0x60
 walk_component+0x3dd/0x9f0
 link_path_walk+0x4a7/0x830
 path_lookupat+0xc1/0x470
 filename_lookup+0x129/0x270
 user_path_at_empty+0x36/0x40
 path_listxattr+0x98/0x110
 SyS_listxattr+0x13/0x20
 do_syscall_64+0xf5/0x280
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

but had many different failure modes including deadlocks trying to
lock the inode that was just allocated or KASAN reports of
use-after-free violations.

The cause of the problem was a corrupt INOBT on a v4 fs where the
root inode was marked as free in the inobt record. Hence when we
allocated an inode, it chose the root inode to allocate, found it in
the cache and re-initialised it.

We recently fixed a similar inode allocation issue caused by inobt
record corruption problem in xfs_iget_cache_miss() in commit
ee457001ed6c ("xfs: catch inode allocation state mismatch
corruption"). This change adds similar checks to the cache-hit path
to catch it, and turns the reproducer into a corruption shutdown
situation.

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-Off-By: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
[darrick: fix typos in comment]
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
[bwh: Backported to 3.16:
 - Look up mode in XFS inode, not VFS inode
 - Use positive error codes, and EIO instead of EFSCORRUPTED]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/xfs/xfs_icache.c | 73 +++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 25 deletions(-)

--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -133,6 +133,46 @@ xfs_inode_free(
 }
 
 /*
+ * If we are allocating a new inode, then check what was returned is
+ * actually a free, empty inode. If we are not allocating an inode,
+ * then check we didn't find a free inode.
+ *
+ * Returns:
+ *	0		if the inode free state matches the lookup context
+ *	ENOENT		if the inode is free and we are not allocating
+ *	EFSCORRUPTED	if there is any state mismatch at all
+ */
+static int
+xfs_iget_check_free_state(
+	struct xfs_inode	*ip,
+	int			flags)
+{
+	if (flags & XFS_IGET_CREATE) {
+		/* should be a free inode */
+		if (ip->i_d.di_mode != 0) {
+			xfs_warn(ip->i_mount,
+"Corruption detected! Free inode 0x%llx not marked free! (mode 0x%x)",
+				ip->i_ino, ip->i_d.di_mode);
+			return EIO;
+		}
+
+		if (ip->i_d.di_nblocks != 0) {
+			xfs_warn(ip->i_mount,
+"Corruption detected! Free inode 0x%llx has blocks allocated!",
+				ip->i_ino);
+			return EIO;
+		}
+		return 0;
+	}
+
+	/* should be an allocated inode */
+	if (ip->i_d.di_mode == 0)
+		return ENOENT;
+
+	return 0;
+}
+
+/*
  * Check the validity of the inode we just found it the cache
  */
 static int
@@ -181,12 +221,12 @@ xfs_iget_cache_hit(
 	}
 
 	/*
-	 * If lookup is racing with unlink return an error immediately.
+	 * Check the inode free state is valid. This also detects lookup
+	 * racing with unlinks.
 	 */
-	if (ip->i_d.di_mode == 0 && !(flags & XFS_IGET_CREATE)) {
-		error = ENOENT;
+	error = xfs_iget_check_free_state(ip, flags);
+	if (error)
 		goto out_error;
-	}
 
 	/*
 	 * If IRECLAIMABLE is set, we've torn down the VFS inode already.
@@ -295,29 +335,12 @@ xfs_iget_cache_miss(
 
 
 	/*
-	 * If we are allocating a new inode, then check what was returned is
-	 * actually a free, empty inode. If we are not allocating an inode,
-	 * the check we didn't find a free inode.
+	 * Check the inode free state is valid. This also detects lookup
+	 * racing with unlinks.
 	 */
-	if (flags & XFS_IGET_CREATE) {
-		if (ip->i_d.di_mode != 0) {
-			xfs_warn(mp,
-"Corruption detected! Free inode 0x%llx not marked free on disk",
-				ino);
-			error = EIO;
-			goto out_destroy;
-		}
-		if (ip->i_d.di_nblocks != 0) {
-			xfs_warn(mp,
-"Corruption detected! Free inode 0x%llx has blocks allocated!",
-				ino);
-			error = EIO;
-			goto out_destroy;
-		}
-	} else if (ip->i_d.di_mode == 0) {
-		error = ENOENT;
+	error = xfs_iget_check_free_state(ip, flags);
+	if (error)
 		goto out_destroy;
-	}
 
 	/*
 	 * Preload the radix tree so we can insert safely under the

