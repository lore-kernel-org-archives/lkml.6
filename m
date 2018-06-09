Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 08iIH89gG1sMEQAAmS7hNA
	; Sat, 09 Jun 2018 05:10:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B39406089E; Sat,  9 Jun 2018 05:10:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 603EC6032D;
	Sat,  9 Jun 2018 05:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 603EC6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeFIFKy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 01:10:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34702 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeFIFKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 01:10:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRW9L-0003J9-64; Sat, 09 Jun 2018 05:10:51 +0000
Date: Sat, 9 Jun 2018 06:10:51 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCHES] getting rid of int *open in ->atomic_open() and
 friends
Message-ID: <20180609051051.GF30522@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:57:06AM -0700, Linus Torvalds wrote:
> I'm obviously biased since I asked for this, but:
> 
> On Fri, Jun 8, 2018 at 11:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >  33 files changed, 135 insertions(+), 180 deletions(-)
> 
> this already looks nice.
> 
> I'll go through the individual patches and see if there's anything
> there that raises my hackles. Silence will mean assent in this case

BTW, looking through alloc_file() callers - in cxl_getfile() we have
	try to grab f_op owner
	try to grab fs_type
		if failed => err_module
	allocate an inode, set it up if successful
		if failed => err_fs
	allocate a dentry
		if failed => err_inode
	pin vfsmount
	d_instantiate
	alloc_file
		if failed => err_dput
	finish setting up
	return file
err_dput:
        drop vfsmount/dentry
err_inode:
        drop inode
err_fs:
	drop fs_type
err_module:
        drop f_op owner
	return an error

That's a double iput when we hit alloc_file failure...  There's a bunch
of callers that can be massaged into something along such lines (not
sharing that bug, though) and I wonder if we would be better off with
wrapper like

something(inode, mnt, name, fops, mode)
{
	struct qstr this = QSTR_INIT(name, strlen(name));
	struct path path;
	struct file *file;

	path.dentry = d_alloc_anon(mnt->mnt_sb, &this);
	if (!path.dentry)
		return ERR_PTR(-ENOMEM);
	path.mnt = mntget(mnt);
	d_instantiate(path.dentry, inode);
	file = alloc_file(&path, mode | FMODE_OPENED, fops);
	if (IS_ERR(file)) {
		ihold(inode);
		path_put(&path);
	}
	return file;
}

with users being
	allocate inode
		if failed => bugger off
	set inode up
	file = something(inode, mnt, name, fops, mode);
	if (IS_ERR(file))
		drop inode, bugger off
	finish setting file up

sock_alloc_file(): inode is coallocated with socket, otherwise it's
as above -
        struct file *file;
        if (!dname) {
		if (sock->sk)
			dname = sock->sk->sk_prot_creator->name;
		else
			dname = "";
        }
        file = something(SOCK_INODE(sock), sock_mnt, dname,
			 &socket_file_ops, FMODE_READ | FMODE_WRITE);
        if (IS_ERR(file)) {
                sock_release(sock);
                return file;
        }
        sock->file = file;
        file->f_flags = O_RDWR | (flags & O_NONBLOCK);
        file->private_data = sock;
	return file;

aio_private_file(): exactly that form, turns into
        struct file *file;
        struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
        if (IS_ERR(inode))  
                return ERR_CAST(inode);

        inode->i_mapping->a_ops = &aio_ctx_aops;
        inode->i_mapping->private_data = ctx;
        inode->i_size = PAGE_SIZE * nr_pages;

        file = something(inode, aio_mnt, "[aio]", &aio_ring_fops,
			 FMODE_READ | FMODE_WRITE);
        if (IS_ERR(file))
                iput(inode);
	else
		file->f_flags = O_RDWR;
        return file;

cxl_getfile(): after fixing the double-iput() in there, turns into
        struct file *file;
        struct inode *inode;
        int rc;

        if (fops->owner && !try_module_get(fops->owner))
                return ERR_PTR(-ENOENT);

        rc = simple_pin_fs(&cxl_fs_type, &cxl_vfs_mount, &cxl_fs_cnt);
        if (rc < 0) {
                pr_err("Cannot mount cxl pseudo filesystem: %d\n", rc);
                file = ERR_PTR(rc);
                goto err_module;
        }

        inode = alloc_anon_inode(cxl_vfs_mount->mnt_sb);
        if (IS_ERR(inode)) {
                file = ERR_CAST(inode);
                goto err_fs;
        }

        file = something(inode, cxl_vfs_mount, name, fops, OPEN_FMODE(flags));
        if (IS_ERR(file)) {
		iput(inode);
		goto err_fs;
	}
	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
	file->private_data = priv;
        return file;

err_fs:
        simple_release_fs(&cxl_vfs_mount, &cxl_fs_cnt);
err_module:
        module_put(fops->owner);
        return file;

__shmem_file_setup() - massaged into
        struct inode *inode;
        struct file *res;

        if (IS_ERR(mnt))
                return ERR_CAST(mnt);

        if (size < 0 || size > MAX_LFS_FILESIZE)
                return ERR_PTR(-EINVAL);

        if (shmem_acct_size(flags, size))
                return ERR_PTR(-ENOMEM);

        inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0, flags);
        if (unlikely(!inode)) {
		shmem_unacct_size(flags, size);
		return ERR_PTR(-ENOSPC);
	}

        inode->i_flags |= i_flags;
        inode->i_size = size;
        clear_nlink(inode);     /* It is unlinked */
        res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
        if (!IS_ERR(res))
		res = something(inode, mnt, name, &shmem_file_operations,
				FMODE_WRITE | FMODE_READ);
        if (IS_ERR(res))
		iput(inode);
        return res;
(massage includes setting ->s_d_op to hybrid of simple_dentry_operations and
anon_ops).

hugetlb_file_setup() - massaged into
        struct file *file;
        struct inode *inode;
        struct vfsmount *mnt;
        int hstate_idx = get_hstate_idx(page_size_log);
        if (hstate_idx < 0)
                return ERR_PTR(-ENODEV);

        *user = NULL;
        mnt = hugetlbfs_vfsmount[hstate_idx];
        if (!mnt)
                return ERR_PTR(-ENOENT);

        if (creat_flags == HUGETLB_SHMFS_INODE && !can_do_hugetlb_shm()) {
                *user = current_user();
                if (user_shm_lock(size, *user)) {
                        task_lock(current);
                        pr_warn_once("%s (%d): Using mlock ulimits for SHM_HUGETLB is deprecated\n",
                                current->comm, current->pid);
                        task_unlock(current);
                } else {
                        *user = NULL;
                        return ERR_PTR(-EPERM);
                }
        }
        inode = hugetlbfs_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0);
        if (unlikely(!inode)) {
		file = ERR_PTR(-ENOSPC);
                goto out;
	}
        if (creat_flags == HUGETLB_SHMFS_INODE)
                inode->i_flags |= S_PRIVATE;
        clear_nlink(inode);
        inode->i_size = size;

        if (hugetlb_reserve_pages(inode, 0,
                        size >> huge_page_shift(hstate_inode(inode)), NULL,
                        acctflag))
		file = ERR_PTR(-ENOMEM);
	else
		file = something(inode, mnt, name, &hugetlbfs_file_operations,
				FMODE_WRITE | FMODE_READ);
        if (!IS_ERR(file))
		return file;
out:
        iput(inode);
        if (*user) {
                user_shm_unlock(size, *user);
                *user = NULL;
        }
        return file;

and the first caller of alloc_file() in create_pipe_files() also massages
into similar form.

That leaves
	* anon_inode_getfile() - converts to similar form, at the price of
ihold done slightly earlier, so that failure exit needs a (non-final, i.e.
very cheap) iput() we currently avoid.  Not a problem.
	* do_shmat() and the second alloc_file() in create_pipe_files().
Those are rather different - we *do* have an existing dentry/inode/mount
there and all we want on cleanup is path_put() to undo the path_get()
we'd done.
	* perfmon mess - _very_ different, and I wouldn't bet a dime on
correctness of failure exits there.  One of the issues is that it simulates
mmap as part of setup, so cleanup really is different.

AFAICS, there's a clear case for alloc_file() wrapper - 6 callers out of
10 get simpler with it, and the seventh is also a good candidate for the
same treatment.  Any naming ideas for that thing ("something" in the above)
would be welcome...

BTW, that's almost all callers of d_alloc_pseudo() - there is exactly one
caller not of that form (in __ns_get_path()) right now.  perfmon should
be another caller, but that might end up converted to the new wrapper...

As for put_filp()... the callers left in my local tree right now are
	* path_openat(), dentry_open(), file_clone_open() (all of the
same form - "put_filp() if it doesn't have FMODE_OPENED, fput() otherwise)
	* perfmon mess.
create_pipe_files() got converted to fput() with a bit of massage...
