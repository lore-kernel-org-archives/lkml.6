Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70ABC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92CE20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92CE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFTOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:33:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeFTOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:32:58 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LcC9p-1fxWBE0ODV-00jbe3; Wed, 20 Jun 2018 16:32:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jan Kara <jack@suse.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext2: use ktime_get_real_seconds for timestamps
Date:   Wed, 20 Jun 2018 16:31:40 +0200
Message-Id: <20180620143203.42225-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:zL4mtlEOqtr9Q0vYs1tK9U4Ty4YLduzUOETI8BLVFwW4zHQ8sMj
 mEARG8mhv+zDQAEOgEQ9MQUmy1E1tu9r39Wm2Zwpr2BMwU5oq491PnQ+85DUrVS6+/6Q1xX
 Fiu/W27xWQgS38FFljnw6M+7ylOJNwvTzy++dg9jTW3S+IAvaFFi2KG2VYtdhw61LARlMs5
 R8dOEr5xCGwmrCdRV2Y1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ccxAz5qrY8=:fWCY7dlzBtjyHUJRK7xGE3
 CIrLN1tmyP4YL5l/Mk44RCxpxAaB/G9Vy+WUfOA/Uf2uDVGqtOpgdNsOdTvBX5IgLnjToDThu
 U7Nn7E2/qNB1a+qhYGkd4RoxYIZgRlKGO/LZ+qaVnf2uzHsa/utz/YnhkYeHxy3iN5vTRAwFu
 Qc9881T6T1f2lDK9BVsAXNPOwEZtsJJ7iAY189LcFq2VmvBaWY+Lj15Zgf/uOe60AiyGbAaNR
 x9rABlDvL9UU5hs8sr53UTE8nzqlHLKRTKa6/L5gZTRUdynj6DmO1fSr1ire5WSfhK1ZXtXwK
 SvRpkiP+39MDSV83f0SQtiriX7QdJ7Sg1/CNiG+P2M77KU1anfD0LNW7PWtZGGrNxrBSpAkmI
 O1yIccGa3weCJflKmQW4fRgI24isECl3GqX1vA7Qijb2YBYggGPtjTmD9OZNEoKbhZPbLe1PQ
 T0QG9ke4bAzPvE8Yt7/8t2/r2r015VBx8nOauOyc/RDU/nYSzfSgRRBAgtT7o7FxXyYCug9LX
 KEgLruK/t8KH+R7O+AWAz6RQLrC5gMJDJSxhGrgZbrYUiHNw9ZufM4Y3J5X2Zk3X1+eCxxQTc
 RAP12ZRQJUE54yQeKijwgCbis6AulhLNLtGDvXXBHBBlz9l/an8X2zKl6obE53mjQa5gjslzd
 YlANbFSDL693U78/PdRO/tic5kjjIM0uVU5OYEX4OKYihJmqh1U66UwEIVvNNaDyD3jg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() is deprecated because of the y2038 overflow, so users
should migrate to 64-bit timestamps using ktime_get_real_seconds().
In ext2, the timestamps in the superblock and in the inode are all
limited to 32-bit, and this won't get fixed, so let's just stop
using the deprecated interface and keep truncating.

All users of ext2 should migrate to ext4 before 2038 to prevent this
from causing problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext2/inode.c | 2 +-
 fs/ext2/super.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 71635909df3b..7f7ee18fe179 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -86,7 +86,7 @@ void ext2_evict_inode(struct inode * inode)
 	if (want_delete) {
 		sb_start_intwrite(inode->i_sb);
 		/* set dtime */
-		EXT2_I(inode)->i_dtime	= get_seconds();
+		EXT2_I(inode)->i_dtime	= ktime_get_real_seconds();
 		mark_inode_dirty(inode);
 		__ext2_write_inode(inode, inode_needs_sync(inode));
 		/* truncate to 0 */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 25ab1274090f..25e31afe961d 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -679,7 +679,7 @@ static int ext2_setup_super (struct super_block * sb,
 			"running e2fsck is recommended");
 	else if (le32_to_cpu(es->s_checkinterval) &&
 		(le32_to_cpu(es->s_lastcheck) +
-			le32_to_cpu(es->s_checkinterval) <= get_seconds()))
+			le32_to_cpu(es->s_checkinterval) <= ktime_get_real_seconds()))
 		ext2_msg(sb, KERN_WARNING,
 			"warning: checktime reached, "
 			"running e2fsck is recommended");
@@ -1245,7 +1245,7 @@ void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es,
 	spin_lock(&EXT2_SB(sb)->s_lock);
 	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
 	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
-	es->s_wtime = cpu_to_le32(get_seconds());
+	es->s_wtime = cpu_to_le32(ktime_get_real_seconds());
 	/* unlock before we do IO */
 	spin_unlock(&EXT2_SB(sb)->s_lock);
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
@@ -1360,7 +1360,7 @@ static int ext2_remount (struct super_block * sb, int * flags, char * data)
 		 * the rdonly flag and then mark the partition as valid again.
 		 */
 		es->s_state = cpu_to_le16(sbi->s_mount_state);
-		es->s_mtime = cpu_to_le32(get_seconds());
+		es->s_mtime = cpu_to_le32(ktime_get_real_seconds());
 		spin_unlock(&sbi->s_lock);
 
 		err = dquot_suspend(sb, -1);
-- 
2.9.0

