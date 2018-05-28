Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162693AbeE1Kjs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162664AbeE1Kjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:39:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 299/329] gfs2: Fix fallocate chunk size
Date: Mon, 28 May 2018 12:03:48 +0200
Message-Id: <20180528100306.257398763@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 174d1232ebc84fcde8f5889d1171c9c7e74a10a7 ]

The chunk size of allocations in __gfs2_fallocate is calculated
incorrectly.  The size can collapse, causing __gfs2_fallocate to
allocate one block at a time, which is very inefficient.  This needs
fixing in two places:

In gfs2_quota_lock_check, always set ap->allowed to UINT_MAX to indicate
that there is no quota limit.  This fixes callers that rely on
ap->allowed to be set even when quotas are off.

In __gfs2_fallocate, reset max_blks to UINT_MAX in each iteration of the
loop to make sure that allocation limits from one resource group won't
spill over into another resource group.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/file.c  |    5 +++--
 fs/gfs2/quota.h |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -801,7 +801,7 @@ static long __gfs2_fallocate(struct file
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_alloc_parms ap = { .aflags = 0, };
 	unsigned int data_blocks = 0, ind_blocks = 0, rblocks;
-	loff_t bytes, max_bytes, max_blks = UINT_MAX;
+	loff_t bytes, max_bytes, max_blks;
 	int error;
 	const loff_t pos = offset;
 	const loff_t count = len;
@@ -853,7 +853,8 @@ static long __gfs2_fallocate(struct file
 			return error;
 		/* ap.allowed tells us how many blocks quota will allow
 		 * us to write. Check if this reduces max_blks */
-		if (ap.allowed && ap.allowed < max_blks)
+		max_blks = UINT_MAX;
+		if (ap.allowed)
 			max_blks = ap.allowed;
 
 		error = gfs2_inplace_reserve(ip, &ap);
--- a/fs/gfs2/quota.h
+++ b/fs/gfs2/quota.h
@@ -45,6 +45,8 @@ static inline int gfs2_quota_lock_check(
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	int ret;
+
+	ap->allowed = UINT_MAX; /* Assume we are permitted a whole lot */
 	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
 		return 0;
 	ret = gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
