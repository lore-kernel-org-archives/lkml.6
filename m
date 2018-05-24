Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970905AbeEXPWx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:22:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34586 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966339AbeEXPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:22:50 -0400
X-Google-Smtp-Source: AB8JxZrVmxQug4l11p9AHveDcyMqxi6cMTDcwsGIPW9otys/4l5A4rC3VG9rGQ6rrO8yNahFGMjhIQ==
Date: Thu, 24 May 2018 17:22:46 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: remove iterate_supers_type
Message-ID: <20180524152246.5qb7az2paicc4mfm@odin.usersys.redhat.com>
Mail-Followup-To: Carlos Maiolino <cmaiolino@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20180517154737.18877-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517154737.18877-1-jlayton@kernel.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 11:47:37AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> Nothing calls this.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

looks like there are no reviews here yet, and it looks good to me, so, feel free
to add.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> ---
>  fs/super.c         | 36 ------------------------------------
>  include/linux/fs.h |  2 --
>  2 files changed, 38 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 30b7490bd049..456276033e59 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -631,42 +631,6 @@ void iterate_supers(void (*f)(struct super_block *, int), int arg)
>  	spin_unlock(&sb_lock);
>  }
>  
> -/**
> - *	iterate_supers_type - call function for superblocks of given type
> - *	@type: fs type
> - *	@f: function to call
> - *	@arg: argument to pass to it
> - *
> - *	Scans the superblock list and calls given function, passing it
> - *	locked superblock and given argument.
> - */
> -void iterate_supers_type(struct file_system_type *type,
> -	void (*f)(struct super_block *, void *), void *arg)
> -{
> -	struct super_block *sb, *p = NULL;
> -
> -	spin_lock(&sb_lock);
> -	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
> -		sb->s_count++;
> -		spin_unlock(&sb_lock);
> -
> -		down_read(&sb->s_umount);
> -		if (sb->s_root && (sb->s_flags & SB_BORN))
> -			f(sb, arg);
> -		up_read(&sb->s_umount);
> -
> -		spin_lock(&sb_lock);
> -		if (p)
> -			__put_super(p);
> -		p = sb;
> -	}
> -	if (p)
> -		__put_super(p);
> -	spin_unlock(&sb_lock);
> -}
> -
> -EXPORT_SYMBOL(iterate_supers_type);
> -
>  static struct super_block *__get_super(struct block_device *bdev, bool excl)
>  {
>  	struct super_block *sb;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7107d291d853..c4761eba3b44 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3116,8 +3116,6 @@ extern struct super_block *get_active_super(struct block_device *bdev);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
>  extern void iterate_supers(void (*)(struct super_block *, int), int);
> -extern void iterate_supers_type(struct file_system_type *,
> -			        void (*)(struct super_block *, void *), void *);
>  
>  extern int dcache_dir_open(struct inode *, struct file *);
>  extern int dcache_dir_close(struct inode *, struct file *);
> -- 
> 2.17.0
> 

-- 
Carlos
