Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423118AbeE1LKY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423874AbeE1LKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 136/272] gfs2: Check for the end of metadata in punch_hole
Date: Mon, 28 May 2018 12:02:49 +0200
Message-Id: <20180528100252.485338569@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit bb491ce67aa7c1635e5ae4f2f304a7d13d3dbe71 ]

When punching a hole or truncating an inode down to a given size, also
check if the truncate point / start of the hole is within the range we
have metadata for.  Otherwise, we can end up freeing blocks that
shouldn't be freed, corrupting the inode, or crashing the machine when
trying to punch a hole into the void.

When growing an inode via truncate, we set the new size but we don't
allocate additional levels of indirect blocks and grow the inode height.
When shrinking that inode again, the new size may still point beyond the
end of the inode's metadata.

Fixes xfstest generic/476.

Debugged-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/bmap.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1344,6 +1344,7 @@ static inline bool walk_done(struct gfs2
 static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	u64 maxsize = sdp->sd_heightsize[ip->i_height];
 	struct metapath mp = {};
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
@@ -1359,6 +1360,14 @@ static int punch_hole(struct gfs2_inode
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
+	if (offset >= maxsize) {
+		/*
+		 * The starting point lies beyond the allocated meta-data;
+		 * there are no blocks do deallocate.
+		 */
+		return 0;
+	}
+
 	/*
 	 * The start position of the hole is defined by lblock, start_list, and
 	 * start_aligned.  The end position of the hole is defined by lend,
@@ -1372,7 +1381,6 @@ static int punch_hole(struct gfs2_inode
 	 */
 
 	if (length) {
-		u64 maxsize = sdp->sd_heightsize[ip->i_height];
 		u64 end_offset = offset + length;
 		u64 lend;
 
