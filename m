Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0911ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8121F206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8121F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeGRM2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:28:08 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45381 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeGRM2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:28:08 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MUjoe-1fY6V828xY-00YAUg; Wed, 18 Jul 2018 13:50:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     akpm@linux-foundation.org, Evgeniy Dushistov <dushistov@mail.ru>
Cc:     viro@zeniv.linux.org.uk, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        David Windsor <dave@nullcore.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [RESEND] ufs: use ktime_get_real_seconds for sb and cg timestamps
Date:   Wed, 18 Jul 2018 13:49:24 +0200
Message-Id: <20180718115017.742609-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:uzKXm1YigPEMvmdjHlAyGCUK5yH9uK2elhy5sLfEGSW6oMXuGv7
 NED5zFxCWkbLOAbWUCE+4sIHOVuGY/y3Wr3lbvCzIKiX6Q1HBcQu94NcuYJjDu0fXPdgBg3
 hPC0dn/zyq7lMUGBQBsQxm3wFrUNcOR36iKycDn0KHVZasgQvN+F9hScsyJ6F8pHB/mFxso
 O74XPLbK/mx20+SlodhDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WE5naEZegOY=:aWCsXwLuHdd44LJvqwk7ml
 M34TTDLnmeed8ldeN1YEEUTAohHGG4K8LvA101QFKfxWr8p8qx/DhfYHWffrBM7eTZKPYlaHn
 mTWt3VI8uMC+hNci9JLKPd0cosQuk1au5ZizNE3SL3fLJB8fAsNBzZJZP7pdo5vma36Z9ZYsx
 JX3habK0fYs2bcSRFUPu+qqnCsUGv3VZX5VigXye4sQyMbzYSudgqCMwTuAyM0JauPJh7I2Vi
 VYSyxctxOJ+ZUj9ucgsPQhAGQuxJfRFDDAnSR8z6fXpSuT5Cz4hKFxJm9ImcJEDaypIl4ObYC
 ES6JXtbHRE9rYsKloD0Tf1oOAM1UtFK24kOeynSRdqIP9/a0Ezy00l2zghLPS4gafBaz2BhOZ
 15t2D0Nr3Bhr0feA47U1qEEiP3jaStvoTfkSgrj80TE5PjmZ4i33NUUXfIVqbBymCQ47dISkn
 NwNcGDs3QPKEkh7KebfEQax+Oa51gNK7YHH+XH0u52qsx+CD9YuJMugh6DSGxnrjJ4xeEBnso
 Gjln/rdy/LIxw7UMtAEoNVc+SFlgrym0YTdzAz4GK5ryYexHymDVUw3GB1BjDxA1eu+jamuAh
 TieHrNdd+V3z4wh9ozMkE1Xru5O90OPEpUuyH4vcZes18hx7/HEzNoYI+3ypaBzgSDXMXk81Y
 h1l+m4M7e05bBUPtupahjzugTiGA5v2xiEbZ5dc5egPYK5RNTwClY+5kg3903wzqX4dY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() is deprecated because of the 32-bit overflow and will
be removed. All callers in ufs also truncate to a 32-bit number, so
nothing changes during the conversion, but this should be harmless as the
superblock and cylinder group timestamps are not visible to user space,
except for checking the fs-dirty state, wich works fine across the
overflow.

This moves the call to get_seconds() into a new inline function, with
a comment explaining the constraints, while converting it to
ktime_get_real_seconds().

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent on June 19, got an Ack but nobody picked up the
patch.
---
 fs/ufs/balloc.c |  4 ++--
 fs/ufs/ialloc.c |  2 +-
 fs/ufs/super.c  |  4 ++--
 fs/ufs/util.h   | 14 ++++++++++++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index e727ee07dbe4..075d3d9114c8 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -547,7 +547,7 @@ static u64 ufs_add_fragments(struct inode *inode, u64 fragment,
 	/*
 	 * Block can be extended
 	 */
-	ucg->cg_time = cpu_to_fs32(sb, get_seconds());
+	ucg->cg_time = ufs_get_seconds(sb);
 	for (i = newcount; i < (uspi->s_fpb - fragoff); i++)
 		if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_freeoff, fragno + i))
 			break;
@@ -639,7 +639,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	if (!ufs_cg_chkmagic(sb, ucg)) 
 		ufs_panic (sb, "ufs_alloc_fragments",
 			"internal error, bad magic number on cg %u", cgno);
-	ucg->cg_time = cpu_to_fs32(sb, get_seconds());
+	ucg->cg_time = ufs_get_seconds(sb);
 
 	if (count == uspi->s_fpb) {
 		result = ufs_alloccg_block (inode, ucpi, goal, err);
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index e1ef0f0a1353..c678fff2a04d 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -89,7 +89,7 @@ void ufs_free_inode (struct inode * inode)
 	if (!ufs_cg_chkmagic(sb, ucg))
 		ufs_panic (sb, "ufs_free_fragments", "internal error, bad cg magic number");
 
-	ucg->cg_time = cpu_to_fs32(sb, get_seconds());
+	ucg->cg_time = ufs_get_seconds(sb);
 
 	is_directory = S_ISDIR(inode->i_mode);
 
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 96a20a76e3c4..f48a5b802221 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -698,7 +698,7 @@ static int ufs_sync_fs(struct super_block *sb, int wait)
 	usb1 = ubh_get_usb_first(uspi);
 	usb3 = ubh_get_usb_third(uspi);
 
-	usb1->fs_time = cpu_to_fs32(sb, get_seconds());
+	usb1->fs_time = ufs_get_seconds(sb);
 	if ((flags & UFS_ST_MASK) == UFS_ST_SUN  ||
 	    (flags & UFS_ST_MASK) == UFS_ST_SUNOS ||
 	    (flags & UFS_ST_MASK) == UFS_ST_SUNx86)
@@ -1344,7 +1344,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags,
 	 */
 	if (*mount_flags & SB_RDONLY) {
 		ufs_put_super_internal(sb);
-		usb1->fs_time = cpu_to_fs32(sb, get_seconds());
+		usb1->fs_time = ufs_get_seconds(sb);
 		if ((flags & UFS_ST_MASK) == UFS_ST_SUN
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNOS
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86) 
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1907be6d5808..1fd3011ea623 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -590,3 +590,17 @@ static inline int ufs_is_data_ptr_zero(struct ufs_sb_private_info *uspi,
 	else
 		return *(__fs32 *)p == 0;
 }
+
+static inline __fs32 ufs_get_seconds(struct super_block *sbp)
+{
+	time64_t now = ktime_get_real_seconds();
+
+	/* Signed 32-bit interpretation wraps around in 2038, which
+	 * happens in ufs1 inode stamps but not ufs2 using 64-bits
+	 * stamps. For superblock and blockgroup, let's assume
+	 * unsigned 32-bit stamps, which are good until y2106.
+	 * Wrap around rather than clamp here to make the dirty
+	 * file system detection work in the superblock stamp.
+	 */
+	return cpu_to_fs32(sbp, lower_32_bits(now));
+}
-- 
2.9.0

