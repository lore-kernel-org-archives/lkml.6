Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60D0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6E7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966683AbeFSPfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:35:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966516AbeFSPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:35:08 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MFsZi-1fSXEc41Di-00Er8q; Tue, 19 Jun 2018 17:35:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hpfs: extend gmt_to_local() conversion to 64-bit times
Date:   Tue, 19 Jun 2018 17:34:51 +0200
Message-Id: <20180619153502.3636500-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fGPtedqSGjN7r9jqb51MAANA0w67te4o3Hahu5DAWBWp7O7+QU/
 JTFtQXJuizfdzIobv1+qCigU78DfcZJEyTbAKs59/VPdPfAPSWYWXaCJbVrUn451v88sTMe
 rGVTVxQjbg5zY1mPvNdIPsW8tI4U1wGAF01834HcsHd8S4I+PZ/4KbIH6JR3DocE9iCkj5O
 r6Lxladb1bHQ+yxlCLcpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Iy6aejMAkc=:KfIrYTwW613mB2Z+xpLqAX
 sC/le+3NJdlHHh+6c+scKhf6O7bJEuT82aEliCqAWrtiG2b3OWJRDJC+WgQhlU1Mjxk2gpm3Y
 wpgSwbJqFmBTQcOwYhKUhWRNd586lskzvhVn9i5YfW2H15KcMpFaw7Rg1PMe3y/omN/C7PX6L
 SRoYwAUCblhGSlhcEwlryxzbgoFkihs/hq8qNKi441bUe/R4i+CrXSdJjuNKLuq7WONGuAdRd
 9tK7PdFiRQ1CoRzQKlSoAEA4VVAIOr7bZQBbZXKc1mrrXQzxZQk2Suiu1QZ//4hWp9DnpshaJ
 r3Pq0EiFhCBWkAosLYoVIzwwYbtrjKkC3Dny4ZXOZ8q133L5HGafqzyTaJjgTyEuStPwjUDVU
 oKl4nJ8VgaexpRvFxU0Iuq6x4nZ1HbDMWJIe7roua2gpsM22SbZ+zDt4eH0aCmtfPTY0kyW9H
 ilheLwupJuuNlW6j4EnSgUuEwoA09uqTQ5JQy1MasjO0WUQDFnjFEbLgXYEwyPqGcG7KyJCUv
 JlkQo1Gve2kmBCkp7n7nNyGIXSsNI2HD0I5DivRI/BRvvm+ar0/W5fv5PR+Rl2d46vJW713Sc
 eOyD60kL/58PTVOeUAHxa47G2rO7iuxOFobereLKYQy2RFDpow6ABrdDBHLgsUsiGxiLbGYSj
 cdjUVeB2mSeBcqRvTTx5D8XrHWBzLHrrJcJ/ieFT7eI9lEaPEqzW47i5prlszwMXUSEg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFS timestamps are all 64-bit now, the only missing piece for
hpfs is the internal conversion function. One interesting bit about
hpfs is that it can already deal with moving the 136 year window of
its timestamps to support a much wider range than other file systems
with 32-bit timestamps. It also treats the timestamps as 'unsigned'
on 64-bit architectures (but signed on 32-bit, because time_t always
around to negative numbers in 2038).

Changing the conversion to use time64_t makes 32-bit architectures
behave the same way as 64-bit. For completeness, this also adds
a clamp_t call for each conversion, so we don't wrap the timestamps
but instead stay within the [0..U32_MAX] range of the on-disk
timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hpfs/hpfs_fn.h | 13 ++++++++++---
 fs/hpfs/namei.c   | 12 ++++++------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index 2a153aed4c19..ab2e7cc2ff33 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -334,16 +334,23 @@ long hpfs_ioctl(struct file *file, unsigned cmd, unsigned long arg);
  * local time (HPFS) to GMT (Unix)
  */
 
-static inline time_t local_to_gmt(struct super_block *s, time32_t t)
+static inline time64_t local_to_gmt(struct super_block *s, time32_t t)
 {
 	extern struct timezone sys_tz;
 	return t + sys_tz.tz_minuteswest * 60 + hpfs_sb(s)->sb_timeshift;
 }
 
-static inline time32_t gmt_to_local(struct super_block *s, time_t t)
+static inline time32_t gmt_to_local(struct super_block *s, time64_t t)
 {
 	extern struct timezone sys_tz;
-	return t - sys_tz.tz_minuteswest * 60 - hpfs_sb(s)->sb_timeshift;
+	t = t - sys_tz.tz_minuteswest * 60 - hpfs_sb(s)->sb_timeshift;
+
+	return clamp_t(time64_t, t, 0, U32_MAX);
+}
+
+static inline time32_t local_get_seconds(struct super_block *s)
+{
+	return gmt_to_local(s, ktime_get_real_seconds());
 }
 
 /*
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index a3615e4c730d..082b7c76dd0c 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -11,7 +11,7 @@
 
 static void hpfs_update_directory_times(struct inode *dir)
 {
-	time_t t = get_seconds();
+	time64_t t = local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
 	if (t == dir->i_mtime.tv_sec &&
 	    t == dir->i_ctime.tv_sec)
 		return;
@@ -50,7 +50,7 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	/*dee.archive = 0;*/
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 	result = new_inode(dir->i_sb);
 	if (!result)
 		goto bail2;
@@ -91,7 +91,7 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	dnode->root_dnode = 1;
 	dnode->up = cpu_to_le32(fno);
 	de = hpfs_add_de(dir->i_sb, dnode, "\001\001", 2, 0);
-	de->creation_date = de->write_date = de->read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	de->creation_date = de->write_date = de->read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 	if (!(mode & 0222)) de->read_only = 1;
 	de->first = de->directory = 1;
 	/*de->hidden = de->system = 0;*/
@@ -151,7 +151,7 @@ static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 
 	result = new_inode(dir->i_sb);
 	if (!result)
@@ -238,7 +238,7 @@ static int hpfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, de
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 
 	result = new_inode(dir->i_sb);
 	if (!result)
@@ -314,7 +314,7 @@ static int hpfs_symlink(struct inode *dir, struct dentry *dentry, const char *sy
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 
 	result = new_inode(dir->i_sb);
 	if (!result)
-- 
2.9.0

