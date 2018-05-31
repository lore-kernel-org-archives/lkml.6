Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeEaTT6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:19:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48472 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754030AbeEaTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:19:57 -0400
Date: Thu, 31 May 2018 20:19:55 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/32] vfs: Make close() unmount the attached mount if so
 flagged [ver #8]
Message-ID: <20180531191955.GG30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720685405.9073.17445116582570028610.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152720685405.9073.17445116582570028610.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:07:34AM +0100, David Howells wrote:
> +	if (unlikely(file->f_mode & FMODE_NEED_UNMOUNT))
> +		__detach_mounts(dentry);
> +

This is completely wrong.  First of all, you want to dissolve the mount tree
on file->f_path.mount, not every tree rooted at dentry equal to file->f_path.dentry.
This is easily done - it would be a simple call of drop_collected_mounts(mnt)
if not for one detail.  You want it to happen only if the sucker isn't attached
anywhere by that point.  IOW,
        namespace_lock();
        lock_mount_hash();
	if (!real_mount(mnt)->mnt_ns)
		umount_tree(real_mount(mnt), UMOUNT_SYNC);
        unlock_mount_hash();
        namespace_unlock();
and that's it.  You don't need that magical mystery turd in move_mount() later
in the series and all the infrastructure you grow for it.

FWIW, I would've suggested this
 void drop_collected_mounts(struct vfsmount *mnt)
 {
 	namespace_lock();
 	lock_mount_hash();
+	if (!real_mount(mnt)->mnt_ns)
+		umount_tree(real_mount(mnt), UMOUNT_SYNC);
-	umount_tree(real_mount(mnt), UMOUNT_SYNC);
 	unlock_mount_hash();
 	namespace_unlock();
 }

and in __fput()
	if (unlikely(file->f_mode & FMODE_NEED_UNMOUNT))
		drop_collected_mounts(mnt);

All there is to it, AFAICS...
