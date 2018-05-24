Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030304AbeEXP7u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:59:50 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34124 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968272AbeEXP7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:59:48 -0400
Date: Thu, 24 May 2018 17:59:44 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 6/6] fs: Allow CAP_SYS_ADMIN in s_user_ns to
 freeze and thaw filesystems
Message-ID: <20180524155943.GC19932@mailbox.org>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523232538.4880-6-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 06:25:38PM -0500, Eric W. Biederman wrote:
> From: Seth Forshee <seth.forshee@canonical.com>
> 
> The user in control of a super block should be allowed to freeze
> and thaw it. Relax the restrictions on the FIFREEZE and FITHAW
> ioctls to require CAP_SYS_ADMIN in s_user_ns.

Acked-by: Christian Brauner <christian@brauner.io>

> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  fs/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 4823431d1c9d..b445b13fc59b 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -549,7 +549,7 @@ static int ioctl_fsfreeze(struct file *filp)
>  {
>  	struct super_block *sb = file_inode(filp)->i_sb;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	/* If filesystem doesn't support freeze feature, return. */
> @@ -566,7 +566,7 @@ static int ioctl_fsthaw(struct file *filp)
>  {
>  	struct super_block *sb = file_inode(filp)->i_sb;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	/* Thaw */
> -- 
> 2.14.1
> 
