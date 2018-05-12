Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeELFB6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 01:01:58 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:43687 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeELFBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 01:01:52 -0400
X-Google-Smtp-Source: AB8JxZr/mnsMaoswhTjUx4uGNE1D/Bt4qW1ASUKListzr4Rx257RfjTk9jX2Tvnug7GPBGt5olsXkQ==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        anton@tuxera.com, balbi@kernel.org, bfields@fieldses.org,
        darrick.wong@oracle.com, dhowells@redhat.com, dsterba@suse.com,
        dwmw2@infradead.org, hch@lst.de, hirofumi@mail.parknet.co.jp,
        hubcap@omnibond.com, jack@suse.com, jaegeuk@kernel.org,
        jaharkes@cs.cmu.edu, jslaby@suse.com, keescook@chromium.org,
        mark@fasheh.com, miklos@szeredi.hu, nico@linaro.org,
        reiserfs-devel@vger.kernel.org, richard@nod.at, sage@redhat.com,
        sfrench@samba.org, swhiteho@redhat.com, tj@kernel.org,
        trond.myklebust@primarydata.com, tytso@mit.edu
Subject: [PATCH 6/6] vfs: change inode times to use struct timespec64
Date: Fri, 11 May 2018 21:59:21 -0700
Message-Id: <20180512045921.18311-7-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180512045921.18311-1-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timespec is not y2038 safe. Transition vfs to use
y2038 safe struct timespec64 instead.

The change was made with the help of the following cocinelle
script. This catches about 80% of the changes.
All the header file and logic changes are included in the
first 5 rules. The rest are trivial substitutions.
I avoid changing any of the function signatures or any other
filesystem specific data structures to keep the patch simple
for review.

The script can be a little shorter by combining different cases.
But, this version was sufficient for my usecase.

virtual patch

@ depends on patch @
identifier now;
@@
- struct timespec
+ struct timespec64
  current_time ( ... )
  {
- struct timespec now = current_kernel_time();
+ struct timespec64 now = current_kernel_time64();
  ...
- return timespec_trunc(
+ return timespec64_trunc(
  ... );
  }

@ depends on patch @
identifier xtime;
@@
 struct \( iattr \| inode \| kstat \) {
 ...
-       struct timespec xtime;
+       struct timespec64 xtime;
 ...
 }

@ depends on patch @
identifier t;
@@
 struct inode_operations {
 ...
int (*update_time) (...,
-       struct timespec t,
+       struct timespec64 t,
...);
 ...
 }

@ depends on patch @
identifier t;
identifier fn_update_time =~ "update_time$";
@@
 fn_update_time (...,
- struct timespec *t,
+ struct timespec64 *t,
 ...) { ... }

@ depends on patch @
identifier t;
@@
lease_get_mtime( ... ,
- struct timespec *t
+ struct timespec64 *t
  ) { ... }

@te depends on patch forall@
identifier ts;
local idexpression struct inode *inode_node;
identifier i_xtime =~ "^i_[acm]time$";
identifier ia_xtime =~ "^ia_[acm]time$";
identifier fn_update_time =~ "update_time$";
identifier fn;
expression e, E3;
local idexpression struct inode *node1;
local idexpression struct inode *node2;
local idexpression struct iattr *attr1;
local idexpression struct iattr *attr2;
local idexpression struct iattr attr;
identifier i_xtime1 =~ "^i_[acm]time$";
identifier i_xtime2 =~ "^i_[acm]time$";
identifier ia_xtime1 =~ "^ia_[acm]time$";
identifier ia_xtime2 =~ "^ia_[acm]time$";
@@
(
(
- struct timespec ts;
+ struct timespec64 ts;
|
- struct timespec ts = current_time(inode_node);
+ struct timespec64 ts = current_time(inode_node);
)

<+... when != ts
(
- timespec_equal(&inode_node->i_xtime, &ts)
+ timespec64_equal(&inode_node->i_xtime, &ts)
|
- timespec_equal(&ts, &inode_node->i_xtime)
+ timespec64_equal(&ts, &inode_node->i_xtime)
|
- timespec_compare(&inode_node->i_xtime, &ts)
+ timespec64_compare(&inode_node->i_xtime, &ts)
|
- timespec_compare(&ts, &inode_node->i_xtime)
+ timespec64_compare(&ts, &inode_node->i_xtime)
|
ts = current_time(e)
|
fn_update_time(..., &ts,...)
|
inode_node->i_xtime = ts
|
node1->i_xtime = ts
|
ts = inode_node->i_xtime
|
<+... attr1->ia_xtime ...+> = ts
|
ts = attr1->ia_xtime
|
ts.tv_sec
|
ts.tv_nsec
|
btrfs_set_stack_timespec_sec(..., ts.tv_sec)
|
btrfs_set_stack_timespec_nsec(..., ts.tv_nsec)
|
- ts = timespec64_to_timespec(
+ ts =
...
-)
|
- ts = ktime_to_timespec(
+ ts = ktime_to_timespec64(
...)
|
- ts = E3
+ ts = timespec_to_timespec64(E3)
|
- ktime_get_real_ts(&ts)
+ ktime_get_real_ts64(&ts)
|
fn(...,
- ts
+ timespec64_to_timespec(ts)
,...)
)
...+>
(
<... when != ts
- return ts;
+ return timespec64_to_timespec(ts);
...>
)
|
- timespec_equal(&node1->i_xtime1, &node2->i_xtime2)
+ timespec64_equal(&node1->i_xtime2, &node2->i_xtime2)
|
- timespec_equal(&node1->i_xtime1, &attr2->ia_xtime2)
+ timespec64_equal(&node1->i_xtime2, &attr2->ia_xtime2)
|
- timespec_compare(&node1->i_xtime1, &node2->i_xtime2)
+ timespec64_compare(&node1->i_xtime1, &node2->i_xtime2)
|
node1->i_xtime1 =
- timespec_trunc(attr1->ia_xtime1,
+ timespec64_trunc(attr1->ia_xtime1,
...)
|
- attr1->ia_xtime1 = timespec_trunc(attr2->ia_xtime2,
+ attr1->ia_xtime1 =  timespec64_trunc(attr2->ia_xtime2,
...)
|
- ktime_get_real_ts(&attr1->ia_xtime1)
+ ktime_get_real_ts64(&attr1->ia_xtime1)
|
- ktime_get_real_ts(&attr.ia_xtime1)
+ ktime_get_real_ts64(&attr.ia_xtime1)
)

@ depends on patch @
struct inode *node;
struct iattr *attr;
identifier fn;
identifier i_xtime =~ "^i_[acm]time$";
identifier ia_xtime =~ "^ia_[acm]time$";
expression e;
@@
(
- fn(node->i_xtime);
+ fn(timespec64_to_timespec(node->i_xtime));
|
 fn(...,
- node->i_xtime);
+ timespec64_to_timespec(node->i_xtime));
|
- e = fn(attr->ia_xtime);
+ e = fn(timespec64_to_timespec(attr->ia_xtime));
)

@ depends on patch forall @
struct inode *node;
struct iattr *attr;
identifier i_xtime =~ "^i_[acm]time$";
identifier ia_xtime =~ "^ia_[acm]time$";
identifier fn;
@@
{
+ struct timespec ts;
<+...
(
+ ts = timespec64_to_timespec(node->i_xtime);
fn (...,
- &node->i_xtime,
+ &ts,
...);
|
+ ts = timespec64_to_timespec(attr->ia_xtime);
fn (...,
- &attr->ia_xtime,
+ &ts,
...);
)
...+>
}

@ depends on patch forall @
struct inode *node;
struct iattr *attr;
struct kstat *stat;
identifier ia_xtime =~ "^ia_[acm]time$";
identifier i_xtime =~ "^i_[acm]time$";
identifier xtime =~ "^[acm]time$";
identifier fn, ret;
@@
{
+ struct timespec ts;
<+...
(
+ ts = timespec64_to_timespec(node->i_xtime);
ret = fn (...,
- &node->i_xtime,
+ &ts,
...);
|
+ ts = timespec64_to_timespec(node->i_xtime);
ret = fn (...,
- &node->i_xtime);
+ &ts);
|
+ ts = timespec64_to_timespec(attr->ia_xtime);
ret = fn (...,
- &attr->ia_xtime,
+ &ts,
...);
|
+ ts = timespec64_to_timespec(attr->ia_xtime);
ret = fn (...,
- &attr->ia_xtime);
+ &ts);
|
+ ts = timespec64_to_timespec(stat->xtime);
ret = fn (...,
- &stat->xtime);
+ &ts);
)
...+>
}

@ depends on patch @
struct inode *node;
struct inode *node2;
identifier i_xtime1 =~ "^i_[acm]time$";
identifier i_xtime2 =~ "^i_[acm]time$";
identifier i_xtime3 =~ "^i_[acm]time$";
struct iattr *attrp;
struct iattr *attrp2;
struct iattr attr ;
identifier ia_xtime1 =~ "^ia_[acm]time$";
identifier ia_xtime2 =~ "^ia_[acm]time$";
struct kstat *stat;
struct kstat stat1;
struct timespec64 ts;
identifier xtime =~ "^[acmb]time$";
expression e;
@@
(
( node->i_xtime2 \| attrp->ia_xtime2 \| attr.ia_xtime2 \) = node->i_xtime1  ;
|
 node->i_xtime2 = \( node2->i_xtime1 \| timespec64_trunc(...) \);
|
 node->i_xtime2 = node->i_xtime1 = node->i_xtime3 = \(ts \| current_time(...) \);
|
 node->i_xtime1 = node->i_xtime3 = \(ts \| current_time(...) \);
|
 stat->xtime = node2->i_xtime1;
|
 stat1.xtime = node2->i_xtime1;
|
( node->i_xtime2 \| attrp->ia_xtime2 \) = attrp->ia_xtime1  ;
|
( attrp->ia_xtime1 \| attr.ia_xtime1 \) = attrp2->ia_xtime2;
|
- e = node->i_xtime1;
+ e = timespec64_to_timespec( node->i_xtime1 );
|
- e = attrp->ia_xtime1;
+ e = timespec64_to_timespec( attrp->ia_xtime1 );
|
node->i_xtime1 = current_time(...);
|
 node->i_xtime2 = node->i_xtime1 = node->i_xtime3 =
- e;
+ timespec_to_timespec64(e);
|
 node->i_xtime1 = node->i_xtime3 =
- e;
+ timespec_to_timespec64(e);
|
- node->i_xtime1 = e;
+ node->i_xtime1 = timespec_to_timespec64(e);
)

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: <anton@tuxera.com>
Cc: <balbi@kernel.org>
Cc: <bfields@fieldses.org>
Cc: <darrick.wong@oracle.com>
Cc: <dhowells@redhat.com>
Cc: <dsterba@suse.com>
Cc: <dwmw2@infradead.org>
Cc: <hch@lst.de>
Cc: <hirofumi@mail.parknet.co.jp>
Cc: <hubcap@omnibond.com>
Cc: <jack@suse.com>
Cc: <jaegeuk@kernel.org>
Cc: <jaharkes@cs.cmu.edu>
Cc: <jslaby@suse.com>
Cc: <keescook@chromium.org>
Cc: <mark@fasheh.com>
Cc: <miklos@szeredi.hu>
Cc: <nico@linaro.org>
Cc: <reiserfs-devel@vger.kernel.org>
Cc: <richard@nod.at>
Cc: <sage@redhat.com>
Cc: <sfrench@samba.org>
Cc: <swhiteho@redhat.com>
Cc: <tj@kernel.org>
Cc: <trond.myklebust@primarydata.com>
Cc: <tytso@mit.edu>
Cc: <viro@zeniv.linux.org.uk>
---
 drivers/tty/tty_io.c               | 15 ++++++++--
 drivers/usb/gadget/function/f_fs.c |  2 +-
 fs/adfs/inode.c                    |  7 +++--
 fs/afs/fsclient.c                  |  2 +-
 fs/attr.c                          | 14 +++++-----
 fs/bad_inode.c                     |  2 +-
 fs/btrfs/file.c                    |  6 ++--
 fs/btrfs/inode.c                   |  8 +++---
 fs/btrfs/ioctl.c                   |  4 +--
 fs/btrfs/root-tree.c               |  4 +--
 fs/btrfs/transaction.c             |  2 +-
 fs/ceph/addr.c                     | 12 ++++----
 fs/ceph/cache.c                    |  4 +--
 fs/ceph/caps.c                     |  6 ++--
 fs/ceph/file.c                     |  6 ++--
 fs/ceph/inode.c                    | 44 ++++++++++++++++--------------
 fs/ceph/mds_client.c               |  7 +++--
 fs/ceph/snap.c                     |  6 ++--
 fs/cifs/cache.c                    |  4 +--
 fs/cifs/fscache.c                  |  8 +++---
 fs/cifs/inode.c                    | 26 ++++++++++--------
 fs/coda/coda_linux.c               | 12 ++++----
 fs/configfs/inode.c                | 12 ++++----
 fs/cramfs/inode.c                  |  2 +-
 fs/ext4/ext4.h                     | 34 +++++++++++++----------
 fs/ext4/ialloc.c                   |  4 +--
 fs/ext4/namei.c                    |  2 +-
 fs/f2fs/f2fs.h                     | 10 +++++--
 fs/f2fs/file.c                     | 12 ++++----
 fs/f2fs/inode.c                    | 12 ++++----
 fs/f2fs/namei.c                    |  4 +--
 fs/fat/inode.c                     | 20 ++++++++++----
 fs/fat/namei_msdos.c               | 21 ++++++++------
 fs/fat/namei_vfat.c                | 22 +++++++++------
 fs/fuse/inode.c                    |  2 +-
 fs/gfs2/dir.c                      |  6 ++--
 fs/gfs2/glops.c                    |  4 +--
 fs/hfs/inode.c                     |  4 +--
 fs/hfsplus/inode.c                 | 12 ++++----
 fs/hostfs/hostfs_kern.c            |  6 ++--
 fs/inode.c                         | 34 +++++++++++------------
 fs/jffs2/dir.c                     | 18 ++++++------
 fs/jffs2/file.c                    |  2 +-
 fs/jffs2/fs.c                      | 12 ++++----
 fs/kernfs/dir.c                    |  4 +--
 fs/kernfs/inode.c                  |  8 +++---
 fs/locks.c                         |  2 +-
 fs/nfs/callback_proc.c             |  4 +--
 fs/nfs/fscache-index.c             |  4 +--
 fs/nfs/fscache.c                   | 12 ++++----
 fs/nfs/inode.c                     | 39 +++++++++++++++-----------
 fs/nfs/nfs2xdr.c                   | 25 ++++++++++-------
 fs/nfs/nfs3xdr.c                   |  8 ++++--
 fs/nfs/nfs4xdr.c                   |  7 +++--
 fs/nfsd/blocklayout.c              |  8 ++++--
 fs/nfsd/nfs3xdr.c                  | 14 ++++++----
 fs/nfsd/nfs4xdr.c                  |  7 +++--
 fs/nfsd/nfsxdr.c                   |  2 +-
 fs/ntfs/inode.c                    | 30 ++++++++++----------
 fs/ocfs2/dlmglue.c                 | 20 ++++++++++----
 fs/ocfs2/file.c                    |  6 ++--
 fs/orangefs/inode.c                |  2 +-
 fs/orangefs/orangefs-kernel.h      |  2 +-
 fs/overlayfs/inode.c               |  2 +-
 fs/overlayfs/overlayfs.h           |  2 +-
 fs/proc/uptime.c                   |  2 +-
 fs/pstore/inode.c                  |  2 +-
 fs/reiserfs/namei.c                |  2 +-
 fs/reiserfs/xattr.c                |  4 +--
 fs/ubifs/dir.c                     |  4 +--
 fs/ubifs/file.c                    | 23 ++++++++--------
 fs/ubifs/ubifs.h                   |  2 +-
 fs/udf/ialloc.c                    |  4 +--
 fs/udf/inode.c                     | 43 +++++++++++++++++++----------
 fs/xfs/xfs_inode.c                 |  2 +-
 fs/xfs/xfs_iops.c                  |  2 +-
 fs/xfs/xfs_trans_inode.c           |  2 +-
 include/linux/fs.h                 | 23 ++++++++--------
 include/linux/stat.h               |  8 +++---
 79 files changed, 445 insertions(+), 342 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7c838b90a31d..aba59521ad48 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -867,8 +867,13 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 		i = -EIO;
 	tty_ldisc_deref(ld);
 
-	if (i > 0)
-		tty_update_time(&inode->i_atime);
+	if (i > 0) {
+		struct timespec ts;
+
+		ts = timespec64_to_timespec(inode->i_atime);
+		tty_update_time(&ts);
+		inode->i_atime = timespec_to_timespec64(ts);
+	}
 
 	return i;
 }
@@ -969,7 +974,11 @@ static inline ssize_t do_tty_write(
 		cond_resched();
 	}
 	if (written) {
-		tty_update_time(&file_inode(file)->i_mtime);
+		struct timespec ts;
+
+		ts = timespec64_to_timespec(file_inode(file)->i_mtime);
+		tty_update_time(&ts);
+		file_inode(file)->i_mtime = timespec_to_timespec64(ts);
 		ret = written;
 	}
 out:
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 0294e4f18873..d8a532fb935d 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1297,7 +1297,7 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 	inode = new_inode(sb);
 
 	if (likely(inode)) {
-		struct timespec ts = current_time(inode);
+		struct timespec64 ts = current_time(inode);
 
 		inode->i_ino	 = get_next_ino();
 		inode->i_mode    = perms->mode;
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 8dbd36f5e581..c836c425ca94 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -199,7 +199,7 @@ adfs_adfs2unix_time(struct timespec *tv, struct inode *inode)
 	return;
 
  cur_time:
-	*tv = current_time(inode);
+	*tv = timespec64_to_timespec(current_time(inode));
 	return;
 
  too_early:
@@ -242,6 +242,7 @@ adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
 struct inode *
 adfs_iget(struct super_block *sb, struct object_info *obj)
 {
+	struct timespec ts;
 	struct inode *inode;
 
 	inode = new_inode(sb);
@@ -270,7 +271,9 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 	ADFS_I(inode)->stamped   = ((obj->loadaddr & 0xfff00000) == 0xfff00000);
 
 	inode->i_mode	 = adfs_atts2mode(sb, inode);
-	adfs_adfs2unix_time(&inode->i_mtime, inode);
+	ts = timespec64_to_timespec(inode->i_mtime);
+	adfs_adfs2unix_time(&ts, inode);
+	inode->i_mtime = timespec_to_timespec64(ts);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index efacdb7c1dee..3e10405f6a63 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -72,7 +72,7 @@ void afs_update_inode_from_status(struct afs_vnode *vnode,
 				  const afs_dataversion_t *expected_version,
 				  u8 flags)
 {
-	struct timespec t;
+	struct timespec64 t;
 	umode_t mode;
 
 	t.tv_sec = status->mtime_client;
diff --git a/fs/attr.c b/fs/attr.c
index 12ffdb6fb63c..63b17ef9e5ac 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -163,14 +163,14 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = timespec_trunc(attr->ia_atime,
-						inode->i_sb->s_time_gran);
+		inode->i_atime = timespec64_trunc(attr->ia_atime,
+						  inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = timespec_trunc(attr->ia_mtime,
-						inode->i_sb->s_time_gran);
+		inode->i_mtime = timespec64_trunc(attr->ia_mtime,
+						  inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = timespec_trunc(attr->ia_ctime,
-						inode->i_sb->s_time_gran);
+		inode->i_ctime = timespec64_trunc(attr->ia_ctime,
+						  inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -207,7 +207,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
 	int error;
-	struct timespec now;
+	struct timespec64 now;
 	unsigned int ia_valid = attr->ia_valid;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 213b51dbbb60..125e8bbd22a2 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -126,7 +126,7 @@ static int bad_inode_fiemap(struct inode *inode,
 	return -EIO;
 }
 
-static int bad_inode_update_time(struct inode *inode, struct timespec *time,
+static int bad_inode_update_time(struct inode *inode, struct timespec64 *time,
 				 int flags)
 {
 	return -EIO;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5772f0cbedef..fa46a13ad11e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1843,16 +1843,16 @@ static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static void update_time_for_write(struct inode *inode)
 {
-	struct timespec now;
+	struct timespec64 now;
 
 	if (IS_NOCMTIME(inode))
 		return;
 
 	now = current_time(inode);
-	if (!timespec_equal(&inode->i_mtime, &now))
+	if (!timespec64_equal(&inode->i_mtime, &now))
 		inode->i_mtime = now;
 
-	if (!timespec_equal(&inode->i_ctime, &now))
+	if (!timespec64_equal(&inode->i_ctime, &now))
 		inode->i_ctime = now;
 
 	if (IS_I_VERSION(inode))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4bdb597b323..0c4cf12a4103 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5985,7 +5985,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	BTRFS_I(inode)->i_otime = timespec64_to_timespec(inode->i_mtime);
 
 	return inode;
 }
@@ -6339,7 +6339,7 @@ static int btrfs_dirty_inode(struct inode *inode)
  * This is a copy of file_update_time.  We need this so we can return error on
  * ENOSPC for updating the inode in the case of file write and mmap writes.
  */
-static int btrfs_update_time(struct inode *inode, struct timespec *now,
+static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
 			     int flags)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -6594,7 +6594,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	BTRFS_I(inode)->i_otime = timespec64_to_timespec(inode->i_mtime);
 
 	inode_item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				  struct btrfs_inode_item);
@@ -9667,7 +9667,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	struct btrfs_root *dest = BTRFS_I(new_dir)->root;
 	struct inode *new_inode = new_dentry->d_inode;
 	struct inode *old_inode = old_dentry->d_inode;
-	struct timespec ctime = current_time(old_inode);
+	struct timespec64 ctime = current_time(old_inode);
 	struct dentry *parent;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
 	u64 new_ino = btrfs_ino(BTRFS_I(new_inode));
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d05d5d7e7f8e..29c092317b9b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -568,7 +568,7 @@ static noinline int create_subvol(struct inode *dir,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *new_root;
 	struct btrfs_block_rsv block_rsv;
-	struct timespec cur_time = current_time(dir);
+	struct timespec64 cur_time = current_time(dir);
 	struct inode *inode;
 	int ret;
 	int err;
@@ -4983,7 +4983,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct btrfs_trans_handle *trans;
-	struct timespec ct = current_time(inode);
+	struct timespec64 ct = current_time(inode);
 	int ret = 0;
 	int received_uuid_changed;
 
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 6db3bda44aa5..c451285976ac 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -485,9 +485,9 @@ void btrfs_update_root_times(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root)
 {
 	struct btrfs_root_item *item = &root->root_item;
-	struct timespec ct;
+	struct timespec64 ct;
 
-	ktime_get_real_ts(&ct);
+	ktime_get_real_ts64(&ct);
 	spin_lock(&root->root_item_lock);
 	btrfs_set_root_ctransid(item, trans->transid);
 	btrfs_set_stack_timespec_sec(&item->ctime, ct.tv_sec);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index dd3b0e0d822f..6ebfdcb7195a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1428,7 +1428,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	struct dentry *dentry;
 	struct extent_buffer *tmp;
 	struct extent_buffer *old;
-	struct timespec cur_time;
+	struct timespec64 cur_time;
 	int ret = 0;
 	u64 to_reserve = 0;
 	u64 index = 0;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5f7ad3d0df2e..0133ea2b784a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -574,6 +574,7 @@ static u64 get_writepages_data_length(struct inode *inode,
  */
 static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 {
+	struct timespec ts;
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_fs_client *fsc;
@@ -624,11 +625,12 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 
 	set_page_writeback(page);
+	ts = timespec64_to_timespec(inode->i_mtime);
 	err = ceph_osdc_writepages(&fsc->client->osdc, ceph_vino(inode),
 				   &ci->i_layout, snapc, page_off, len,
 				   ceph_wbc.truncate_seq,
 				   ceph_wbc.truncate_size,
-				   &inode->i_mtime, &page, 1);
+				   &ts, &page, 1);
 	if (err < 0) {
 		struct writeback_control tmp_wbc;
 		if (!wbc)
@@ -1131,7 +1133,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			pages = NULL;
 		}
 
-		req->r_mtime = inode->i_mtime;
+		req->r_mtime = timespec64_to_timespec(inode->i_mtime);
 		rc = ceph_osdc_start_request(&fsc->client->osdc, req, true);
 		BUG_ON(rc);
 		req = NULL;
@@ -1731,7 +1733,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 		goto out;
 	}
 
-	req->r_mtime = inode->i_mtime;
+	req->r_mtime = timespec64_to_timespec(inode->i_mtime);
 	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!err)
 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
@@ -1773,7 +1775,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 			goto out_put;
 	}
 
-	req->r_mtime = inode->i_mtime;
+	req->r_mtime = timespec64_to_timespec(inode->i_mtime);
 	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!err)
 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
@@ -1934,7 +1936,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 				     0, false, true);
 	err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
 
-	wr_req->r_mtime = ci->vfs_inode.i_mtime;
+	wr_req->r_mtime = timespec64_to_timespec(ci->vfs_inode.i_mtime);
 	wr_req->r_abort_on_full = true;
 	err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
 
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index bb524c880b1e..362900e42424 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -130,7 +130,7 @@ static enum fscache_checkaux ceph_fscache_inode_check_aux(
 
 	memset(&aux, 0, sizeof(aux));
 	aux.version = ci->i_version;
-	aux.mtime = inode->i_mtime;
+	aux.mtime = timespec64_to_timespec(inode->i_mtime);
 
 	if (memcmp(data, &aux, sizeof(aux)) != 0)
 		return FSCACHE_CHECKAUX_OBSOLETE;
@@ -163,7 +163,7 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 	if (!ci->fscache) {
 		memset(&aux, 0, sizeof(aux));
 		aux.version = ci->i_version;
-		aux.mtime = inode->i_mtime;
+		aux.mtime = timespec64_to_timespec(inode->i_mtime);
 		ci->fscache = fscache_acquire_cookie(fsc->fscache,
 						     &ceph_fscache_inode_object_def,
 						     &ci->i_vino, sizeof(ci->i_vino),
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 23dbfae16156..96b2ce936daa 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1358,9 +1358,9 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 		arg.xattr_buf = NULL;
 	}
 
-	arg.mtime = inode->i_mtime;
-	arg.atime = inode->i_atime;
-	arg.ctime = inode->i_ctime;
+	arg.mtime = timespec64_to_timespec(inode->i_mtime);
+	arg.atime = timespec64_to_timespec(inode->i_atime);
+	arg.ctime = timespec64_to_timespec(inode->i_ctime);
 
 	arg.op = op;
 	arg.caps = cap->implemented;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f85040d73e3d..9d36b72b7309 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -884,7 +884,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	int num_pages = 0;
 	int flags;
 	int ret;
-	struct timespec mtime = current_time(inode);
+	struct timespec mtime = timespec64_to_timespec(current_time(inode));
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
@@ -1093,7 +1093,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	int flags;
 	int ret;
 	bool check_caps = false;
-	struct timespec mtime = current_time(inode);
+	struct timespec mtime = timespec64_to_timespec(current_time(inode));
 	size_t count = iov_iter_count(from);
 
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
@@ -1625,7 +1625,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 		goto out;
 	}
 
-	req->r_mtime = inode->i_mtime;
+	req->r_mtime = timespec64_to_timespec(inode->i_mtime);
 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!ret) {
 		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 676065a1ea62..700fd652cc77 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -662,6 +662,9 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 			 struct timespec *mtime, struct timespec *atime)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct timespec64 ctime64 = timespec_to_timespec64(*ctime);
+	struct timespec64 mtime64 = timespec_to_timespec64(*mtime);
+	struct timespec64 atime64 = timespec_to_timespec64(*atime);
 	int warn = 0;
 
 	if (issued & (CEPH_CAP_FILE_EXCL|
@@ -670,11 +673,11 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_AUTH_EXCL|
 		      CEPH_CAP_XATTR_EXCL)) {
 		if (ci->i_version == 0 ||
-		    timespec_compare(ctime, &inode->i_ctime) > 0) {
+		    timespec64_compare(&ctime64, &inode->i_ctime) > 0) {
 			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
 			     (long long)inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
 			     (long long)ctime->tv_sec, ctime->tv_nsec);
-			inode->i_ctime = *ctime;
+			inode->i_ctime = ctime64;
 		}
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
@@ -685,24 +688,24 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 			     (long long)mtime->tv_sec, mtime->tv_nsec,
 			     ci->i_time_warp_seq, (int)time_warp_seq);
 
-			inode->i_mtime = *mtime;
-			inode->i_atime = *atime;
+			inode->i_mtime = mtime64;
+			inode->i_atime = atime64;
 			ci->i_time_warp_seq = time_warp_seq;
 		} else if (time_warp_seq == ci->i_time_warp_seq) {
 			/* nobody did utimes(); take the max */
-			if (timespec_compare(mtime, &inode->i_mtime) > 0) {
+			if (timespec64_compare(&mtime64, &inode->i_mtime) > 0) {
 				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
 				     (long long)inode->i_mtime.tv_sec,
 				     inode->i_mtime.tv_nsec,
 				     (long long)mtime->tv_sec, mtime->tv_nsec);
-				inode->i_mtime = *mtime;
+				inode->i_mtime = mtime64;
 			}
-			if (timespec_compare(atime, &inode->i_atime) > 0) {
+			if (timespec64_compare(&atime64, &inode->i_atime) > 0) {
 				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
 				     (long long)inode->i_atime.tv_sec,
 				     inode->i_atime.tv_nsec,
 				     (long long)atime->tv_sec, atime->tv_nsec);
-				inode->i_atime = *atime;
+				inode->i_atime = atime64;
 			}
 		} else if (issued & CEPH_CAP_FILE_EXCL) {
 			/* we did a utimes(); ignore mds values */
@@ -712,9 +715,9 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 	} else {
 		/* we have no write|excl caps; whatever the MDS says is true */
 		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) >= 0) {
-			inode->i_ctime = *ctime;
-			inode->i_mtime = *mtime;
-			inode->i_atime = *atime;
+			inode->i_ctime = ctime64;
+			inode->i_mtime = mtime64;
+			inode->i_atime = atime64;
 			ci->i_time_warp_seq = time_warp_seq;
 		} else {
 			warn = 1;
@@ -1941,6 +1944,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	int err = 0;
 	int inode_dirty_flags = 0;
 	bool lock_snap_rwsem = false;
+	struct timespec ts;
 
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
@@ -2023,14 +2027,14 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 			inode->i_atime = attr->ia_atime;
 			dirtied |= CEPH_CAP_FILE_EXCL;
 		} else if ((issued & CEPH_CAP_FILE_WR) &&
-			   timespec_compare(&inode->i_atime,
+			   timespec64_compare(&inode->i_atime,
 					    &attr->ia_atime) < 0) {
 			inode->i_atime = attr->ia_atime;
 			dirtied |= CEPH_CAP_FILE_WR;
 		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
-			   !timespec_equal(&inode->i_atime, &attr->ia_atime)) {
-			ceph_encode_timespec(&req->r_args.setattr.atime,
-					     &attr->ia_atime);
+			   !timespec64_equal(&inode->i_atime, &attr->ia_atime)) {
+			ts = timespec64_to_timespec(attr->ia_atime);
+			ceph_encode_timespec(&req->r_args.setattr.atime, &ts);
 			mask |= CEPH_SETATTR_ATIME;
 			release |= CEPH_CAP_FILE_SHARED |
 				   CEPH_CAP_FILE_RD | CEPH_CAP_FILE_WR;
@@ -2045,14 +2049,14 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 			inode->i_mtime = attr->ia_mtime;
 			dirtied |= CEPH_CAP_FILE_EXCL;
 		} else if ((issued & CEPH_CAP_FILE_WR) &&
-			   timespec_compare(&inode->i_mtime,
+			   timespec64_compare(&inode->i_mtime,
 					    &attr->ia_mtime) < 0) {
 			inode->i_mtime = attr->ia_mtime;
 			dirtied |= CEPH_CAP_FILE_WR;
 		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
-			   !timespec_equal(&inode->i_mtime, &attr->ia_mtime)) {
-			ceph_encode_timespec(&req->r_args.setattr.mtime,
-					     &attr->ia_mtime);
+			   !timespec64_equal(&inode->i_mtime, &attr->ia_mtime)) {
+			ts = timespec64_to_timespec(attr->ia_mtime);
+			ceph_encode_timespec(&req->r_args.setattr.mtime, &ts);
 			mask |= CEPH_SETATTR_MTIME;
 			release |= CEPH_CAP_FILE_SHARED |
 				   CEPH_CAP_FILE_RD | CEPH_CAP_FILE_WR;
@@ -2126,7 +2130,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		req->r_inode_drop = release;
 		req->r_args.setattr.mask = cpu_to_le32(mask);
 		req->r_num_caps = 1;
-		req->r_stamp = attr->ia_ctime;
+		req->r_stamp = timespec64_to_timespec(attr->ia_ctime);
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 	}
 	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5ece2e6ad154..9460a92ce56d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2958,12 +2958,15 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		rec.v2.flock_len = (__force __le32)
 			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
 	} else {
+		struct timespec ts;
 		rec.v1.cap_id = cpu_to_le64(cap->cap_id);
 		rec.v1.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
 		rec.v1.issued = cpu_to_le32(cap->issued);
 		rec.v1.size = cpu_to_le64(inode->i_size);
-		ceph_encode_timespec(&rec.v1.mtime, &inode->i_mtime);
-		ceph_encode_timespec(&rec.v1.atime, &inode->i_atime);
+		ts = timespec64_to_timespec(inode->i_mtime);
+		ceph_encode_timespec(&rec.v1.mtime, &ts);
+		ts = timespec64_to_timespec(inode->i_atime);
+		ceph_encode_timespec(&rec.v1.atime, &ts);
 		rec.v1.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v1.pathbase = cpu_to_le64(pathbase);
 	}
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 041c27ea8de1..af81555c14fd 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -594,9 +594,9 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 
 	BUG_ON(capsnap->writing);
 	capsnap->size = inode->i_size;
-	capsnap->mtime = inode->i_mtime;
-	capsnap->atime = inode->i_atime;
-	capsnap->ctime = inode->i_ctime;
+	capsnap->mtime = timespec64_to_timespec(inode->i_mtime);
+	capsnap->atime = timespec64_to_timespec(inode->i_atime);
+	capsnap->ctime = timespec64_to_timespec(inode->i_ctime);
 	capsnap->time_warp_seq = ci->i_time_warp_seq;
 	capsnap->truncate_size = ci->i_truncate_size;
 	capsnap->truncate_seq = ci->i_truncate_seq;
diff --git a/fs/cifs/cache.c b/fs/cifs/cache.c
index edf5f40898bf..e1553d1e0e50 100644
--- a/fs/cifs/cache.c
+++ b/fs/cifs/cache.c
@@ -128,8 +128,8 @@ fscache_checkaux cifs_fscache_inode_check_aux(void *cookie_netfs_data,
 
 	memset(&auxdata, 0, sizeof(auxdata));
 	auxdata.eof = cifsi->server_eof;
-	auxdata.last_write_time = cifsi->vfs_inode.i_mtime;
-	auxdata.last_change_time = cifsi->vfs_inode.i_ctime;
+	auxdata.last_write_time = timespec64_to_timespec(cifsi->vfs_inode.i_mtime);
+	auxdata.last_change_time = timespec64_to_timespec(cifsi->vfs_inode.i_ctime);
 
 	if (memcmp(data, &auxdata, datalen) != 0)
 		return FSCACHE_CHECKAUX_OBSOLETE;
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index 25d3f66b2d50..85145a763021 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -129,8 +129,8 @@ static void cifs_fscache_acquire_inode_cookie(struct cifsInodeInfo *cifsi,
 
 	memset(&auxdata, 0, sizeof(auxdata));
 	auxdata.eof = cifsi->server_eof;
-	auxdata.last_write_time = cifsi->vfs_inode.i_mtime;
-	auxdata.last_change_time = cifsi->vfs_inode.i_ctime;
+	auxdata.last_write_time = timespec64_to_timespec(cifsi->vfs_inode.i_mtime);
+	auxdata.last_change_time = timespec64_to_timespec(cifsi->vfs_inode.i_ctime);
 
 	cifsi->fscache =
 		fscache_acquire_cookie(tcon->fscache,
@@ -166,8 +166,8 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
 	if (cifsi->fscache) {
 		memset(&auxdata, 0, sizeof(auxdata));
 		auxdata.eof = cifsi->server_eof;
-		auxdata.last_write_time = cifsi->vfs_inode.i_mtime;
-		auxdata.last_change_time = cifsi->vfs_inode.i_ctime;
+		auxdata.last_write_time = timespec64_to_timespec(cifsi->vfs_inode.i_mtime);
+		auxdata.last_change_time = timespec64_to_timespec(cifsi->vfs_inode.i_ctime);
 
 		cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
 		fscache_relinquish_cookie(cifsi->fscache, &auxdata, false);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 3c371f7f5963..6be9a7cfaf0e 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -95,6 +95,7 @@ static void
 cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 {
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
+	struct timespec ts;
 
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
@@ -113,7 +114,8 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	}
 
 	 /* revalidate if mtime or size have changed */
-	if (timespec_equal(&inode->i_mtime, &fattr->cf_mtime) &&
+	ts = timespec64_to_timespec(inode->i_mtime);
+	if (timespec_equal(&ts, &fattr->cf_mtime) &&
 	    cifs_i->server_eof == fattr->cf_eof) {
 		cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
 			 __func__, cifs_i->uniqueid);
@@ -162,9 +164,9 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	cifs_revalidate_cache(inode, fattr);
 
 	spin_lock(&inode->i_lock);
-	inode->i_atime = fattr->cf_atime;
-	inode->i_mtime = fattr->cf_mtime;
-	inode->i_ctime = fattr->cf_ctime;
+	inode->i_atime = timespec_to_timespec64(fattr->cf_atime);
+	inode->i_mtime = timespec_to_timespec64(fattr->cf_mtime);
+	inode->i_ctime = timespec_to_timespec64(fattr->cf_ctime);
 	inode->i_rdev = fattr->cf_rdev;
 	cifs_nlink_fattr_to_inode(inode, fattr);
 	inode->i_uid = fattr->cf_uid;
@@ -1122,14 +1124,14 @@ cifs_set_file_info(struct inode *inode, struct iattr *attrs, unsigned int xid,
 	if (attrs->ia_valid & ATTR_ATIME) {
 		set_time = true;
 		info_buf.LastAccessTime =
-			cpu_to_le64(cifs_UnixTimeToNT(attrs->ia_atime));
+			cpu_to_le64(cifs_UnixTimeToNT(timespec64_to_timespec(attrs->ia_atime)));
 	} else
 		info_buf.LastAccessTime = 0;
 
 	if (attrs->ia_valid & ATTR_MTIME) {
 		set_time = true;
 		info_buf.LastWriteTime =
-		    cpu_to_le64(cifs_UnixTimeToNT(attrs->ia_mtime));
+		    cpu_to_le64(cifs_UnixTimeToNT(timespec64_to_timespec(attrs->ia_mtime)));
 	} else
 		info_buf.LastWriteTime = 0;
 
@@ -1142,7 +1144,7 @@ cifs_set_file_info(struct inode *inode, struct iattr *attrs, unsigned int xid,
 	if (set_time && (attrs->ia_valid & ATTR_CTIME)) {
 		cifs_dbg(FYI, "CIFS - CTIME changed\n");
 		info_buf.ChangeTime =
-		    cpu_to_le64(cifs_UnixTimeToNT(attrs->ia_ctime));
+		    cpu_to_le64(cifs_UnixTimeToNT(timespec64_to_timespec(attrs->ia_ctime)));
 	} else
 		info_buf.ChangeTime = 0;
 
@@ -2059,8 +2061,8 @@ int cifs_getattr(const struct path *path, struct kstat *stat,
 	/* old CIFS Unix Extensions doesn't return create time */
 	if (CIFS_I(inode)->createtime) {
 		stat->result_mask |= STATX_BTIME;
-		stat->btime =
-		      cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->createtime));
+		stat->btime = timespec_to_timespec64(
+		      cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->createtime)));
 	}
 
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED);
@@ -2262,17 +2264,17 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		args->gid = INVALID_GID; /* no change */
 
 	if (attrs->ia_valid & ATTR_ATIME)
-		args->atime = cifs_UnixTimeToNT(attrs->ia_atime);
+		args->atime = cifs_UnixTimeToNT(timespec64_to_timespec(attrs->ia_atime));
 	else
 		args->atime = NO_CHANGE_64;
 
 	if (attrs->ia_valid & ATTR_MTIME)
-		args->mtime = cifs_UnixTimeToNT(attrs->ia_mtime);
+		args->mtime = cifs_UnixTimeToNT(timespec64_to_timespec(attrs->ia_mtime));
 	else
 		args->mtime = NO_CHANGE_64;
 
 	if (attrs->ia_valid & ATTR_CTIME)
-		args->ctime = cifs_UnixTimeToNT(attrs->ia_ctime);
+		args->ctime = cifs_UnixTimeToNT(timespec64_to_timespec(attrs->ia_ctime));
 	else
 		args->ctime = NO_CHANGE_64;
 
diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index ca599df0dcb1..f3d543dd9a98 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -105,11 +105,11 @@ void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 	if (attr->va_size != -1)
 		inode->i_blocks = (attr->va_size + 511) >> 9;
 	if (attr->va_atime.tv_sec != -1) 
-	        inode->i_atime = attr->va_atime;
+		inode->i_atime = timespec_to_timespec64(attr->va_atime);
 	if (attr->va_mtime.tv_sec != -1)
-	        inode->i_mtime = attr->va_mtime;
+		inode->i_mtime = timespec_to_timespec64(attr->va_mtime);
         if (attr->va_ctime.tv_sec != -1)
-	        inode->i_ctime = attr->va_ctime;
+		inode->i_ctime = timespec_to_timespec64(attr->va_ctime);
 }
 
 
@@ -175,13 +175,13 @@ void coda_iattr_to_vattr(struct iattr *iattr, struct coda_vattr *vattr)
                 vattr->va_size = iattr->ia_size;
 	}
         if ( valid & ATTR_ATIME ) {
-                vattr->va_atime = iattr->ia_atime;
+		vattr->va_atime = timespec64_to_timespec(iattr->ia_atime);
 	}
         if ( valid & ATTR_MTIME ) {
-                vattr->va_mtime = iattr->ia_mtime;
+		vattr->va_mtime = timespec64_to_timespec(iattr->ia_mtime);
 	}
         if ( valid & ATTR_CTIME ) {
-                vattr->va_ctime = iattr->ia_ctime;
+		vattr->va_ctime = timespec64_to_timespec(iattr->ia_ctime);
 	}
 }
 
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index ad718e5e37bb..28ef9e528853 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -90,14 +90,14 @@ int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
 	if (ia_valid & ATTR_GID)
 		sd_iattr->ia_gid = iattr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
-		sd_iattr->ia_atime = timespec_trunc(iattr->ia_atime,
-						inode->i_sb->s_time_gran);
+		sd_iattr->ia_atime = timespec64_trunc(iattr->ia_atime,
+						      inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
-		sd_iattr->ia_mtime = timespec_trunc(iattr->ia_mtime,
-						inode->i_sb->s_time_gran);
+		sd_iattr->ia_mtime = timespec64_trunc(iattr->ia_mtime,
+						      inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
-		sd_iattr->ia_ctime = timespec_trunc(iattr->ia_ctime,
-						inode->i_sb->s_time_gran);
+		sd_iattr->ia_ctime = timespec64_trunc(iattr->ia_ctime,
+						      inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = iattr->ia_mode;
 
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 017b0ab19bc4..d7a600e00f28 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -90,7 +90,7 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	const struct cramfs_inode *cramfs_inode, unsigned int offset)
 {
 	struct inode *inode;
-	static struct timespec zerotime;
+	static struct timespec64 zerotime;
 
 	inode = iget_locked(sb, cramino(cramfs_inode, offset));
 	if (!inode)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a42e71203e53..f76d0777f7ad 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -817,12 +817,14 @@ static inline void ext4_decode_extra_time(struct timespec *time, __le32 extra)
 	time->tv_nsec = (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
 }
 
-#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)			       \
-do {									       \
-	(raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);	       \
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     \
-		(raw_inode)->xtime ## _extra =				       \
-				ext4_encode_extra_time(&(inode)->xtime);       \
+#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
+do {										\
+	(raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);		\
+	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     {\
+		struct timespec ts = timespec64_to_timespec((inode)->xtime);	\
+		(raw_inode)->xtime ## _extra =					\
+				ext4_encode_extra_time(&ts);			\
+		}								\
 } while (0)
 
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
@@ -834,16 +836,20 @@ do {									       \
 				ext4_encode_extra_time(&(einode)->xtime);      \
 } while (0)
 
-#define EXT4_INODE_GET_XTIME(xtime, inode, raw_inode)			       \
-do {									       \
-	(inode)->xtime.tv_sec = (signed)le32_to_cpu((raw_inode)->xtime);       \
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     \
-		ext4_decode_extra_time(&(inode)->xtime,			       \
-				       raw_inode->xtime ## _extra);	       \
-	else								       \
-		(inode)->xtime.tv_nsec = 0;				       \
+#define EXT4_INODE_GET_XTIME(xtime, inode, raw_inode)				\
+do {										\
+	(inode)->xtime.tv_sec = (signed)le32_to_cpu((raw_inode)->xtime);	\
+	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra)) {	\
+		struct timespec ts = timespec64_to_timespec((inode)->xtime);	\
+		ext4_decode_extra_time(&ts,					\
+				       raw_inode->xtime ## _extra);		\
+		(inode)->xtime = timespec_to_timespec64(ts);			\
+		}								\
+	else									\
+		(inode)->xtime.tv_nsec = 0;					\
 } while (0)
 
+
 #define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
 do {									       \
 	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))		       \
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index df92e3ec9913..751e1be2c652 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1078,8 +1078,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	inode->i_ino = ino + group * EXT4_INODES_PER_GROUP(sb);
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = ei->i_crtime =
-						       current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	ei->i_crtime = timespec64_to_timespec(inode->i_mtime);
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_dir_start_lookup = 0;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b1f21e3a0763..2feb546dfcaf 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3675,7 +3675,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	};
 	u8 new_file_type;
 	int retval;
-	struct timespec ctime;
+	struct timespec64 ctime;
 
 	if ((ext4_test_inode_flag(new_dir, EXT4_INODE_PROJINHERIT) &&
 	     !projid_eq(EXT4_I(new_dir)->i_projid,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f32a0c79702f..5ae465c264d0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2460,6 +2460,7 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
+	struct timespec ts;
 	bool ret;
 
 	if (dsync) {
@@ -2475,11 +2476,14 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 			i_size_read(inode) & ~PAGE_MASK)
 		return false;
 
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
+	ts = timespec64_to_timespec(inode->i_atime);
+	if (!timespec_equal(F2FS_I(inode)->i_disk_time, &ts))
 		return false;
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
+	ts = timespec64_to_timespec(inode->i_ctime);
+	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 1, &ts))
 		return false;
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
+	ts = timespec64_to_timespec(inode->i_mtime);
+	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 2, &ts))
 		return false;
 	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 3,
 						&F2FS_I(inode)->i_crtime))
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cc08956334a0..6029d2bd78e1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -724,14 +724,14 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = timespec_trunc(attr->ia_atime,
-						inode->i_sb->s_time_gran);
+		inode->i_atime = timespec64_trunc(attr->ia_atime,
+						  inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = timespec_trunc(attr->ia_mtime,
-						inode->i_sb->s_time_gran);
+		inode->i_mtime = timespec64_trunc(attr->ia_mtime,
+						  inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = timespec_trunc(attr->ia_ctime,
-						inode->i_sb->s_time_gran);
+		inode->i_ctime = timespec64_trunc(attr->ia_ctime,
+						  inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index deee5ea56ccf..83d23303d3bd 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -285,9 +285,9 @@ static int do_read_inode(struct inode *inode)
 		fi->i_crtime.tv_nsec = le32_to_cpu(ri->i_crtime_nsec);
 	}
 
-	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
-	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
-	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
+	F2FS_I(inode)->i_disk_time[0] = timespec64_to_timespec(inode->i_atime);
+	F2FS_I(inode)->i_disk_time[1] = timespec64_to_timespec(inode->i_ctime);
+	F2FS_I(inode)->i_disk_time[2] = timespec64_to_timespec(inode->i_mtime);
 	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
 	f2fs_put_page(node_page, 1);
 
@@ -449,9 +449,9 @@ void update_inode(struct inode *inode, struct page *node_page)
 	if (inode->i_nlink == 0)
 		clear_inline_node(node_page);
 
-	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
-	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
-	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
+	F2FS_I(inode)->i_disk_time[0] = timespec64_to_timespec(inode->i_atime);
+	F2FS_I(inode)->i_disk_time[1] = timespec64_to_timespec(inode->i_ctime);
+	F2FS_I(inode)->i_disk_time[2] = timespec64_to_timespec(inode->i_mtime);
 	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3a7ed962d2f7..1752fb886a40 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -50,8 +50,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime =
-			F2FS_I(inode)->i_crtime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	F2FS_I(inode)->i_crtime = timespec64_to_timespec(inode->i_mtime);
 	inode->i_generation = sbi->s_next_generation++;
 
 	err = insert_inode_locked(inode);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index ffbbf0520d9e..13271ea2b453 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -502,6 +502,7 @@ static int fat_validate_dir(struct inode *dir)
 /* doesn't deal with root inode */
 int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
+	struct timespec ts;
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	int error;
 
@@ -552,11 +553,14 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
-	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
+	fat_time_fat2unix(sbi, &ts, de->time, de->date, 0);
+	inode->i_mtime = timespec_to_timespec64(ts);
 	if (sbi->options.isvfat) {
-		fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
+		fat_time_fat2unix(sbi, &ts, de->ctime,
 				  de->cdate, de->ctime_cs);
-		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
+		inode->i_ctime = timespec_to_timespec64(ts);
+		fat_time_fat2unix(sbi, &ts, 0, de->adate, 0);
+		inode->i_atime = timespec_to_timespec64(ts);
 	} else
 		inode->i_ctime = inode->i_atime = inode->i_mtime;
 
@@ -825,6 +829,7 @@ static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int __fat_write_inode(struct inode *inode, int wait)
 {
+	struct timespec ts;
 	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
@@ -862,13 +867,16 @@ static int __fat_write_inode(struct inode *inode, int wait)
 		raw_entry->size = cpu_to_le32(inode->i_size);
 	raw_entry->attr = fat_make_attrs(inode);
 	fat_set_start(raw_entry, MSDOS_I(inode)->i_logstart);
-	fat_time_unix2fat(sbi, &inode->i_mtime, &raw_entry->time,
+	ts = timespec64_to_timespec(inode->i_mtime);
+	fat_time_unix2fat(sbi, &ts, &raw_entry->time,
 			  &raw_entry->date, NULL);
 	if (sbi->options.isvfat) {
 		__le16 atime;
-		fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime,
+		ts = timespec64_to_timespec(inode->i_ctime);
+		fat_time_unix2fat(sbi, &ts, &raw_entry->ctime,
 				  &raw_entry->cdate, &raw_entry->ctime_cs);
-		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
+		ts = timespec64_to_timespec(inode->i_atime);
+		fat_time_unix2fat(sbi, &ts, &atime,
 				  &raw_entry->adate, NULL);
 	}
 	spin_unlock(&sbi->inode_hash_lock);
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 484ce674e0cd..16a832c37d66 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -250,7 +250,7 @@ static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 	if (err)
 		return err;
 
-	dir->i_ctime = dir->i_mtime = *ts;
+	dir->i_ctime = dir->i_mtime = timespec_to_timespec64(*ts);
 	if (IS_DIRSYNC(dir))
 		(void)fat_sync_inode(dir);
 	else
@@ -266,7 +266,8 @@ static int msdos_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
 	struct fat_slot_info sinfo;
-	struct timespec ts;
+	struct timespec64 ts;
+	struct timespec t;
 	unsigned char msdos_name[MSDOS_NAME];
 	int err, is_hid;
 
@@ -285,7 +286,8 @@ static int msdos_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	}
 
 	ts = current_time(dir);
-	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &ts, &sinfo);
+	t = timespec64_to_timespec(ts);
+	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &t, &sinfo);
 	if (err)
 		goto out;
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
@@ -344,7 +346,8 @@ static int msdos_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct fat_slot_info sinfo;
 	struct inode *inode;
 	unsigned char msdos_name[MSDOS_NAME];
-	struct timespec ts;
+	struct timespec64 ts;
+	struct timespec t;
 	int err, is_hid, cluster;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
@@ -362,12 +365,13 @@ static int msdos_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	}
 
 	ts = current_time(dir);
-	cluster = fat_alloc_new_dir(dir, &ts);
+	t = timespec64_to_timespec(ts);
+	cluster = fat_alloc_new_dir(dir, &t);
 	if (cluster < 0) {
 		err = cluster;
 		goto out;
 	}
-	err = msdos_add_entry(dir, msdos_name, 1, is_hid, cluster, &ts, &sinfo);
+	err = msdos_add_entry(dir, msdos_name, 1, is_hid, cluster, &t, &sinfo);
 	if (err)
 		goto out_free;
 	inc_nlink(dir);
@@ -432,7 +436,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	struct msdos_dir_entry *dotdot_de;
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
-	struct timespec ts;
+	struct timespec64 ts;
 	loff_t new_i_pos;
 	int err, old_attrs, is_dir, update_dotdot, corrupt = 0;
 
@@ -499,8 +503,9 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		new_i_pos = MSDOS_I(new_inode)->i_pos;
 		fat_detach(new_inode);
 	} else {
+		struct timespec t = timespec64_to_timespec(ts);
 		err = msdos_add_entry(new_dir, new_name, is_dir, is_hid, 0,
-				      &ts, &sinfo);
+				      &t, &sinfo);
 		if (err)
 			goto out;
 		new_i_pos = sinfo.i_pos;
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 2649759c478a..caa229423327 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -678,7 +678,7 @@ static int vfat_add_entry(struct inode *dir, const struct qstr *qname,
 		goto cleanup;
 
 	/* update timestamp */
-	dir->i_ctime = dir->i_mtime = dir->i_atime = *ts;
+	dir->i_ctime = dir->i_mtime = dir->i_atime = timespec_to_timespec64(*ts);
 	if (IS_DIRSYNC(dir))
 		(void)fat_sync_inode(dir);
 	else
@@ -772,13 +772,15 @@ static int vfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
 	struct fat_slot_info sinfo;
-	struct timespec ts;
+	struct timespec64 ts;
+	struct timespec t;
 	int err;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
 
 	ts = current_time(dir);
-	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
+	t = timespec64_to_timespec(ts);
+	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &t, &sinfo);
 	if (err)
 		goto out;
 	inode_inc_iversion(dir);
@@ -861,18 +863,20 @@ static int vfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
 	struct fat_slot_info sinfo;
-	struct timespec ts;
+	struct timespec64 ts;
+	struct timespec t;
 	int err, cluster;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
 
 	ts = current_time(dir);
-	cluster = fat_alloc_new_dir(dir, &ts);
+	t = timespec64_to_timespec(ts);
+	cluster = fat_alloc_new_dir(dir, &t);
 	if (cluster < 0) {
 		err = cluster;
 		goto out;
 	}
-	err = vfat_add_entry(dir, &dentry->d_name, 1, cluster, &ts, &sinfo);
+	err = vfat_add_entry(dir, &dentry->d_name, 1, cluster, &t, &sinfo);
 	if (err)
 		goto out_free;
 	inode_inc_iversion(dir);
@@ -910,7 +914,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct msdos_dir_entry *dotdot_de;
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
-	struct timespec ts;
+	struct timespec64 ts;
+	struct timespec t;
 	loff_t new_i_pos;
 	int err, is_dir, update_dotdot, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
@@ -945,8 +950,9 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		new_i_pos = MSDOS_I(new_inode)->i_pos;
 		fat_detach(new_inode);
 	} else {
+		t = timespec64_to_timespec(ts);
 		err = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir, 0,
-				     &ts, &sinfo);
+				     &t, &sinfo);
 		if (err)
 			goto out;
 		new_i_pos = sinfo.i_pos;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ef4775401c0d..f0bc691d32ab 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -217,7 +217,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		return;
 	}
 
-	old_mtime = inode->i_mtime;
+	old_mtime = timespec64_to_timespec(inode->i_mtime);
 	fuse_change_attributes_common(inode, attr, attr_valid);
 
 	oldsize = inode->i_size;
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index d9fb0ad6cc30..c22090e97ff0 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -871,7 +871,7 @@ static struct gfs2_leaf *new_leaf(struct inode *inode, struct buffer_head **pbh,
 	struct buffer_head *bh;
 	struct gfs2_leaf *leaf;
 	struct gfs2_dirent *dent;
-	struct timespec tv = current_time(inode);
+	struct timespec64 tv = current_time(inode);
 
 	error = gfs2_alloc_blocks(ip, &bn, &n, 0, NULL);
 	if (error)
@@ -1802,7 +1802,7 @@ int gfs2_dir_add(struct inode *inode, const struct qstr *name,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct buffer_head *bh = da->bh;
 	struct gfs2_dirent *dent = da->dent;
-	struct timespec tv;
+	struct timespec64 tv;
 	struct gfs2_leaf *leaf;
 	int error;
 
@@ -1880,7 +1880,7 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 	const struct qstr *name = &dentry->d_name;
 	struct gfs2_dirent *dent, *prev = NULL;
 	struct buffer_head *bh;
-	struct timespec tv = current_time(&dip->i_inode);
+	struct timespec64 tv = current_time(&dip->i_inode);
 
 	/* Returns _either_ the entry (if its first in block) or the
 	   previous entry otherwise */
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index d8782a7a1e7d..c63bee9adb6a 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -338,7 +338,7 @@ static int inode_go_demote_ok(const struct gfs2_glock *gl)
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
 	const struct gfs2_dinode *str = buf;
-	struct timespec atime;
+	struct timespec64 atime;
 	u16 height, depth;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr)))
@@ -361,7 +361,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	gfs2_set_inode_blocks(&ip->i_inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
-	if (timespec_compare(&ip->i_inode.i_atime, &atime) < 0)
+	if (timespec64_compare(&ip->i_inode.i_atime, &atime) < 0)
 		ip->i_inode.i_atime = atime;
 	ip->i_inode.i_mtime.tv_sec = be64_to_cpu(str->di_mtime);
 	ip->i_inode.i_mtime.tv_nsec = be32_to_cpu(str->di_mtime_nsec);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2538b49cc349..8ea683f01cda 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -351,7 +351,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				hfs_m_to_utime(rec->file.MdDat);
+				timespec_to_timespec64(hfs_m_to_utime(rec->file.MdDat));
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -362,7 +362,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				hfs_m_to_utime(rec->dir.MdDat);
+				timespec_to_timespec64(hfs_m_to_utime(rec->dir.MdDat));
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c0c8d433864f..c824f702feec 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -493,9 +493,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		hfsplus_get_perms(inode, &folder->permissions, 1);
 		set_nlink(inode, 1);
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
-		inode->i_atime = hfsp_mt2ut(folder->access_date);
-		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
-		inode->i_ctime = hfsp_mt2ut(folder->attribute_mod_date);
+		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(folder->access_date));
+		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(folder->content_mod_date));
+		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(folder->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = folder->create_date;
 		HFSPLUS_I(inode)->fs_blocks = 0;
 		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
@@ -531,9 +531,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
 		}
-		inode->i_atime = hfsp_mt2ut(file->access_date);
-		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
-		inode->i_ctime = hfsp_mt2ut(file->attribute_mod_date);
+		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(file->access_date));
+		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(file->content_mod_date));
+		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(file->attribute_mod_date));
 		HFSPLUS_I(inode)->create_date = file->create_date;
 	} else {
 		pr_err("bad catalog entry used to create inode\n");
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 3cd85eb5bbb1..77c72db33c3b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -838,15 +838,15 @@ static int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 	if (attr->ia_valid & ATTR_ATIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME;
-		attrs.ia_atime = attr->ia_atime;
+		attrs.ia_atime = timespec64_to_timespec(attr->ia_atime);
 	}
 	if (attr->ia_valid & ATTR_MTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_MTIME;
-		attrs.ia_mtime = attr->ia_mtime;
+		attrs.ia_mtime = timespec64_to_timespec(attr->ia_mtime);
 	}
 	if (attr->ia_valid & ATTR_CTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_CTIME;
-		attrs.ia_ctime = attr->ia_ctime;
+		attrs.ia_ctime = timespec64_to_timespec(attr->ia_ctime);
 	}
 	if (attr->ia_valid & ATTR_ATIME_SET) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME_SET;
diff --git a/fs/inode.c b/fs/inode.c
index 93af998ee290..9fe1f941be02 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1590,8 +1590,8 @@ static void update_ovl_inode_times(struct dentry *dentry, struct inode *inode,
 	if (upperdentry) {
 		struct inode *realinode = d_inode(upperdentry);
 
-		if ((!timespec_equal(&inode->i_mtime, &realinode->i_mtime) ||
-		     !timespec_equal(&inode->i_ctime, &realinode->i_ctime))) {
+		if ((!timespec64_equal(&inode->i_mtime, &realinode->i_mtime) ||
+		     !timespec64_equal(&inode->i_ctime, &realinode->i_ctime))) {
 			inode->i_mtime = realinode->i_mtime;
 			inode->i_ctime = realinode->i_ctime;
 		}
@@ -1614,12 +1614,12 @@ static int relatime_need_update(const struct path *path, struct inode *inode,
 	/*
 	 * Is mtime younger than atime? If yes, update atime:
 	 */
-	if (timespec_compare(&inode->i_mtime, &inode->i_atime) >= 0)
+	if (timespec64_compare(&inode->i_mtime, &inode->i_atime) >= 0)
 		return 1;
 	/*
 	 * Is ctime younger than atime? If yes, update atime:
 	 */
-	if (timespec_compare(&inode->i_ctime, &inode->i_atime) >= 0)
+	if (timespec64_compare(&inode->i_ctime, &inode->i_atime) >= 0)
 		return 1;
 
 	/*
@@ -1634,7 +1634,7 @@ static int relatime_need_update(const struct path *path, struct inode *inode,
 	return 0;
 }
 
-int generic_update_time(struct inode *inode, struct timespec *time, int flags)
+int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
 	int iflags = I_DIRTY_TIME;
 	bool dirty = false;
@@ -1662,9 +1662,9 @@ EXPORT_SYMBOL(generic_update_time);
  * This does the actual work of updating an inodes time or version.  Must have
  * had called mnt_want_write() before calling this.
  */
-static int update_time(struct inode *inode, struct timespec *time, int flags)
+static int update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
-	int (*update_time)(struct inode *, struct timespec *, int);
+	int (*update_time)(struct inode *, struct timespec64 *, int);
 
 	update_time = inode->i_op->update_time ? inode->i_op->update_time :
 		generic_update_time;
@@ -1685,7 +1685,7 @@ bool __atime_needs_update(const struct path *path, struct inode *inode,
 			  bool rcu)
 {
 	struct vfsmount *mnt = path->mnt;
-	struct timespec now;
+	struct timespec64 now;
 
 	if (inode->i_flags & S_NOATIME)
 		return false;
@@ -1708,10 +1708,10 @@ bool __atime_needs_update(const struct path *path, struct inode *inode,
 
 	now = current_time(inode);
 
-	if (!relatime_need_update(path, inode, now, rcu))
+	if (!relatime_need_update(path, inode, timespec64_to_timespec(now), rcu))
 		return false;
 
-	if (timespec_equal(&inode->i_atime, &now))
+	if (timespec64_equal(&inode->i_atime, &now))
 		return false;
 
 	return true;
@@ -1721,7 +1721,7 @@ void touch_atime(const struct path *path)
 {
 	struct vfsmount *mnt = path->mnt;
 	struct inode *inode = d_inode(path->dentry);
-	struct timespec now;
+	struct timespec64 now;
 
 	if (!__atime_needs_update(path, inode, false))
 		return;
@@ -1855,7 +1855,7 @@ EXPORT_SYMBOL(file_remove_privs);
 int file_update_time(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	struct timespec now;
+	struct timespec64 now;
 	int sync_it = 0;
 	int ret;
 
@@ -1864,10 +1864,10 @@ int file_update_time(struct file *file)
 		return 0;
 
 	now = current_time(inode);
-	if (!timespec_equal(&inode->i_mtime, &now))
+	if (!timespec64_equal(&inode->i_mtime, &now))
 		sync_it = S_MTIME;
 
-	if (!timespec_equal(&inode->i_ctime, &now))
+	if (!timespec64_equal(&inode->i_ctime, &now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
@@ -2144,15 +2144,15 @@ EXPORT_SYMBOL(timespec64_trunc);
  * Note that inode and inode->sb cannot be NULL.
  * Otherwise, the function warns and returns time without truncation.
  */
-struct timespec current_time(struct inode *inode)
+struct timespec64 current_time(struct inode *inode)
 {
-	struct timespec now = current_kernel_time();
+	struct timespec64 now = current_kernel_time64();
 
 	if (unlikely(!inode->i_sb)) {
 		WARN(1, "current_time() called with uninitialized super_block in the inode");
 		return now;
 	}
 
-	return timespec_trunc(now, inode->i_sb->s_time_gran);
+	return timespec64_trunc(now, inode->i_sb->s_time_gran);
 }
 EXPORT_SYMBOL(current_time);
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 0a754f38462e..4ef97805eb27 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -201,7 +201,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 	if (ret)
 		goto fail;
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(ri->ctime));
+	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->ctime)));
 
 	jffs2_free_raw_inode(ri);
 
@@ -235,7 +235,7 @@ static int jffs2_unlink(struct inode *dir_i, struct dentry *dentry)
 	if (dead_f->inocache)
 		set_nlink(d_inode(dentry), dead_f->inocache->pino_nlink);
 	if (!ret)
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
 	return ret;
 }
 /***********************************************************************/
@@ -269,7 +269,7 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 		set_nlink(d_inode(old_dentry), ++f->inocache->pino_nlink);
 		mutex_unlock(&f->sem);
 		d_instantiate(dentry, d_inode(old_dentry));
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
 		ihold(d_inode(old_dentry));
 	}
 	return ret;
@@ -419,7 +419,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(rd->mctime)));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -563,7 +563,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(rd->mctime)));
 	inc_nlink(dir_i);
 
 	jffs2_free_raw_dirent(rd);
@@ -601,7 +601,7 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	ret = jffs2_do_unlink(c, dir_f, dentry->d_name.name,
 			      dentry->d_name.len, f, now);
 	if (!ret) {
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
 		clear_nlink(d_inode(dentry));
 		drop_nlink(dir_i);
 	}
@@ -736,7 +736,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = dir_i->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(rd->mctime)));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -857,14 +857,14 @@ static int jffs2_rename (struct inode *old_dir_i, struct dentry *old_dentry,
 		 * caller won't do it on its own since we are returning an error.
 		 */
 		d_invalidate(new_dentry);
-		new_dir_i->i_mtime = new_dir_i->i_ctime = ITIME(now);
+		new_dir_i->i_mtime = new_dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
 		return ret;
 	}
 
 	if (d_is_dir(old_dentry))
 		drop_nlink(old_dir_i);
 
-	new_dir_i->i_mtime = new_dir_i->i_ctime = old_dir_i->i_mtime = old_dir_i->i_ctime = ITIME(now);
+	new_dir_i->i_mtime = new_dir_i->i_ctime = old_dir_i->i_mtime = old_dir_i->i_ctime = timespec_to_timespec64(ITIME(now));
 
 	return 0;
 }
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index bd0428bebe9b..481afd4c2e1a 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -308,7 +308,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			inode->i_size = pos + writtenlen;
 			inode->i_blocks = (inode->i_size + 511) >> 9;
 
-			inode->i_ctime = inode->i_mtime = ITIME(je32_to_cpu(ri->ctime));
+			inode->i_ctime = inode->i_mtime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->ctime)));
 		}
 	}
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index eab04eca95a3..0ecfb8ea38cd 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -146,9 +146,9 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 		return PTR_ERR(new_metadata);
 	}
 	/* It worked. Update the inode */
-	inode->i_atime = ITIME(je32_to_cpu(ri->atime));
-	inode->i_ctime = ITIME(je32_to_cpu(ri->ctime));
-	inode->i_mtime = ITIME(je32_to_cpu(ri->mtime));
+	inode->i_atime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->atime)));
+	inode->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->ctime)));
+	inode->i_mtime = timespec_to_timespec64(ITIME(je32_to_cpu(ri->mtime)));
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_uid_write(inode, je16_to_cpu(ri->uid));
 	i_gid_write(inode, je16_to_cpu(ri->gid));
@@ -280,9 +280,9 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	i_uid_write(inode, je16_to_cpu(latest_node.uid));
 	i_gid_write(inode, je16_to_cpu(latest_node.gid));
 	inode->i_size = je32_to_cpu(latest_node.isize);
-	inode->i_atime = ITIME(je32_to_cpu(latest_node.atime));
-	inode->i_mtime = ITIME(je32_to_cpu(latest_node.mtime));
-	inode->i_ctime = ITIME(je32_to_cpu(latest_node.ctime));
+	inode->i_atime = timespec_to_timespec64(ITIME(je32_to_cpu(latest_node.atime)));
+	inode->i_mtime = timespec_to_timespec64(ITIME(je32_to_cpu(latest_node.mtime)));
+	inode->i_ctime = timespec_to_timespec64(ITIME(je32_to_cpu(latest_node.ctime)));
 
 	set_nlink(inode, f->inocache->pino_nlink);
 
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc19340b..d66cc0777303 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -779,7 +779,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	ps_iattr = parent->iattr;
 	if (ps_iattr) {
 		struct iattr *ps_iattrs = &ps_iattr->ia_iattr;
-		ktime_get_real_ts(&ps_iattrs->ia_ctime);
+		ktime_get_real_ts64(&ps_iattrs->ia_ctime);
 		ps_iattrs->ia_mtime = ps_iattrs->ia_ctime;
 	}
 
@@ -1306,7 +1306,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 			/* update timestamps on the parent */
 			if (ps_iattr) {
-				ktime_get_real_ts(&ps_iattr->ia_iattr.ia_ctime);
+				ktime_get_real_ts64(&ps_iattr->ia_iattr.ia_ctime);
 				ps_iattr->ia_iattr.ia_mtime =
 					ps_iattr->ia_iattr.ia_ctime;
 			}
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index a34303981deb..3d73fe9d56e2 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -52,7 +52,7 @@ static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 	iattrs->ia_uid = GLOBAL_ROOT_UID;
 	iattrs->ia_gid = GLOBAL_ROOT_GID;
 
-	ktime_get_real_ts(&iattrs->ia_atime);
+	ktime_get_real_ts64(&iattrs->ia_atime);
 	iattrs->ia_mtime = iattrs->ia_atime;
 	iattrs->ia_ctime = iattrs->ia_atime;
 
@@ -176,9 +176,9 @@ static inline void set_inode_attr(struct inode *inode, struct iattr *iattr)
 	struct super_block *sb = inode->i_sb;
 	inode->i_uid = iattr->ia_uid;
 	inode->i_gid = iattr->ia_gid;
-	inode->i_atime = timespec_trunc(iattr->ia_atime, sb->s_time_gran);
-	inode->i_mtime = timespec_trunc(iattr->ia_mtime, sb->s_time_gran);
-	inode->i_ctime = timespec_trunc(iattr->ia_ctime, sb->s_time_gran);
+	inode->i_atime = timespec64_trunc(iattr->ia_atime, sb->s_time_gran);
+	inode->i_mtime = timespec64_trunc(iattr->ia_mtime, sb->s_time_gran);
+	inode->i_ctime = timespec64_trunc(iattr->ia_ctime, sb->s_time_gran);
 }
 
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
diff --git a/fs/locks.c b/fs/locks.c
index 62bbe8b31f26..7356c405ec46 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1562,7 +1562,7 @@ EXPORT_SYMBOL(__break_lease);
  * exclusive leases.  The justification is that if someone has an
  * exclusive lease, then they could be modifying it.
  */
-void lease_get_mtime(struct inode *inode, struct timespec *time)
+void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 {
 	bool has_lease = false;
 	struct file_lock_context *ctx;
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index a50d7813e3ea..9d24aabcd8bb 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -54,8 +54,8 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	res->change_attr = delegation->change_attr;
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
-	res->ctime = inode->i_ctime;
-	res->mtime = inode->i_mtime;
+	res->ctime = timespec64_to_timespec(inode->i_ctime);
+	res->mtime = timespec64_to_timespec(inode->i_mtime);
 	res->bitmap[0] = (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE) &
 		args->bitmap[0];
 	res->bitmap[1] = (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY) &
diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index 1c5d8d31fc0a..666415d13d52 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -88,8 +88,8 @@ enum fscache_checkaux nfs_fscache_inode_check_aux(void *cookie_netfs_data,
 		return FSCACHE_CHECKAUX_OBSOLETE;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = nfsi->vfs_inode.i_mtime;
-	auxdata.ctime = nfsi->vfs_inode.i_ctime;
+	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
+	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
 
 	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
 		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index b55fc7920c3b..4dc887813c71 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -237,8 +237,8 @@ void nfs_fscache_init_inode(struct inode *inode)
 		return;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = nfsi->vfs_inode.i_mtime;
-	auxdata.ctime = nfsi->vfs_inode.i_ctime;
+	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
+	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
 
 	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
 		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
@@ -262,8 +262,8 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = nfsi->vfs_inode.i_mtime;
-	auxdata.ctime = nfsi->vfs_inode.i_ctime;
+	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
+	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
 	fscache_relinquish_cookie(cookie, &auxdata, false);
 	nfsi->fscache = NULL;
 }
@@ -304,8 +304,8 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 		return;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = nfsi->vfs_inode.i_mtime;
-	auxdata.ctime = nfsi->vfs_inode.i_ctime;
+	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
+	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
 
 	if (inode_is_open_for_write(inode)) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 55b62254dd7c..138941a97327 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -494,15 +494,15 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		nfsi->read_cache_jiffies = fattr->time_start;
 		nfsi->attr_gencount = fattr->gencount;
 		if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-			inode->i_atime = fattr->atime;
+			inode->i_atime = timespec_to_timespec64(fattr->atime);
 		else if (nfs_server_capable(inode, NFS_CAP_ATIME))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 		if (fattr->valid & NFS_ATTR_FATTR_MTIME)
-			inode->i_mtime = fattr->mtime;
+			inode->i_mtime = timespec_to_timespec64(fattr->mtime);
 		else if (nfs_server_capable(inode, NFS_CAP_MTIME))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode->i_ctime = timespec_to_timespec64(fattr->ctime);
 		else if (nfs_server_capable(inode, NFS_CAP_CTIME))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
@@ -1304,6 +1304,8 @@ static bool nfs_file_has_buffered_writers(struct nfs_inode *nfsi)
 
 static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 {
+	struct timespec ts;
+
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECHANGE)
 			&& (fattr->valid & NFS_ATTR_FATTR_CHANGE)
 			&& inode_eq_iversion_raw(inode, fattr->pre_change_attr)) {
@@ -1312,16 +1314,18 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
+	ts = timespec64_to_timespec(inode->i_ctime);
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			&& timespec_equal(&inode->i_ctime, &fattr->pre_ctime)) {
-		inode->i_ctime = fattr->ctime;
+			&& timespec_equal(&ts, &fattr->pre_ctime)) {
+		inode->i_ctime = timespec_to_timespec64(fattr->ctime);
 	}
 
+	ts = timespec64_to_timespec(inode->i_mtime);
 	if ((fattr->valid & NFS_ATTR_FATTR_PREMTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_MTIME)
-			&& timespec_equal(&inode->i_mtime, &fattr->pre_mtime)) {
-		inode->i_mtime = fattr->mtime;
+			&& timespec_equal(&ts, &fattr->pre_mtime)) {
+		inode->i_mtime = timespec_to_timespec64(fattr->mtime);
 		if (S_ISDIR(inode->i_mode))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
 	}
@@ -1347,7 +1351,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t cur_size, new_isize;
 	unsigned long invalid = 0;
-
+	struct timespec ts;
 
 	if (nfs_have_delegated_attributes(inode))
 		return 0;
@@ -1363,10 +1367,12 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 			invalid |= NFS_INO_INVALID_CHANGE
 				| NFS_INO_REVAL_PAGECACHE;
 
-		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec_equal(&inode->i_mtime, &fattr->mtime))
+		ts = timespec64_to_timespec(inode->i_mtime);
+		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec_equal(&ts, &fattr->mtime))
 			invalid |= NFS_INO_INVALID_MTIME;
 
-		if ((fattr->valid & NFS_ATTR_FATTR_CTIME) && !timespec_equal(&inode->i_ctime, &fattr->ctime))
+		ts = timespec64_to_timespec(inode->i_ctime);
+		if ((fattr->valid & NFS_ATTR_FATTR_CTIME) && !timespec_equal(&ts, &fattr->ctime))
 			invalid |= NFS_INO_INVALID_CTIME;
 
 		if (fattr->valid & NFS_ATTR_FATTR_SIZE) {
@@ -1396,7 +1402,8 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if ((fattr->valid & NFS_ATTR_FATTR_NLINK) && inode->i_nlink != fattr->nlink)
 		invalid |= NFS_INO_INVALID_OTHER;
 
-	if ((fattr->valid & NFS_ATTR_FATTR_ATIME) && !timespec_equal(&inode->i_atime, &fattr->atime))
+	ts = timespec64_to_timespec(inode->i_atime);
+	if ((fattr->valid & NFS_ATTR_FATTR_ATIME) && !timespec_equal(&ts, &fattr->atime))
 		invalid |= NFS_INO_INVALID_ATIME;
 
 	if (invalid != 0)
@@ -1667,12 +1674,12 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_CTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PRECTIME) == 0) {
-		fattr->pre_ctime = inode->i_ctime;
+		fattr->pre_ctime = timespec64_to_timespec(inode->i_ctime);
 		fattr->valid |= NFS_ATTR_FATTR_PRECTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_MTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PREMTIME) == 0) {
-		fattr->pre_mtime = inode->i_mtime;
+		fattr->pre_mtime = timespec64_to_timespec(inode->i_mtime);
 		fattr->valid |= NFS_ATTR_FATTR_PREMTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_SIZE) != 0 &&
@@ -1829,7 +1836,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_MTIME) {
-		inode->i_mtime = fattr->mtime;
+		inode->i_mtime = timespec_to_timespec64(fattr->mtime);
 	} else if (server->caps & NFS_CAP_MTIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_MTIME
@@ -1838,7 +1845,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME) {
-		inode->i_ctime = fattr->ctime;
+		inode->i_ctime = timespec_to_timespec64(fattr->ctime);
 	} else if (server->caps & NFS_CAP_CTIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_CTIME
@@ -1875,7 +1882,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 
 	if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-		inode->i_atime = fattr->atime;
+		inode->i_atime = timespec_to_timespec64(fattr->atime);
 	else if (server->caps & NFS_CAP_ATIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_ATIME
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 85e4b4a233f9..350675e3ed47 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -354,6 +354,7 @@ static __be32 *xdr_time_not_set(__be32 *p)
 
 static void encode_sattr(struct xdr_stream *xdr, const struct iattr *attr)
 {
+	struct timespec ts;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS_sattr_sz << 2);
@@ -375,17 +376,21 @@ static void encode_sattr(struct xdr_stream *xdr, const struct iattr *attr)
 	else
 		*p++ = cpu_to_be32(NFS2_SATTR_NOT_SET);
 
-	if (attr->ia_valid & ATTR_ATIME_SET)
-		p = xdr_encode_time(p, &attr->ia_atime);
-	else if (attr->ia_valid & ATTR_ATIME)
-		p = xdr_encode_current_server_time(p, &attr->ia_atime);
-	else
+	if (attr->ia_valid & ATTR_ATIME_SET) {
+		ts = timespec64_to_timespec(attr->ia_atime);
+		p = xdr_encode_time(p, &ts);
+	} else if (attr->ia_valid & ATTR_ATIME) {
+		ts = timespec64_to_timespec(attr->ia_atime);
+		p = xdr_encode_current_server_time(p, &ts);
+	} else
 		p = xdr_time_not_set(p);
-	if (attr->ia_valid & ATTR_MTIME_SET)
-		xdr_encode_time(p, &attr->ia_mtime);
-	else if (attr->ia_valid & ATTR_MTIME)
-		xdr_encode_current_server_time(p, &attr->ia_mtime);
-	else
+	if (attr->ia_valid & ATTR_MTIME_SET) {
+		ts = timespec64_to_timespec(attr->ia_atime);
+		xdr_encode_time(p, &ts);
+	} else if (attr->ia_valid & ATTR_MTIME) {
+		ts = timespec64_to_timespec(attr->ia_mtime);
+		xdr_encode_current_server_time(p, &ts);
+	} else
 		xdr_time_not_set(p);
 }
 
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 09ee36dd8426..64e4fa33d89f 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -561,6 +561,7 @@ static __be32 *xdr_decode_nfstime3(__be32 *p, struct timespec *timep)
  */
 static void encode_sattr3(struct xdr_stream *xdr, const struct iattr *attr)
 {
+	struct timespec ts;
 	u32 nbytes;
 	__be32 *p;
 
@@ -610,8 +611,10 @@ static void encode_sattr3(struct xdr_stream *xdr, const struct iattr *attr)
 		*p++ = xdr_zero;
 
 	if (attr->ia_valid & ATTR_ATIME_SET) {
+		struct timespec ts;
 		*p++ = xdr_two;
-		p = xdr_encode_nfstime3(p, &attr->ia_atime);
+		ts = timespec64_to_timespec(attr->ia_atime);
+		p = xdr_encode_nfstime3(p, &ts);
 	} else if (attr->ia_valid & ATTR_ATIME) {
 		*p++ = xdr_one;
 	} else
@@ -619,7 +622,8 @@ static void encode_sattr3(struct xdr_stream *xdr, const struct iattr *attr)
 
 	if (attr->ia_valid & ATTR_MTIME_SET) {
 		*p++ = xdr_two;
-		xdr_encode_nfstime3(p, &attr->ia_mtime);
+		ts = timespec64_to_timespec(attr->ia_mtime);
+		xdr_encode_nfstime3(p, &ts);
 	} else if (attr->ia_valid & ATTR_MTIME) {
 		*p = xdr_one;
 	} else
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 9b7392032321..481426e9e6f0 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1057,6 +1057,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 				const struct nfs_server *server,
 				const uint32_t attrmask[])
 {
+	struct timespec ts;
 	char owner_name[IDMAP_NAMESZ];
 	char owner_group[IDMAP_NAMESZ];
 	int owner_namelen = 0;
@@ -1145,14 +1146,16 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
 		if (iap->ia_valid & ATTR_ATIME_SET) {
 			*p++ = cpu_to_be32(NFS4_SET_TO_CLIENT_TIME);
-			p = xdr_encode_nfstime4(p, &iap->ia_atime);
+			ts = timespec64_to_timespec(iap->ia_atime);
+			p = xdr_encode_nfstime4(p, &ts);
 		} else
 			*p++ = cpu_to_be32(NFS4_SET_TO_SERVER_TIME);
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
 		if (iap->ia_valid & ATTR_MTIME_SET) {
 			*p++ = cpu_to_be32(NFS4_SET_TO_CLIENT_TIME);
-			p = xdr_encode_nfstime4(p, &iap->ia_mtime);
+			ts = timespec64_to_timespec(iap->ia_mtime);
+			p = xdr_encode_nfstime4(p, &ts);
 		} else
 			*p++ = cpu_to_be32(NFS4_SET_TO_SERVER_TIME);
 	}
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 0cd9249a3a25..94bb63adcb90 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -121,13 +121,15 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 {
 	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
+	struct timespec ts;
 	int error;
 
+	ts = timespec64_to_timespec(inode->i_mtime);
 	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
-	    timespec_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
-		lcp->lc_mtime = current_time(inode);
+	    timespec_compare(&lcp->lc_mtime, &ts) < 0)
+		lcp->lc_mtime = timespec64_to_timespec(current_time(inode));
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
-	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
+	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = timespec_to_timespec64(lcp->lc_mtime);
 
 	if (new_size > i_size_read(inode)) {
 		iattr.ia_valid |= ATTR_SIZE;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 3192b544a441..9b973f4f7d01 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -165,6 +165,7 @@ static __be32 *
 encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	      struct kstat *stat)
 {
+	struct timespec ts;
 	*p++ = htonl(nfs3_ftypes[(stat->mode & S_IFMT) >> 12]);
 	*p++ = htonl((u32) (stat->mode & S_IALLUGO));
 	*p++ = htonl((u32) stat->nlink);
@@ -180,9 +181,12 @@ encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	*p++ = htonl((u32) MINOR(stat->rdev));
 	p = encode_fsid(p, fhp);
 	p = xdr_encode_hyper(p, stat->ino);
-	p = encode_time3(p, &stat->atime);
-	p = encode_time3(p, &stat->mtime);
-	p = encode_time3(p, &stat->ctime);
+	ts = timespec64_to_timespec(stat->atime);
+	p = encode_time3(p, &ts);
+	ts = timespec64_to_timespec(stat->mtime);
+	p = encode_time3(p, &ts);
+	ts = timespec64_to_timespec(stat->ctime);
+	p = encode_time3(p, &ts);
 
 	return p;
 }
@@ -271,8 +275,8 @@ void fill_pre_wcc(struct svc_fh *fhp)
 		stat.size  = inode->i_size;
 	}
 
-	fhp->fh_pre_mtime = stat.mtime;
-	fhp->fh_pre_ctime = stat.ctime;
+	fhp->fh_pre_mtime = timespec64_to_timespec(stat.mtime);
+	fhp->fh_pre_ctime = timespec64_to_timespec(stat.ctime);
 	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 	fhp->fh_pre_saved = true;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index aaa88c1fd7a3..b85068fdd36e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -320,6 +320,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		   struct iattr *iattr, struct nfs4_acl **acl,
 		   struct xdr_netobj *label, int *umask)
 {
+	struct timespec ts;
 	int expected_len, len = 0;
 	u32 dummy32;
 	char *buf;
@@ -421,7 +422,8 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
 			len += 12;
-			status = nfsd4_decode_time(argp, &iattr->ia_atime);
+			status = nfsd4_decode_time(argp, &ts);
+			iattr->ia_atime = timespec_to_timespec64(ts);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
@@ -440,7 +442,8 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
 			len += 12;
-			status = nfsd4_decode_time(argp, &iattr->ia_mtime);
+			status = nfsd4_decode_time(argp, &ts);
+			iattr->ia_mtime = timespec_to_timespec64(ts);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index a43e8260520a..6b2e8b73d36e 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -131,7 +131,7 @@ encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 {
 	struct dentry	*dentry = fhp->fh_dentry;
 	int type;
-	struct timespec time;
+	struct timespec64 time;
 	u32 f;
 
 	type = (stat->mode & S_IFMT);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 1c1ee489284b..decaf75d1cd5 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -667,18 +667,18 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * mtime is the last change of the data within the file. Not changed
 	 * when only metadata is changed, e.g. a rename doesn't affect mtime.
 	 */
-	vi->i_mtime = ntfs2utc(si->last_data_change_time);
+	vi->i_mtime = timespec_to_timespec64(ntfs2utc(si->last_data_change_time));
 	/*
 	 * ctime is the last change of the metadata of the file. This obviously
 	 * always changes, when mtime is changed. ctime can be changed on its
 	 * own, mtime is then not changed, e.g. when a file is renamed.
 	 */
-	vi->i_ctime = ntfs2utc(si->last_mft_change_time);
+	vi->i_ctime = timespec_to_timespec64(ntfs2utc(si->last_mft_change_time));
 	/*
 	 * Last access to the data within the file. Not changed during a rename
 	 * for example but changed whenever the file is written to.
 	 */
-	vi->i_atime = ntfs2utc(si->last_access_time);
+	vi->i_atime = timespec_to_timespec64(ntfs2utc(si->last_access_time));
 
 	/* Find the attribute list attribute if present. */
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -2804,11 +2804,11 @@ int ntfs_truncate(struct inode *vi)
 	 * for real.
 	 */
 	if (!IS_NOCMTIME(VFS_I(base_ni)) && !IS_RDONLY(VFS_I(base_ni))) {
-		struct timespec now = current_time(VFS_I(base_ni));
+		struct timespec64 now = current_time(VFS_I(base_ni));
 		int sync_it = 0;
 
-		if (!timespec_equal(&VFS_I(base_ni)->i_mtime, &now) ||
-		    !timespec_equal(&VFS_I(base_ni)->i_ctime, &now))
+		if (!timespec64_equal(&VFS_I(base_ni)->i_mtime, &now) ||
+		    !timespec64_equal(&VFS_I(base_ni)->i_ctime, &now))
 			sync_it = 1;
 		VFS_I(base_ni)->i_mtime = now;
 		VFS_I(base_ni)->i_ctime = now;
@@ -2923,14 +2923,14 @@ int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_ATIME)
-		vi->i_atime = timespec_trunc(attr->ia_atime,
-				vi->i_sb->s_time_gran);
+		vi->i_atime = timespec64_trunc(attr->ia_atime,
+					       vi->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
-		vi->i_mtime = timespec_trunc(attr->ia_mtime,
-				vi->i_sb->s_time_gran);
+		vi->i_mtime = timespec64_trunc(attr->ia_mtime,
+					       vi->i_sb->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
-		vi->i_ctime = timespec_trunc(attr->ia_ctime,
-				vi->i_sb->s_time_gran);
+		vi->i_ctime = timespec64_trunc(attr->ia_ctime,
+					       vi->i_sb->s_time_gran);
 	mark_inode_dirty(vi);
 out:
 	return err;
@@ -2997,7 +2997,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	si = (STANDARD_INFORMATION*)((u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
 	/* Update the access times if they have changed. */
-	nt = utc2ntfs(vi->i_mtime);
+	nt = utc2ntfs(timespec64_to_timespec(vi->i_mtime));
 	if (si->last_data_change_time != nt) {
 		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
@@ -3006,7 +3006,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_data_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(vi->i_ctime);
+	nt = utc2ntfs(timespec64_to_timespec(vi->i_ctime));
 	if (si->last_mft_change_time != nt) {
 		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
@@ -3015,7 +3015,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_mft_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(vi->i_atime);
+	nt = utc2ntfs(timespec64_to_timespec(vi->i_atime));
 	if (si->last_access_time != nt) {
 		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino,
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index ce33ac354602..285b72347403 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2141,6 +2141,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
+	struct timespec ts;
 
 	lvb = ocfs2_dlm_lvb(&lockres->l_lksb);
 
@@ -2161,12 +2162,15 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	lvb->lvb_igid      = cpu_to_be32(i_gid_read(inode));
 	lvb->lvb_imode     = cpu_to_be16(inode->i_mode);
 	lvb->lvb_inlink    = cpu_to_be16(inode->i_nlink);
+	ts = timespec64_to_timespec(inode->i_atime);
 	lvb->lvb_iatime_packed  =
-		cpu_to_be64(ocfs2_pack_timespec(&inode->i_atime));
+		cpu_to_be64(ocfs2_pack_timespec(&ts));
+	ts = timespec64_to_timespec(inode->i_ctime);
 	lvb->lvb_ictime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&inode->i_ctime));
+		cpu_to_be64(ocfs2_pack_timespec(&ts));
+	ts = timespec64_to_timespec(inode->i_mtime);
 	lvb->lvb_imtime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
+		cpu_to_be64(ocfs2_pack_timespec(&ts));
 	lvb->lvb_iattr    = cpu_to_be32(oi->ip_attr);
 	lvb->lvb_idynfeatures = cpu_to_be16(oi->ip_dyn_features);
 	lvb->lvb_igeneration = cpu_to_be32(inode->i_generation);
@@ -2184,6 +2188,7 @@ static void ocfs2_unpack_timespec(struct timespec *spec,
 
 static void ocfs2_refresh_inode_from_lvb(struct inode *inode)
 {
+	struct timespec ts;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
@@ -2211,12 +2216,15 @@ static void ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	i_gid_write(inode, be32_to_cpu(lvb->lvb_igid));
 	inode->i_mode    = be16_to_cpu(lvb->lvb_imode);
 	set_nlink(inode, be16_to_cpu(lvb->lvb_inlink));
-	ocfs2_unpack_timespec(&inode->i_atime,
+	ocfs2_unpack_timespec(&ts,
 			      be64_to_cpu(lvb->lvb_iatime_packed));
-	ocfs2_unpack_timespec(&inode->i_mtime,
+	inode->i_atime = timespec_to_timespec64(ts);
+	ocfs2_unpack_timespec(&ts,
 			      be64_to_cpu(lvb->lvb_imtime_packed));
-	ocfs2_unpack_timespec(&inode->i_ctime,
+	inode->i_mtime = timespec_to_timespec64(ts);
+	ocfs2_unpack_timespec(&ts,
 			      be64_to_cpu(lvb->lvb_ictime_packed));
+	inode->i_ctime = timespec_to_timespec64(ts);
 	spin_unlock(&oi->ip_lock);
 }
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 86d153d3d305..76217d76dd91 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -222,7 +222,7 @@ static int ocfs2_sync_file(struct file *file, loff_t start, loff_t end,
 int ocfs2_should_update_atime(struct inode *inode,
 			      struct vfsmount *vfsmnt)
 {
-	struct timespec now;
+	struct timespec64 now;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
 	if (ocfs2_is_hard_readonly(osb) || ocfs2_is_soft_readonly(osb))
@@ -248,8 +248,8 @@ int ocfs2_should_update_atime(struct inode *inode,
 		return 0;
 
 	if (vfsmnt->mnt_flags & MNT_RELATIME) {
-		if ((timespec_compare(&inode->i_atime, &inode->i_mtime) <= 0) ||
-		    (timespec_compare(&inode->i_atime, &inode->i_ctime) <= 0))
+		if ((timespec64_compare(&inode->i_atime, &inode->i_mtime) <= 0) ||
+		    (timespec64_compare(&inode->i_atime, &inode->i_ctime) <= 0))
 			return 1;
 
 		return 0;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 79c61da8b1bc..7e3400b90bc9 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -290,7 +290,7 @@ int orangefs_permission(struct inode *inode, int mask)
 	return generic_permission(inode, mask);
 }
 
-int orangefs_update_time(struct inode *inode, struct timespec *time, int flags)
+int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
 	struct iattr iattr;
 	gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_update_time: %pU\n",
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index c29bb0ebc6bb..7ed50ee3db8a 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -343,7 +343,7 @@ int orangefs_getattr(const struct path *path, struct kstat *stat,
 
 int orangefs_permission(struct inode *inode, int mask);
 
-int orangefs_update_time(struct inode *, struct timespec *, int);
+int orangefs_update_time(struct inode *, struct timespec64 *, int);
 
 /*
  * defined in xattr.c
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 6e3815fb006b..d7cca60f28e6 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -416,7 +416,7 @@ int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags)
 	return err;
 }
 
-int ovl_update_time(struct inode *inode, struct timespec *ts, int flags)
+int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
 {
 	if (flags & S_ATIME) {
 		struct ovl_fs *ofs = inode->i_sb->s_fs_info;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index e0b7de799f6b..9fe10247f9d4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -331,7 +331,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 struct posix_acl *ovl_get_acl(struct inode *inode, int type);
 int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags);
-int ovl_update_time(struct inode *inode, struct timespec *ts, int flags);
+int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
 bool ovl_is_private_xattr(const char *name);
 
 struct inode *ovl_new_inode(struct super_block *sb, umode_t mode, dev_t rdev);
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 95a708d83721..f18e6f949e0c 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -10,7 +10,7 @@
 static int uptime_proc_show(struct seq_file *m, void *v)
 {
 	struct timespec uptime;
-	struct timespec idle;
+	struct timespec64 idle;
 	u64 nsec;
 	u32 rem;
 	int i;
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..fb681d302bb3 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -392,7 +392,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	inode->i_private = private;
 
 	if (record->time.tv_sec)
-		inode->i_mtime = inode->i_ctime = record->time;
+		inode->i_mtime = inode->i_ctime = timespec_to_timespec64(record->time);
 
 	d_add(dentry, inode);
 
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index bd39a998843d..d2869ced6d39 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1320,7 +1320,7 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	int jbegin_count;
 	umode_t old_inode_mode;
 	unsigned long savelink = 1;
-	struct timespec ctime;
+	struct timespec64 ctime;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 5dbf5324bdda..ff94fad477e4 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -451,10 +451,10 @@ int reiserfs_commit_write(struct file *f, struct page *page,
 
 static void update_ctime(struct inode *inode)
 {
-	struct timespec now = current_time(inode);
+	struct timespec64 now = current_time(inode);
 
 	if (inode_unhashed(inode) || !inode->i_nlink ||
-	    timespec_equal(&inode->i_ctime, &now))
+	    timespec64_equal(&inode->i_ctime, &now))
 		return;
 
 	inode->i_ctime = current_time(inode);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9d7fb88e172e..ba53517448b4 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1289,7 +1289,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 					.dirtied_ino = 3 };
 	struct ubifs_budget_req ino_req = { .dirtied_ino = 1,
 			.dirtied_ino_d = ALIGN(old_inode_ui->data_len, 8) };
-	struct timespec time;
+	struct timespec64 time;
 	unsigned int uninitialized_var(saved_nlink);
 	struct fscrypt_name old_nm, new_nm;
 
@@ -1517,7 +1517,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	int sync = IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir);
 	struct inode *fst_inode = d_inode(old_dentry);
 	struct inode *snd_inode = d_inode(new_dentry);
-	struct timespec time;
+	struct timespec64 time;
 	int err;
 	struct fscrypt_name fst_nm, snd_nm;
 
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 1acb2ff505e6..ddb252109945 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1089,14 +1089,14 @@ static void do_attr_changes(struct inode *inode, const struct iattr *attr)
 	if (attr->ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
 	if (attr->ia_valid & ATTR_ATIME)
-		inode->i_atime = timespec_trunc(attr->ia_atime,
-						inode->i_sb->s_time_gran);
+		inode->i_atime = timespec64_trunc(attr->ia_atime,
+						  inode->i_sb->s_time_gran);
 	if (attr->ia_valid & ATTR_MTIME)
-		inode->i_mtime = timespec_trunc(attr->ia_mtime,
-						inode->i_sb->s_time_gran);
+		inode->i_mtime = timespec64_trunc(attr->ia_mtime,
+						  inode->i_sb->s_time_gran);
 	if (attr->ia_valid & ATTR_CTIME)
-		inode->i_ctime = timespec_trunc(attr->ia_ctime,
-						inode->i_sb->s_time_gran);
+		inode->i_ctime = timespec64_trunc(attr->ia_ctime,
+						  inode->i_sb->s_time_gran);
 	if (attr->ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -1367,8 +1367,9 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 static inline int mctime_update_needed(const struct inode *inode,
 				       const struct timespec *now)
 {
-	if (!timespec_equal(&inode->i_mtime, now) ||
-	    !timespec_equal(&inode->i_ctime, now))
+	struct timespec64 now64 = timespec_to_timespec64(*now);
+	if (!timespec64_equal(&inode->i_mtime, &now64) ||
+	    !timespec64_equal(&inode->i_ctime, &now64))
 		return 1;
 	return 0;
 }
@@ -1380,7 +1381,7 @@ static inline int mctime_update_needed(const struct inode *inode,
  *
  * This function updates time of the inode.
  */
-int ubifs_update_time(struct inode *inode, struct timespec *time,
+int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 			     int flags)
 {
 	struct ubifs_inode *ui = ubifs_inode(inode);
@@ -1424,7 +1425,7 @@ int ubifs_update_time(struct inode *inode, struct timespec *time,
  */
 static int update_mctime(struct inode *inode)
 {
-	struct timespec now = current_time(inode);
+	struct timespec now = timespec64_to_timespec(current_time(inode));
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
@@ -1518,7 +1519,7 @@ static int ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
-	struct timespec now = current_time(inode);
+	struct timespec now = timespec64_to_timespec(current_time(inode));
 	struct ubifs_budget_req req = { .new_page = 1 };
 	int err, update_time;
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 5ee7af879cc4..ac61ba9921c8 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1740,7 +1740,7 @@ int ubifs_calc_dark(const struct ubifs_info *c, int spc);
 int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 int ubifs_setattr(struct dentry *dentry, struct iattr *attr);
 #ifdef CONFIG_UBIFS_ATIME_SUPPORT
-int ubifs_update_time(struct inode *inode, struct timespec *time, int flags);
+int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 #endif
 
 /* dir.c */
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index b7a0d4b4bda1..56569023783b 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -124,8 +124,8 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-	inode->i_mtime = inode->i_atime = inode->i_ctime =
-		iinfo->i_crtime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	iinfo->i_crtime = timespec64_to_timespec(inode->i_mtime);
 	if (unlikely(insert_inode_locked(inode) < 0)) {
 		make_bad_inode(inode);
 		iput(inode);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index df2378d6ebb4..7f39d17352c9 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1271,6 +1271,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
 	struct kernel_lb_addr *iloc = &iinfo->i_location;
+	struct timespec ts;
 	unsigned int link_count;
 	unsigned int indirections = 0;
 	int bs = inode->i_sb->s_blocksize;
@@ -1443,9 +1444,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(fe->logicalBlocksRecorded) <<
 			(inode->i_sb->s_blocksize_bits - 9);
 
-		udf_disk_stamp_to_time(&inode->i_atime, fe->accessTime);
-		udf_disk_stamp_to_time(&inode->i_mtime, fe->modificationTime);
-		udf_disk_stamp_to_time(&inode->i_ctime, fe->attrTime);
+		udf_disk_stamp_to_time(&ts, fe->accessTime);
+		inode->i_atime = timespec_to_timespec64(ts);
+		udf_disk_stamp_to_time(&ts, fe->modificationTime);
+		inode->i_mtime = timespec_to_timespec64(ts);
+		udf_disk_stamp_to_time(&ts, fe->attrTime);
+		inode->i_ctime = timespec_to_timespec64(ts);
 
 		iinfo->i_unique = le64_to_cpu(fe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
@@ -1455,10 +1459,13 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
 		    (inode->i_sb->s_blocksize_bits - 9);
 
-		udf_disk_stamp_to_time(&inode->i_atime, efe->accessTime);
-		udf_disk_stamp_to_time(&inode->i_mtime, efe->modificationTime);
+		udf_disk_stamp_to_time(&ts, efe->accessTime);
+		inode->i_atime = timespec_to_timespec64(ts);
+		udf_disk_stamp_to_time(&ts, efe->modificationTime);
+		inode->i_mtime = timespec_to_timespec64(ts);
 		udf_disk_stamp_to_time(&iinfo->i_crtime, efe->createTime);
-		udf_disk_stamp_to_time(&inode->i_ctime, efe->attrTime);
+		udf_disk_stamp_to_time(&ts, efe->attrTime);
+		inode->i_ctime = timespec_to_timespec64(ts);
 
 		iinfo->i_unique = le64_to_cpu(efe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
@@ -1708,9 +1715,12 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 		       inode->i_sb->s_blocksize - sizeof(struct fileEntry));
 		fe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
-		udf_time_to_disk_stamp(&fe->accessTime, inode->i_atime);
-		udf_time_to_disk_stamp(&fe->modificationTime, inode->i_mtime);
-		udf_time_to_disk_stamp(&fe->attrTime, inode->i_ctime);
+		udf_time_to_disk_stamp(&fe->accessTime,
+				       timespec64_to_timespec(inode->i_atime));
+		udf_time_to_disk_stamp(&fe->modificationTime,
+				       timespec64_to_timespec(inode->i_mtime));
+		udf_time_to_disk_stamp(&fe->attrTime,
+				       timespec64_to_timespec(inode->i_ctime));
 		memset(&(fe->impIdent), 0, sizeof(struct regid));
 		strcpy(fe->impIdent.ident, UDF_ID_DEVELOPER);
 		fe->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
@@ -1729,14 +1739,17 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 		efe->objectSize = cpu_to_le64(inode->i_size);
 		efe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
-		udf_adjust_time(iinfo, inode->i_atime);
-		udf_adjust_time(iinfo, inode->i_mtime);
-		udf_adjust_time(iinfo, inode->i_ctime);
+		udf_adjust_time(iinfo, timespec64_to_timespec(inode->i_atime));
+		udf_adjust_time(iinfo, timespec64_to_timespec(inode->i_mtime));
+		udf_adjust_time(iinfo, timespec64_to_timespec(inode->i_ctime));
 
-		udf_time_to_disk_stamp(&efe->accessTime, inode->i_atime);
-		udf_time_to_disk_stamp(&efe->modificationTime, inode->i_mtime);
+		udf_time_to_disk_stamp(&efe->accessTime,
+				       timespec64_to_timespec(inode->i_atime));
+		udf_time_to_disk_stamp(&efe->modificationTime,
+				       timespec64_to_timespec(inode->i_mtime));
 		udf_time_to_disk_stamp(&efe->createTime, iinfo->i_crtime);
-		udf_time_to_disk_stamp(&efe->attrTime, inode->i_ctime);
+		udf_time_to_disk_stamp(&efe->attrTime,
+				       timespec64_to_timespec(inode->i_ctime));
 
 		memset(&(efe->impIdent), 0, sizeof(efe->impIdent));
 		strcpy(efe->impIdent.ident, UDF_ID_DEVELOPER);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 2b70c8b4cee2..0043812897af 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -773,7 +773,7 @@ xfs_ialloc(
 	xfs_inode_t	*ip;
 	uint		flags;
 	int		error;
-	struct timespec	tv;
+	struct timespec64 tv;
 	struct inode	*inode;
 
 	/*
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ce0c1f9466a8..3a65c1348d92 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1054,7 +1054,7 @@ xfs_vn_setattr(
 STATIC int
 xfs_vn_update_time(
 	struct inode		*inode,
-	struct timespec		*now,
+	struct timespec64	*now,
 	int			flags)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
diff --git a/fs/xfs/xfs_trans_inode.c b/fs/xfs/xfs_trans_inode.c
index 07cea592dc01..a1b3ce132f2f 100644
--- a/fs/xfs/xfs_trans_inode.c
+++ b/fs/xfs/xfs_trans_inode.c
@@ -70,7 +70,7 @@ xfs_trans_ichgtime(
 	int			flags)
 {
 	struct inode		*inode = VFS_I(ip);
-	struct timespec		tv;
+	struct timespec64 tv;
 
 	ASSERT(tp);
 	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 381c77a37404..e2f9d858d198 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -208,9 +208,9 @@ struct iattr {
 	kuid_t		ia_uid;
 	kgid_t		ia_gid;
 	loff_t		ia_size;
-	struct timespec	ia_atime;
-	struct timespec	ia_mtime;
-	struct timespec	ia_ctime;
+	struct timespec64 ia_atime;
+	struct timespec64 ia_mtime;
+	struct timespec64 ia_ctime;
 
 	/*
 	 * Not an attribute, but an auxiliary info for filesystems wanting to
@@ -604,9 +604,9 @@ struct inode {
 	};
 	dev_t			i_rdev;
 	loff_t			i_size;
-	struct timespec		i_atime;
-	struct timespec		i_mtime;
-	struct timespec		i_ctime;
+	struct timespec64	i_atime;
+	struct timespec64	i_mtime;
+	struct timespec64	i_ctime;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	unsigned int		i_blkbits;
@@ -1093,7 +1093,7 @@ extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct
 extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
 extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
 extern int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
-extern void lease_get_mtime(struct inode *, struct timespec *time);
+extern void lease_get_mtime(struct inode *, struct timespec64 *time);
 extern int generic_setlease(struct file *, long, struct file_lock **, void **priv);
 extern int vfs_setlease(struct file *, long, struct file_lock **, void **);
 extern int lease_modify(struct file_lock *, int, struct list_head *);
@@ -1208,7 +1208,8 @@ static inline int __break_lease(struct inode *inode, unsigned int mode, unsigned
 	return 0;
 }
 
-static inline void lease_get_mtime(struct inode *inode, struct timespec *time)
+static inline void lease_get_mtime(struct inode *inode,
+				   struct timespec64 *time)
 {
 	return;
 }
@@ -1478,7 +1479,7 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 }
 
 extern struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran);
-extern struct timespec current_time(struct inode *inode);
+extern struct timespec64 current_time(struct inode *inode);
 
 /*
  * Snapshotting support.
@@ -1766,7 +1767,7 @@ struct inode_operations {
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
 		      u64 len);
-	int (*update_time)(struct inode *, struct timespec *, int);
+	int (*update_time)(struct inode *, struct timespec64 *, int);
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode, int *opened);
@@ -2202,7 +2203,7 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
-extern int generic_update_time(struct inode *, struct timespec *, int);
+extern int generic_update_time(struct inode *, struct timespec64 *, int);
 
 /* /sys/fs */
 extern struct kobject *fs_kobj;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 22484e44544d..765573dc17d6 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -41,10 +41,10 @@ struct kstat {
 	kuid_t		uid;
 	kgid_t		gid;
 	loff_t		size;
-	struct timespec	atime;
-	struct timespec	mtime;
-	struct timespec	ctime;
-	struct timespec	btime;			/* File creation time */
+	struct timespec64 atime;
+	struct timespec64 mtime;
+	struct timespec64 ctime;
+	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 };
 
-- 
2.17.0
