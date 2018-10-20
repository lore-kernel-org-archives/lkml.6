Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4704FECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0F4214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0F4214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJTJUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:20:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:20:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF4183001A49;
        Sat, 20 Oct 2018 01:12:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43FAB19495;
        Sat, 20 Oct 2018 01:12:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/24] afs: Increase to 64-bit volume ID and 96-bit vnode ID
 for YFS
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:12:04 +0100
Message-ID: <153999792445.866.2510021574177838311.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 20 Oct 2018 01:12:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the sizes of the volume ID to 64 bits and the vnode ID (inode
number equivalent) to 96 bits to allow the support of YFS.

This requires the iget comparator to check the vnode->fid rather than i_ino
and i_generation as i_ino is not sufficiently capacious.  It also requires
this data to be placed into the vnode cache key for fscache.

For the moment, just discard the top 32 bits of the vnode ID when returning
it though stat.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h               |   11 ++++++-----
 fs/afs/cache.c             |    2 +-
 fs/afs/callback.c          |    2 +-
 fs/afs/dir.c               |   24 ++++++++++++------------
 fs/afs/dynroot.c           |    2 +-
 fs/afs/file.c              |    8 ++++----
 fs/afs/flock.c             |   22 +++++++++++-----------
 fs/afs/fsclient.c          |   24 ++++++++++++------------
 fs/afs/inode.c             |   31 +++++++++++++++++--------------
 fs/afs/proc.c              |    2 +-
 fs/afs/rotate.c            |    2 +-
 fs/afs/security.c          |    6 +++---
 fs/afs/super.c             |    5 +++--
 fs/afs/volume.c            |    2 +-
 fs/afs/write.c             |   18 +++++++++---------
 fs/afs/xattr.c             |    2 +-
 include/trace/events/afs.h |    4 ++--
 17 files changed, 86 insertions(+), 81 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index b4ff1f7ae4ab..c23b31b742fa 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -23,9 +23,9 @@
 #define AFSPATHMAX		1024	/* Maximum length of a pathname plus NUL */
 #define AFSOPAQUEMAX		1024	/* Maximum length of an opaque field */
 
-typedef unsigned			afs_volid_t;
-typedef unsigned			afs_vnodeid_t;
-typedef unsigned long long		afs_dataversion_t;
+typedef u64			afs_volid_t;
+typedef u64			afs_vnodeid_t;
+typedef u64			afs_dataversion_t;
 
 typedef enum {
 	AFSVL_RWVOL,			/* read/write volume */
@@ -52,8 +52,9 @@ typedef enum {
  */
 struct afs_fid {
 	afs_volid_t	vid;		/* volume ID */
-	afs_vnodeid_t	vnode;		/* file index within volume */
-	unsigned	unique;		/* unique ID number (file index version) */
+	afs_vnodeid_t	vnode;		/* Lower 64-bits of file index within volume */
+	u32		vnode_hi;	/* Upper 32-bits of file index */
+	u32		unique;		/* unique ID number (file index version) */
 };
 
 /*
diff --git a/fs/afs/cache.c b/fs/afs/cache.c
index b1c31ec4523a..f6d0a21e8052 100644
--- a/fs/afs/cache.c
+++ b/fs/afs/cache.c
@@ -49,7 +49,7 @@ static enum fscache_checkaux afs_vnode_cache_check_aux(void *cookie_netfs_data,
 	struct afs_vnode *vnode = cookie_netfs_data;
 	struct afs_vnode_cache_aux aux;
 
-	_enter("{%x,%x,%llx},%p,%u",
+	_enter("{%llx,%x,%llx},%p,%u",
 	       vnode->fid.vnode, vnode->fid.unique, vnode->status.data_version,
 	       buffer, buflen);
 
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 5f261fbf2182..8698198ad427 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -310,7 +310,7 @@ void afs_break_callbacks(struct afs_server *server, size_t count,
 	/* TODO: Sort the callback break list by volume ID */
 
 	for (; count > 0; callbacks++, count--) {
-		_debug("- Fid { vl=%08x n=%u u=%u }  CB { v=%u x=%u t=%u }",
+		_debug("- Fid { vl=%08llx n=%llu u=%u }  CB { v=%u x=%u t=%u }",
 		       callbacks->fid.vid,
 		       callbacks->fid.vnode,
 		       callbacks->fid.unique,
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78f9754fd03d..024b7cf7441c 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -552,7 +552,7 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
 	}
 
 	*fid = cookie.fid;
-	_leave(" = 0 { vn=%u u=%u }", fid->vnode, fid->unique);
+	_leave(" = 0 { vn=%llu u=%u }", fid->vnode, fid->unique);
 	return 0;
 }
 
@@ -830,7 +830,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	struct key *key;
 	int ret;
 
-	_enter("{%x:%u},%p{%pd},",
+	_enter("{%llx:%llu},%p{%pd},",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry, dentry);
 
 	ASSERTCMP(d_inode(dentry), ==, NULL);
@@ -900,7 +900,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
-		_enter("{v={%x:%u} n=%pd fl=%lx},",
+		_enter("{v={%llx:%llu} n=%pd fl=%lx},",
 		       vnode->fid.vid, vnode->fid.vnode, dentry,
 		       vnode->flags);
 	} else {
@@ -969,7 +969,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 		/* if the vnode ID has changed, then the dirent points to a
 		 * different file */
 		if (fid.vnode != vnode->fid.vnode) {
-			_debug("%pd: dirent changed [%u != %u]",
+			_debug("%pd: dirent changed [%llu != %llu]",
 			       dentry, fid.vnode,
 			       vnode->fid.vnode);
 			goto not_found;
@@ -1108,7 +1108,7 @@ static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	mode |= S_IFDIR;
 
-	_enter("{%x:%u},{%pd},%ho",
+	_enter("{%llx:%llu},{%pd},%ho",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry, mode);
 
 	key = afs_request_key(dvnode->volume->cell);
@@ -1178,7 +1178,7 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 	u64 data_version = dvnode->status.data_version;
 	int ret;
 
-	_enter("{%x:%u},{%pd}",
+	_enter("{%llx:%llu},{%pd}",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry);
 
 	key = afs_request_key(dvnode->volume->cell);
@@ -1270,7 +1270,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	u64 data_version = dvnode->status.data_version;
 	int ret;
 
-	_enter("{%x:%u},{%pd}",
+	_enter("{%llx:%llu},{%pd}",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry);
 
 	if (dentry->d_name.len >= AFSNAMEMAX)
@@ -1334,7 +1334,7 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	mode |= S_IFREG;
 
-	_enter("{%x:%u},{%pd},%ho,",
+	_enter("{%llx:%llu},{%pd},%ho,",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry, mode);
 
 	ret = -ENAMETOOLONG;
@@ -1397,7 +1397,7 @@ static int afs_link(struct dentry *from, struct inode *dir,
 	dvnode = AFS_FS_I(dir);
 	data_version = dvnode->status.data_version;
 
-	_enter("{%x:%u},{%x:%u},{%pd}",
+	_enter("{%llx:%llu},{%llx:%llu},{%pd}",
 	       vnode->fid.vid, vnode->fid.vnode,
 	       dvnode->fid.vid, dvnode->fid.vnode,
 	       dentry);
@@ -1468,7 +1468,7 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 	u64 data_version = dvnode->status.data_version;
 	int ret;
 
-	_enter("{%x:%u},{%pd},%s",
+	_enter("{%llx:%llu},{%pd},%s",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry,
 	       content);
 
@@ -1544,7 +1544,7 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	orig_data_version = orig_dvnode->status.data_version;
 	new_data_version = new_dvnode->status.data_version;
 
-	_enter("{%x:%u},{%x:%u},{%x:%u},{%pd}",
+	_enter("{%llx:%llu},{%llx:%llu},{%llx:%llu},{%pd}",
 	       orig_dvnode->fid.vid, orig_dvnode->fid.vnode,
 	       vnode->fid.vid, vnode->fid.vnode,
 	       new_dvnode->fid.vid, new_dvnode->fid.vnode,
@@ -1611,7 +1611,7 @@ static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(page->mapping->host);
 
-	_enter("{{%x:%u}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, page->index);
+	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, page->index);
 
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 0efed0a63080..a9ba81ddf154 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -62,7 +62,7 @@ struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 	struct inode *inode;
 	int ret = -ENOENT;
 
-	_enter("%p{%pd}, {%x:%u}",
+	_enter("%p{%pd}, {%llx:%llu}",
 	       dentry, dentry, vnode->fid.vid, vnode->fid.vnode);
 
 	if (!test_bit(AFS_VNODE_AUTOCELL, &vnode->flags))
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 7d4f26198573..d6bc3f5d784b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -121,7 +121,7 @@ int afs_open(struct inode *inode, struct file *file)
 	struct key *key;
 	int ret;
 
-	_enter("{%x:%u},", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu},", vnode->fid.vid, vnode->fid.vnode);
 
 	key = afs_request_key(vnode->volume->cell);
 	if (IS_ERR(key)) {
@@ -170,7 +170,7 @@ int afs_release(struct inode *inode, struct file *file)
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = file->private_data;
 
-	_enter("{%x:%u},", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu},", vnode->fid.vid, vnode->fid.vnode);
 
 	if ((file->f_mode & FMODE_WRITE))
 		return vfs_fsync(file, 0);
@@ -228,7 +228,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *de
 	struct afs_fs_cursor fc;
 	int ret;
 
-	_enter("%s{%x:%u.%u},%x,,,",
+	_enter("%s{%llx:%llu.%u},%x,,,",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
@@ -634,7 +634,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
 	unsigned long priv;
 
-	_enter("{{%x:%u}[%lu],%lx},%x",
+	_enter("{{%llx:%llu}[%lu],%lx},%x",
 	       vnode->fid.vid, vnode->fid.vnode, page->index, page->flags,
 	       gfp_flags);
 
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index dc62d15a964b..0568fd986821 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -29,7 +29,7 @@ static const struct file_lock_operations afs_lock_ops = {
  */
 void afs_lock_may_be_available(struct afs_vnode *vnode)
 {
-	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 	queue_delayed_work(afs_lock_manager, &vnode->lock_work, 0);
 }
@@ -76,7 +76,7 @@ static int afs_set_lock(struct afs_vnode *vnode, struct key *key,
 	struct afs_fs_cursor fc;
 	int ret;
 
-	_enter("%s{%x:%u.%u},%x,%u",
+	_enter("%s{%llx:%llu.%u},%x,%u",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
@@ -107,7 +107,7 @@ static int afs_extend_lock(struct afs_vnode *vnode, struct key *key)
 	struct afs_fs_cursor fc;
 	int ret;
 
-	_enter("%s{%x:%u.%u},%x",
+	_enter("%s{%llx:%llu.%u},%x",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
@@ -138,7 +138,7 @@ static int afs_release_lock(struct afs_vnode *vnode, struct key *key)
 	struct afs_fs_cursor fc;
 	int ret;
 
-	_enter("%s{%x:%u.%u},%x",
+	_enter("%s{%llx:%llu.%u},%x",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
@@ -175,7 +175,7 @@ void afs_lock_work(struct work_struct *work)
 	struct key *key;
 	int ret;
 
-	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 	spin_lock(&vnode->lock);
 
@@ -192,7 +192,7 @@ void afs_lock_work(struct work_struct *work)
 		ret = afs_release_lock(vnode, vnode->lock_key);
 		if (ret < 0)
 			printk(KERN_WARNING "AFS:"
-			       " Failed to release lock on {%x:%x} error %d\n",
+			       " Failed to release lock on {%llx:%llx} error %d\n",
 			       vnode->fid.vid, vnode->fid.vnode, ret);
 
 		spin_lock(&vnode->lock);
@@ -229,7 +229,7 @@ void afs_lock_work(struct work_struct *work)
 		key_put(key);
 
 		if (ret < 0)
-			pr_warning("AFS: Failed to extend lock on {%x:%x} error %d\n",
+			pr_warning("AFS: Failed to extend lock on {%llx:%llx} error %d\n",
 				   vnode->fid.vid, vnode->fid.vnode, ret);
 
 		spin_lock(&vnode->lock);
@@ -430,7 +430,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	struct key *key = afs_file_key(file);
 	int ret;
 
-	_enter("{%x:%u},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
+	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
 
 	/* only whole-file locks are supported */
 	if (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX)
@@ -582,7 +582,7 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
 	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
 	int ret;
 
-	_enter("{%x:%u},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
+	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
 
 	/* Flush all pending writes before doing anything with locks. */
 	vfs_fsync(file, 0);
@@ -639,7 +639,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
 
-	_enter("{%x:%u},%d,{t=%x,fl=%x,r=%Ld:%Ld}",
+	_enter("{%llx:%llu},%d,{t=%x,fl=%x,r=%Ld:%Ld}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
 	       fl->fl_type, fl->fl_flags,
 	       (long long) fl->fl_start, (long long) fl->fl_end);
@@ -662,7 +662,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
 
-	_enter("{%x:%u},%d,{t=%x,fl=%x}",
+	_enter("{%llx:%llu},%d,{t=%x,fl=%x}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
 	       fl->fl_type, fl->fl_flags);
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index fe2e9e39b388..5e3027f21390 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -90,7 +90,7 @@ void afs_update_inode_from_status(struct afs_vnode *vnode,
 	if (!(flags & AFS_VNODE_NOT_YET_SET)) {
 		if (expected_version &&
 		    *expected_version != status->data_version) {
-			_debug("vnode modified %llx on {%x:%u} [exp %llx]",
+			_debug("vnode modified %llx on {%llx:%llu} [exp %llx]",
 			       (unsigned long long) status->data_version,
 			       vnode->fid.vid, vnode->fid.vnode,
 			       (unsigned long long) *expected_version);
@@ -164,7 +164,7 @@ static int xdr_decode_AFSFetchStatus(struct afs_call *call,
 		if (type != status->type &&
 		    vnode &&
 		    !test_bit(AFS_VNODE_UNSET, &vnode->flags)) {
-			pr_warning("Vnode %x:%x:%x changed type %u to %u\n",
+			pr_warning("Vnode %llx:%llx:%x changed type %u to %u\n",
 				   vnode->fid.vid,
 				   vnode->fid.vnode,
 				   vnode->fid.unique,
@@ -389,7 +389,7 @@ static int afs_deliver_fs_fetch_status_vnode(struct afs_call *call)
 	if (ret < 0)
 		return ret;
 
-	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
@@ -426,7 +426,7 @@ int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
-	_enter(",%x,{%x:%u},,",
+	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	call = afs_alloc_flat_call(net, &afs_RXFSFetchStatus_vnode,
@@ -1261,7 +1261,7 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
-	_enter(",%x,{%x:%u},,",
+	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	call = afs_alloc_flat_call(net, &afs_RXFSStoreData64,
@@ -1318,7 +1318,7 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 	loff_t size, pos, i_size;
 	__be32 *bp;
 
-	_enter(",%x,{%x:%u},,",
+	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	size = (loff_t)to - (loff_t)offset;
@@ -1440,7 +1440,7 @@ static int afs_fs_setattr_size64(struct afs_fs_cursor *fc, struct iattr *attr)
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
-	_enter(",%x,{%x:%u},,",
+	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	ASSERT(attr->ia_valid & ATTR_SIZE);
@@ -1487,7 +1487,7 @@ static int afs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr)
 	struct afs_net *net = afs_v2net(vnode);
 	__be32 *bp;
 
-	_enter(",%x,{%x:%u},,",
+	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	ASSERT(attr->ia_valid & ATTR_SIZE);
@@ -1536,7 +1536,7 @@ int afs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr)
 	if (attr->ia_valid & ATTR_SIZE)
 		return afs_fs_setattr_size(fc, attr);
 
-	_enter(",%x,{%x:%u},,",
+	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	call = afs_alloc_flat_call(net, &afs_RXFSStoreStatus,
@@ -2034,7 +2034,7 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 	if (ret < 0)
 		return ret;
 
-	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
@@ -2079,7 +2079,7 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
 	struct afs_call *call;
 	__be32 *bp;
 
-	_enter(",%x,{%x:%u},,",
+	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), fid->vid, fid->vnode);
 
 	call = afs_alloc_flat_call(net, &afs_RXFSFetchStatus, 16, (21 + 3 + 6) * 4);
@@ -2250,7 +2250,7 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	__be32 *bp;
 	int i;
 
-	_enter(",%x,{%x:%u},%u",
+	_enter(",%x,{%llx:%llu},%u",
 	       key_serial(fc->key), fids[0].vid, fids[1].vnode, nr_fids);
 
 	call = afs_alloc_flat_call(net, &afs_RXFSInlineBulkStatus,
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index ab4e7a15c205..4ba47efe9668 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -100,7 +100,7 @@ int afs_fetch_status(struct afs_vnode *vnode, struct key *key, bool new_inode)
 	struct afs_fs_cursor fc;
 	int ret;
 
-	_enter("%s,{%x:%u.%u,S=%lx}",
+	_enter("%s,{%llx:%llu.%u,S=%lx}",
 	       vnode->volume->name,
 	       vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique,
 	       vnode->flags);
@@ -127,9 +127,9 @@ int afs_fetch_status(struct afs_vnode *vnode, struct key *key, bool new_inode)
 int afs_iget5_test(struct inode *inode, void *opaque)
 {
 	struct afs_iget_data *data = opaque;
+	struct afs_vnode *vnode = AFS_FS_I(inode);
 
-	return inode->i_ino == data->fid.vnode &&
-		inode->i_generation == data->fid.unique;
+	return memcmp(&vnode->fid, &data->fid, sizeof(data->fid)) == 0;
 }
 
 /*
@@ -150,11 +150,14 @@ static int afs_iget5_set(struct inode *inode, void *opaque)
 	struct afs_iget_data *data = opaque;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 
-	inode->i_ino = data->fid.vnode;
-	inode->i_generation = data->fid.unique;
 	vnode->fid = data->fid;
 	vnode->volume = data->volume;
 
+	/* YFS supports 96-bit vnode IDs, but Linux only supports
+	 * 64-bit inode numbers.
+	 */
+	inode->i_ino = data->fid.vnode;
+	inode->i_generation = data->fid.unique;
 	return 0;
 }
 
@@ -193,7 +196,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	_debug("GOT INODE %p { ino=%lu, vl=%x, vn=%x, u=%x }",
+	_debug("GOT INODE %p { ino=%lu, vl=%llx, vn=%llx, u=%x }",
 	       inode, inode->i_ino, data.fid.vid, data.fid.vnode,
 	       data.fid.unique);
 
@@ -252,8 +255,8 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 
 	key.vnode_id		= vnode->fid.vnode;
 	key.unique		= vnode->fid.unique;
-	key.vnode_id_ext[0]	= 0;
-	key.vnode_id_ext[1]	= 0;
+	key.vnode_id_ext[0]	= vnode->fid.vnode >> 32;
+	key.vnode_id_ext[1]	= vnode->fid.vnode_hi;
 	aux.data_version	= vnode->status.data_version;
 
 	vnode->cache = fscache_acquire_cookie(vnode->volume->cache,
@@ -277,7 +280,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 	struct inode *inode;
 	int ret;
 
-	_enter(",{%x:%u.%u},,", fid->vid, fid->vnode, fid->unique);
+	_enter(",{%llx:%llu.%u},,", fid->vid, fid->vnode, fid->unique);
 
 	as = sb->s_fs_info;
 	data.volume = as->volume;
@@ -289,7 +292,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	_debug("GOT INODE %p { vl=%x vn=%x, u=%x }",
+	_debug("GOT INODE %p { vl=%llx vn=%llx, u=%x }",
 	       inode, fid->vid, fid->vnode, fid->unique);
 
 	vnode = AFS_FS_I(inode);
@@ -352,7 +355,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
  */
 void afs_zap_data(struct afs_vnode *vnode)
 {
-	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 #ifdef CONFIG_AFS_FSCACHE
 	fscache_invalidate(vnode->cache);
@@ -382,7 +385,7 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	bool valid = false;
 	int ret;
 
-	_enter("{v={%x:%u} fl=%lx},%x",
+	_enter("{v={%llx:%llu} fl=%lx},%x",
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
 	       key_serial(key));
 
@@ -501,7 +504,7 @@ void afs_evict_inode(struct inode *inode)
 
 	vnode = AFS_FS_I(inode);
 
-	_enter("{%x:%u.%d}",
+	_enter("{%llx:%llu.%d}",
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique);
@@ -550,7 +553,7 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	struct key *key;
 	int ret;
 
-	_enter("{%x:%u},{n=%pd},%x",
+	_enter("{%llx:%llu},{n=%pd},%x",
 	       vnode->fid.vid, vnode->fid.vnode, dentry,
 	       attr->ia_valid);
 
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index fc36c41641ab..d887f822f4eb 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -221,7 +221,7 @@ static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 		return 0;
 	}
 
-	seq_printf(m, "%3d %08x %s\n",
+	seq_printf(m, "%3d %08llx %s\n",
 		   atomic_read(&vol->usage), vol->vid,
 		   afs_vol_types[vol->type]);
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index d7cbc3c230ee..41405dde0113 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -118,7 +118,7 @@ static void afs_busy(struct afs_volume *volume, u32 abort_code)
 	default:		m = "busy";		break;
 	}
 
-	pr_notice("kAFS: Volume %u '%s' is %s\n", volume->vid, volume->name, m);
+	pr_notice("kAFS: Volume %llu '%s' is %s\n", volume->vid, volume->name, m);
 }
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 81dfedb7879f..d1ae53fd3739 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -126,7 +126,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 	bool changed = false;
 	int i, j;
 
-	_enter("{%x:%u},%x,%x",
+	_enter("{%llx:%llu},%x,%x",
 	       vnode->fid.vid, vnode->fid.vnode, key_serial(key), caller_access);
 
 	rcu_read_lock();
@@ -289,7 +289,7 @@ int afs_check_permit(struct afs_vnode *vnode, struct key *key,
 	bool valid = false;
 	int i, ret;
 
-	_enter("{%x:%u},%x",
+	_enter("{%llx:%llu},%x",
 	       vnode->fid.vid, vnode->fid.vnode, key_serial(key));
 
 	/* check the permits to see if we've got one yet */
@@ -349,7 +349,7 @@ int afs_permission(struct inode *inode, int mask)
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
-	_enter("{{%x:%u},%lx},%x,",
+	_enter("{{%llx:%llu},%lx},%x,",
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags, mask);
 
 	key = afs_request_key(vnode->volume->cell);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 4d3e274207fb..dcd07fe99871 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -406,10 +406,11 @@ static int afs_fill_super(struct super_block *sb,
 		inode = afs_iget_pseudo_dir(sb, true);
 		sb->s_flags	|= SB_RDONLY;
 	} else {
-		sprintf(sb->s_id, "%u", as->volume->vid);
+		sprintf(sb->s_id, "%llu", as->volume->vid);
 		afs_activate_volume(as->volume);
 		fid.vid		= as->volume->vid;
 		fid.vnode	= 1;
+		fid.vnode_hi	= 0;
 		fid.unique	= 1;
 		inode = afs_iget(sb, params->key, &fid, NULL, NULL, NULL);
 	}
@@ -663,7 +664,7 @@ static void afs_destroy_inode(struct inode *inode)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 
-	_enter("%p{%x:%u}", inode, vnode->fid.vid, vnode->fid.vnode);
+	_enter("%p{%llx:%llu}", inode, vnode->fid.vid, vnode->fid.vnode);
 
 	_debug("DESTROY INODE %p", inode);
 
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 1cd263fa6028..f0020e35bf6f 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -250,7 +250,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	/* We look up an ID by passing it as a decimal string in the
 	 * operation's name parameter.
 	 */
-	idsz = sprintf(idbuf, "%u", volume->vid);
+	idsz = sprintf(idbuf, "%llu", volume->vid);
 
 	vldb = afs_vl_lookup_vldb(volume->cell, key, idbuf, idsz);
 	if (IS_ERR(vldb)) {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 11066a3248ba..72efcfcf9f95 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -92,7 +92,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int ret;
 
-	_enter("{%x:%u},{%lx},%u,%u",
+	_enter("{%llx:%llu},{%lx},%u,%u",
 	       vnode->fid.vid, vnode->fid.vnode, index, from, to);
 
 	/* We want to store information about how much of a page is altered in
@@ -192,7 +192,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	loff_t i_size, maybe_i_size;
 	int ret;
 
-	_enter("{%x:%u},{%lx}",
+	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
 
 	maybe_i_size = pos + copied;
@@ -241,7 +241,7 @@ static void afs_kill_pages(struct address_space *mapping,
 	struct pagevec pv;
 	unsigned count, loop;
 
-	_enter("{%x:%u},%lx-%lx",
+	_enter("{%llx:%llu},%lx-%lx",
 	       vnode->fid.vid, vnode->fid.vnode, first, last);
 
 	pagevec_init(&pv);
@@ -283,7 +283,7 @@ static void afs_redirty_pages(struct writeback_control *wbc,
 	struct pagevec pv;
 	unsigned count, loop;
 
-	_enter("{%x:%u},%lx-%lx",
+	_enter("{%llx:%llu},%lx-%lx",
 	       vnode->fid.vid, vnode->fid.vnode, first, last);
 
 	pagevec_init(&pv);
@@ -325,7 +325,7 @@ static int afs_store_data(struct address_space *mapping,
 	struct list_head *p;
 	int ret = -ENOKEY, ret2;
 
-	_enter("%s{%x:%u.%u},%lx,%lx,%x,%x",
+	_enter("%s{%llx:%llu.%u},%lx,%lx,%x,%x",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
@@ -687,7 +687,7 @@ void afs_pages_written_back(struct afs_vnode *vnode, struct afs_call *call)
 	unsigned count, loop;
 	pgoff_t first = call->first, last = call->last;
 
-	_enter("{%x:%u},{%lx-%lx}",
+	_enter("{%llx:%llu},{%lx-%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, first, last);
 
 	pagevec_init(&pv);
@@ -726,7 +726,7 @@ ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t result;
 	size_t count = iov_iter_count(from);
 
-	_enter("{%x.%u},{%zu},",
+	_enter("{%llx:%llu},{%zu},",
 	       vnode->fid.vid, vnode->fid.vnode, count);
 
 	if (IS_SWAPFILE(&vnode->vfs_inode)) {
@@ -754,7 +754,7 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 
-	_enter("{%x:%u},{n=%pD},%d",
+	_enter("{%llx:%llu},{n=%pD},%d",
 	       vnode->fid.vid, vnode->fid.vnode, file,
 	       datasync);
 
@@ -772,7 +772,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	unsigned long priv;
 
-	_enter("{{%x:%u}},{%lx}",
+	_enter("{{%llx:%llu}},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, vmf->page->index);
 
 	sb_start_pagefault(inode->i_sb);
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index cfcc674e64a5..a2cdf25573e2 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -72,7 +72,7 @@ static int afs_xattr_get_fid(const struct xattr_handler *handler,
 	char text[8 + 1 + 8 + 1 + 8 + 1];
 	size_t len;
 
-	len = sprintf(text, "%x:%x:%x",
+	len = sprintf(text, "%llx:%llx:%x",
 		      vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique);
 	if (size == 0)
 		return len;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 48b20a261d39..8acd56e20a37 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -374,7 +374,7 @@ TRACE_EVENT(afs_make_fs_call,
 		    }
 			   ),
 
-	    TP_printk("c=%08x %06x:%06x:%06x %s",
+	    TP_printk("c=%08x %06llx:%06llx:%06x %s",
 		      __entry->call,
 		      __entry->fid.vid,
 		      __entry->fid.vnode,
@@ -688,7 +688,7 @@ TRACE_EVENT(afs_file_error,
 		    __entry->where = where;
 			   ),
 
-	    TP_printk("%x:%x:%x r=%d %s",
+	    TP_printk("%llx:%llx:%x r=%d %s",
 		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique,
 		      __entry->error,
 		      __print_symbolic(__entry->where, afs_file_errors))

