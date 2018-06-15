Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7DC30C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F59820896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QZ/HB/pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F59820896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965364AbeFOAnr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:43:47 -0400
Received: from ozlabs.org ([203.11.71.1]:51111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965207AbeFOAnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:43:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 416MDb0dBwz9s01;
        Fri, 15 Jun 2018 10:43:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529023424;
        bh=vTUAFAx9q8uT+LAPQrNLpqusicZdqDcipWCvRLP2hBU=;
        h=Date:From:To:Cc:Subject:From;
        b=QZ/HB/pgnJgP8IVdk89EleNuy4yUWN8LpdgWnc54IOSLqfvckeHLUJoNmgSUAga1b
         ICN4tZsSbkp3UOsvuqx64msoHTS7UCrNnDxZJNb58sVUvnvAbBj2Ns5EHFEmS43Hlc
         mXiiNKtAU1L/STGnmn8o2GErE/OkBkUXCm3vo2vwdWSIqa3+J8LgWr5jLlHTRCZXr/
         g4XHqnKWEWicoe3syAbYptuF58GGNaN5q+FlGSzojdczK9YU4Ro6Q3vW/9Kep8TcQc
         lRfqhJExaYjLOLmd7TVWZBEGv3R2hISIMVBKV6nwcTCIZyxbzpVn6BOrdny9rmyVnQ
         8agOIeCsNBGHA==
Date:   Fri, 15 Jun 2018 10:43:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: linux-next: manual merge of the y2038 tree with the overlayfs tree
Message-ID: <20180615104324.76f86eae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/njFEiffbKUUUr1=hy4vp1yR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/njFEiffbKUUUr1=hy4vp1yR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the y2038 tree got conflicts in:

  fs/inode.c
  fs/overlayfs/inode.c
  fs/overlayfs/overlayfs.h

between various commits from the overlayfs tree and commits:

  8efd6894ff08 ("fs: add timespec64_truncate()")
  95582b008388 ("vfs: change inode times to use struct timespec64")

from the y2038 tree.

I fixed it up (I copied the resolutions that used to be in the merge of
the overlayfs into the y2038 tree - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/inode.c
index 9a6fc2f2d220,9fe1f941be02..55373fcba3a5
--- a/fs/inode.c
+++ b/fs/inode.c
@@@ -1635,10 -1681,11 +1635,10 @@@ static int update_time(struct inode *in
   *	This function automatically handles read only file systems and media,
   *	as well as the "noatime" flag and inode specific "noatime" markers.
   */
 -bool __atime_needs_update(const struct path *path, struct inode *inode,
 -			  bool rcu)
 +bool atime_needs_update(const struct path *path, struct inode *inode)
  {
  	struct vfsmount *mnt =3D path->mnt;
- 	struct timespec now;
+ 	struct timespec64 now;
 =20
  	if (inode->i_flags & S_NOATIME)
  		return false;
@@@ -1661,10 -1708,10 +1661,10 @@@
 =20
  	now =3D current_time(inode);
 =20
- 	if (!relatime_need_update(mnt, inode, now))
 -	if (!relatime_need_update(path, inode, timespec64_to_timespec(now), rcu))
++	if (!relatime_need_update(mnt, inode, timespec64_to_timespec(now)))
  		return false;
 =20
- 	if (timespec_equal(&inode->i_atime, &now))
+ 	if (timespec64_equal(&inode->i_atime, &now))
  		return false;
 =20
  	return true;
@@@ -1674,9 -1721,9 +1674,9 @@@ void touch_atime(const struct path *pat
  {
  	struct vfsmount *mnt =3D path->mnt;
  	struct inode *inode =3D d_inode(path->dentry);
- 	struct timespec now;
+ 	struct timespec64 now;
 =20
 -	if (!__atime_needs_update(path, inode, false))
 +	if (!atime_needs_update(path, inode))
  		return;
 =20
  	if (!sb_start_write_trylock(inode->i_sb))
diff --cc fs/overlayfs/file.c
index f801e1175a0b,000000000000..c6bce11ac6d3
mode 100644,000000..100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@@ -1,508 -1,0 +1,508 @@@
 +/*
 + * Copyright (C) 2017 Red Hat, Inc.
 + *
 + * This program is free software; you can redistribute it and/or modify it
 + * under the terms of the GNU General Public License version 2 as publish=
ed by
 + * the Free Software Foundation.
 + */
 +
 +#include <linux/cred.h>
 +#include <linux/file.h>
 +#include <linux/mount.h>
 +#include <linux/xattr.h>
 +#include <linux/uio.h>
 +#include "overlayfs.h"
 +
 +static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 +{
 +	if (realinode !=3D ovl_inode_upper(inode))
 +		return 'l';
 +	if (ovl_has_upperdata(inode))
 +		return 'u';
 +	else
 +		return 'm';
 +}
 +
 +static struct file *ovl_open_realfile(const struct file *file,
 +				      struct inode *realinode)
 +{
 +	struct inode *inode =3D file_inode(file);
 +	struct file *realfile;
 +	const struct cred *old_cred;
 +
 +	old_cred =3D ovl_override_creds(inode->i_sb);
 +	realfile =3D path_open(&file->f_path, file->f_flags | O_NOATIME,
 +			     realinode, current_cred(), false);
 +	revert_creds(old_cred);
 +
 +	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 +		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
 +		 realfile, IS_ERR(realfile) ? 0 : realfile->f_flags);
 +
 +	return realfile;
 +}
 +
 +#define OVL_SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT)
 +
 +static int ovl_change_flags(struct file *file, unsigned int flags)
 +{
 +	struct inode *inode =3D file_inode(file);
 +	int err;
 +
 +	/* No atime modificaton on underlying */
 +	flags |=3D O_NOATIME;
 +
 +	/* If some flag changed that cannot be changed then something's amiss */
 +	if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))
 +		return -EIO;
 +
 +	flags &=3D OVL_SETFL_MASK;
 +
 +	if (((flags ^ file->f_flags) & O_APPEND) && IS_APPEND(inode))
 +		return -EPERM;
 +
 +	if (flags & O_DIRECT) {
 +		if (!file->f_mapping->a_ops ||
 +		    !file->f_mapping->a_ops->direct_IO)
 +			return -EINVAL;
 +	}
 +
 +	if (file->f_op->check_flags) {
 +		err =3D file->f_op->check_flags(flags);
 +		if (err)
 +			return err;
 +	}
 +
 +	spin_lock(&file->f_lock);
 +	file->f_flags =3D (file->f_flags & ~OVL_SETFL_MASK) | flags;
 +	spin_unlock(&file->f_lock);
 +
 +	return 0;
 +}
 +
 +static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 +			       bool allow_meta)
 +{
 +	struct inode *inode =3D file_inode(file);
 +	struct inode *realinode;
 +
 +	real->flags =3D 0;
 +	real->file =3D file->private_data;
 +
 +	if (allow_meta)
 +		realinode =3D ovl_inode_real(inode);
 +	else
 +		realinode =3D ovl_inode_realdata(inode);
 +
 +	/* Has it been copied up since we'd opened it? */
 +	if (unlikely(file_inode(real->file) !=3D realinode)) {
 +		real->flags =3D FDPUT_FPUT;
 +		real->file =3D ovl_open_realfile(file, realinode);
 +
 +		return PTR_ERR_OR_ZERO(real->file);
 +	}
 +
 +	/* Did the flags change since open? */
 +	if (unlikely((file->f_flags ^ real->file->f_flags) & ~O_NOATIME))
 +		return ovl_change_flags(real->file, file->f_flags);
 +
 +	return 0;
 +}
 +
 +static int ovl_real_fdget(const struct file *file, struct fd *real)
 +{
 +	return ovl_real_fdget_meta(file, real, false);
 +}
 +
 +static int ovl_open(struct inode *inode, struct file *file)
 +{
 +	struct dentry *dentry =3D file_dentry(file);
 +	struct file *realfile;
 +	int err;
 +
 +	err =3D ovl_open_maybe_copy_up(dentry, file->f_flags);
 +	if (err)
 +		return err;
 +
 +	/* No longer need these flags, so don't pass them on to underlying fs */
 +	file->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 +
 +	realfile =3D ovl_open_realfile(file, ovl_inode_realdata(inode));
 +	if (IS_ERR(realfile))
 +		return PTR_ERR(realfile);
 +
 +	/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
 +	file->f_mapping =3D realfile->f_mapping;
 +
 +	file->private_data =3D realfile;
 +
 +	return 0;
 +}
 +
 +static int ovl_release(struct inode *inode, struct file *file)
 +{
 +	fput(file->private_data);
 +
 +	return 0;
 +}
 +
 +static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 +{
 +	struct inode *realinode =3D ovl_inode_real(file_inode(file));
 +
 +	return generic_file_llseek_size(file, offset, whence,
 +					realinode->i_sb->s_maxbytes,
 +					i_size_read(realinode));
 +}
 +
 +static void ovl_file_accessed(struct file *file)
 +{
 +	struct inode *inode, *upperinode;
 +
 +	if (file->f_flags & O_NOATIME)
 +		return;
 +
 +	inode =3D file_inode(file);
 +	upperinode =3D ovl_inode_upper(inode);
 +
 +	if (!upperinode)
 +		return;
 +
- 	if ((!timespec_equal(&inode->i_mtime, &upperinode->i_mtime) ||
- 	     !timespec_equal(&inode->i_ctime, &upperinode->i_ctime))) {
++	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
++	     !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
 +		inode->i_mtime =3D upperinode->i_mtime;
 +		inode->i_ctime =3D upperinode->i_ctime;
 +	}
 +
 +	touch_atime(&file->f_path);
 +}
 +
 +static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
 +{
 +	int ifl =3D iocb->ki_flags;
 +	rwf_t flags =3D 0;
 +
 +	if (ifl & IOCB_NOWAIT)
 +		flags |=3D RWF_NOWAIT;
 +	if (ifl & IOCB_HIPRI)
 +		flags |=3D RWF_HIPRI;
 +	if (ifl & IOCB_DSYNC)
 +		flags |=3D RWF_DSYNC;
 +	if (ifl & IOCB_SYNC)
 +		flags |=3D RWF_SYNC;
 +
 +	return flags;
 +}
 +
 +static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 +{
 +	struct file *file =3D iocb->ki_filp;
 +	struct fd real;
 +	const struct cred *old_cred;
 +	ssize_t ret;
 +
 +	if (!iov_iter_count(iter))
 +		return 0;
 +
 +	ret =3D ovl_real_fdget(file, &real);
 +	if (ret)
 +		return ret;
 +
 +	old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 +	ret =3D vfs_iter_read(real.file, iter, &iocb->ki_pos,
 +			    ovl_iocb_to_rwf(iocb));
 +	revert_creds(old_cred);
 +
 +	ovl_file_accessed(file);
 +
 +	fdput(real);
 +
 +	return ret;
 +}
 +
 +static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 +{
 +	struct file *file =3D iocb->ki_filp;
 +	struct inode *inode =3D file_inode(file);
 +	struct fd real;
 +	const struct cred *old_cred;
 +	ssize_t ret;
 +
 +	if (!iov_iter_count(iter))
 +		return 0;
 +
 +	inode_lock(inode);
 +	/* Update mode */
 +	ovl_copyattr(ovl_inode_real(inode), inode);
 +	ret =3D file_remove_privs(file);
 +	if (ret)
 +		goto out_unlock;
 +
 +	ret =3D ovl_real_fdget(file, &real);
 +	if (ret)
 +		goto out_unlock;
 +
 +	old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 +	ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos,
 +			     ovl_iocb_to_rwf(iocb));
 +	revert_creds(old_cred);
 +
 +	/* Update size */
 +	ovl_copyattr(ovl_inode_real(inode), inode);
 +
 +	fdput(real);
 +
 +out_unlock:
 +	inode_unlock(inode);
 +
 +	return ret;
 +}
 +
 +static int ovl_fsync(struct file *file, loff_t start, loff_t end, int dat=
async)
 +{
 +	struct fd real;
 +	const struct cred *old_cred;
 +	int ret;
 +
 +	ret =3D ovl_real_fdget_meta(file, &real, !datasync);
 +	if (ret)
 +		return ret;
 +
 +	/* Don't sync lower file for fear of receiving EROFS error */
 +	if (file_inode(real.file) =3D=3D ovl_inode_upper(file_inode(file))) {
 +		old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 +		ret =3D vfs_fsync_range(real.file, start, end, datasync);
 +		revert_creds(old_cred);
 +	}
 +
 +	fdput(real);
 +
 +	return ret;
 +}
 +
 +static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 +{
 +	struct fd real;
 +	const struct cred *old_cred;
 +	int ret;
 +
 +	ret =3D ovl_real_fdget(file, &real);
 +	if (ret)
 +		return ret;
 +
 +	/* transfer ref: */
 +	fput(vma->vm_file);
 +	vma->vm_file =3D get_file(real.file);
 +	fdput(real);
 +
 +	if (!vma->vm_file->f_op->mmap)
 +		return -ENODEV;
 +
 +	old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 +	ret =3D call_mmap(vma->vm_file, vma);
 +	revert_creds(old_cred);
 +
 +	ovl_file_accessed(file);
 +
 +	return ret;
 +}
 +
 +static long ovl_fallocate(struct file *file, int mode, loff_t offset, lof=
f_t len)
 +{
 +	struct inode *inode =3D file_inode(file);
 +	struct fd real;
 +	const struct cred *old_cred;
 +	int ret;
 +
 +	ret =3D ovl_real_fdget(file, &real);
 +	if (ret)
 +		return ret;
 +
 +	old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 +	ret =3D vfs_fallocate(real.file, mode, offset, len);
 +	revert_creds(old_cred);
 +
 +	/* Update size */
 +	ovl_copyattr(ovl_inode_real(inode), inode);
 +
 +	fdput(real);
 +
 +	return ret;
 +}
 +
 +static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 +			   unsigned long arg)
 +{
 +	struct fd real;
 +	const struct cred *old_cred;
 +	long ret;
 +
 +	ret =3D ovl_real_fdget(file, &real);
 +	if (ret)
 +		return ret;
 +
 +	old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 +	ret =3D vfs_ioctl(real.file, cmd, arg);
 +	revert_creds(old_cred);
 +
 +	fdput(real);
 +
 +	return ret;
 +}
 +
 +static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long =
arg)
 +{
 +	long ret;
 +	struct inode *inode =3D file_inode(file);
 +
 +	switch (cmd) {
 +	case FS_IOC_GETFLAGS:
 +		ret =3D ovl_real_ioctl(file, cmd, arg);
 +		break;
 +
 +	case FS_IOC_SETFLAGS:
 +		if (!inode_owner_or_capable(inode))
 +			return -EACCES;
 +
 +		ret =3D mnt_want_write_file(file);
 +		if (ret)
 +			return ret;
 +
 +		ret =3D ovl_copy_up_with_data(file_dentry(file));
 +		if (!ret) {
 +			ret =3D ovl_real_ioctl(file, cmd, arg);
 +
 +			inode_lock(inode);
 +			ovl_copyflags(ovl_inode_real(inode), inode);
 +			inode_unlock(inode);
 +		}
 +
 +		mnt_drop_write_file(file);
 +		break;
 +
 +	default:
 +		ret =3D -ENOTTY;
 +	}
 +
 +	return ret;
 +}
 +
 +static long ovl_compat_ioctl(struct file *file, unsigned int cmd,
 +			     unsigned long arg)
 +{
 +	switch (cmd) {
 +	case FS_IOC32_GETFLAGS:
 +		cmd =3D FS_IOC_GETFLAGS;
 +		break;
 +
 +	case FS_IOC32_SETFLAGS:
 +		cmd =3D FS_IOC_SETFLAGS;
 +		break;
 +
 +	default:
 +		return -ENOIOCTLCMD;
 +	}
 +
 +	return ovl_ioctl(file, cmd, arg);
 +}
 +
 +enum ovl_copyop {
 +	OVL_COPY,
 +	OVL_CLONE,
 +	OVL_DEDUPE,
 +};
 +
 +static s64 ovl_copyfile(struct file *file_in, loff_t pos_in,
 +			struct file *file_out, loff_t pos_out,
 +			u64 len, unsigned int flags, enum ovl_copyop op)
 +{
 +	struct inode *inode_out =3D file_inode(file_out);
 +	struct fd real_in, real_out;
 +	const struct cred *old_cred;
 +	s64 ret;
 +
 +	ret =3D ovl_real_fdget(file_out, &real_out);
 +	if (ret)
 +		return ret;
 +
 +	ret =3D ovl_real_fdget(file_in, &real_in);
 +	if (ret) {
 +		fdput(real_out);
 +		return ret;
 +	}
 +
 +	old_cred =3D ovl_override_creds(file_inode(file_out)->i_sb);
 +	switch (op) {
 +	case OVL_COPY:
 +		ret =3D vfs_copy_file_range(real_in.file, pos_in,
 +					  real_out.file, pos_out, len, flags);
 +		break;
 +
 +	case OVL_CLONE:
 +		ret =3D vfs_clone_file_range(real_in.file, pos_in,
 +					   real_out.file, pos_out, len);
 +		break;
 +
 +	case OVL_DEDUPE:
 +		ret =3D vfs_dedupe_file_range_one(real_in.file, pos_in,
 +						real_out.file, pos_out, len);
 +		break;
 +	}
 +	revert_creds(old_cred);
 +
 +	/* Update size */
 +	ovl_copyattr(ovl_inode_real(inode_out), inode_out);
 +
 +	fdput(real_in);
 +	fdput(real_out);
 +
 +	return ret;
 +}
 +
 +static ssize_t ovl_copy_file_range(struct file *file_in, loff_t pos_in,
 +				   struct file *file_out, loff_t pos_out,
 +				   size_t len, unsigned int flags)
 +{
 +	return ovl_copyfile(file_in, pos_in, file_out, pos_out, len, flags,
 +			    OVL_COPY);
 +}
 +
 +static int ovl_clone_file_range(struct file *file_in, loff_t pos_in,
 +				struct file *file_out, loff_t pos_out, u64 len)
 +{
 +	return ovl_copyfile(file_in, pos_in, file_out, pos_out, len, 0,
 +			    OVL_CLONE);
 +}
 +
 +static loff_t ovl_dedupe_file_range(struct file *file_in, loff_t pos_in,
 +				    struct file *file_out, loff_t pos_out,
 +				    loff_t len)
 +{
 +	/*
 +	 * Don't copy up because of a dedupe request, this wouldn't make sense
 +	 * most of the time (data would be duplicated instead of deduplicated).
 +	 */
 +	if (!ovl_inode_upper(file_inode(file_in)) ||
 +	    !ovl_inode_upper(file_inode(file_out)))
 +		return -EPERM;
 +
 +	return ovl_copyfile(file_in, pos_in, file_out, pos_out, len, 0,
 +			    OVL_DEDUPE);
 +}
 +
 +const struct file_operations ovl_file_operations =3D {
 +	.open		=3D ovl_open,
 +	.release	=3D ovl_release,
 +	.llseek		=3D ovl_llseek,
 +	.read_iter	=3D ovl_read_iter,
 +	.write_iter	=3D ovl_write_iter,
 +	.fsync		=3D ovl_fsync,
 +	.mmap		=3D ovl_mmap,
 +	.fallocate	=3D ovl_fallocate,
 +	.unlocked_ioctl	=3D ovl_ioctl,
 +	.compat_ioctl	=3D ovl_compat_ioctl,
 +
 +	.copy_file_range	=3D ovl_copy_file_range,
 +	.clone_file_range	=3D ovl_clone_file_range,
 +	.dedupe_file_range	=3D ovl_dedupe_file_range,
 +};
diff --cc fs/overlayfs/inode.c
index e31d64206a01,d7cca60f28e6..e0bb217c01e2
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@@ -439,7 -384,39 +439,7 @@@ struct posix_acl *ovl_get_acl(struct in
  	return acl;
  }
 =20
- int ovl_update_time(struct inode *inode, struct timespec *ts, int flags)
 -static bool ovl_open_need_copy_up(struct dentry *dentry, int flags)
 -{
 -	/* Copy up of disconnected dentry does not set upper alias */
 -	if (ovl_dentry_upper(dentry) &&
 -	    (ovl_dentry_has_upper_alias(dentry) ||
 -	     (dentry->d_flags & DCACHE_DISCONNECTED)))
 -		return false;
 -
 -	if (special_file(d_inode(dentry)->i_mode))
 -		return false;
 -
 -	if (!(OPEN_FMODE(flags) & FMODE_WRITE) && !(flags & O_TRUNC))
 -		return false;
 -
 -	return true;
 -}
 -
 -int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags)
 -{
 -	int err =3D 0;
 -
 -	if (ovl_open_need_copy_up(dentry, file_flags)) {
 -		err =3D ovl_want_write(dentry);
 -		if (!err) {
 -			err =3D ovl_copy_up_flags(dentry, file_flags);
 -			ovl_drop_write(dentry);
 -		}
 -	}
 -
 -	return err;
 -}
 -
+ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
  {
  	if (flags & S_ATIME) {
  		struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
diff --cc fs/overlayfs/overlayfs.h
index ac9fbc3d08ea,9fe10247f9d4..f61839e1054c
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@@ -349,18 -330,10 +349,18 @@@ int ovl_xattr_get(struct dentry *dentry
  		  void *value, size_t size);
  ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
  struct posix_acl *ovl_get_acl(struct inode *inode, int type);
- int ovl_update_time(struct inode *inode, struct timespec *ts, int flags);
 -int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags=
);
+ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags=
);
  bool ovl_is_private_xattr(const char *name);
 =20
 +struct ovl_inode_params {
 +	struct inode *newinode;
 +	struct dentry *upperdentry;
 +	struct ovl_path *lowerpath;
 +	struct dentry *index;
 +	unsigned int numlower;
 +	char *redirect;
 +	struct dentry *lowerdata;
 +};
  struct inode *ovl_new_inode(struct super_block *sb, umode_t mode, dev_t r=
dev);
  struct inode *ovl_lookup_inode(struct super_block *sb, struct dentry *rea=
l,
  			       bool is_upper);

--Sig_/njFEiffbKUUUr1=hy4vp1yR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsjC6wACgkQAVBC80lX
0Gw/uggAlXKXPpkLh+IpVpGVLsdsptpD8rUEnLpLs+j9fNDFe2Y5Wy2TSR7TvU79
ai9trxU+ZrIhROwh/b+KpM81FPf5PLLEtioGZb0aIrasmHmMxy3eXMNnrMplNWyK
Yh8xoRFExn6jft4j3BSzv3X/v17Cw951ESbzyVWn9CpFbqxZ+0VQHAmnS4qZI6Yh
zXrZZcqS6QDyxy9Bo/s5EnjCwJ/fBWx7WfEwbip99VqqDmuaXFpi/pkFJim55vj0
eyxcPWPRBOHZEFGiVQRyDlLpYk1+T/1JWHPs9vEAwgH38UjobgBKkAvni2Xr/gvw
Iw8IT4rIYvEc6eShR5QWLscuoooHNg==
=ZpWI
-----END PGP SIGNATURE-----

--Sig_/njFEiffbKUUUr1=hy4vp1yR--
