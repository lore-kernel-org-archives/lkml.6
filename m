Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACE3ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3B12157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3B12157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbeIVGMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:12:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44320 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392009AbeIVGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Ve1-0008BQ-2G; Sat, 22 Sep 2018 01:19:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000rX-R8; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Sandeen" <sandeen@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.622870092@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 23/63] xfs: set format back to extents if
 xfs_bmap_extents_to_btree
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

From: Eric Sandeen <sandeen@redhat.com>

commit 2c4306f719b083d17df2963bc761777576b8ad1b upstream.

If xfs_bmap_extents_to_btree fails in a mode where we call
xfs_iroot_realloc(-1) to de-allocate the root, set the
format back to extents.

Otherwise we can assume we can dereference ifp->if_broot
based on the XFS_DINODE_FMT_BTREE format, and crash.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199423
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
[bwh: Backported to 3.16:
 - Only one failure path needs to be patched
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/xfs/xfs_bmap.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/xfs/xfs_bmap.c
+++ b/fs/xfs/xfs_bmap.c
@@ -822,6 +822,8 @@ xfs_bmap_extents_to_btree(
 	*logflagsp = 0;
 	if ((error = xfs_alloc_vextent(&args))) {
 		xfs_iroot_realloc(ip, -1, whichfork);
+		ASSERT(ifp->if_broot == NULL);
+		XFS_IFORK_FMT_SET(ip, whichfork, XFS_DINODE_FMT_EXTENTS);
 		xfs_btree_del_cursor(cur, XFS_BTREE_ERROR);
 		return error;
 	}

