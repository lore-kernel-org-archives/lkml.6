Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E873F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E873F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbeGKPas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:30:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36928 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbeGKPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:30:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdH07-0003Qb-BP; Wed, 11 Jul 2018 15:25:55 +0000
Date:   Wed, 11 Jul 2018 16:25:55 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [RFC][PATCH 01/42] drm_mode_create_lease_ioctl(): fix open-coded
 filp_clone_open()
Message-ID: <20180711152555.GR30522@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 07:56:51PM -0700, Linus Torvalds wrote:
> Ok, you didn't seem to have a coverletter email, so I'm just replying
> to the first one.
> 
> Apart from the couple of totally trivial things I reacted to, this
> looks very clean and nice. And now I sat in front of the computer
> while reading it, so I could follow along better.
> 
> So apart from the small stylistic nits, all Acked-by from me.

FWIW, looking at the ->f_flags handling, I'm seriously tempted to do
alloc_file_pseudo(inode, mnt, name, f_flags, ops).

Reason: right now all but two callers of alloc_file_pseudo() are followed
by setting ->f_flags and for all those callers the mode argument passed
to alloc_file_pseudo() is equal to OPEN_FMODE(->f_flags value to be).

The exceptions are __shmem_file_setup() and hugetlb_file_setup().  Both
end up with FMODE_READ | FMODE_WRITE combined with 0 (i.e. O_RDONLY) in
f_flags.  Which smells like a bug in making, at the very least.

Unless somebody has a good reason why those shouldn't have O_RDWR,
I want to add (and fold back into individual "convert to alloc_file_pseudo"
commits) the following:

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index 77e2d623e115..6b8f5e37f0f7 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -613,7 +613,7 @@ in your dentry operations instead.
 --
 [mandatory]
 	alloc_file() has become static now; two wrappers are to be used instead.
-	alloc_file_pseudo(inode, vfsmount, name, mode, ops) is for the cases
+	alloc_file_pseudo(inode, vfsmount, name, flags, ops) is for the cases
 	when dentry needs to be created; that's the majority of old alloc_file()
 	users.  Calling conventions: on success a reference to new struct file
 	is returned and callers reference to inode is subsumed by that.  On
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index e0b9c00aecde..8fd5ec4d6042 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -90,11 +90,10 @@ static struct file *cxl_getfile(const char *name,
 	}
 
 	file = alloc_file_pseudo(inode, cxl_vfs_mount, name,
-				 OPEN_FMODE(flags), fops);
+				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file))
 		goto err_inode;
 
-	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = priv;
 
 	return file;
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 6d0632174ec6..a43d44e7e7dd 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -115,7 +115,7 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
 	}
 
 	file = alloc_file_pseudo(inode, ocxlflash_vfs_mount, name,
-				 OPEN_FMODE(flags), fops);
+				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file)) {
 		rc = PTR_ERR(file);
 		dev_err(dev, "%s: alloc_file failed rc=%d\n",
@@ -123,7 +123,6 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
 		goto err4;
 	}
 
-	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = priv;
 out:
 	return file;
diff --git a/fs/aio.c b/fs/aio.c
index c5244c68f90e..c3a8bac16374 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -225,11 +225,9 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 	inode->i_size = PAGE_SIZE * nr_pages;
 
 	file = alloc_file_pseudo(inode, aio_mnt, "[aio]",
-				FMODE_READ | FMODE_WRITE, &aio_ring_fops);
+				O_RDWR, &aio_ring_fops);
 	if (IS_ERR(file))
 		iput(inode);
-	else
-		file->f_flags = O_RDWR;
 	return file;
 }
 
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 7e13edd23db1..9a3c765fc7b1 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -85,13 +85,11 @@ struct file *anon_inode_getfile(const char *name,
 	 */
 	ihold(anon_inode_inode);
 	file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
-				 OPEN_FMODE(flags), fops);
+				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file))
 		goto err;
 
 	file->f_mapping = anon_inode_inode->i_mapping;
-
-	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = priv;
 
 	return file;
diff --git a/fs/file_table.c b/fs/file_table.c
index c5f651fd6830..af9141d8e29f 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -182,7 +182,7 @@ static struct file *alloc_file(const struct path *path, fmode_t mode,
 }
 
 struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
-				const char *name, fmode_t mode,
+				const char *name, int flags,
 				const struct file_operations *fops)
 {
 	static const struct dentry_operations anon_ops = {
@@ -199,11 +199,12 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 		d_set_d_op(path.dentry, &anon_ops);
 	path.mnt = mntget(mnt);
 	d_instantiate(path.dentry, inode);
-	file = alloc_file(&path, mode, fops);
+	file = alloc_file(&path, OPEN_FMODE(flags), fops);
 	if (IS_ERR(file)) {
 		ihold(inode);
 		path_put(&path);
 	}
+	file->f_flags = flags;
 	return file;
 }
 EXPORT_SYMBOL(alloc_file_pseudo);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 86ffe04f73d6..87605c73361b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1358,8 +1358,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 			acctflag))
 		file = ERR_PTR(-ENOMEM);
 	else
-		file = alloc_file_pseudo(inode, mnt, name,
-					FMODE_WRITE | FMODE_READ,
+		file = alloc_file_pseudo(inode, mnt, name, O_RDWR,
 					&hugetlbfs_file_operations);
 	if (!IS_ERR(file))
 		return file;
diff --git a/fs/pipe.c b/fs/pipe.c
index 94323a1d7c92..f5d30579e017 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -750,14 +750,15 @@ int create_pipe_files(struct file **res, int flags)
 	if (!inode)
 		return -ENFILE;
 
-	f = alloc_file_pseudo(inode, pipe_mnt, "", FMODE_WRITE, &pipefifo_fops);
+	f = alloc_file_pseudo(inode, pipe_mnt, "",
+				O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT)),
+				&pipefifo_fops);
 	if (IS_ERR(f)) {
 		free_pipe_info(inode->i_pipe);
 		iput(inode);
 		return PTR_ERR(f);
 	}
 
-	f->f_flags = O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT));
 	f->private_data = inode->i_pipe;
 
 	res[0] = alloc_file_clone(f, FMODE_READ, &pipefifo_fops);
diff --git a/include/linux/file.h b/include/linux/file.h
index 325b36ca336d..1972776e1677 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -20,7 +20,7 @@ struct dentry;
 struct inode;
 struct path;
 extern struct file *alloc_file_pseudo(struct inode *, struct vfsmount *,
-	const char *, fmode_t, const struct file_operations *);
+	const char *, int, const struct file_operations *);
 extern struct file *alloc_file_clone(struct file *, fmode_t,
 	const struct file_operations *);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index fd21df189f32..d7e984141be5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3922,8 +3922,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	clear_nlink(inode);	/* It is unlinked */
 	res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
 	if (!IS_ERR(res))
-		res = alloc_file_pseudo(inode, mnt, name,
-				FMODE_WRITE | FMODE_READ,
+		res = alloc_file_pseudo(inode, mnt, name, O_RDWR,
 				&shmem_file_operations);
 	if (IS_ERR(res))
 		iput(inode);
diff --git a/net/socket.c b/net/socket.c
index 81cf9906cae5..4cf3568caf9f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -397,14 +397,14 @@ struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname)
 		dname = sock->sk ? sock->sk->sk_prot_creator->name : "";
 
 	file = alloc_file_pseudo(SOCK_INODE(sock), sock_mnt, dname,
-				FMODE_READ | FMODE_WRITE, &socket_file_ops);
+				O_RDWR | (flags & O_NONBLOCK),
+				&socket_file_ops);
 	if (IS_ERR(file)) {
 		sock_release(sock);
 		return file;
 	}
 
 	sock->file = file;
-	file->f_flags = O_RDWR | (flags & O_NONBLOCK);
 	file->private_data = sock;
 	return file;
 }


Objections?  Another odd beastie is do_shmat() - there we end up with
f_mode not matching f_flags, same way as in shmem and hugetlb.  If we
could rectify that one as well, we'd be able to switch alloc_file_clone()
to flags as well.  I would obviously prefer that kind of change to happen
before these helpers go into mainline...
