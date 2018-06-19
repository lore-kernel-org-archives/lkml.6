Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543C4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174A7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174A7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966894AbeFSPsM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:48:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966449AbeFSPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:48:04 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MRkrZ-1fbfaS2sq9-00SzlG; Tue, 19 Jun 2018 17:47:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Evgeniy Dushistov <dushistov@mail.ru>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: use ktime_get_real_seconds for sb and cg timestamps
Date:   Tue, 19 Jun 2018 17:47:21 +0200
Message-Id: <20180619154752.3768171-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:RcM+QfwdBeq949+6u50fOIxb1aBtCUmanrohmosvY4+ZIkJjVq4
 NwmgKhhRY16g1lQVigDgR7HB6y2tYbsvLde7xEJDYqCn0zhgOlkb6r/7N0GhynnTBRdGqum
 7KMZ3Fpe2dSuVlckmO7KC3OkIcJREd91j6VGQfje1W4fwmQGoo3bf3jkqSVrP2DigSEh3uD
 B39gx9td03LryO8OKaV6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uySgg7QRfg4=:1bFj5yiByloBpajtkH0JIC
 U84ajq8SSCac2i49Y4dA6KXFIhCBIo5WA6+Lq9URh+P3Ai6pPiI0XH4G0QXoOHMQBGBuCGe6i
 cuIq7aBiNjGu+Xk5nzAG8CelGB2JLwLQGLM2pHovrpM1ILxnA0nVuE77nsVmAmu1AhajTNAFn
 kCx2GI+UDIISmDy7gMl71uDG8ZGz8vKr2GAop5S2wDUp7QqsNyqpm8+BU0X2hjTOgO8boXByZ
 fWEG42CXC668wq0yjl7ESuByYXWugcgcJB4Eih+eOiAPrZNONxbgnS80+Q5b8heBKnAmy/9bm
 vPO1FzQqAue6Nyc97HJfk4Q5fa6T8CUhweIlyGmZwAi8gHPdwYAuFczRye1hZuEkWBimgnduU
 IYSjm+ZraJgSJzI82ybLqKJx1EuBeVeNalrUALy5B3EwYn0zwL0lD1OQHLmS6JOk9a9Bw3xxe
 aeOaij/yE3sw/aejuq+SS5SrHLuSEgoRKrQ0YE5IGuxbFFIzxNUYaiTysnn6JFCq9rDZ/qktm
 +6Lki5S9S7c4XyIQEfZcre06mT0OmSFtu/RhOlKb3QZU2Jn+pimJefEXBZRcfWcLBcvQ8Lv9W
 R1YkrMzeDrL7irfjWeADsyz9jJoeFvklf1k9HrNGb19zEL7r3BBFtHr6lxwcVjCvwFPpwQ/ex
 LOmFkH5bIHbao1Liqy/PeuQHXNobZY4F7EL4oWogPTEQDDZMQA0cTN/p3bUZ9J/re/Cc=
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
index 488088141451..a4e07e910f1b 100644
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
@@ -1342,7 +1342,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
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

