Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7E5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FD420684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FD420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeJCMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:54:07 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33305 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:54:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g7aJR-0001eT-HK; Wed, 03 Oct 2018 00:07:09 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g7aJP-0004bn-NJ; Wed, 03 Oct 2018 00:07:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
References: <20181002102054.13245-1-laurent@vivier.eu>
        <20181002102054.13245-2-laurent@vivier.eu>
Date:   Wed, 03 Oct 2018 08:07:00 +0200
In-Reply-To: <20181002102054.13245-2-laurent@vivier.eu> (Laurent Vivier's
        message of "Tue, 2 Oct 2018 12:20:54 +0200")
Message-ID: <87o9cbo96j.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g7aJP-0004bn-NJ;;;mid=<87o9cbo96j.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/n9lmhVkdEThtZOb6LuQf3hBmSk8UHn10=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC v2 v2 1/1] ns: add binfmt_misc to the mount namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Vivier <laurent@vivier.eu> writes:

> This patch allows to have a different binftm_misc configuration
> in each container we mount binfmt_misc filesystem with mount namespace
> enabled.
>
> A container started without the CLONE_NEWNS will use the host binfmt_misc
> configuration, otherwise the container starts with an empty binfmt_misc
> interpreters list.
>
> For instance, using "unshare" we can start a chroot of an another
> architecture and configure the binfmt_misc interpreted without being root
> to run the binaries in this chroot.

A couple of things.
As has already been mentioned on your previous version anything that
comes through the filesystem interface needs to lookup up the local
binfmt context not through current but through file->f_dentry->d_sb.
AKA the superblock of the mounted filesystem.

As you have this coded any time a mount namespace is unshared you get a
new binfmt context.  That has a very reasonable chance of breaking
existing userspace.

A mount of binfmt_misc today from within a user namespace is not allowed
which is why I have figured that will be a nice place to trigger
creating a new binfmt context.

It is fundamentally necessary to be able to get a pointer to the binfmt
context from current.  Either stored in an existing namespace or
stored in nsproxy.  Anything else will risk breaking backwards
compatibility with existing user space for no good reason.

What is fundamentally being changed is the behavior of exec.

Changing the behavior of exec needs to be carefully contained or we risk
confusing privileged applications.

I believe your last email to James Bottomley detailed a very strong use
case for this functionality.

As the key gains over the existing kernel is unprivileged use.  As it is
the behavior of exec that is changing.  You definitely need a user
namespace involved.

So I think the simplest would be to hang the binfmt context off of a
user namespace.  But I am open to other ideas.

My primary concern is that we keep the cognitive and the maintenance
burden as small as is reasonably possible so that the costs don't out
weigh the benefit.

Eric


> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  fs/binfmt_misc.c | 50 +++++++++++++++++++++++++-----------------------
>  fs/mount.h       |  8 ++++++++
>  fs/namespace.c   |  6 ++++++
>  3 files changed, 40 insertions(+), 24 deletions(-)
>
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index aa4a7a23ff99..ecb14776c759 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -25,6 +25,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
> +#include <mount.h>
>  
>  #include "internal.h"
>  
> @@ -38,9 +39,6 @@ enum {
>  	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
>  };
>  
> -static LIST_HEAD(entries);
> -static int enabled = 1;
> -
>  enum {Enabled, Magic};
>  #define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
>  #define MISC_FMT_OPEN_BINARY (1 << 30)
> @@ -60,10 +58,7 @@ typedef struct {
>  	struct file *interp_file;
>  } Node;
>  
> -static DEFINE_RWLOCK(entries_lock);
>  static struct file_system_type bm_fs_type;
> -static struct vfsmount *bm_mnt;
> -static int entry_count;
>  
>  /*
>   * Max length of the register string.  Determined by:
> @@ -91,7 +86,7 @@ static Node *check_file(struct linux_binprm *bprm)
>  	struct list_head *l;
>  
>  	/* Walk all the registered handlers. */
> -	list_for_each(l, &entries) {
> +	list_for_each(l, &binfmt_ns(entries)) {
>  		Node *e = list_entry(l, Node, list);
>  		char *s;
>  		int j;
> @@ -135,15 +130,15 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	int fd_binary = -1;
>  
>  	retval = -ENOEXEC;
> -	if (!enabled)
> +	if (!binfmt_ns(enabled))
>  		return retval;
>  
>  	/* to keep locking time low, we copy the interpreter string */
> -	read_lock(&entries_lock);
> +	read_lock(&binfmt_ns(entries_lock));
>  	fmt = check_file(bprm);
>  	if (fmt)
>  		dget(fmt->dentry);
> -	read_unlock(&entries_lock);
> +	read_unlock(&binfmt_ns(entries_lock));
>  	if (!fmt)
>  		return retval;
>  
> @@ -613,15 +608,15 @@ static void kill_node(Node *e)
>  {
>  	struct dentry *dentry;
>  
> -	write_lock(&entries_lock);
> +	write_lock(&binfmt_ns(entries_lock));
>  	list_del_init(&e->list);
> -	write_unlock(&entries_lock);
> +	write_unlock(&binfmt_ns(entries_lock));
>  
>  	dentry = e->dentry;
>  	drop_nlink(d_inode(dentry));
>  	d_drop(dentry);
>  	dput(dentry);
> -	simple_release_fs(&bm_mnt, &entry_count);
> +	simple_release_fs(&binfmt_ns(bm_mnt), &binfmt_ns(entry_count));
>  }
>  
>  /* /<entry> */
> @@ -716,7 +711,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  	if (!inode)
>  		goto out2;
>  
> -	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
> +	err = simple_pin_fs(&bm_fs_type, &binfmt_ns(bm_mnt),
> +			    &binfmt_ns(entry_count));
>  	if (err) {
>  		iput(inode);
>  		inode = NULL;
> @@ -730,7 +726,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  		if (IS_ERR(f)) {
>  			err = PTR_ERR(f);
>  			pr_notice("register: failed to install interpreter file %s\n", e->interpreter);
> -			simple_release_fs(&bm_mnt, &entry_count);
> +			simple_release_fs(&binfmt_ns(bm_mnt),
> +					  &binfmt_ns(entry_count));
>  			iput(inode);
>  			inode = NULL;
>  			goto out2;
> @@ -743,9 +740,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  	inode->i_fop = &bm_entry_operations;
>  
>  	d_instantiate(dentry, inode);
> -	write_lock(&entries_lock);
> -	list_add(&e->list, &entries);
> -	write_unlock(&entries_lock);
> +	write_lock(&binfmt_ns(entries_lock));
> +	list_add(&e->list, &binfmt_ns(entries));
> +	write_unlock(&binfmt_ns(entries_lock));
>  
>  	err = 0;
>  out2:
> @@ -770,7 +767,7 @@ static const struct file_operations bm_register_operations = {
>  static ssize_t
>  bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
>  {
> -	char *s = enabled ? "enabled\n" : "disabled\n";
> +	char *s = binfmt_ns(enabled) ? "enabled\n" : "disabled\n";
>  
>  	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>  }
> @@ -784,19 +781,20 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  	switch (res) {
>  	case 1:
>  		/* Disable all handlers. */
> -		enabled = 0;
> +		binfmt_ns(enabled) = 0;
>  		break;
>  	case 2:
>  		/* Enable all handlers. */
> -		enabled = 1;
> +		binfmt_ns(enabled) = 1;
>  		break;
>  	case 3:
>  		/* Delete all handlers. */
>  		root = file_inode(file)->i_sb->s_root;
>  		inode_lock(d_inode(root));
>  
> -		while (!list_empty(&entries))
> -			kill_node(list_first_entry(&entries, Node, list));
> +		while (!list_empty(&binfmt_ns(entries)))
> +			kill_node(list_first_entry(&binfmt_ns(entries),
> +						   Node, list));
>  
>  		inode_unlock(d_inode(root));
>  		break;
> @@ -838,7 +836,10 @@ static int bm_fill_super(struct super_block *sb, void *data, int silent)
>  static struct dentry *bm_mount(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data)
>  {
> -	return mount_single(fs_type, flags, data, bm_fill_super);
> +	struct mnt_namespace *mnt_ns = current->nsproxy->mnt_ns;
> +
> +	return mount_ns(fs_type, flags, data, mnt_ns, mnt_ns->user_ns,
> +			bm_fill_super);
>  }
>  
>  static struct linux_binfmt misc_format = {
> @@ -849,6 +850,7 @@ static struct linux_binfmt misc_format = {
>  static struct file_system_type bm_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "binfmt_misc",
> +	.fs_flags	= FS_USERNS_MOUNT,
>  	.mount		= bm_mount,
>  	.kill_sb	= kill_litter_super,
>  };
> diff --git a/fs/mount.h b/fs/mount.h
> index f39bc9da4d73..f03b35141440 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -17,6 +17,12 @@ struct mnt_namespace {
>  	u64 event;
>  	unsigned int		mounts; /* # of mounts in the namespace */
>  	unsigned int		pending_mounts;
> +	/* binfmt misc */
> +	struct list_head entries;
> +	rwlock_t entries_lock;
> +	int enabled;
> +	struct vfsmount *bm_mnt;
> +	int entry_count;
>  } __randomize_layout;
>  
>  struct mnt_pcp {
> @@ -72,6 +78,8 @@ struct mount {
>  	struct dentry *mnt_ex_mountpoint;
>  } __randomize_layout;
>  
> +#define binfmt_ns(a) (current->nsproxy->mnt_ns->a)
> +
>  #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
>  
>  static inline struct mount *real_mount(struct vfsmount *mnt)
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 99186556f8d3..f92b8371228d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2850,6 +2850,12 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns)
>  	new_ns->ucounts = ucounts;
>  	new_ns->mounts = 0;
>  	new_ns->pending_mounts = 0;
> +	/* binfmt_misc */
> +	INIT_LIST_HEAD(&new_ns->entries);
> +	new_ns->enabled = 1;
> +	rwlock_init(&new_ns->entries_lock);
> +	new_ns->bm_mnt = NULL;
> +	new_ns->entry_count = 0;
>  	return new_ns;
>  }
