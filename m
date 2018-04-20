Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeDTDTI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753964AbeDTDTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:19:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF6F2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Thu, 19 Apr 2018 20:19:05 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH 5/5] f2fs: fix to avoid race during access gc_thread
 pointer
Message-ID: <20180420031905.GE39280@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180418094505.98888-1-yuchao0@huawei.com>
 <20180418094505.98888-5-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418094505.98888-5-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18, Chao Yu wrote:
> Thread A			Thread B		Thread C
> - f2fs_remount
>  - stop_gc_thread
> 				- f2fs_sbi_store
> 							- issue_discard_thread
>    sbi->gc_thread = NULL;
> 				  sbi->gc_thread->gc_wake = 1
> 							  access sbi->gc_thread->gc_urgent

Do we simply need a lock for this?

> 
> Previously, we allocate memory for sbi->gc_thread based on background
> gc thread mount option, the memory can be released if we turn off
> that mount option, but still there are several places access gc_thread
> pointer without considering race condition, result in NULL point
> dereference.
> 
> In order to fix this issue, keep gc_thread structure valid in sbi all
> the time instead of alloc/free it dynamically.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/debug.c   |  3 +--
>  fs/f2fs/f2fs.h    |  7 +++++++
>  fs/f2fs/gc.c      | 58 +++++++++++++++++++++++++++++++++----------------------
>  fs/f2fs/segment.c |  4 ++--
>  fs/f2fs/super.c   | 13 +++++++++++--
>  fs/f2fs/sysfs.c   |  8 ++++----
>  6 files changed, 60 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 715beb85e9db..7bb036a3bb81 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -223,8 +223,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>  	si->cache_mem = 0;
>  
>  	/* build gc */
> -	if (sbi->gc_thread)
> -		si->cache_mem += sizeof(struct f2fs_gc_kthread);
> +	si->cache_mem += sizeof(struct f2fs_gc_kthread);
>  
>  	/* build merge flush thread */
>  	if (SM_I(sbi)->fcc_info)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 567c6bb57ae3..c553f63199e8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1412,6 +1412,11 @@ static inline struct sit_info *SIT_I(struct f2fs_sb_info *sbi)
>  	return (struct sit_info *)(SM_I(sbi)->sit_info);
>  }
>  
> +static inline struct f2fs_gc_kthread *GC_I(struct f2fs_sb_info *sbi)
> +{
> +	return (struct f2fs_gc_kthread *)(sbi->gc_thread);
> +}
> +
>  static inline struct free_segmap_info *FREE_I(struct f2fs_sb_info *sbi)
>  {
>  	return (struct free_segmap_info *)(SM_I(sbi)->free_info);
> @@ -2954,6 +2959,8 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
>  /*
>   * gc.c
>   */
> +int init_gc_context(struct f2fs_sb_info *sbi);
> +void destroy_gc_context(struct f2fs_sb_info * sbi);
>  int start_gc_thread(struct f2fs_sb_info *sbi);
>  void stop_gc_thread(struct f2fs_sb_info *sbi);
>  block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index da89ca16a55d..7d310e454b77 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -26,8 +26,8 @@
>  static int gc_thread_func(void *data)
>  {
>  	struct f2fs_sb_info *sbi = data;
> -	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
> -	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
> +	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
> +	wait_queue_head_t *wq = &gc_th->gc_wait_queue_head;
>  	unsigned int wait_ms;
>  
>  	wait_ms = gc_th->min_sleep_time;
> @@ -114,17 +114,15 @@ static int gc_thread_func(void *data)
>  	return 0;
>  }
>  
> -int start_gc_thread(struct f2fs_sb_info *sbi)
> +int init_gc_context(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_gc_kthread *gc_th;
> -	dev_t dev = sbi->sb->s_bdev->bd_dev;
> -	int err = 0;
>  
>  	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
> -	if (!gc_th) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!gc_th)
> +		return -ENOMEM;
> +
> +	gc_th->f2fs_gc_task = NULL;
>  
>  	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
>  	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
> @@ -139,26 +137,41 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>  	gc_th->atomic_file[FG_GC] = 0;
>  
>  	sbi->gc_thread = gc_th;
> -	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
> -	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
> +
> +	return 0;
> +}
> +
> +void destroy_gc_context(struct f2fs_sb_info *sbi)
> +{
> +	kfree(GC_I(sbi));
> +	sbi->gc_thread = NULL;
> +}
> +
> +int start_gc_thread(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
> +	dev_t dev = sbi->sb->s_bdev->bd_dev;
> +	int err = 0;
> +
> +	init_waitqueue_head(&gc_th->gc_wait_queue_head);
> +	gc_th->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
>  			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
>  	if (IS_ERR(gc_th->f2fs_gc_task)) {
>  		err = PTR_ERR(gc_th->f2fs_gc_task);
> -		kfree(gc_th);
> -		sbi->gc_thread = NULL;
> +		gc_th->f2fs_gc_task = NULL;
>  	}
> -out:
> +
>  	return err;
>  }
>  
>  void stop_gc_thread(struct f2fs_sb_info *sbi)
>  {
> -	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
> -	if (!gc_th)
> -		return;
> -	kthread_stop(gc_th->f2fs_gc_task);
> -	kfree(gc_th);
> -	sbi->gc_thread = NULL;
> +	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
> +
> +	if (gc_th->f2fs_gc_task) {
> +		kthread_stop(gc_th->f2fs_gc_task);
> +		gc_th->f2fs_gc_task = NULL;
> +	}
>  }
>  
>  static int select_gc_type(struct f2fs_gc_kthread *gc_th, int gc_type)
> @@ -190,15 +203,14 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>  		p->max_search = dirty_i->nr_dirty[type];
>  		p->ofs_unit = 1;
>  	} else {
> -		p->gc_mode = select_gc_type(sbi->gc_thread, gc_type);
> +		p->gc_mode = select_gc_type(GC_I(sbi), gc_type);
>  		p->dirty_segmap = dirty_i->dirty_segmap[DIRTY];
>  		p->max_search = dirty_i->nr_dirty[DIRTY];
>  		p->ofs_unit = sbi->segs_per_sec;
>  	}
>  
>  	/* we need to check every dirty segments in the FG_GC case */
> -	if (gc_type != FG_GC &&
> -			(sbi->gc_thread && !sbi->gc_thread->gc_urgent) &&
> +	if (gc_type != FG_GC && !GC_I(sbi)->gc_urgent &&
>  			p->max_search > sbi->max_victim_search)
>  		p->max_search = sbi->max_victim_search;
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 831cefa088bc..c869ce54be4d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -177,7 +177,7 @@ bool need_SSR(struct f2fs_sb_info *sbi)
>  
>  	if (test_opt(sbi, LFS))
>  		return false;
> -	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
> +	if (GC_I(sbi)->gc_urgent)
>  		return true;
>  
>  	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
> @@ -1422,7 +1422,7 @@ static int issue_discard_thread(void *data)
>  		if (dcc->discard_wake)
>  			dcc->discard_wake = 0;
>  
> -		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
> +		if (GC_I(sbi)->gc_urgent)
>  			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
>  
>  		sb_start_intwrite(sbi->sb);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d01c11f5e9c1..f3a5f463496f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1012,6 +1012,8 @@ static void f2fs_put_super(struct super_block *sb)
>  		write_checkpoint(sbi, &cpc);
>  	}
>  
> +	destroy_gc_context(sbi);
> +
>  	/* write_checkpoint can update stat informaion */
>  	f2fs_destroy_stats(sbi);
>  
> @@ -1044,6 +1046,7 @@ static void f2fs_put_super(struct super_block *sb)
>  	kfree(sbi->raw_super);
>  
>  	destroy_device_list(sbi);
> +	destroy_gc_context(sbi);
>  	mempool_destroy(sbi->write_io_dummy);
>  #ifdef CONFIG_QUOTA
>  	for (i = 0; i < MAXQUOTAS; i++)
> @@ -1476,11 +1479,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  	 * option. Also sync the filesystem.
>  	 */
>  	if ((*flags & SB_RDONLY) || !test_opt(sbi, BG_GC)) {
> -		if (sbi->gc_thread) {
> +		if (GC_I(sbi)->f2fs_gc_task) {
>  			stop_gc_thread(sbi);
>  			need_restart_gc = true;
>  		}
> -	} else if (!sbi->gc_thread) {
> +	} else if (!GC_I(sbi)->f2fs_gc_task) {
>  		err = start_gc_thread(sbi);
>  		if (err)
>  			goto restore_opts;
> @@ -2771,6 +2774,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_meta_inode;
>  	}
>  
> +	err = init_gc_context(sbi);
> +	if (err)
> +		goto free_checkpoint;
> +
>  	/* Initialize device list */
>  	err = f2fs_scan_devices(sbi);
>  	if (err) {
> @@ -2981,6 +2988,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	destroy_segment_manager(sbi);
>  free_devices:
>  	destroy_device_list(sbi);
> +	destroy_gc_context(sbi);
> +free_checkpoint:
>  	kfree(sbi->ckpt);
>  free_meta_inode:
>  	make_bad_inode(sbi->meta_inode);
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 2c53de9251be..fb3cd477d985 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -46,7 +46,7 @@ struct f2fs_attr {
>  static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
>  {
>  	if (struct_type == GC_THREAD)
> -		return (unsigned char *)sbi->gc_thread;
> +		return (unsigned char *)GC_I(sbi);
>  	else if (struct_type == SM_INFO)
>  		return (unsigned char *)SM_I(sbi);
>  	else if (struct_type == DCC_INFO)
> @@ -252,9 +252,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  
>  	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>  		f2fs_reset_iostat(sbi);
> -	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
> -		sbi->gc_thread->gc_wake = 1;
> -		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
> +	if (!strcmp(a->attr.name, "gc_urgent") && t == 1) {
> +		GC_I(sbi)->gc_wake = 1;
> +		wake_up_interruptible_all(&GC_I(sbi)->gc_wait_queue_head);
>  		wake_up_discard_thread(sbi, true);
>  	}
>  
> -- 
> 2.15.0.55.gc2ece9dc4de6
