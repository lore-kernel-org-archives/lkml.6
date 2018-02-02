Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeBBKkS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:40:18 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:46399 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751656AbeBBKkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:40:11 -0500
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] ext4: report delalloc reserve as non-free in statfs mangled
 by project quota
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>, Li Xi <lixi@ddn.com>,
        Jan Kara <jack@suse.cz>
Date: Fri, 02 Feb 2018 13:40:05 +0300
Message-ID: <151756800585.979296.13086151972011935611.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reserved space isn't committed yet but cannot be used for allocations.
For userspace it has no difference from used space. XFS already does this.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 689c958cbe6b ("ext4: add project quota support")
---
 fs/ext4/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5de959fb0244..13ce97b9e820 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5227,7 +5227,8 @@ static int ext4_statfs_project(struct super_block *sb,
 		 dquot->dq_dqb.dqb_bsoftlimit :
 		 dquot->dq_dqb.dqb_bhardlimit) >> sb->s_blocksize_bits;
 	if (limit && buf->f_blocks > limit) {
-		curblock = dquot->dq_dqb.dqb_curspace >> sb->s_blocksize_bits;
+		curblock = (dquot->dq_dqb.dqb_curspace +
+			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
 		buf->f_blocks = limit;
 		buf->f_bfree = buf->f_bavail =
 			(buf->f_blocks > curblock) ?
