Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756028AbeEHS27 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:28:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755452AbeEHSFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:47 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 40/76] fs/hpfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:00 -0700
Message-Id: <20180508180436.716-41-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/hpfs/dir.c   |  76 +++++++++++++-----------
 fs/hpfs/dnode.c | 176 ++++++++++++++++++++++++++++++++------------------------
 fs/hpfs/ea.c    |   2 +-
 fs/hpfs/file.c  |  45 ++++++++-------
 fs/hpfs/inode.c |  77 +++++++++++++------------
 fs/hpfs/namei.c | 130 ++++++++++++++++++++++-------------------
 fs/hpfs/super.c |   6 +-
 7 files changed, 287 insertions(+), 225 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index c83ece7facc5..416e6e238ee4 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -12,10 +12,10 @@
 
 static int hpfs_dir_release(struct inode *inode, struct file *filp)
 {
-	hpfs_lock(inode->i_sb);
+	hpfs_lock(inode_sb(inode));
 	hpfs_del_pos(inode, &filp->f_pos);
 	/*hpfs_write_if_changed(inode);*/
-	hpfs_unlock(inode->i_sb);
+	hpfs_unlock(inode_sb(inode));
 	return 0;
 }
 
@@ -28,7 +28,7 @@ static loff_t hpfs_dir_lseek(struct file *filp, loff_t off, int whence)
 	struct quad_buffer_head qbh;
 	struct inode *i = file_inode(filp);
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
-	struct super_block *s = i->i_sb;
+	struct super_block *s = inode_sb(i);
 
 	/* Somebody else will have to figure out what to do here */
 	if (whence == SEEK_DATA || whence == SEEK_HOLE)
@@ -74,34 +74,38 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 	int c1, c2 = 0;
 	int ret = 0;
 
-	hpfs_lock(inode->i_sb);
+	hpfs_lock(inode_sb(inode));
 
-	if (hpfs_sb(inode->i_sb)->sb_chk) {
-		if (hpfs_chk_sectors(inode->i_sb, inode->i_ino, 1, "dir_fnode")) {
+	if (hpfs_sb(inode_sb(inode))->sb_chk) {
+		if (hpfs_chk_sectors(inode_sb(inode), inode->i_ino, 1, "dir_fnode")) {
 			ret = -EFSERROR;
 			goto out;
 		}
-		if (hpfs_chk_sectors(inode->i_sb, hpfs_inode->i_dno, 4, "dir_dnode")) {
+		if (hpfs_chk_sectors(inode_sb(inode), hpfs_inode->i_dno, 4, "dir_dnode")) {
 			ret = -EFSERROR;
 			goto out;
 		}
 	}
-	if (hpfs_sb(inode->i_sb)->sb_chk >= 2) {
+	if (hpfs_sb(inode_sb(inode))->sb_chk >= 2) {
 		struct buffer_head *bh;
 		struct fnode *fno;
 		int e = 0;
-		if (!(fno = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) {
+		if (!(fno = hpfs_map_fnode(inode_sb(inode), inode->i_ino, &bh))) {
 			ret = -EIOERROR;
 			goto out;
 		}
 		if (!fnode_is_dir(fno)) {
 			e = 1;
-			hpfs_error(inode->i_sb, "not a directory, fnode %08lx",
+			hpfs_error(inode_sb(inode),
+					"not a directory, fnode %08lx",
 					(unsigned long)inode->i_ino);
 		}
 		if (hpfs_inode->i_dno != le32_to_cpu(fno->u.external[0].disk_secno)) {
 			e = 1;
-			hpfs_error(inode->i_sb, "corrupted inode: i_dno == %08x, fnode -> dnode == %08x", hpfs_inode->i_dno, le32_to_cpu(fno->u.external[0].disk_secno));
+			hpfs_error(inode_sb(inode),
+				   "corrupted inode: i_dno == %08x, fnode -> dnode == %08x",
+				   hpfs_inode->i_dno,
+				   le32_to_cpu(fno->u.external[0].disk_secno));
 		}
 		brelse(bh);
 		if (e) {
@@ -109,7 +113,7 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 	}
-	lc = hpfs_sb(inode->i_sb)->sb_lowercase;
+	lc = hpfs_sb(inode_sb(inode))->sb_lowercase;
 	if (ctx->pos == 12) { /* diff -r requires this (note, that diff -r */
 		ctx->pos = 13; /* also fails on msdos filesystem in 2.0) */
 		goto out;
@@ -124,8 +128,8 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 		/* This won't work when cycle is longer than number of dirents
 		   accepted by filldir, but what can I do?
 		   maybe killall -9 ls helps */
-		if (hpfs_sb(inode->i_sb)->sb_chk)
-			if (hpfs_stop_cycles(inode->i_sb, ctx->pos, &c1, &c2, "hpfs_readdir")) {
+		if (hpfs_sb(inode_sb(inode))->sb_chk)
+			if (hpfs_stop_cycles(inode_sb(inode), ctx->pos, &c1, &c2, "hpfs_readdir")) {
 				ret = -EFSERROR;
 				goto out;
 			}
@@ -149,7 +153,7 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 			ret = hpfs_add_pos(inode, &file->f_pos);
 			if (unlikely(ret < 0))
 				goto out;
-			ctx->pos = ((loff_t) hpfs_de_as_down_as_possible(inode->i_sb, hpfs_inode->i_dno) << 4) + 1;
+			ctx->pos = ((loff_t) hpfs_de_as_down_as_possible(inode_sb(inode), hpfs_inode->i_dno) << 4) + 1;
 		}
 		next_pos = ctx->pos;
 		if (!(de = map_pos_dirent(inode, &next_pos, &qbh))) {
@@ -158,18 +162,23 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 		if (de->first || de->last) {
-			if (hpfs_sb(inode->i_sb)->sb_chk) {
+			if (hpfs_sb(inode_sb(inode))->sb_chk) {
 				if (de->first && !de->last && (de->namelen != 2
 				    || de ->name[0] != 1 || de->name[1] != 1))
-					hpfs_error(inode->i_sb, "hpfs_readdir: bad ^A^A entry; pos = %08lx", (unsigned long)ctx->pos);
+					hpfs_error(inode_sb(inode),
+						   "hpfs_readdir: bad ^A^A entry; pos = %08lx",
+						   (unsigned long)ctx->pos);
 				if (de->last && (de->namelen != 1 || de ->name[0] != 255))
-					hpfs_error(inode->i_sb, "hpfs_readdir: bad \\377 entry; pos = %08lx", (unsigned long)ctx->pos);
+					hpfs_error(inode_sb(inode),
+						   "hpfs_readdir: bad \\377 entry; pos = %08lx",
+						   (unsigned long)ctx->pos);
 			}
 			hpfs_brelse4(&qbh);
 			ctx->pos = next_pos;
 			goto again;
 		}
-		tempname = hpfs_translate_name(inode->i_sb, de->name, de->namelen, lc, de->not_8x3);
+		tempname = hpfs_translate_name(inode_sb(inode), de->name,
+					       de->namelen, lc, de->not_8x3);
 		if (!dir_emit(ctx, tempname, de->namelen, le32_to_cpu(de->fnode), DT_UNKNOWN)) {
 			if (tempname != de->name) kfree(tempname);
 			hpfs_brelse4(&qbh);
@@ -180,7 +189,7 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 		hpfs_brelse4(&qbh);
 	}
 out:
-	hpfs_unlock(inode->i_sb);
+	hpfs_unlock(inode_sb(inode));
 	return ret;
 }
 
@@ -210,10 +219,10 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	struct inode *result = NULL;
 	struct hpfs_inode_info *hpfs_result;
 
-	hpfs_lock(dir->i_sb);
+	hpfs_lock(inode_sb(dir));
 	if ((err = hpfs_chk_name(name, &len))) {
 		if (err == -ENAMETOOLONG) {
-			hpfs_unlock(dir->i_sb);
+			hpfs_unlock(inode_sb(dir));
 			return ERR_PTR(-ENAMETOOLONG);
 		}
 		goto end_add;
@@ -241,16 +250,16 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	 * Go find or make an inode.
 	 */
 
-	result = iget_locked(dir->i_sb, ino);
+	result = iget_locked(inode_sb(dir), ino);
 	if (!result) {
-		hpfs_error(dir->i_sb, "hpfs_lookup: can't get inode");
+		hpfs_error(inode_sb(dir), "hpfs_lookup: can't get inode");
 		goto bail1;
 	}
 	if (result->i_state & I_NEW) {
 		hpfs_init_inode(result);
 		if (de->directory)
 			hpfs_read_inode(result);
-		else if (le32_to_cpu(de->ea_size) && hpfs_sb(dir->i_sb)->sb_eas)
+		else if (le32_to_cpu(de->ea_size) && hpfs_sb(inode_sb(dir))->sb_eas)
 			hpfs_read_inode(result);
 		else {
 			result->i_mode |= S_IFREG;
@@ -264,8 +273,9 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	hpfs_result = hpfs_i(result);
 	if (!de->directory) hpfs_result->i_parent_dir = dir->i_ino;
 
-	if (de->has_acl || de->has_xtd_perm) if (!sb_rdonly(dir->i_sb)) {
-		hpfs_error(result->i_sb, "ACLs or XPERM found. This is probably HPFS386. This driver doesn't support it now. Send me some info on these structures");
+	if (de->has_acl || de->has_xtd_perm) if (!sb_rdonly(inode_sb(dir))) {
+		hpfs_error(inode_sb(result),
+			   "ACLs or XPERM found. This is probably HPFS386. This driver doesn't support it now. Send me some info on these structures");
 		goto bail1;
 	}
 
@@ -275,12 +285,14 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	 */
 
 	if (!result->i_ctime.tv_sec) {
-		if (!(result->i_ctime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->creation_date))))
+		if (!(result->i_ctime.tv_sec = local_to_gmt(inode_sb(dir), le32_to_cpu(de->creation_date))))
 			result->i_ctime.tv_sec = 1;
 		result->i_ctime.tv_nsec = 0;
-		result->i_mtime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->write_date));
+		result->i_mtime.tv_sec = local_to_gmt(inode_sb(dir),
+						      le32_to_cpu(de->write_date));
 		result->i_mtime.tv_nsec = 0;
-		result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->read_date));
+		result->i_atime.tv_sec = local_to_gmt(inode_sb(dir),
+						      le32_to_cpu(de->read_date));
 		result->i_atime.tv_nsec = 0;
 		hpfs_result->i_ea_size = le32_to_cpu(de->ea_size);
 		if (!hpfs_result->i_ea_mode && de->read_only)
@@ -309,7 +321,7 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 
 	end:
 	end_add:
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	d_add(dentry, result);
 	return NULL;
 
@@ -322,7 +334,7 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	
 	/*bail:*/
 
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return ERR_PTR(-ENOENT);
 }
 
diff --git a/fs/hpfs/dnode.c b/fs/hpfs/dnode.c
index a4ad18afbdec..085d8582cf14 100644
--- a/fs/hpfs/dnode.c
+++ b/fs/hpfs/dnode.c
@@ -254,19 +254,20 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 	}
 	go_up:
 	if (namelen >= 256) {
-		hpfs_error(i->i_sb, "%s(): namelen == %d", __func__, namelen);
+		hpfs_error(inode_sb(i), "%s(): namelen == %d", __func__,
+			   namelen);
 		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
-	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) {
+	if (!(d = hpfs_map_dnode(inode_sb(i), dno, &qbh))) {
 		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
 	go_up_a:
-	if (hpfs_sb(i->i_sb)->sb_chk)
-		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_to_dnode")) {
+	if (hpfs_sb(inode_sb(i))->sb_chk)
+		if (hpfs_stop_cycles(inode_sb(i), dno, &c1, &c2, "hpfs_add_to_dnode")) {
 			hpfs_brelse4(&qbh);
 			kfree(nd);
 			kfree(nname);
@@ -274,7 +275,8 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 		}
 	if (le32_to_cpu(d->first_free) + de_size(namelen, down_ptr) <= 2048) {
 		loff_t t;
-		copy_de(de=hpfs_add_de(i->i_sb, d, name, namelen, down_ptr), new_de);
+		copy_de(de=hpfs_add_de(inode_sb(i), d, name, namelen, down_ptr),
+			new_de);
 		t = get_pos(d, de);
 		for_all_poss(i, hpfs_pos_ins, t, 1);
 		for_all_poss(i, hpfs_pos_subst, 4, t);
@@ -297,11 +299,13 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 		return 1;
 	}	
 	memcpy(nd, d, le32_to_cpu(d->first_free));
-	copy_de(de = hpfs_add_de(i->i_sb, nd, name, namelen, down_ptr), new_de);
+	copy_de(de = hpfs_add_de(inode_sb(i), nd, name, namelen, down_ptr),
+		new_de);
 	for_all_poss(i, hpfs_pos_ins, get_pos(nd, de), 1);
 	h = ((char *)dnode_last_de(nd) - (char *)nd) / 2 + 10;
-	if (!(ad = hpfs_alloc_dnode(i->i_sb, le32_to_cpu(d->up), &adno, &qbh1))) {
-		hpfs_error(i->i_sb, "unable to alloc dnode - dnode tree will be corrupted");
+	if (!(ad = hpfs_alloc_dnode(inode_sb(i), le32_to_cpu(d->up), &adno, &qbh1))) {
+		hpfs_error(inode_sb(i),
+			   "unable to alloc dnode - dnode tree will be corrupted");
 		hpfs_brelse4(&qbh);
 		kfree(nd);
 		kfree(nname);
@@ -311,7 +315,8 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 	i->i_blocks += 4;
 	pos = 1;
 	for (de = dnode_first_de(nd); (char *)de_next_de(de) - (char *)nd < h; de = de_next_de(de)) {
-		copy_de(hpfs_add_de(i->i_sb, ad, de->name, de->namelen, de->down ? de_down_pointer(de) : 0), de);
+		copy_de(hpfs_add_de(inode_sb(i), ad, de->name, de->namelen, de->down ? de_down_pointer(de) : 0),
+			de);
 		for_all_poss(i, hpfs_pos_subst, ((loff_t)dno << 4) | pos, ((loff_t)adno << 4) | pos);
 		pos++;
 	}
@@ -321,13 +326,13 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 	namelen = de->namelen;
 	for_all_poss(i, hpfs_pos_subst, ((loff_t)dno << 4) | pos, 4);
 	down_ptr = adno;
-	set_last_pointer(i->i_sb, ad, de->down ? de_down_pointer(de) : 0);
+	set_last_pointer(inode_sb(i), ad, de->down ? de_down_pointer(de) : 0);
 	de = de_next_de(de);
 	memmove((char *)nd + 20, de, le32_to_cpu(nd->first_free) + (char *)nd - (char *)de);
 	le32_add_cpu(&nd->first_free, -((char *)de - (char *)nd - 20));
 	memcpy(d, nd, le32_to_cpu(nd->first_free));
 	for_all_poss(i, hpfs_pos_del, (loff_t)dno << 4, pos);
-	fix_up_ptrs(i->i_sb, ad);
+	fix_up_ptrs(inode_sb(i), ad);
 	if (!d->root_dnode) {
 		ad->up = d->up;
 		dno = le32_to_cpu(ad->up);
@@ -337,8 +342,9 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 		hpfs_brelse4(&qbh1);
 		goto go_up;
 	}
-	if (!(rd = hpfs_alloc_dnode(i->i_sb, le32_to_cpu(d->up), &rdno, &qbh2))) {
-		hpfs_error(i->i_sb, "unable to alloc dnode - dnode tree will be corrupted");
+	if (!(rd = hpfs_alloc_dnode(inode_sb(i), le32_to_cpu(d->up), &rdno, &qbh2))) {
+		hpfs_error(inode_sb(i),
+			   "unable to alloc dnode - dnode tree will be corrupted");
 		hpfs_brelse4(&qbh);
 		hpfs_brelse4(&qbh1);
 		kfree(nd);
@@ -349,8 +355,8 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 	i->i_blocks += 4;
 	rd->root_dnode = 1;
 	rd->up = d->up;
-	if (!(fnode = hpfs_map_fnode(i->i_sb, le32_to_cpu(d->up), &bh))) {
-		hpfs_free_dnode(i->i_sb, rdno);
+	if (!(fnode = hpfs_map_fnode(inode_sb(i), le32_to_cpu(d->up), &bh))) {
+		hpfs_free_dnode(inode_sb(i), rdno);
 		hpfs_brelse4(&qbh);
 		hpfs_brelse4(&qbh1);
 		hpfs_brelse4(&qbh2);
@@ -369,7 +375,7 @@ static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
 	hpfs_mark_4buffers_dirty(&qbh1);
 	hpfs_brelse4(&qbh1);
 	qbh = qbh2;
-	set_last_pointer(i->i_sb, rd, dno);
+	set_last_pointer(inode_sb(i), rd, dno);
 	dno = rdno;
 	d = rd;
 	goto go_up_a;
@@ -396,12 +402,12 @@ int hpfs_add_dirent(struct inode *i,
 	int c1, c2 = 0;
 	dno = hpfs_inode->i_dno;
 	down:
-	if (hpfs_sb(i->i_sb)->sb_chk)
-		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_dirent")) return 1;
-	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) return 1;
+	if (hpfs_sb(inode_sb(i))->sb_chk)
+		if (hpfs_stop_cycles(inode_sb(i), dno, &c1, &c2, "hpfs_add_dirent")) return 1;
+	if (!(d = hpfs_map_dnode(inode_sb(i), dno, &qbh))) return 1;
 	de_end = dnode_end_de(d);
 	for (de = dnode_first_de(d); de < de_end; de = de_next_de(de)) {
-		if (!(c = hpfs_compare_names(i->i_sb, name, namelen, de->name, de->namelen, de->last))) {
+		if (!(c = hpfs_compare_names(inode_sb(i), name, namelen, de->name, de->namelen, de->last))) {
 			hpfs_brelse4(&qbh);
 			return -1;
 		}	
@@ -415,7 +421,7 @@ int hpfs_add_dirent(struct inode *i,
 		}
 	}
 	hpfs_brelse4(&qbh);
-	if (hpfs_check_free_dnodes(i->i_sb, FREE_DNODES_ADD)) {
+	if (hpfs_check_free_dnodes(inode_sb(i), FREE_DNODES_ADD)) {
 		c = 1;
 		goto ret;
 	}	
@@ -441,21 +447,25 @@ static secno move_to_top(struct inode *i, dnode_secno from, dnode_secno to)
 	int c1, c2 = 0;
 	dno = from;
 	while (1) {
-		if (hpfs_sb(i->i_sb)->sb_chk)
-			if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "move_to_top"))
+		if (hpfs_sb(inode_sb(i))->sb_chk)
+			if (hpfs_stop_cycles(inode_sb(i), dno, &c1, &c2, "move_to_top"))
 				return 0;
-		if (!(dnode = hpfs_map_dnode(i->i_sb, dno, &qbh))) return 0;
-		if (hpfs_sb(i->i_sb)->sb_chk) {
+		if (!(dnode = hpfs_map_dnode(inode_sb(i), dno, &qbh))) return 0;
+		if (hpfs_sb(inode_sb(i))->sb_chk) {
 			if (le32_to_cpu(dnode->up) != chk_up) {
-				hpfs_error(i->i_sb, "move_to_top: up pointer from %08x should be %08x, is %08x",
-					dno, chk_up, le32_to_cpu(dnode->up));
+				hpfs_error(inode_sb(i),
+					   "move_to_top: up pointer from %08x should be %08x, is %08x",
+					   dno, chk_up,
+					   le32_to_cpu(dnode->up));
 				hpfs_brelse4(&qbh);
 				return 0;
 			}
 			chk_up = dno;
 		}
 		if (!(de = dnode_last_de(dnode))) {
-			hpfs_error(i->i_sb, "move_to_top: dnode %08x has no last de", dno);
+			hpfs_error(inode_sb(i),
+				   "move_to_top: dnode %08x has no last de",
+				   dno);
 			hpfs_brelse4(&qbh);
 			return 0;
 		}
@@ -466,20 +476,24 @@ static secno move_to_top(struct inode *i, dnode_secno from, dnode_secno to)
 	while (!(de = dnode_pre_last_de(dnode))) {
 		dnode_secno up = le32_to_cpu(dnode->up);
 		hpfs_brelse4(&qbh);
-		hpfs_free_dnode(i->i_sb, dno);
+		hpfs_free_dnode(inode_sb(i), dno);
 		i->i_size -= 2048;
 		i->i_blocks -= 4;
 		for_all_poss(i, hpfs_pos_subst, ((loff_t)dno << 4) | 1, 5);
 		if (up == to) return to;
-		if (!(dnode = hpfs_map_dnode(i->i_sb, up, &qbh))) return 0;
+		if (!(dnode = hpfs_map_dnode(inode_sb(i), up, &qbh))) return 0;
 		if (dnode->root_dnode) {
-			hpfs_error(i->i_sb, "move_to_top: got to root_dnode while moving from %08x to %08x", from, to);
+			hpfs_error(inode_sb(i),
+				   "move_to_top: got to root_dnode while moving from %08x to %08x",
+				   from, to);
 			hpfs_brelse4(&qbh);
 			return 0;
 		}
 		de = dnode_last_de(dnode);
 		if (!de || !de->down) {
-			hpfs_error(i->i_sb, "move_to_top: dnode %08x doesn't point down to %08x", up, dno);
+			hpfs_error(inode_sb(i),
+				   "move_to_top: dnode %08x doesn't point down to %08x",
+				   up, dno);
 			hpfs_brelse4(&qbh);
 			return 0;
 		}
@@ -493,14 +507,15 @@ static secno move_to_top(struct inode *i, dnode_secno from, dnode_secno to)
 	for_all_poss(i, hpfs_pos_subst, t, 4);
 	for_all_poss(i, hpfs_pos_subst, t + 1, 5);
 	if (!(nde = kmalloc(le16_to_cpu(de->length), GFP_NOFS))) {
-		hpfs_error(i->i_sb, "out of memory for dirent - directory will be corrupted");
+		hpfs_error(inode_sb(i),
+			   "out of memory for dirent - directory will be corrupted");
 		hpfs_brelse4(&qbh);
 		return 0;
 	}
 	memcpy(nde, de, le16_to_cpu(de->length));
 	ddno = de->down ? de_down_pointer(de) : 0;
-	hpfs_delete_de(i->i_sb, dnode, de);
-	set_last_pointer(i->i_sb, dnode, ddno);
+	hpfs_delete_de(inode_sb(i), dnode, de);
+	set_last_pointer(inode_sb(i), dnode, ddno);
 	hpfs_mark_4buffers_dirty(&qbh);
 	hpfs_brelse4(&qbh);
 	a = hpfs_add_to_dnode(i, to, nde->name, nde->namelen, nde, from);
@@ -524,8 +539,8 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 	struct hpfs_dirent *de;
 	int c1, c2 = 0;
 	try_it_again:
-	if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "delete_empty_dnode")) return;
-	if (!(dnode = hpfs_map_dnode(i->i_sb, dno, &qbh))) return;
+	if (hpfs_stop_cycles(inode_sb(i), dno, &c1, &c2, "delete_empty_dnode")) return;
+	if (!(dnode = hpfs_map_dnode(inode_sb(i), dno, &qbh))) return;
 	if (le32_to_cpu(dnode->first_free) > 56) goto end;
 	if (le32_to_cpu(dnode->first_free) == 52 || le32_to_cpu(dnode->first_free) == 56) {
 		struct hpfs_dirent *de_end;
@@ -533,12 +548,14 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 		up = le32_to_cpu(dnode->up);
 		de = dnode_first_de(dnode);
 		down = de->down ? de_down_pointer(de) : 0;
-		if (hpfs_sb(i->i_sb)->sb_chk) if (root && !down) {
-			hpfs_error(i->i_sb, "delete_empty_dnode: root dnode %08x is empty", dno);
+		if (hpfs_sb(inode_sb(i))->sb_chk) if (root && !down) {
+			hpfs_error(inode_sb(i),
+				   "delete_empty_dnode: root dnode %08x is empty",
+				   dno);
 			goto end;
 		}
 		hpfs_brelse4(&qbh);
-		hpfs_free_dnode(i->i_sb, dno);
+		hpfs_free_dnode(inode_sb(i), dno);
 		i->i_size -= 2048;
 		i->i_blocks -= 4;
 		if (root) {
@@ -546,21 +563,21 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 			struct buffer_head *bh;
 			struct dnode *d1;
 			struct quad_buffer_head qbh1;
-			if (hpfs_sb(i->i_sb)->sb_chk)
+			if (hpfs_sb(inode_sb(i))->sb_chk)
 				if (up != i->i_ino) {
-					hpfs_error(i->i_sb,
+					hpfs_error(inode_sb(i),
 						   "bad pointer to fnode, dnode %08x, pointing to %08x, should be %08lx",
 						   dno, up,
 						   (unsigned long)i->i_ino);
 					return;
 				}
-			if ((d1 = hpfs_map_dnode(i->i_sb, down, &qbh1))) {
+			if ((d1 = hpfs_map_dnode(inode_sb(i), down, &qbh1))) {
 				d1->up = cpu_to_le32(up);
 				d1->root_dnode = 1;
 				hpfs_mark_4buffers_dirty(&qbh1);
 				hpfs_brelse4(&qbh1);
 			}
-			if ((fnode = hpfs_map_fnode(i->i_sb, up, &bh))) {
+			if ((fnode = hpfs_map_fnode(inode_sb(i), up, &bh))) {
 				fnode->u.external[0].disk_secno = cpu_to_le32(down);
 				mark_buffer_dirty(bh);
 				brelse(bh);
@@ -569,12 +586,14 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 			for_all_poss(i, hpfs_pos_subst, ((loff_t)dno << 4) | 1, (loff_t) 12);
 			return;
 		}
-		if (!(dnode = hpfs_map_dnode(i->i_sb, up, &qbh))) return;
+		if (!(dnode = hpfs_map_dnode(inode_sb(i), up, &qbh))) return;
 		p = 1;
 		de_end = dnode_end_de(dnode);
 		for (de = dnode_first_de(dnode); de < de_end; de = de_next_de(de), p++)
 			if (de->down) if (de_down_pointer(de) == dno) goto fnd;
-		hpfs_error(i->i_sb, "delete_empty_dnode: pointer to dnode %08x not found in dnode %08x", dno, up);
+		hpfs_error(inode_sb(i),
+			   "delete_empty_dnode: pointer to dnode %08x not found in dnode %08x",
+			   dno, up);
 		goto end;
 		fnd:
 		for_all_poss(i, hpfs_pos_subst, ((loff_t)dno << 4) | 1, ((loff_t)up << 4) | p);
@@ -588,14 +607,16 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 			struct dnode *d1;
 			struct quad_buffer_head qbh1;
 			*(dnode_secno *) ((void *) de + le16_to_cpu(de->length) - 4) = down;
-			if ((d1 = hpfs_map_dnode(i->i_sb, down, &qbh1))) {
+			if ((d1 = hpfs_map_dnode(inode_sb(i), down, &qbh1))) {
 				d1->up = cpu_to_le32(up);
 				hpfs_mark_4buffers_dirty(&qbh1);
 				hpfs_brelse4(&qbh1);
 			}
 		}
 	} else {
-		hpfs_error(i->i_sb, "delete_empty_dnode: dnode %08x, first_free == %03x", dno, le32_to_cpu(dnode->first_free));
+		hpfs_error(inode_sb(i),
+			   "delete_empty_dnode: dnode %08x, first_free == %03x",
+			   dno, le32_to_cpu(dnode->first_free));
 		goto end;
 	}
 
@@ -611,12 +632,12 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 			goto endm;
 		}
 		memcpy(de_cp, de, le16_to_cpu(de->length));
-		hpfs_delete_de(i->i_sb, dnode, de);
+		hpfs_delete_de(inode_sb(i), dnode, de);
 		hpfs_mark_4buffers_dirty(&qbh);
 		hpfs_brelse4(&qbh);
 		for_all_poss(i, hpfs_pos_subst, ((loff_t)up << 4) | p, 4);
 		for_all_poss(i, hpfs_pos_del, ((loff_t)up << 4) | p, 1);
-		if (de_cp->down) if ((d1 = hpfs_map_dnode(i->i_sb, de_down_pointer(de_cp), &qbh1))) {
+		if (de_cp->down) if ((d1 = hpfs_map_dnode(inode_sb(i), de_down_pointer(de_cp), &qbh1))) {
 			d1->up = cpu_to_le32(ndown);
 			hpfs_mark_4buffers_dirty(&qbh1);
 			hpfs_brelse4(&qbh1);
@@ -634,7 +655,8 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 		struct quad_buffer_head qbh1;
 		dnode_secno dlp;
 		if (!de_prev) {
-			hpfs_error(i->i_sb, "delete_empty_dnode: empty dnode %08x", up);
+			hpfs_error(inode_sb(i),
+				   "delete_empty_dnode: empty dnode %08x", up);
 			hpfs_mark_4buffers_dirty(&qbh);
 			hpfs_brelse4(&qbh);
 			dno = up;
@@ -642,19 +664,19 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 		}
 		if (!de_prev->down) goto endm;
 		ndown = de_down_pointer(de_prev);
-		if ((d1 = hpfs_map_dnode(i->i_sb, ndown, &qbh1))) {
+		if ((d1 = hpfs_map_dnode(inode_sb(i), ndown, &qbh1))) {
 			struct hpfs_dirent *del = dnode_last_de(d1);
 			dlp = del->down ? de_down_pointer(del) : 0;
 			if (!dlp && down) {
 				if (le32_to_cpu(d1->first_free) > 2044) {
-					if (hpfs_sb(i->i_sb)->sb_chk >= 2) {
+					if (hpfs_sb(inode_sb(i))->sb_chk >= 2) {
 						pr_err("unbalanced dnode tree, see hpfs.txt 4 more info\n");
 						pr_err("terminating balancing operation\n");
 					}
 					hpfs_brelse4(&qbh1);
 					goto endm;
 				}
-				if (hpfs_sb(i->i_sb)->sb_chk >= 2) {
+				if (hpfs_sb(inode_sb(i))->sb_chk >= 2) {
 					pr_err("unbalanced dnode tree, see hpfs.txt 4 more info\n");
 					pr_err("goin'on\n");
 				}
@@ -677,7 +699,7 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 		hpfs_mark_4buffers_dirty(&qbh1);
 		hpfs_brelse4(&qbh1);
 		memcpy(de_cp, de_prev, le16_to_cpu(de_prev->length));
-		hpfs_delete_de(i->i_sb, dnode, de_prev);
+		hpfs_delete_de(inode_sb(i), dnode, de_prev);
 		if (!de_prev->down) {
 			le16_add_cpu(&de_prev->length, 4);
 			de_prev->down = 1;
@@ -688,7 +710,7 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 		hpfs_brelse4(&qbh);
 		for_all_poss(i, hpfs_pos_subst, ((loff_t)up << 4) | (p - 1), 4);
 		for_all_poss(i, hpfs_pos_subst, ((loff_t)up << 4) | p, ((loff_t)up << 4) | (p - 1));
-		if (down) if ((d1 = hpfs_map_dnode(i->i_sb, de_down_pointer(de), &qbh1))) {
+		if (down) if ((d1 = hpfs_map_dnode(inode_sb(i), de_down_pointer(de), &qbh1))) {
 			d1->up = cpu_to_le32(ndown);
 			hpfs_mark_4buffers_dirty(&qbh1);
 			hpfs_brelse4(&qbh1);
@@ -714,19 +736,21 @@ int hpfs_remove_dirent(struct inode *i, dnode_secno dno, struct hpfs_dirent *de,
 	dnode_secno down = 0;
 	loff_t t;
 	if (de->first || de->last) {
-		hpfs_error(i->i_sb, "hpfs_remove_dirent: attempt to delete first or last dirent in dnode %08x", dno);
+		hpfs_error(inode_sb(i),
+			   "hpfs_remove_dirent: attempt to delete first or last dirent in dnode %08x",
+			   dno);
 		hpfs_brelse4(qbh);
 		return 1;
 	}
 	if (de->down) down = de_down_pointer(de);
 	if (depth && (de->down || (de == dnode_first_de(dnode) && de_next_de(de)->last))) {
-		if (hpfs_check_free_dnodes(i->i_sb, FREE_DNODES_DEL)) {
+		if (hpfs_check_free_dnodes(inode_sb(i), FREE_DNODES_DEL)) {
 			hpfs_brelse4(qbh);
 			return 2;
 		}
 	}
 	for_all_poss(i, hpfs_pos_del, (t = get_pos(dnode, de)) + 1, 1);
-	hpfs_delete_de(i->i_sb, dnode, de);
+	hpfs_delete_de(inode_sb(i), dnode, de);
 	hpfs_mark_4buffers_dirty(qbh);
 	hpfs_brelse4(qbh);
 	if (down) {
@@ -856,20 +880,20 @@ struct hpfs_dirent *map_pos_dirent(struct inode *inode, loff_t *posp,
 	pos = *posp;
 	dno = pos >> 6 << 2;
 	pos &= 077;
-	if (!(de = map_nth_dirent(inode->i_sb, dno, pos, qbh, &dnode)))
+	if (!(de = map_nth_dirent(inode_sb(inode), dno, pos, qbh, &dnode)))
 		goto bail;
 
 	/* Going to the next dirent */
 	if ((d = de_next_de(de)) < dnode_end_de(dnode)) {
 		if (!(++*posp & 077)) {
-			hpfs_error(inode->i_sb,
-				"map_pos_dirent: pos crossed dnode boundary; pos = %08llx",
-				(unsigned long long)*posp);
+			hpfs_error(inode_sb(inode),
+				   "map_pos_dirent: pos crossed dnode boundary; pos = %08llx",
+				   (unsigned long long)*posp);
 			goto bail;
 		}
 		/* We're going down the tree */
 		if (d->down) {
-			*posp = ((loff_t) hpfs_de_as_down_as_possible(inode->i_sb, de_down_pointer(d)) << 4) + 1;
+			*posp = ((loff_t) hpfs_de_as_down_as_possible(inode_sb(inode), de_down_pointer(d)) << 4) + 1;
 		}
 	
 		return de;
@@ -878,15 +902,16 @@ struct hpfs_dirent *map_pos_dirent(struct inode *inode, loff_t *posp,
 	/* Going up */
 	if (dnode->root_dnode) goto bail;
 
-	if (!(up_dnode = hpfs_map_dnode(inode->i_sb, le32_to_cpu(dnode->up), &qbh0)))
+	if (!(up_dnode = hpfs_map_dnode(inode_sb(inode), le32_to_cpu(dnode->up), &qbh0)))
 		goto bail;
 
 	end_up_de = dnode_end_de(up_dnode);
 	c = 0;
 	for (up_de = dnode_first_de(up_dnode); up_de < end_up_de;
 	     up_de = de_next_de(up_de)) {
-		if (!(++c & 077)) hpfs_error(inode->i_sb,
-			"map_pos_dirent: pos crossed dnode boundary; dnode = %08x", le32_to_cpu(dnode->up));
+		if (!(++c & 077)) hpfs_error(inode_sb(inode),
+					     "map_pos_dirent: pos crossed dnode boundary; dnode = %08x",
+					     le32_to_cpu(dnode->up));
 		if (up_de->down && de_down_pointer(up_de) == dno) {
 			*posp = ((loff_t) le32_to_cpu(dnode->up) << 4) + c;
 			hpfs_brelse4(&qbh0);
@@ -894,8 +919,9 @@ struct hpfs_dirent *map_pos_dirent(struct inode *inode, loff_t *posp,
 		}
 	}
 	
-	hpfs_error(inode->i_sb, "map_pos_dirent: pointer to dnode %08x not found in parent dnode %08x",
-		dno, le32_to_cpu(dnode->up));
+	hpfs_error(inode_sb(inode),
+		   "map_pos_dirent: pointer to dnode %08x not found in parent dnode %08x",
+		   dno, le32_to_cpu(dnode->up));
 	hpfs_brelse4(&qbh0);
 	
 	bail:
@@ -914,15 +940,17 @@ struct hpfs_dirent *map_dirent(struct inode *inode, dnode_secno dno,
 	struct hpfs_dirent *de_end;
 	int c1, c2 = 0;
 
-	if (!S_ISDIR(inode->i_mode)) hpfs_error(inode->i_sb, "map_dirent: not a directory\n");
+	if (!S_ISDIR(inode->i_mode)) hpfs_error(inode_sb(inode),
+						"map_dirent: not a directory\n");
 	again:
-	if (hpfs_sb(inode->i_sb)->sb_chk)
-		if (hpfs_stop_cycles(inode->i_sb, dno, &c1, &c2, "map_dirent")) return NULL;
-	if (!(dnode = hpfs_map_dnode(inode->i_sb, dno, qbh))) return NULL;
+	if (hpfs_sb(inode_sb(inode))->sb_chk)
+		if (hpfs_stop_cycles(inode_sb(inode), dno, &c1, &c2, "map_dirent")) return NULL;
+	if (!(dnode = hpfs_map_dnode(inode_sb(inode), dno, qbh))) return NULL;
 	
 	de_end = dnode_end_de(dnode);
 	for (de = dnode_first_de(dnode); de < de_end; de = de_next_de(de)) {
-		int t = hpfs_compare_names(inode->i_sb, name, len, de->name, de->namelen, de->last);
+		int t = hpfs_compare_names(inode_sb(inode), name, len,
+					   de->name, de->namelen, de->last);
 		if (!t) {
 			if (dd) *dd = dno;
 			return de;
diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 102ba18e561f..4c973239b948 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -191,7 +191,7 @@ void hpfs_set_ea(struct inode *inode, struct fnode *fnode, const char *key,
 		 const char *data, int size)
 {
 	fnode_secno fno = inode->i_ino;
-	struct super_block *s = inode->i_sb;
+	struct super_block *s = inode_sb(inode);
 	unsigned pos;
 	int ano, len;
 	secno a;
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 1ecec124e76f..3877807b08f4 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -14,9 +14,9 @@
 
 static int hpfs_file_release(struct inode *inode, struct file *file)
 {
-	hpfs_lock(inode->i_sb);
+	hpfs_lock(inode_sb(inode));
 	hpfs_write_if_changed(inode);
-	hpfs_unlock(inode->i_sb);
+	hpfs_unlock(inode_sb(inode));
 	return 0;
 }
 
@@ -28,7 +28,7 @@ int hpfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	ret = file_write_and_wait_range(file, start, end);
 	if (ret)
 		return ret;
-	return sync_blockdev(inode->i_sb->s_bdev);
+	return sync_blockdev(inode_sb(inode)->s_bdev);
 }
 
 /*
@@ -48,10 +48,11 @@ static secno hpfs_bmap(struct inode *inode, unsigned file_secno, unsigned *n_sec
 		*n_secs = hpfs_inode->i_n_secs - n;
 		return hpfs_inode->i_disk_sec + n;
 	}
-	if (!(fnode = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) return 0;
-	disk_secno = hpfs_bplus_lookup(inode->i_sb, inode, &fnode->btree, file_secno, bh);
+	if (!(fnode = hpfs_map_fnode(inode_sb(inode), inode->i_ino, &bh))) return 0;
+	disk_secno = hpfs_bplus_lookup(inode_sb(inode), inode, &fnode->btree,
+				       file_secno, bh);
 	if (disk_secno == -1) return 0;
-	if (hpfs_chk_sectors(inode->i_sb, disk_secno, 1, "bmap")) return 0;
+	if (hpfs_chk_sectors(inode_sb(inode), disk_secno, 1, "bmap")) return 0;
 	n = file_secno - hpfs_inode->i_file_sec;
 	if (n < hpfs_inode->i_n_secs) {
 		*n_secs = hpfs_inode->i_n_secs - n;
@@ -64,12 +65,13 @@ static secno hpfs_bmap(struct inode *inode, unsigned file_secno, unsigned *n_sec
 void hpfs_truncate(struct inode *i)
 {
 	if (IS_IMMUTABLE(i)) return /*-EPERM*/;
-	hpfs_lock_assert(i->i_sb);
+	hpfs_lock_assert(inode_sb(i));
 
 	hpfs_i(i)->i_n_secs = 0;
 	i->i_blocks = 1 + ((i->i_size + 511) >> 9);
 	hpfs_i(i)->mmu_private = i->i_size;
-	hpfs_truncate_btree(i->i_sb, i->i_ino, 1, ((i->i_size + 511) >> 9));
+	hpfs_truncate_btree(inode_sb(i), i->i_ino, 1,
+			    ((i->i_size + 511) >> 9));
 	hpfs_write_inode(i);
 	hpfs_i(i)->i_n_secs = 0;
 }
@@ -79,17 +81,18 @@ static int hpfs_get_block(struct inode *inode, sector_t iblock, struct buffer_he
 	int r;
 	secno s;
 	unsigned n_secs;
-	hpfs_lock(inode->i_sb);
+	hpfs_lock(inode_sb(inode));
 	s = hpfs_bmap(inode, iblock, &n_secs);
 	if (s) {
 		if (bh_result->b_size >> 9 < n_secs)
 			n_secs = bh_result->b_size >> 9;
-		n_secs = hpfs_search_hotfix_map_for_range(inode->i_sb, s, n_secs);
+		n_secs = hpfs_search_hotfix_map_for_range(inode_sb(inode), s,
+							  n_secs);
 		if (unlikely(!n_secs)) {
-			s = hpfs_search_hotfix_map(inode->i_sb, s);
+			s = hpfs_search_hotfix_map(inode_sb(inode), s);
 			n_secs = 1;
 		}
-		map_bh(bh_result, inode->i_sb, s);
+		map_bh(bh_result, inode_sb(inode), s);
 		bh_result->b_size = n_secs << 9;
 		goto ret_0;
 	}
@@ -99,19 +102,21 @@ static int hpfs_get_block(struct inode *inode, sector_t iblock, struct buffer_he
 		r = -EIO;
 		goto ret_r;
 	}
-	if ((s = hpfs_add_sector_to_btree(inode->i_sb, inode->i_ino, 1, inode->i_blocks - 1)) == -1) {
-		hpfs_truncate_btree(inode->i_sb, inode->i_ino, 1, inode->i_blocks - 1);
+	if ((s = hpfs_add_sector_to_btree(inode_sb(inode), inode->i_ino, 1, inode->i_blocks - 1)) == -1) {
+		hpfs_truncate_btree(inode_sb(inode), inode->i_ino, 1,
+				    inode->i_blocks - 1);
 		r = -ENOSPC;
 		goto ret_r;
 	}
 	inode->i_blocks++;
 	hpfs_i(inode)->mmu_private += 512;
 	set_buffer_new(bh_result);
-	map_bh(bh_result, inode->i_sb, hpfs_search_hotfix_map(inode->i_sb, s));
+	map_bh(bh_result, inode_sb(inode),
+	       hpfs_search_hotfix_map(inode_sb(inode), s));
 	ret_0:
 	r = 0;
 	ret_r:
-	hpfs_unlock(inode->i_sb);
+	hpfs_unlock(inode_sb(inode));
 	return r;
 }
 
@@ -141,14 +146,14 @@ static void hpfs_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;
 
-	hpfs_lock(inode->i_sb);
+	hpfs_lock(inode_sb(inode));
 
 	if (to > inode->i_size) {
 		truncate_pagecache(inode, inode->i_size);
 		hpfs_truncate(inode);
 	}
 
-	hpfs_unlock(inode->i_sb);
+	hpfs_unlock(inode_sb(inode));
 }
 
 static int hpfs_write_begin(struct file *file, struct address_space *mapping,
@@ -178,9 +183,9 @@ static int hpfs_write_end(struct file *file, struct address_space *mapping,
 		hpfs_write_failed(mapping, pos + len);
 	if (!(err < 0)) {
 		/* make sure we write it on close, if not earlier */
-		hpfs_lock(inode->i_sb);
+		hpfs_lock(inode_sb(inode));
 		hpfs_i(inode)->i_dirty = 1;
-		hpfs_unlock(inode->i_sb);
+		hpfs_unlock(inode_sb(inode));
 	}
 	return err;
 }
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index eb8b4baf0f2e..eab8df9daa8c 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -13,7 +13,7 @@
 
 void hpfs_init_inode(struct inode *i)
 {
-	struct super_block *sb = i->i_sb;
+	struct super_block *sb = inode_sb(i);
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 
 	i->i_uid = hpfs_sb(sb)->sb_uid;
@@ -45,7 +45,7 @@ void hpfs_read_inode(struct inode *i)
 {
 	struct buffer_head *bh;
 	struct fnode *fnode;
-	struct super_block *sb = i->i_sb;
+	struct super_block *sb = inode_sb(i);
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 	void *ea;
 	int ea_size;
@@ -59,22 +59,22 @@ void hpfs_read_inode(struct inode *i)
 		make_bad_inode(i);
 		return;
 	}
-	if (hpfs_sb(i->i_sb)->sb_eas) {
-		if ((ea = hpfs_get_ea(i->i_sb, fnode, "UID", &ea_size))) {
+	if (hpfs_sb(inode_sb(i))->sb_eas) {
+		if ((ea = hpfs_get_ea(inode_sb(i), fnode, "UID", &ea_size))) {
 			if (ea_size == 2) {
 				i_uid_write(i, le16_to_cpu(*(__le16*)ea));
 				hpfs_inode->i_ea_uid = 1;
 			}
 			kfree(ea);
 		}
-		if ((ea = hpfs_get_ea(i->i_sb, fnode, "GID", &ea_size))) {
+		if ((ea = hpfs_get_ea(inode_sb(i), fnode, "GID", &ea_size))) {
 			if (ea_size == 2) {
 				i_gid_write(i, le16_to_cpu(*(__le16*)ea));
 				hpfs_inode->i_ea_gid = 1;
 			}
 			kfree(ea);
 		}
-		if ((ea = hpfs_get_ea(i->i_sb, fnode, "SYMLINK", &ea_size))) {
+		if ((ea = hpfs_get_ea(inode_sb(i), fnode, "SYMLINK", &ea_size))) {
 			kfree(ea);
 			i->i_mode = S_IFLNK | 0777;
 			i->i_op = &page_symlink_inode_operations;
@@ -86,7 +86,7 @@ void hpfs_read_inode(struct inode *i)
 			brelse(bh);
 			return;
 		}
-		if ((ea = hpfs_get_ea(i->i_sb, fnode, "MODE", &ea_size))) {
+		if ((ea = hpfs_get_ea(inode_sb(i), fnode, "MODE", &ea_size))) {
 			int rdev = 0;
 			umode_t mode = hpfs_sb(sb)->sb_mode;
 			if (ea_size == 2) {
@@ -96,7 +96,7 @@ void hpfs_read_inode(struct inode *i)
 			kfree(ea);
 			i->i_mode = mode;
 			if (S_ISBLK(mode) || S_ISCHR(mode)) {
-				if ((ea = hpfs_get_ea(i->i_sb, fnode, "DEV", &ea_size))) {
+				if ((ea = hpfs_get_ea(inode_sb(i), fnode, "DEV", &ea_size))) {
 					if (ea_size == 4)
 						rdev = le32_to_cpu(*(__le32*)ea);
 					kfree(ea);
@@ -125,7 +125,8 @@ void hpfs_read_inode(struct inode *i)
 			if (hpfs_map_fnode(sb, hpfs_inode->i_parent_dir, &bh0)) brelse(bh0);
 		}
 		n_dnodes = 0; n_subdirs = 0;
-		hpfs_count_dnodes(i->i_sb, hpfs_inode->i_dno, &n_dnodes, &n_subdirs, NULL);
+		hpfs_count_dnodes(inode_sb(i), hpfs_inode->i_dno, &n_dnodes,
+				  &n_subdirs, NULL);
 		i->i_blocks = 4 * n_dnodes;
 		i->i_size = 2048 * n_dnodes;
 		set_nlink(i, 2 + n_subdirs);
@@ -149,24 +150,24 @@ static void hpfs_write_inode_ea(struct inode *i, struct fnode *fnode)
 	/*if (le32_to_cpu(fnode->acl_size_l) || le16_to_cpu(fnode->acl_size_s)) {
 		   Some unknown structures like ACL may be in fnode,
 		   we'd better not overwrite them
-		hpfs_error(i->i_sb, "fnode %08x has some unknown HPFS386 structures", i->i_ino);
-	} else*/ if (hpfs_sb(i->i_sb)->sb_eas >= 2) {
+		hpfs_error(inode_sb(i), "fnode %08x has some unknown HPFS386 structures", i->i_ino);
+	} else*/ if (hpfs_sb(inode_sb(i))->sb_eas >= 2) {
 		__le32 ea;
-		if (!uid_eq(i->i_uid, hpfs_sb(i->i_sb)->sb_uid) || hpfs_inode->i_ea_uid) {
+		if (!uid_eq(i->i_uid, hpfs_sb(inode_sb(i))->sb_uid) || hpfs_inode->i_ea_uid) {
 			ea = cpu_to_le32(i_uid_read(i));
 			hpfs_set_ea(i, fnode, "UID", (char*)&ea, 2);
 			hpfs_inode->i_ea_uid = 1;
 		}
-		if (!gid_eq(i->i_gid, hpfs_sb(i->i_sb)->sb_gid) || hpfs_inode->i_ea_gid) {
+		if (!gid_eq(i->i_gid, hpfs_sb(inode_sb(i))->sb_gid) || hpfs_inode->i_ea_gid) {
 			ea = cpu_to_le32(i_gid_read(i));
 			hpfs_set_ea(i, fnode, "GID", (char *)&ea, 2);
 			hpfs_inode->i_ea_gid = 1;
 		}
 		if (!S_ISLNK(i->i_mode))
-			if ((i->i_mode != ((hpfs_sb(i->i_sb)->sb_mode & ~(S_ISDIR(i->i_mode) ? 0 : 0111))
-			  | (S_ISDIR(i->i_mode) ? S_IFDIR : S_IFREG))
-			  && i->i_mode != ((hpfs_sb(i->i_sb)->sb_mode & ~(S_ISDIR(i->i_mode) ? 0222 : 0333))
-			  | (S_ISDIR(i->i_mode) ? S_IFDIR : S_IFREG))) || hpfs_inode->i_ea_mode) {
+			if ((i->i_mode != ((hpfs_sb(inode_sb(i))->sb_mode & ~(S_ISDIR(i->i_mode) ? 0 : 0111))
+					   | (S_ISDIR(i->i_mode) ? S_IFDIR : S_IFREG))
+			     && i->i_mode != ((hpfs_sb(inode_sb(i))->sb_mode & ~(S_ISDIR(i->i_mode) ? 0222 : 0333))
+					      | (S_ISDIR(i->i_mode) ? S_IFDIR : S_IFREG))) || hpfs_inode->i_ea_mode) {
 				ea = cpu_to_le32(i->i_mode);
 				/* sick, but legal */
 				hpfs_set_ea(i, fnode, "MODE", (char *)&ea, 2);
@@ -183,7 +184,7 @@ void hpfs_write_inode(struct inode *i)
 {
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 	struct inode *parent;
-	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
+	if (i->i_ino == hpfs_sb(inode_sb(i))->sb_root) return;
 	if (hpfs_inode->i_rddir_off && !atomic_read(&i->i_count)) {
 		if (*hpfs_inode->i_rddir_off)
 			pr_err("write_inode: some position still there\n");
@@ -193,7 +194,7 @@ void hpfs_write_inode(struct inode *i)
 	if (!i->i_nlink) {
 		return;
 	}
-	parent = iget_locked(i->i_sb, hpfs_inode->i_parent_dir);
+	parent = iget_locked(inode_sb(i), hpfs_inode->i_parent_dir);
 	if (parent) {
 		hpfs_inode->i_dirty = 0;
 		if (parent->i_state & I_NEW) {
@@ -213,10 +214,10 @@ void hpfs_write_inode_nolock(struct inode *i)
 	struct fnode *fnode;
 	struct quad_buffer_head qbh;
 	struct hpfs_dirent *de;
-	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
-	if (!(fnode = hpfs_map_fnode(i->i_sb, i->i_ino, &bh))) return;
-	if (i->i_ino != hpfs_sb(i->i_sb)->sb_root && i->i_nlink) {
-		if (!(de = map_fnode_dirent(i->i_sb, i->i_ino, fnode, &qbh))) {
+	if (i->i_ino == hpfs_sb(inode_sb(i))->sb_root) return;
+	if (!(fnode = hpfs_map_fnode(inode_sb(i), i->i_ino, &bh))) return;
+	if (i->i_ino != hpfs_sb(inode_sb(i))->sb_root && i->i_nlink) {
+		if (!(de = map_fnode_dirent(inode_sb(i), i->i_ino, fnode, &qbh))) {
 			brelse(bh);
 			return;
 		}
@@ -230,9 +231,9 @@ void hpfs_write_inode_nolock(struct inode *i)
 	}
 	hpfs_write_inode_ea(i, fnode);
 	if (de) {
-		de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
-		de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_ctime.tv_sec));
+		de->write_date = cpu_to_le32(gmt_to_local(inode_sb(i), i->i_mtime.tv_sec));
+		de->read_date = cpu_to_le32(gmt_to_local(inode_sb(i), i->i_atime.tv_sec));
+		de->creation_date = cpu_to_le32(gmt_to_local(inode_sb(i), i->i_ctime.tv_sec));
 		de->read_only = !(i->i_mode & 0222);
 		de->ea_size = cpu_to_le32(hpfs_inode->i_ea_size);
 		hpfs_mark_4buffers_dirty(&qbh);
@@ -240,18 +241,18 @@ void hpfs_write_inode_nolock(struct inode *i)
 	}
 	if (S_ISDIR(i->i_mode)) {
 		if ((de = map_dirent(i, hpfs_inode->i_dno, "\001\001", 2, NULL, &qbh))) {
-			de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
-			de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_ctime.tv_sec));
+			de->write_date = cpu_to_le32(gmt_to_local(inode_sb(i), i->i_mtime.tv_sec));
+			de->read_date = cpu_to_le32(gmt_to_local(inode_sb(i), i->i_atime.tv_sec));
+			de->creation_date = cpu_to_le32(gmt_to_local(inode_sb(i), i->i_ctime.tv_sec));
 			de->read_only = !(i->i_mode & 0222);
 			de->ea_size = cpu_to_le32(/*hpfs_inode->i_ea_size*/0);
 			de->file_size = cpu_to_le32(0);
 			hpfs_mark_4buffers_dirty(&qbh);
 			hpfs_brelse4(&qbh);
 		} else
-			hpfs_error(i->i_sb,
-				"directory %08lx doesn't have '.' entry",
-				(unsigned long)i->i_ino);
+			hpfs_error(inode_sb(i),
+				   "directory %08lx doesn't have '.' entry",
+				   (unsigned long)i->i_ino);
 	}
 	mark_buffer_dirty(bh);
 	brelse(bh);
@@ -262,8 +263,8 @@ int hpfs_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_inode(dentry);
 	int error = -EINVAL;
 
-	hpfs_lock(inode->i_sb);
-	if (inode->i_ino == hpfs_sb(inode->i_sb)->sb_root)
+	hpfs_lock(inode_sb(inode));
+	if (inode->i_ino == hpfs_sb(inode_sb(inode))->sb_root)
 		goto out_unlock;
 	if ((attr->ia_valid & ATTR_UID) &&
 	    from_kuid(&init_user_ns, attr->ia_uid) >= 0x10000)
@@ -293,7 +294,7 @@ int hpfs_setattr(struct dentry *dentry, struct iattr *attr)
 	hpfs_write_inode(inode);
 
  out_unlock:
-	hpfs_unlock(inode->i_sb);
+	hpfs_unlock(inode_sb(inode));
 	return error;
 }
 
@@ -310,8 +311,8 @@ void hpfs_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (!inode->i_nlink) {
-		hpfs_lock(inode->i_sb);
-		hpfs_remove_fnode(inode->i_sb, inode->i_ino);
-		hpfs_unlock(inode->i_sb);
+		hpfs_lock(inode_sb(inode));
+		hpfs_remove_fnode(inode_sb(inode), inode->i_ino);
+		hpfs_unlock(inode_sb(inode));
 	}
 }
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index a3615e4c730d..605fe8f2ad9c 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -36,12 +36,12 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct hpfs_dirent dee;
 	int err;
 	if ((err = hpfs_chk_name(name, &len))) return err==-ENOENT ? -EINVAL : err;
-	hpfs_lock(dir->i_sb);
+	hpfs_lock(inode_sb(dir));
 	err = -ENOSPC;
-	fnode = hpfs_alloc_fnode(dir->i_sb, hpfs_i(dir)->i_dno, &fno, &bh);
+	fnode = hpfs_alloc_fnode(inode_sb(dir), hpfs_i(dir)->i_dno, &fno, &bh);
 	if (!fnode)
 		goto bail;
-	dnode = hpfs_alloc_dnode(dir->i_sb, fno, &dno, &qbh0);
+	dnode = hpfs_alloc_dnode(inode_sb(dir), fno, &dno, &qbh0);
 	if (!dnode)
 		goto bail1;
 	memset(&dee, 0, sizeof dee);
@@ -50,15 +50,16 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	/*dee.archive = 0;*/
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
-	result = new_inode(dir->i_sb);
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(inode_sb(dir), get_seconds()));
+	result = new_inode(inode_sb(dir));
 	if (!result)
 		goto bail2;
 	hpfs_init_inode(result);
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
 	hpfs_i(result)->i_dno = dno;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
+	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(inode_sb(dir),
+												le32_to_cpu(dee.creation_date));
 	result->i_ctime.tv_nsec = 0; 
 	result->i_mtime.tv_nsec = 0; 
 	result->i_atime.tv_nsec = 0; 
@@ -90,8 +91,8 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	fnode->u.external[0].file_secno = cpu_to_le32(-1);
 	dnode->root_dnode = 1;
 	dnode->up = cpu_to_le32(fno);
-	de = hpfs_add_de(dir->i_sb, dnode, "\001\001", 2, 0);
-	de->creation_date = de->write_date = de->read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	de = hpfs_add_de(inode_sb(dir), dnode, "\001\001", 2, 0);
+	de->creation_date = de->write_date = de->read_date = cpu_to_le32(gmt_to_local(inode_sb(dir), get_seconds()));
 	if (!(mode & 0222)) de->read_only = 1;
 	de->first = de->directory = 1;
 	/*de->hidden = de->system = 0;*/
@@ -113,18 +114,18 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	}
 	hpfs_update_directory_times(dir);
 	d_instantiate(dentry, result);
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return 0;
 bail3:
 	iput(result);
 bail2:
 	hpfs_brelse4(&qbh0);
-	hpfs_free_dnode(dir->i_sb, dno);
+	hpfs_free_dnode(inode_sb(dir), dno);
 bail1:
 	brelse(bh);
-	hpfs_free_sectors(dir->i_sb, fno, 1);
+	hpfs_free_sectors(inode_sb(dir), fno, 1);
 bail:
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return err;
 }
 
@@ -141,9 +142,9 @@ static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 	int err;
 	if ((err = hpfs_chk_name(name, &len)))
 		return err==-ENOENT ? -EINVAL : err;
-	hpfs_lock(dir->i_sb);
+	hpfs_lock(inode_sb(dir));
 	err = -ENOSPC;
-	fnode = hpfs_alloc_fnode(dir->i_sb, hpfs_i(dir)->i_dno, &fno, &bh);
+	fnode = hpfs_alloc_fnode(inode_sb(dir), hpfs_i(dir)->i_dno, &fno, &bh);
 	if (!fnode)
 		goto bail;
 	memset(&dee, 0, sizeof dee);
@@ -151,9 +152,9 @@ static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(inode_sb(dir), get_seconds()));
 
-	result = new_inode(dir->i_sb);
+	result = new_inode(inode_sb(dir));
 	if (!result)
 		goto bail1;
 	
@@ -165,7 +166,8 @@ static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 	result->i_fop = &hpfs_file_ops;
 	set_nlink(result, 1);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
+	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(inode_sb(dir),
+												le32_to_cpu(dee.creation_date));
 	result->i_ctime.tv_nsec = 0;
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
@@ -202,16 +204,16 @@ static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 	}
 	hpfs_update_directory_times(dir);
 	d_instantiate(dentry, result);
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return 0;
 
 bail2:
 	iput(result);
 bail1:
 	brelse(bh);
-	hpfs_free_sectors(dir->i_sb, fno, 1);
+	hpfs_free_sectors(inode_sb(dir), fno, 1);
 bail:
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return err;
 }
 
@@ -227,10 +229,10 @@ static int hpfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, de
 	struct inode *result = NULL;
 	int err;
 	if ((err = hpfs_chk_name(name, &len))) return err==-ENOENT ? -EINVAL : err;
-	if (hpfs_sb(dir->i_sb)->sb_eas < 2) return -EPERM;
-	hpfs_lock(dir->i_sb);
+	if (hpfs_sb(inode_sb(dir))->sb_eas < 2) return -EPERM;
+	hpfs_lock(inode_sb(dir));
 	err = -ENOSPC;
-	fnode = hpfs_alloc_fnode(dir->i_sb, hpfs_i(dir)->i_dno, &fno, &bh);
+	fnode = hpfs_alloc_fnode(inode_sb(dir), hpfs_i(dir)->i_dno, &fno, &bh);
 	if (!fnode)
 		goto bail;
 	memset(&dee, 0, sizeof dee);
@@ -238,16 +240,17 @@ static int hpfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, de
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(inode_sb(dir), get_seconds()));
 
-	result = new_inode(dir->i_sb);
+	result = new_inode(inode_sb(dir));
 	if (!result)
 		goto bail1;
 
 	hpfs_init_inode(result);
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
+	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(inode_sb(dir),
+												le32_to_cpu(dee.creation_date));
 	result->i_ctime.tv_nsec = 0;
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
@@ -277,15 +280,15 @@ static int hpfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, de
 	hpfs_update_directory_times(dir);
 	d_instantiate(dentry, result);
 	brelse(bh);
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return 0;
 bail2:
 	iput(result);
 bail1:
 	brelse(bh);
-	hpfs_free_sectors(dir->i_sb, fno, 1);
+	hpfs_free_sectors(inode_sb(dir), fno, 1);
 bail:
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return err;
 }
 
@@ -301,28 +304,29 @@ static int hpfs_symlink(struct inode *dir, struct dentry *dentry, const char *sy
 	struct inode *result;
 	int err;
 	if ((err = hpfs_chk_name(name, &len))) return err==-ENOENT ? -EINVAL : err;
-	hpfs_lock(dir->i_sb);
-	if (hpfs_sb(dir->i_sb)->sb_eas < 2) {
-		hpfs_unlock(dir->i_sb);
+	hpfs_lock(inode_sb(dir));
+	if (hpfs_sb(inode_sb(dir))->sb_eas < 2) {
+		hpfs_unlock(inode_sb(dir));
 		return -EPERM;
 	}
 	err = -ENOSPC;
-	fnode = hpfs_alloc_fnode(dir->i_sb, hpfs_i(dir)->i_dno, &fno, &bh);
+	fnode = hpfs_alloc_fnode(inode_sb(dir), hpfs_i(dir)->i_dno, &fno, &bh);
 	if (!fnode)
 		goto bail;
 	memset(&dee, 0, sizeof dee);
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(inode_sb(dir), get_seconds()));
 
-	result = new_inode(dir->i_sb);
+	result = new_inode(inode_sb(dir));
 	if (!result)
 		goto bail1;
 	result->i_ino = fno;
 	hpfs_init_inode(result);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
+	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(inode_sb(dir),
+												le32_to_cpu(dee.creation_date));
 	result->i_ctime.tv_nsec = 0;
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
@@ -356,15 +360,15 @@ static int hpfs_symlink(struct inode *dir, struct dentry *dentry, const char *sy
 	hpfs_write_inode_nolock(result);
 	hpfs_update_directory_times(dir);
 	d_instantiate(dentry, result);
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return 0;
 bail2:
 	iput(result);
 bail1:
 	brelse(bh);
-	hpfs_free_sectors(dir->i_sb, fno, 1);
+	hpfs_free_sectors(inode_sb(dir), fno, 1);
 bail:
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return err;
 }
 
@@ -379,7 +383,7 @@ static int hpfs_unlink(struct inode *dir, struct dentry *dentry)
 	int r;
 	int err;
 
-	hpfs_lock(dir->i_sb);
+	hpfs_lock(inode_sb(dir));
 	hpfs_adjust_length(name, &len);
 
 	err = -ENOENT;
@@ -398,7 +402,8 @@ static int hpfs_unlink(struct inode *dir, struct dentry *dentry)
 	r = hpfs_remove_dirent(dir, dno, de, &qbh, 1);
 	switch (r) {
 	case 1:
-		hpfs_error(dir->i_sb, "there was error when removing dirent");
+		hpfs_error(inode_sb(dir),
+			   "there was error when removing dirent");
 		err = -EFSERROR;
 		break;
 	case 2:		/* no space for deleting */
@@ -415,7 +420,7 @@ static int hpfs_unlink(struct inode *dir, struct dentry *dentry)
 out:
 	if (!err)
 		hpfs_update_directory_times(dir);
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return err;
 }
 
@@ -432,7 +437,7 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 	int r;
 
 	hpfs_adjust_length(name, &len);
-	hpfs_lock(dir->i_sb);
+	hpfs_lock(inode_sb(dir));
 	err = -ENOENT;
 	de = map_dirent(dir, hpfs_i(dir)->i_dno, name, len, &dno, &qbh);
 	if (!de)
@@ -446,7 +451,8 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (!de->directory)
 		goto out1;
 
-	hpfs_count_dnodes(dir->i_sb, hpfs_i(inode)->i_dno, NULL, NULL, &n_items);
+	hpfs_count_dnodes(inode_sb(dir), hpfs_i(inode)->i_dno, NULL, NULL,
+			  &n_items);
 	err = -ENOTEMPTY;
 	if (n_items)
 		goto out1;
@@ -454,7 +460,8 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 	r = hpfs_remove_dirent(dir, dno, de, &qbh, 1);
 	switch (r) {
 	case 1:
-		hpfs_error(dir->i_sb, "there was error when removing dirent");
+		hpfs_error(inode_sb(dir),
+			   "there was error when removing dirent");
 		err = -EFSERROR;
 		break;
 	case 2:
@@ -471,7 +478,7 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 out:
 	if (!err)
 		hpfs_update_directory_times(dir);
-	hpfs_unlock(dir->i_sb);
+	hpfs_unlock(inode_sb(dir));
 	return err;
 }
 
@@ -484,20 +491,20 @@ static int hpfs_symlink_readpage(struct file *file, struct page *page)
 	int err;
 
 	err = -EIO;
-	hpfs_lock(i->i_sb);
-	if (!(fnode = hpfs_map_fnode(i->i_sb, i->i_ino, &bh)))
+	hpfs_lock(inode_sb(i));
+	if (!(fnode = hpfs_map_fnode(inode_sb(i), i->i_ino, &bh)))
 		goto fail;
-	err = hpfs_read_ea(i->i_sb, fnode, "SYMLINK", link, PAGE_SIZE);
+	err = hpfs_read_ea(inode_sb(i), fnode, "SYMLINK", link, PAGE_SIZE);
 	brelse(bh);
 	if (err)
 		goto fail;
-	hpfs_unlock(i->i_sb);
+	hpfs_unlock(inode_sb(i));
 	SetPageUptodate(page);
 	unlock_page(page);
 	return 0;
 
 fail:
-	hpfs_unlock(i->i_sb);
+	hpfs_unlock(inode_sb(i));
 	SetPageError(page);
 	unlock_page(page);
 	return err;
@@ -533,7 +540,7 @@ static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	err = 0;
 	hpfs_adjust_length(old_name, &old_len);
 
-	hpfs_lock(i->i_sb);
+	hpfs_lock(inode_sb(i));
 	/* order doesn't matter, due to VFS exclusion */
 	
 	/* Erm? Moving over the empty non-busy directory is perfectly legal */
@@ -543,7 +550,8 @@ static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	if (!(dep = map_dirent(old_dir, hpfs_i(old_dir)->i_dno, old_name, old_len, &dno, &qbh))) {
-		hpfs_error(i->i_sb, "lookup succeeded but map dirent failed");
+		hpfs_error(inode_sb(i),
+			   "lookup succeeded but map dirent failed");
 		err = -ENOENT;
 		goto end1;
 	}
@@ -561,7 +569,8 @@ static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 				hpfs_brelse4(&qbh1);
 				goto end;
 			}
-			hpfs_error(new_dir->i_sb, "hpfs_rename: could not find dirent");
+			hpfs_error(inode_sb(new_dir),
+				   "hpfs_rename: could not find dirent");
 			err = -EFSERROR;
 			goto end1;
 		}
@@ -572,7 +581,8 @@ static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (new_dir == old_dir) hpfs_brelse4(&qbh);
 
 	if ((r = hpfs_add_dirent(new_dir, new_name, new_len, &de))) {
-		if (r == -1) hpfs_error(new_dir->i_sb, "hpfs_rename: dirent already exists!");
+		if (r == -1) hpfs_error(inode_sb(new_dir),
+					"hpfs_rename: dirent already exists!");
 		err = r == 1 ? -ENOSPC : -EFSERROR;
 		if (new_dir != old_dir) hpfs_brelse4(&qbh);
 		goto end1;
@@ -580,13 +590,15 @@ static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	
 	if (new_dir == old_dir)
 		if (!(dep = map_dirent(old_dir, hpfs_i(old_dir)->i_dno, old_name, old_len, &dno, &qbh))) {
-			hpfs_error(i->i_sb, "lookup succeeded but map dirent failed at #2");
+			hpfs_error(inode_sb(i),
+				   "lookup succeeded but map dirent failed at #2");
 			err = -ENOENT;
 			goto end1;
 		}
 
 	if ((r = hpfs_remove_dirent(old_dir, dno, dep, &qbh, 0))) {
-		hpfs_error(i->i_sb, "hpfs_rename: could not remove dirent");
+		hpfs_error(inode_sb(i),
+			   "hpfs_rename: could not remove dirent");
 		err = r == 2 ? -ENOSPC : -EFSERROR;
 		goto end1;
 	}
@@ -597,7 +609,7 @@ static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		inc_nlink(new_dir);
 		drop_nlink(old_dir);
 	}
-	if ((fnode = hpfs_map_fnode(i->i_sb, i->i_ino, &bh))) {
+	if ((fnode = hpfs_map_fnode(inode_sb(i), i->i_ino, &bh))) {
 		fnode->up = cpu_to_le32(new_dir->i_ino);
 		fnode->len = new_len;
 		memcpy(fnode->name, new_name, new_len>15?15:new_len);
@@ -610,7 +622,7 @@ static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		hpfs_update_directory_times(old_dir);
 		hpfs_update_directory_times(new_dir);
 	}
-	hpfs_unlock(i->i_sb);
+	hpfs_unlock(inode_sb(i));
 	return err;
 }
 
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index f2c3ebcd309c..74351b3ca304 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -212,7 +212,11 @@ long hpfs_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 				return -EPERM;
 			if (copy_from_user(&range, (struct fstrim_range __user *)arg, sizeof(range)))
 				return -EFAULT;
-			r = hpfs_trim_fs(file_inode(file)->i_sb, range.start >> 9, (range.start + range.len) >> 9, (range.minlen + 511) >> 9, &n_trimmed);
+			r = hpfs_trim_fs(inode_sb(file_inode(file)),
+					 range.start >> 9,
+					 (range.start + range.len) >> 9,
+					 (range.minlen + 511) >> 9,
+					 &n_trimmed);
 			if (r)
 				return r;
 			range.len = (u64)n_trimmed << 9;
-- 
2.15.1
