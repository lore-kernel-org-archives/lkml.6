Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971036AbeEXP6O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:58:14 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:29084 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971002AbeEXP6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:58:10 -0400
Date: Thu, 24 May 2018 17:58:03 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 4/6] fs: Allow superblock owner to access
 do_remount_sb()
Message-ID: <20180524155803.GB19932@mailbox.org>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523232538.4880-4-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 06:25:36PM -0500, Eric W. Biederman wrote:
> Superblock level remounts are currently restricted to global
> CAP_SYS_ADMIN, as is the path for changing the root mount to
> read only on umount. Loosen both of these permission checks to
> also allow CAP_SYS_ADMIN in any namespace which is privileged
> towards the userns which originally mounted the filesystem.

Acked-by: Christian Brauner <christian@brauner.io>

> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Acked-by: Serge Hallyn <serge.hallyn@canonical.com>

Note, I just talked to Serge. This should be Acked-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  fs/namespace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5f75969adff1..8ddd14806799 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1590,7 +1590,7 @@ static int do_umount(struct mount *mnt, int flags)
>  		 * Special case for "unmounting" root ...
>  		 * we just try to remount it readonly.
>  		 */
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
>  			return -EPERM;
>  		down_write(&sb->s_umount);
>  		if (!sb_rdonly(sb))
> @@ -2333,7 +2333,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
>  	down_write(&sb->s_umount);
>  	if (ms_flags & MS_BIND)
>  		err = change_mount_flags(path->mnt, ms_flags);
> -	else if (!capable(CAP_SYS_ADMIN))
> +	else if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
>  		err = -EPERM;
>  	else
>  		err = do_remount_sb(sb, sb_flags, data, 0);
> -- 
> 2.14.1
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
