Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1276ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B248A208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYShcvhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B248A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeKIHpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbeKIHpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:43 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B41E208A3;
        Thu,  8 Nov 2018 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714891;
        bh=w8PbSV6nMmWy4rmWx7hQ05RUCy7//I8O6CVZQgNY05g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYShcvhJHzQARIysK8TKGAkJBMK3evOOjM9N1vhToCFRiil9y2M2PH8In1l9JVZWJ
         67WhB9gFYKMbsxotSxt8LE2OwVyC/8GPR/MrE/t1GRd+R7Jtt9DQb1/4jKvvA88/OU
         f0xcNinXM9ijFe2I9jwGxrWhbvrlyr39ClV7h0KQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 10/31] xfs: truncate transaction does not modify the inobt
Date:   Thu,  8 Nov 2018 13:52:34 -0800
Message-Id: <20181108215130.568724793@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a606ebdb859e78beb757dfefa08001df366e2ef5 ]

The truncate transaction does not ever modify the inode btree, but
includes an associated log reservation. Update
xfs_calc_itruncate_reservation() to remove the reservation
associated with inobt updates.

[Amir:	This commit was merged for kernel v4.16 and a twin commit was
	merged for xfsprogs v4.16. As a result, a small xfs filesystem
	formatted with features -m rmapbt=1,reflink=1 using mkfs.xfs
	version >= v4.16 cannot be mounted with kernel < v4.16.

	For example, xfstests generic/17{1,2,3} format a small fs and
	when trying to mount it, they fail with an assert on this very
	demonic line:

 XFS (vdc): Log size 3075 blocks too small, minimum size is 3717 blocks
 XFS (vdc): AAIEEE! Log failed size checks. Abort!
 XFS: Assertion failed: 0, file: src/linux/fs/xfs/xfs_log.c, line: 666

	The simple solution for stable kernels is to apply this patch,
	because mkfs.xfs v4.16 is already in the wild, so we have to
	assume that xfs filesystems with a "too small" log exist.
	Regardless, xfsprogs maintainers should also consider reverting
	the twin patch to stop creating those filesystems for the sake
	of users with unpatched kernels.]

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J . Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 6bd916bd35e2..48eff18c5496 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -232,8 +232,6 @@ xfs_calc_write_reservation(
  *    the super block to reflect the freed blocks: sector size
  *    worst case split in allocation btrees per extent assuming 4 extents:
  *		4 exts * 2 trees * (2 * max depth - 1) * block size
- *    the inode btree: max depth * blocksize
- *    the allocation btrees: 2 trees * (max depth - 1) * block size
  */
 STATIC uint
 xfs_calc_itruncate_reservation(
@@ -245,12 +243,7 @@ xfs_calc_itruncate_reservation(
 				      XFS_FSB_TO_B(mp, 1))),
 		    (xfs_calc_buf_res(9, mp->m_sb.sb_sectsize) +
 		     xfs_calc_buf_res(xfs_allocfree_log_count(mp, 4),
-				      XFS_FSB_TO_B(mp, 1)) +
-		    xfs_calc_buf_res(5, 0) +
-		    xfs_calc_buf_res(xfs_allocfree_log_count(mp, 1),
-				     XFS_FSB_TO_B(mp, 1)) +
-		    xfs_calc_buf_res(2 + mp->m_ialloc_blks +
-				     mp->m_in_maxlevels, 0)));
+				      XFS_FSB_TO_B(mp, 1))));
 }
 
 /*
-- 
2.17.1



