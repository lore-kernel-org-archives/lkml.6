Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D03C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D1E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D1E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966894AbeFSQAB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:00:01 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeFSP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:59:59 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Mbb9R-1fnntS12Ll-00IyXi; Tue, 19 Jun 2018 17:59:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andreas Dilger <adilger@dilger.ca>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] jffs2: use 64-bit intermediate timestamps
Date:   Tue, 19 Jun 2018 17:59:03 +0200
Message-Id: <20180619155925.4107498-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:eeKxuE4Qe5q1IB2NdpY1z+HTlGBDbAjRgdgsDvvYmIEMpgX9QDZ
 wXu2XXZrO2V4GzipYC7/avsKP1vgIYgtugK/7TPrCcwmOvyVT5qTtmF1V2n3hHHWNJ5+IgP
 BA6kgCBNBBZNnstEvRtBY94yJRO2CrrCXdmh7Ophr/Ii1AF2JyJ76BLZwJMS982/hCiPs8C
 w6WAT/EiJNquyVaSPnF7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WnXYo3caGrA=:pRS4FbaEyswuGg+QMEXrfO
 01PkDgyO+Au3G9hOtySEnHQPPAOSi+W5ZbQ6ix5pAyy5Rv8QKGzz5V1fP+3Z/jDkZO1b1f3c3
 J8fTzaL8RmgDaD5gbE4YZ9TqEyDxSySXKK7EhGhve3mk+u+SrqQNJ+QzxuSv6d4KM5+MntCuH
 bbFU3lqpE6CLajXg0CKaQIA5Gz2KGTkXxFwBUffYvM04SYurD2o+bX2/ff3mctsuM494fW7as
 Dg4OJAWutcy9G5y1ccU0WArtt2gk4LBuuRo0AWp4VZB3sRqUgwwWFAu07x2fp2RCMJqgQLQws
 7S3kPccz2p8W/9zc/3KjKSVmAXM4bg1FJlJcl+o4d62Bq1k079VhRKDGo9AACmoISEviHV93v
 DVOIey7a5FhlFbfc0S9XOrBgPScBaJJy0u/AHaumevYyoV3C0Vgk8KtJLnVR1htE/64ps0gvT
 Wweqmk/VkQhXTz4cUjWQqbRhzB4ls1A6rRoTI7+2qvfRhMXhzQR0FT70SbtTUwPGC2hYdeROo
 U5aHJJGVLTnbTWwMBpStzXGdr+Py1x6otYO9cZ9XH6wId0FC9sQQF6BDbw2iEJgOkOP9zbbDs
 vnKNQHeqty0nWwWsu5mZCjAmX/OcZIbNEddgO3UlGQyLcZgXwpO8W1xbjxAe4aiYs6t9h7jt0
 fd7XoNX9ZtvKeYiBJez8sdAaFV/C4agNs0ENzJZJ+YDS9nIOYGS6EdkaYoC//3/VTY2M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFS now uses timespec64 timestamps consistently, but jffs2 still
converts them to 32-bit numbers on the storage medium. As the helper
functions for the conversion (get_seconds() and timespec_to_timespec64())
are now deprecated, let's change them over to the more modern
replacements.

This keeps the traditional interpretation of those values, where
the on-disk 32-bit numbers are taken to be negative numbers, i.e.
dates before 1970, on 32-bit machines, but future numbers past 2038
on 64-bit machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jffs2/dir.c      | 32 ++++++++++++++++----------------
 fs/jffs2/file.c     |  6 +++---
 fs/jffs2/fs.c       | 12 ++++++------
 fs/jffs2/os-linux.h |  3 ++-
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index b2944f9218f7..f20cff1194bb 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -201,7 +201,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 	if (ret)
 		goto fail;
 
-	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->ctime)));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(ri->ctime));
 
 	jffs2_free_raw_inode(ri);
 
@@ -227,14 +227,14 @@ static int jffs2_unlink(struct inode *dir_i, struct dentry *dentry)
 	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
 	struct jffs2_inode_info *dead_f = JFFS2_INODE_INFO(d_inode(dentry));
 	int ret;
-	uint32_t now = get_seconds();
+	uint32_t now = JFFS2_NOW();
 
 	ret = jffs2_do_unlink(c, dir_f, dentry->d_name.name,
 			      dentry->d_name.len, dead_f, now);
 	if (dead_f->inocache)
 		set_nlink(d_inode(dentry), dead_f->inocache->pino_nlink);
 	if (!ret)
-		dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
+		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
 	return ret;
 }
 /***********************************************************************/
@@ -260,7 +260,7 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 	type = (d_inode(old_dentry)->i_mode & S_IFMT) >> 12;
 	if (!type) type = DT_REG;
 
-	now = get_seconds();
+	now = JFFS2_NOW();
 	ret = jffs2_do_link(c, dir_f, f->inocache->ino, type, dentry->d_name.name, dentry->d_name.len, now);
 
 	if (!ret) {
@@ -268,7 +268,7 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 		set_nlink(d_inode(old_dentry), ++f->inocache->pino_nlink);
 		mutex_unlock(&f->sem);
 		d_instantiate(dentry, d_inode(old_dentry));
-		dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
+		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
 		ihold(d_inode(old_dentry));
 	}
 	return ret;
@@ -400,7 +400,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	rd->pino = cpu_to_je32(dir_i->i_ino);
 	rd->version = cpu_to_je32(++dir_f->highest_version);
 	rd->ino = cpu_to_je32(inode->i_ino);
-	rd->mctime = cpu_to_je32(get_seconds());
+	rd->mctime = cpu_to_je32(JFFS2_NOW());
 	rd->nsize = namelen;
 	rd->type = DT_LNK;
 	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
@@ -418,7 +418,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(rd->mctime)));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -543,7 +543,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	rd->pino = cpu_to_je32(dir_i->i_ino);
 	rd->version = cpu_to_je32(++dir_f->highest_version);
 	rd->ino = cpu_to_je32(inode->i_ino);
-	rd->mctime = cpu_to_je32(get_seconds());
+	rd->mctime = cpu_to_je32(JFFS2_NOW());
 	rd->nsize = namelen;
 	rd->type = DT_DIR;
 	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
@@ -561,7 +561,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(rd->mctime)));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
 	inc_nlink(dir_i);
 
 	jffs2_free_raw_dirent(rd);
@@ -588,7 +588,7 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(d_inode(dentry));
 	struct jffs2_full_dirent *fd;
 	int ret;
-	uint32_t now = get_seconds();
+	uint32_t now = JFFS2_NOW();
 
 	for (fd = f->dents ; fd; fd = fd->next) {
 		if (fd->ino)
@@ -598,7 +598,7 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	ret = jffs2_do_unlink(c, dir_f, dentry->d_name.name,
 			      dentry->d_name.len, f, now);
 	if (!ret) {
-		dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
+		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
 		clear_nlink(d_inode(dentry));
 		drop_nlink(dir_i);
 	}
@@ -712,7 +712,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	rd->pino = cpu_to_je32(dir_i->i_ino);
 	rd->version = cpu_to_je32(++dir_f->highest_version);
 	rd->ino = cpu_to_je32(inode->i_ino);
-	rd->mctime = cpu_to_je32(get_seconds());
+	rd->mctime = cpu_to_je32(JFFS2_NOW());
 	rd->nsize = namelen;
 
 	/* XXX: This is ugly. */
@@ -733,7 +733,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(rd->mctime)));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -797,7 +797,7 @@ static int jffs2_rename (struct inode *old_dir_i, struct dentry *old_dentry,
 	type = (d_inode(old_dentry)->i_mode & S_IFMT) >> 12;
 	if (!type) type = DT_REG;
 
-	now = get_seconds();
+	now = JFFS2_NOW();
 	ret = jffs2_do_link(c, JFFS2_INODE_INFO(new_dir_i),
 			    d_inode(old_dentry)->i_ino, type,
 			    new_dentry->d_name.name, new_dentry->d_name.len, now);
@@ -853,14 +853,14 @@ static int jffs2_rename (struct inode *old_dir_i, struct dentry *old_dentry,
 		 * caller won't do it on its own since we are returning an error.
 		 */
 		d_invalidate(new_dentry);
-		new_dir_i->i_mtime = new_dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
+		new_dir_i->i_mtime = new_dir_i->i_ctime = ITIME(now);
 		return ret;
 	}
 
 	if (d_is_dir(old_dentry))
 		drop_nlink(old_dir_i);
 
-	new_dir_i->i_mtime = new_dir_i->i_ctime = old_dir_i->i_mtime = old_dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
+	new_dir_i->i_mtime = new_dir_i->i_ctime = old_dir_i->i_mtime = old_dir_i->i_ctime = ITIME(now);
 
 	return 0;
 }
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 481afd4c2e1a..7d8654a1472e 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -175,7 +175,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 		ri.uid = cpu_to_je16(i_uid_read(inode));
 		ri.gid = cpu_to_je16(i_gid_read(inode));
 		ri.isize = cpu_to_je32(max((uint32_t)inode->i_size, pageofs));
-		ri.atime = ri.ctime = ri.mtime = cpu_to_je32(get_seconds());
+		ri.atime = ri.ctime = ri.mtime = cpu_to_je32(JFFS2_NOW());
 		ri.offset = cpu_to_je32(inode->i_size);
 		ri.dsize = cpu_to_je32(pageofs - inode->i_size);
 		ri.csize = cpu_to_je32(0);
@@ -283,7 +283,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 	ri->uid = cpu_to_je16(i_uid_read(inode));
 	ri->gid = cpu_to_je16(i_gid_read(inode));
 	ri->isize = cpu_to_je32((uint32_t)inode->i_size);
-	ri->atime = ri->ctime = ri->mtime = cpu_to_je32(get_seconds());
+	ri->atime = ri->ctime = ri->mtime = cpu_to_je32(JFFS2_NOW());
 
 	/* In 2.4, it was already kmapped by generic_file_write(). Doesn't
 	   hurt to do it again. The alternative is ifdefs, which are ugly. */
@@ -308,7 +308,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			inode->i_size = pos + writtenlen;
 			inode->i_blocks = (inode->i_size + 511) >> 9;
 
-			inode->i_ctime = inode->i_mtime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->ctime)));
+			inode->i_ctime = inode->i_mtime = ITIME(je32_to_cpu(ri->ctime));
 		}
 	}
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 0ecfb8ea38cd..eab04eca95a3 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -146,9 +146,9 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 		return PTR_ERR(new_metadata);
 	}
 	/* It worked. Update the inode */
-	inode->i_atime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->atime)));
-	inode->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->ctime)));
-	inode->i_mtime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->mtime)));
+	inode->i_atime = ITIME(je32_to_cpu(ri->atime));
+	inode->i_ctime = ITIME(je32_to_cpu(ri->ctime));
+	inode->i_mtime = ITIME(je32_to_cpu(ri->mtime));
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_uid_write(inode, je16_to_cpu(ri->uid));
 	i_gid_write(inode, je16_to_cpu(ri->gid));
@@ -280,9 +280,9 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	i_uid_write(inode, je16_to_cpu(latest_node.uid));
 	i_gid_write(inode, je16_to_cpu(latest_node.gid));
 	inode->i_size = je32_to_cpu(latest_node.isize);
-	inode->i_atime = timespec_to_timespec64(ITIME(je32_to_cpu(latest_node.atime)));
-	inode->i_mtime = timespec_to_timespec64(ITIME(je32_to_cpu(latest_node.mtime)));
-	inode->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(latest_node.ctime)));
+	inode->i_atime = ITIME(je32_to_cpu(latest_node.atime));
+	inode->i_mtime = ITIME(je32_to_cpu(latest_node.mtime));
+	inode->i_ctime = ITIME(je32_to_cpu(latest_node.ctime));
 
 	set_nlink(inode, f->inocache->pino_nlink);
 
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index c2fbec19c616..acbe1f722f2d 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -31,7 +31,8 @@ struct kvec;
 #define JFFS2_F_I_GID(f) (i_gid_read(OFNI_EDONI_2SFFJ(f)))
 #define JFFS2_F_I_RDEV(f) (OFNI_EDONI_2SFFJ(f)->i_rdev)
 
-#define ITIME(sec) ((struct timespec){sec, 0})
+#define ITIME(sec) ((struct timespec64){(int32_t)sec, 0})
+#define JFFS2_NOW() (ktime_get_real_seconds())
 #define I_SEC(tv) ((tv).tv_sec)
 #define JFFS2_F_I_CTIME(f) (OFNI_EDONI_2SFFJ(f)->i_ctime.tv_sec)
 #define JFFS2_F_I_MTIME(f) (OFNI_EDONI_2SFFJ(f)->i_mtime.tv_sec)
-- 
2.9.0

