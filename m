Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeEQQjx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:39:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54611 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeEQQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:39:52 -0400
Date: Thu, 17 May 2018 18:39:50 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lurodriguez@suse.de
Subject: Re: [PATCH] vfs: change iterate_supers callback to take an int arg
 instead of a void *
Message-ID: <20180517163950.yympqumpiu4m7yy5@quack2.suse.cz>
References: <20180517154646.18751-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517154646.18751-1-jlayton@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-05-18 11:46:46, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> All of the callback functions for iterate_supers either ignore the
> opaque argument, or dereference the pointer only to fetch the int
> to which it points.
> 
> Change iterate_supers to pass an opaque int arg to the callback
> instead of a void pointer.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Hum, I'm not sure if Luis didn't have any plan with the argument in his
fs-freeze-during-hibernate series. Luis?

								Honza

> ---
>  fs/drop_caches.c         |  4 ++--
>  fs/quota/quota.c         |  6 ++----
>  fs/super.c               |  3 ++-
>  fs/sync.c                | 32 ++++++++++++++------------------
>  include/linux/fs.h       |  2 +-
>  mm/cleancache.c          |  4 ++--
>  security/selinux/hooks.c |  4 ++--
>  7 files changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index 82377017130f..1850e7276fdf 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -14,7 +14,7 @@
>  /* A global variable is a bit ugly, but it keeps the code simple */
>  int sysctl_drop_caches;
>  
> -static void drop_pagecache_sb(struct super_block *sb, void *unused)
> +static void drop_pagecache_sb(struct super_block *sb, int unused)
>  {
>  	struct inode *inode, *toput_inode = NULL;
>  
> @@ -52,7 +52,7 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
>  		static int stfu;
>  
>  		if (sysctl_drop_caches & 1) {
> -			iterate_supers(drop_pagecache_sb, NULL);
> +			iterate_supers(drop_pagecache_sb, 0);
>  			count_vm_event(DROP_PAGECACHE);
>  		}
>  		if (sysctl_drop_caches & 2) {
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 860bfbe7a07a..5f1e1c494c07 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -46,10 +46,8 @@ static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
>  	return security_quotactl(cmd, type, id, sb);
>  }
>  
> -static void quota_sync_one(struct super_block *sb, void *arg)
> +static void quota_sync_one(struct super_block *sb, int type)
>  {
> -	int type = *(int *)arg;
> -
>  	if (sb->s_qcop && sb->s_qcop->quota_sync &&
>  	    (sb->s_quota_types & (1 << type)))
>  		sb->s_qcop->quota_sync(sb, type);
> @@ -63,7 +61,7 @@ static int quota_sync_all(int type)
>  		return -EINVAL;
>  	ret = security_quotactl(Q_SYNC, type, 0, NULL);
>  	if (!ret)
> -		iterate_supers(quota_sync_one, &type);
> +		iterate_supers(quota_sync_one, type);
>  	return ret;
>  }
>  
> diff --git a/fs/super.c b/fs/super.c
> index 122c402049a2..30b7490bd049 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -596,6 +596,7 @@ static void __iterate_supers(void (*f)(struct super_block *))
>  		__put_super(p);
>  	spin_unlock(&sb_lock);
>  }
> +
>  /**
>   *	iterate_supers - call function for all active superblocks
>   *	@f: function to call
> @@ -604,7 +605,7 @@ static void __iterate_supers(void (*f)(struct super_block *))
>   *	Scans the superblock list and calls given function, passing it
>   *	locked superblock and given argument.
>   */
> -void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
> +void iterate_supers(void (*f)(struct super_block *, int), int arg)
>  {
>  	struct super_block *sb, *p = NULL;
>  
> diff --git a/fs/sync.c b/fs/sync.c
> index b54e0541ad89..8c418da67e41 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -68,16 +68,16 @@ int sync_filesystem(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(sync_filesystem);
>  
> -static void sync_inodes_one_sb(struct super_block *sb, void *arg)
> +static void sync_inodes_one_sb(struct super_block *sb, int unused)
>  {
>  	if (!sb_rdonly(sb))
>  		sync_inodes_sb(sb);
>  }
>  
> -static void sync_fs_one_sb(struct super_block *sb, void *arg)
> +static void sync_fs_one_sb(struct super_block *sb, int arg)
>  {
>  	if (!sb_rdonly(sb) && sb->s_op->sync_fs)
> -		sb->s_op->sync_fs(sb, *(int *)arg);
> +		sb->s_op->sync_fs(sb, arg);
>  }
>  
>  static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
> @@ -107,14 +107,12 @@ static void fdatawait_one_bdev(struct block_device *bdev, void *arg)
>   */
>  void ksys_sync(void)
>  {
> -	int nowait = 0, wait = 1;
> -
>  	wakeup_flusher_threads(WB_REASON_SYNC);
> -	iterate_supers(sync_inodes_one_sb, NULL);
> -	iterate_supers(sync_fs_one_sb, &nowait);
> -	iterate_supers(sync_fs_one_sb, &wait);
> -	iterate_bdevs(fdatawrite_one_bdev, NULL);
> -	iterate_bdevs(fdatawait_one_bdev, NULL);
> +	iterate_supers(sync_inodes_one_sb, 0);
> +	iterate_supers(sync_fs_one_sb, 0);
> +	iterate_supers(sync_fs_one_sb, 1);
> +	iterate_bdevs(fdatawrite_one_bdev, 0);
> +	iterate_bdevs(fdatawait_one_bdev, 0);
>  	if (unlikely(laptop_mode))
>  		laptop_sync_completion();
>  }
> @@ -127,18 +125,16 @@ SYSCALL_DEFINE0(sync)
>  
>  static void do_sync_work(struct work_struct *work)
>  {
> -	int nowait = 0;
> -
>  	/*
>  	 * Sync twice to reduce the possibility we skipped some inodes / pages
>  	 * because they were temporarily locked
>  	 */
> -	iterate_supers(sync_inodes_one_sb, &nowait);
> -	iterate_supers(sync_fs_one_sb, &nowait);
> -	iterate_bdevs(fdatawrite_one_bdev, NULL);
> -	iterate_supers(sync_inodes_one_sb, &nowait);
> -	iterate_supers(sync_fs_one_sb, &nowait);
> -	iterate_bdevs(fdatawrite_one_bdev, NULL);
> +	iterate_supers(sync_inodes_one_sb, 0);
> +	iterate_supers(sync_fs_one_sb, 0);
> +	iterate_bdevs(fdatawrite_one_bdev, 0);
> +	iterate_supers(sync_inodes_one_sb, 0);
> +	iterate_supers(sync_fs_one_sb, 0);
> +	iterate_bdevs(fdatawrite_one_bdev, 0);
>  	printk("Emergency Sync complete\n");
>  	kfree(work);
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 760d8da1b6c7..7107d291d853 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3115,7 +3115,7 @@ extern struct super_block *get_super_exclusive_thawed(struct block_device *bdev)
>  extern struct super_block *get_active_super(struct block_device *bdev);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
> -extern void iterate_supers(void (*)(struct super_block *, void *), void *);
> +extern void iterate_supers(void (*)(struct super_block *, int), int);
>  extern void iterate_supers_type(struct file_system_type *,
>  			        void (*)(struct super_block *, void *), void *);
>  
> diff --git a/mm/cleancache.c b/mm/cleancache.c
> index f7b9fdc79d97..92d27cc10274 100644
> --- a/mm/cleancache.c
> +++ b/mm/cleancache.c
> @@ -34,7 +34,7 @@ static u64 cleancache_failed_gets;
>  static u64 cleancache_puts;
>  static u64 cleancache_invalidates;
>  
> -static void cleancache_register_ops_sb(struct super_block *sb, void *unused)
> +static void cleancache_register_ops_sb(struct super_block *sb, int unused)
>  {
>  	switch (sb->cleancache_poolid) {
>  	case CLEANCACHE_NO_BACKEND:
> @@ -105,7 +105,7 @@ int cleancache_register_ops(const struct cleancache_ops *ops)
>  	 * until the corresponding ->init_fs has been actually called and
>  	 * cleancache_ops has been set.
>  	 */
> -	iterate_supers(cleancache_register_ops_sb, NULL);
> +	iterate_supers(cleancache_register_ops_sb, 0);
>  	return 0;
>  }
>  EXPORT_SYMBOL(cleancache_register_ops);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a19167..91c13b72b427 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7138,7 +7138,7 @@ static __init int selinux_init(void)
>  	return 0;
>  }
>  
> -static void delayed_superblock_init(struct super_block *sb, void *unused)
> +static void delayed_superblock_init(struct super_block *sb, int unused)
>  {
>  	superblock_doinit(sb, NULL);
>  }
> @@ -7149,7 +7149,7 @@ void selinux_complete_init(void)
>  
>  	/* Set up any superblocks initialized prior to the policy load. */
>  	printk(KERN_DEBUG "SELinux:  Setting up existing superblocks.\n");
> -	iterate_supers(delayed_superblock_init, NULL);
> +	iterate_supers(delayed_superblock_init, 0);
>  }
>  
>  /* SELinux requires early initialization in order to label
> -- 
> 2.17.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
