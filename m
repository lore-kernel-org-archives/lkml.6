Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeENEcn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:32:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeENEcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:32:42 -0400
Date: Mon, 14 May 2018 05:32:39 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+481ad819c717f6b78df9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        gregkh@linuxfoundation.org, tj@kernel.org
Subject: Re: general protection fault in kernfs_kill_sb (2)
Message-ID: <20180514043239.GE30522@ZenIV.linux.org.uk>
References: <14892403-d680-dc5d-1927-bc4a279514fb@I-love.SAKURA.ne.jp>
 <20180514024726.GB30522@ZenIV.linux.org.uk>
 <201805140320.w4E3KG2o056158@www262.sakura.ne.jp>
 <20180514040415.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514040415.GD30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:04:15AM +0100, Al Viro wrote:
> diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
> index b428d317ae92..92682fcc41f6 100644
> --- a/fs/sysfs/mount.c
> +++ b/fs/sysfs/mount.c
> @@ -25,7 +25,7 @@ static struct dentry *sysfs_mount(struct file_system_type *fs_type,
>  {
>  	struct dentry *root;
>  	void *ns;
> -	bool new_sb;
> +	bool new_sb = false;
>  
>  	if (!(flags & SB_KERNMOUNT)) {
>  		if (!kobj_ns_current_may_mount(KOBJ_NS_TYPE_NET))
> @@ -35,9 +35,9 @@ static struct dentry *sysfs_mount(struct file_system_type *fs_type,
>  	ns = kobj_ns_grab_current(KOBJ_NS_TYPE_NET);
>  	root = kernfs_mount_ns(fs_type, flags, sysfs_root,
>  				SYSFS_MAGIC, &new_sb, ns);
> -	if (IS_ERR(root) || !new_sb)
> +	if (!new_sb)
>  		kobj_ns_drop(KOBJ_NS_TYPE_NET, ns);
> -	else if (new_sb)
> +	else if (!IS_ERR(root))
>  		root->d_sb->s_iflags |= SB_I_USERNS_VISIBLE;
>  
>  	return root;

What we want for that kobj_ns_drop() is "no fs instances created" (== no
->kill_sb(), be it now or later, to drop that kobj reference); for setting
->s_iflags - "new instance successfully set up".

That's it; all we need is new_sb that would be accurate on its own.
The problem is with kludging over the cases when it's left uninitialized
(early exits from kernfs_mount_ns()) with IS_ERR(root), which happens to
grab the cases when new_sb *was* set to true.  So the fix is to initialize
new_sb properly and get rid of that kludge.  Which turns the whole thing
into
	if (!new_sb)
		...
	if (!IS_ERR(root) && new_sb)
		...
i.e.
	if (!new_sb)
		...
	else if (!IS_ERR(root))
		...
