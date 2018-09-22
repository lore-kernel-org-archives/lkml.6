Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D68ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11927208D9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11927208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392275AbeIVGPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:15:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44167 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391937AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BS-5d; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000tx-Vr; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Sandeen" <sandeen@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Eric Sandeen" <sandeen@sandeen.net>, "Xu, Wen" <wen.xu@gatech.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.901442804@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 53/63] xfs: don't call xfs_da_shrink_inode with NULL bp
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

From: Eric Sandeen <sandeen@sandeen.net>

commit bb3d48dcf86a97dc25fe9fc2c11938e19cb4399a upstream.

xfs_attr3_leaf_create may have errored out before instantiating a buffer,
for example if the blkno is out of range.  In that case there is no work
to do to remove it, and in fact xfs_da_shrink_inode will lead to an oops
if we try.

This also seems to fix a flaw where the original error from
xfs_attr3_leaf_create gets overwritten in the cleanup case, and it
removes a pointless assignment to bp which isn't used after this.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199969
Reported-by: Xu, Wen <wen.xu@gatech.edu>
Tested-by: Xu, Wen <wen.xu@gatech.edu>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/xfs/xfs_attr_leaf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/xfs/xfs_attr_leaf.c
+++ b/fs/xfs/xfs_attr_leaf.c
@@ -701,9 +701,8 @@ xfs_attr_shortform_to_leaf(xfs_da_args_t
 	ASSERT(blkno == 0);
 	error = xfs_attr3_leaf_create(args, blkno, &bp);
 	if (error) {
-		error = xfs_da_shrink_inode(args, 0, bp);
-		bp = NULL;
-		if (error)
+		/* xfs_attr3_leaf_create may not have instantiated a block */
+		if (bp && (xfs_da_shrink_inode(args, 0, bp) != 0))
 			goto out;
 		xfs_idata_realloc(dp, size, XFS_ATTR_FORK);	/* try to put */
 		memcpy(ifp->if_u1.if_data, tmpbuffer, size);	/* it back */

