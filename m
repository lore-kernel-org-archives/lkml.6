Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034500AbeEXTMj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:12:39 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:39160 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034448AbeEXTMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:12:37 -0400
Date: Thu, 24 May 2018 21:12:32 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 2/6] vfs: Allow userns root to call mknod on
 owned filesystems.
Message-ID: <20180524191232.GA7573@mailbox.org>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523232538.4880-2-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 06:25:34PM -0500, Eric W. Biederman wrote:
> These filesystems already always set SB_I_NODEV so mknod will not be
> useful for gaining control of any devices no matter their permissions.
> This will allow overlayfs and applications to fakeroot to use device
> nodes to represent things on disk.

Excellent.

Acked-by: Christian Brauner <christian@brauner.io>

> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 942c1f096f6b..20335896dcce 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3679,7 +3679,8 @@ int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
>  	if (error)
>  		return error;
>  
> -	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> +	if ((S_ISCHR(mode) || S_ISBLK(mode)) &&
> +	    !ns_capable(dentry->d_sb->s_user_ns, CAP_MKNOD))
>  		return -EPERM;
>  
>  	if (!dir->i_op->mknod)
> -- 
> 2.14.1
> 
