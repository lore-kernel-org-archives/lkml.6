Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA86A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA86A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbeGPIGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:06:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeGPIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:06:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DABACA1;
        Mon, 16 Jul 2018 07:40:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 23/54] devpts: resolve devpts bind-mounts
Date:   Mon, 16 Jul 2018 09:35:20 +0200
Message-Id: <20180716073455.239933212@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <christian.brauner@ubuntu.com>

commit a319b01d9095da6f6c54bd20c1f1300762506255 upstream.

Most libcs will still look at /dev/ptmx when opening the master fd of a pty
device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
ioctl() is used to safely retrieve a file descriptor for the slave side of
the pty based on the master fd, the /proc/self/fd/{0,1,2} symlinks will
point to /. A very simply reproducer for this issue presupposing a libc
that uses TIOCGPTPEER in its openpty() implementation is:

unshare --mount
mount --bind /dev/pts/ptmx /dev/ptmx
chmod 666 /dev/ptmx
script
ls -al /proc/self/fd/0

Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
regression. In addition, it is also a fairly common scenario in containers
employing user namespaces.

The reason for the current failure is that the kernel tries to verify the
useability of the devpts filesystem without resolving the /dev/ptmx
bind-mount first. This will lead it to detect that the dentry is escaping
its bind-mount. The reason is that while the devpts filesystem mounted at
/dev/pts has the devtmpfs mounted at /dev as its parent mount:

21 -- -- / /dev
-- 21 -- / /dev/pts

devtmpfs and devpts are on different devices

-- -- 0:6  / /dev
-- -- 0:20 / /dev/pts

This has the consequence that the pathname of the parent directory of the
devpts filesystem mount at /dev/pts is /. So if /dev/ptmx is a bind-mount
of /dev/pts/ptmx then the /dev/ptmx bind-mount and the devpts mount at
/dev/pts will end up being located on the same device which is recorded in
the superblock of their vfsmount. This means the parent directory of the
/dev/ptmx bind-mount will be /ptmx:

-- -- ---- /ptmx /dev/ptmx

Without the bind-mount resolution patch the kernel will now perform the
bind-mount escape check directly on /dev/ptmx. The function responsible for
this is devpts_ptmx_path() which calls pts_path() which in turn calls
path_parent_directory(). Based on the above explanation,
path_parent_directory() will yield / as the parent directory for the
/dev/ptmx bind-mount and not the expected /dev. Thus, the kernel detects
that /dev/ptmx is escaping its bind-mount and will set /proc/<pid>/fd/<nr>
to /.

This patch changes the logic to first resolve any bind-mounts. After the
bind-mounts have been resolved (i.e. we have traced it back to the
associated devpts mount) devpts_ptmx_path() can be called. In order to
guarantee correct path generation for the slave file descriptor the kernel
now requires that a pts directory is found in the parent directory of the
ptmx bind-mount. This implies that when doing bind-mounts the ptmx
bind-mount and the devpts mount should have a common parent directory. A
valid example is:

mount -t devpts devpts /dev/pts
mount --bind /dev/pts/ptmx /dev/ptmx

an invalid example is:

mount -t devpts devpts /dev/pts
mount --bind /dev/pts/ptmx /ptmx

This allows us to support:
- calling open on ptmx devices located inside non-standard devpts mounts:
  mount -t devpts devpts /mnt
  master = open("/mnt/ptmx", ...);
  slave = ioctl(master, TIOCGPTPEER, ...);
- calling open on ptmx devices located outside the devpts mount with a
  common ancestor directory:
  mount -t devpts devpts /dev/pts
  mount --bind /dev/pts/ptmx /dev/ptmx
  master = open("/dev/ptmx", ...);
  slave = ioctl(master, TIOCGPTPEER, ...);

while failing on ptmx devices located outside the devpts mount without a
common ancestor directory:
  mount -t devpts devpts /dev/pts
  mount --bind /dev/pts/ptmx /ptmx
  master = open("/ptmx", ...);
  slave = ioctl(master, TIOCGPTPEER, ...);

in which case save path generation cannot be guaranteed.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/devpts/inode.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -160,21 +160,27 @@ struct vfsmount *devpts_mntget(struct fi
 	path = filp->f_path;
 	path_get(&path);
 
-	/* Has the devpts filesystem already been found? */
-	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)
+	/* Walk upward while the start point is a bind mount of
+	 * a single file.
+	 */
+	while (path.mnt->mnt_root == path.dentry)
+		if (follow_up(&path) == 0)
+			break;
+
+	/* devpts_ptmx_path() finds a devpts fs or returns an error. */
+	if ((path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) ||
+	    (DEVPTS_SB(path.mnt->mnt_sb) != fsi))
 		err = devpts_ptmx_path(&path);
 	dput(path.dentry);
-	if (err) {
-		mntput(path.mnt);
-		return ERR_PTR(err);
-	}
+	if (!err) {
+		if (DEVPTS_SB(path.mnt->mnt_sb) == fsi)
+			return path.mnt;
 
-	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
-		mntput(path.mnt);
-		return ERR_PTR(-ENODEV);
+		err = -ENODEV;
 	}
 
-	return path.mnt;
+	mntput(path.mnt);
+	return ERR_PTR(err);
 }
 
 struct pts_fs_info *devpts_acquire(struct file *filp)


