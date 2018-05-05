Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeEECV3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:21:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44250 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751572AbeEECV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:21:27 -0400
Subject: Re: [PATCH v2] f2fs: fix to avoid race during access gc_thread
 pointer
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180424024214.83177-1-yuchao0@huawei.com>
 <20180426160359.GH68594@jaegeuk-macbookpro.roam.corp.google.com>
 <96ccc4d2-8360-14c2-6d98-6fdf35255b65@huawei.com>
 <20180428023621.GC10595@jaegeuk-macbookpro.roam.corp.google.com>
 <e52ecabe-7d30-b729-b78c-17984a54d1b4@huawei.com>
 <20180504185946.GD27993@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <1667b2c3-add4-ac46-47de-45260e1a579e@huawei.com>
Date: Sat, 5 May 2018 10:21:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180504185946.GD27993@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/5 2:59, Jaegeuk Kim wrote:
> On 05/02, Chao Yu wrote:
>> On 2018/4/28 10:36, Jaegeuk Kim wrote:
>>> On 04/27, Chao Yu wrote:
>>>> On 2018/4/27 0:03, Jaegeuk Kim wrote:
>>>>> On 04/24, Chao Yu wrote:
>>>>>> Thread A			Thread B		Thread C
>>>>>> - f2fs_remount
>>>>>>  - stop_gc_thread
>>>>>> 				- f2fs_sbi_store
>>>>>> 							- issue_discard_thread
>>>>>>    sbi->gc_thread = NULL;
>>>>>> 				  sbi->gc_thread->gc_wake = 1
>>>>>> 							  access sbi->gc_thread->gc_urgent
>>>>>>
>>>>>> Previously, we allocate memory for sbi->gc_thread based on background
>>>>>> gc thread mount option, the memory can be released if we turn off
>>>>>> that mount option, but still there are several places access gc_thread
>>>>>> pointer without considering race condition, result in NULL point
>>>>>> dereference.
>>>>>
>>>>> Do we just need to check &sb->s_umount in f2fs_sbi_store() and
>>>>
>>>> Better,
>>>>
>>>>> issue_discard_thread?
>>>>
>>>> There is more cases can be called from different scenarios:
>>>> - select_policy()
>>>> - need_SSR()
>>>
>>> No? They should be blocked by remount(2).
>>
>> How about below cases?
>>
>> - do_remount
> 
> Was there no guard to block any filesystem operations?

The only block point is f2fs_readonly in f2fs_sync_file, without holding
s_umount during ->fsync, so IMO, we need to cover need_SSR & select_gc_type, let
me update the patch later.

Thanks,

> If it's true, yeah, we need to cover them.
> 
>>  - do_remount_sb
>>   - remount_fs
>>    - f2fs_remount
>>     - stop_gc_thread
>> 					- fsync
>> 					 - f2fs_sync_file
>> 					  - file_write_and_wait_range
>> 					   - f2fs_write_data_pages
>> 					    - __write_data_page
>> 					     - should_update_inplace
>> 					      - check_inplace_update_policy
>> 					       - need_SSR
>>      : sbi->gc_thread = NULL;
>>
>> or
>>
>> 					     - write_data_page
>> 					      - allocate_data_block
>> 					       - allocate_segment
>> 					        - get_ssr_segment
>> 					         - select_gc_type
>>      : sbi->gc_thread = NULL;
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> In order to fix this issue, keep gc_thread structure valid in sbi all
>>>>>> the time instead of alloc/free it dynamically.
>>>>>>
>>>>>> In addition, add a rw semaphore to exclude rw operation in fields of
>>>>>> gc_thread.
>>>>>>
>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>> ---
>>>>>> v2:
>>>>>> - add a rw semaphore to exclude rw operation suggested by Jaegeuk.
>>>>>>  fs/f2fs/debug.c   |  3 +--
>>>>>>  fs/f2fs/f2fs.h    |  9 ++++++-
>>>>>>  fs/f2fs/gc.c      | 78 ++++++++++++++++++++++++++++++++++++-------------------
>>>>>>  fs/f2fs/gc.h      |  1 +
>>>>>>  fs/f2fs/segment.c | 10 +++++--
>>>>>>  fs/f2fs/super.c   | 26 +++++++++++++------
>>>>>>  fs/f2fs/sysfs.c   | 26 ++++++++++++++-----
>>>>>>  7 files changed, 107 insertions(+), 46 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
>>>>>> index a66107b5cfff..0fbd674c66fb 100644
>>>>>> --- a/fs/f2fs/debug.c
>>>>>> +++ b/fs/f2fs/debug.c
>>>>>> @@ -221,8 +221,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>>>>>>  	si->cache_mem = 0;
>>>>>>  
>>>>>>  	/* build gc */
>>>>>> -	if (sbi->gc_thread)
>>>>>> -		si->cache_mem += sizeof(struct f2fs_gc_kthread);
>>>>>> +	si->cache_mem += sizeof(struct f2fs_gc_kthread);
>>>>>>  
>>>>>>  	/* build merge flush thread */
>>>>>>  	if (SM_I(sbi)->fcc_info)
>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>> index 8f3ad9662d13..75d3b4875429 100644
>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>> @@ -1412,6 +1412,11 @@ static inline struct sit_info *SIT_I(struct f2fs_sb_info *sbi)
>>>>>>  	return (struct sit_info *)(SM_I(sbi)->sit_info);
>>>>>>  }
>>>>>>  
>>>>>> +static inline struct f2fs_gc_kthread *GC_I(struct f2fs_sb_info *sbi)
>>>>>> +{
>>>>>> +	return (struct f2fs_gc_kthread *)(sbi->gc_thread);
>>>>>> +}
>>>>>> +
>>>>>>  static inline struct free_segmap_info *FREE_I(struct f2fs_sb_info *sbi)
>>>>>>  {
>>>>>>  	return (struct free_segmap_info *)(SM_I(sbi)->free_info);
>>>>>> @@ -2954,8 +2959,10 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
>>>>>>  /*
>>>>>>   * gc.c
>>>>>>   */
>>>>>> +int init_gc_context(struct f2fs_sb_info *sbi);
>>>>>> +void destroy_gc_context(struct f2fs_sb_info * sbi);
>>>>>>  int start_gc_thread(struct f2fs_sb_info *sbi);
>>>>>> -void stop_gc_thread(struct f2fs_sb_info *sbi);
>>>>>> +bool stop_gc_thread(struct f2fs_sb_info *sbi);
>>>>>>  block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
>>>>>>  int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
>>>>>>  			unsigned int segno);
>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>> index 70418b34c5f6..2febb84b2fd6 100644
>>>>>> --- a/fs/f2fs/gc.c
>>>>>> +++ b/fs/f2fs/gc.c
>>>>>> @@ -26,8 +26,8 @@
>>>>>>  static int gc_thread_func(void *data)
>>>>>>  {
>>>>>>  	struct f2fs_sb_info *sbi = data;
>>>>>> -	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
>>>>>> -	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
>>>>>> +	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
>>>>>> +	wait_queue_head_t *wq = &gc_th->gc_wait_queue_head;
>>>>>>  	unsigned int wait_ms;
>>>>>>  
>>>>>>  	wait_ms = gc_th->min_sleep_time;
>>>>>> @@ -114,17 +114,15 @@ static int gc_thread_func(void *data)
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> -int start_gc_thread(struct f2fs_sb_info *sbi)
>>>>>> +int init_gc_context(struct f2fs_sb_info *sbi)
>>>>>>  {
>>>>>>  	struct f2fs_gc_kthread *gc_th;
>>>>>> -	dev_t dev = sbi->sb->s_bdev->bd_dev;
>>>>>> -	int err = 0;
>>>>>>  
>>>>>>  	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
>>>>>> -	if (!gc_th) {
>>>>>> -		err = -ENOMEM;
>>>>>> -		goto out;
>>>>>> -	}
>>>>>> +	if (!gc_th)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	gc_th->f2fs_gc_task = NULL;
>>>>>>  
>>>>>>  	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
>>>>>>  	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
>>>>>> @@ -135,35 +133,59 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>>>>>>  	gc_th->gc_urgent = 0;
>>>>>>  	gc_th->gc_wake= 0;
>>>>>>  
>>>>>> +	init_rwsem(&gc_th->gc_rwsem);
>>>>>> +
>>>>>>  	sbi->gc_thread = gc_th;
>>>>>> -	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
>>>>>> -	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +void destroy_gc_context(struct f2fs_sb_info *sbi)
>>>>>> +{
>>>>>> +	kfree(GC_I(sbi));
>>>>>> +	sbi->gc_thread = NULL;
>>>>>> +}
>>>>>> +
>>>>>> +int start_gc_thread(struct f2fs_sb_info *sbi)
>>>>>> +{
>>>>>> +	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
>>>>>> +	dev_t dev = sbi->sb->s_bdev->bd_dev;
>>>>>> +	int err = 0;
>>>>>> +
>>>>>> +	init_waitqueue_head(&gc_th->gc_wait_queue_head);
>>>>>> +	gc_th->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
>>>>>>  			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
>>>>>>  	if (IS_ERR(gc_th->f2fs_gc_task)) {
>>>>>>  		err = PTR_ERR(gc_th->f2fs_gc_task);
>>>>>> -		kfree(gc_th);
>>>>>> -		sbi->gc_thread = NULL;
>>>>>> +		gc_th->f2fs_gc_task = NULL;
>>>>>>  	}
>>>>>> -out:
>>>>>> +
>>>>>>  	return err;
>>>>>>  }
>>>>>>  
>>>>>> -void stop_gc_thread(struct f2fs_sb_info *sbi)
>>>>>> +bool stop_gc_thread(struct f2fs_sb_info *sbi)
>>>>>>  {
>>>>>> -	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
>>>>>> -	if (!gc_th)
>>>>>> -		return;
>>>>>> -	kthread_stop(gc_th->f2fs_gc_task);
>>>>>> -	kfree(gc_th);
>>>>>> -	sbi->gc_thread = NULL;
>>>>>> +	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
>>>>>> +	bool stopped = false;
>>>>>> +
>>>>>> +	down_write(&gc_th->gc_rwsem);
>>>>>> +	if (gc_th->f2fs_gc_task) {
>>>>>> +		kthread_stop(gc_th->f2fs_gc_task);
>>>>>> +		gc_th->f2fs_gc_task = NULL;
>>>>>> +		stopped = true;
>>>>>> +	}
>>>>>> +	up_write(&gc_th->gc_rwsem);
>>>>>> +
>>>>>> +	return stopped;
>>>>>>  }
>>>>>>  
>>>>>>  static int select_gc_type(struct f2fs_gc_kthread *gc_th, int gc_type)
>>>>>>  {
>>>>>>  	int gc_mode = (gc_type == BG_GC) ? GC_CB : GC_GREEDY;
>>>>>>  
>>>>>> -	if (!gc_th)
>>>>>> -		return gc_mode;
>>>>>> +	down_read(&gc_th->gc_rwsem);
>>>>>> +	if (!gc_th->f2fs_gc_task)
>>>>>> +		goto out;
>>>>>>  
>>>>>>  	if (gc_th->gc_idle) {
>>>>>>  		if (gc_th->gc_idle == 1)
>>>>>> @@ -173,6 +195,8 @@ static int select_gc_type(struct f2fs_gc_kthread *gc_th, int gc_type)
>>>>>>  	}
>>>>>>  	if (gc_th->gc_urgent)
>>>>>>  		gc_mode = GC_GREEDY;
>>>>>> +out:
>>>>>> +	up_read(&gc_th->gc_rwsem);
>>>>>>  	return gc_mode;
>>>>>>  }
>>>>>>  
>>>>>> @@ -187,17 +211,19 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>>>>>>  		p->max_search = dirty_i->nr_dirty[type];
>>>>>>  		p->ofs_unit = 1;
>>>>>>  	} else {
>>>>>> -		p->gc_mode = select_gc_type(sbi->gc_thread, gc_type);
>>>>>> +		p->gc_mode = select_gc_type(GC_I(sbi), gc_type);
>>>>>>  		p->dirty_segmap = dirty_i->dirty_segmap[DIRTY];
>>>>>>  		p->max_search = dirty_i->nr_dirty[DIRTY];
>>>>>>  		p->ofs_unit = sbi->segs_per_sec;
>>>>>>  	}
>>>>>>  
>>>>>>  	/* we need to check every dirty segments in the FG_GC case */
>>>>>> -	if (gc_type != FG_GC &&
>>>>>> -			(sbi->gc_thread && !sbi->gc_thread->gc_urgent) &&
>>>>>> +	down_read(&GC_I(sbi)->gc_rwsem);
>>>>>> +	if (gc_type != FG_GC && GC_I(sbi)->f2fs_gc_task &&
>>>>>> +			!GC_I(sbi)->gc_urgent &&
>>>>>>  			p->max_search > sbi->max_victim_search)
>>>>>>  		p->max_search = sbi->max_victim_search;
>>>>>> +	up_read(&GC_I(sbi)->gc_rwsem);
>>>>>>  
>>>>>>  	/* let's select beginning hot/small space first in no_heap mode*/
>>>>>>  	if (test_opt(sbi, NOHEAP) &&
>>>>>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
>>>>>> index b0045d4c8d1e..9a5b273328c2 100644
>>>>>> --- a/fs/f2fs/gc.h
>>>>>> +++ b/fs/f2fs/gc.h
>>>>>> @@ -26,6 +26,7 @@
>>>>>>  #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
>>>>>>  
>>>>>>  struct f2fs_gc_kthread {
>>>>>> +	struct rw_semaphore gc_rwsem;		/* semaphore for f2fs_gc_task */
>>>>>>  	struct task_struct *f2fs_gc_task;
>>>>>>  	wait_queue_head_t gc_wait_queue_head;
>>>>>>  
>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>> index 5960768d26df..f787eea1b2f6 100644
>>>>>> --- a/fs/f2fs/segment.c
>>>>>> +++ b/fs/f2fs/segment.c
>>>>>> @@ -177,8 +177,12 @@ bool need_SSR(struct f2fs_sb_info *sbi)
>>>>>>  
>>>>>>  	if (test_opt(sbi, LFS))
>>>>>>  		return false;
>>>>>> -	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
>>>>>> +	down_read(&GC_I(sbi)->gc_rwsem);
>>>>>> +	if (GC_I(sbi)->f2fs_gc_task && GC_I(sbi)->gc_urgent) {
>>>>>> +		down_read(&GC_I(sbi)->gc_rwsem);
>>>>>>  		return true;
>>>>>> +	}
>>>>>> +	up_read(&GC_I(sbi)->gc_rwsem);
>>>>>>  
>>>>>>  	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
>>>>>>  			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
>>>>>> @@ -1425,8 +1429,10 @@ static int issue_discard_thread(void *data)
>>>>>>  		if (dcc->discard_wake)
>>>>>>  			dcc->discard_wake = 0;
>>>>>>  
>>>>>> -		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
>>>>>> +		down_read(&GC_I(sbi)->gc_rwsem);
>>>>>> +		if (GC_I(sbi)->f2fs_gc_task && GC_I(sbi)->gc_urgent)
>>>>>>  			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
>>>>>> +		up_read(&GC_I(sbi)->gc_rwsem);
>>>>>>  
>>>>>>  		sb_start_intwrite(sbi->sb);
>>>>>>  
>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>>> index dedb8e50b440..199f29dce86d 100644
>>>>>> --- a/fs/f2fs/super.c
>>>>>> +++ b/fs/f2fs/super.c
>>>>>> @@ -1044,6 +1044,7 @@ static void f2fs_put_super(struct super_block *sb)
>>>>>>  	kfree(sbi->raw_super);
>>>>>>  
>>>>>>  	destroy_device_list(sbi);
>>>>>> +	destroy_gc_context(sbi);
>>>>>>  	mempool_destroy(sbi->write_io_dummy);
>>>>>>  #ifdef CONFIG_QUOTA
>>>>>>  	for (i = 0; i < MAXQUOTAS; i++)
>>>>>> @@ -1476,15 +1477,18 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>>  	 * option. Also sync the filesystem.
>>>>>>  	 */
>>>>>>  	if ((*flags & SB_RDONLY) || !test_opt(sbi, BG_GC)) {
>>>>>> -		if (sbi->gc_thread) {
>>>>>> -			stop_gc_thread(sbi);
>>>>>> -			need_restart_gc = true;
>>>>>> +		need_restart_gc = stop_gc_thread(sbi);
>>>>>> +	} else {
>>>>>> +		down_write(&GC_I(sbi)->gc_rwsem);
>>>>>> +		if (!GC_I(sbi)->f2fs_gc_task) {
>>>>>> +			err = start_gc_thread(sbi);
>>>>>> +			if (err) {
>>>>>> +				up_write(&GC_I(sbi)->gc_rwsem);
>>>>>> +				goto restore_opts;
>>>>>> +			}
>>>>>> +			need_stop_gc = true;
>>>>>>  		}
>>>>>> -	} else if (!sbi->gc_thread) {
>>>>>> -		err = start_gc_thread(sbi);
>>>>>> -		if (err)
>>>>>> -			goto restore_opts;
>>>>>> -		need_stop_gc = true;
>>>>>> +		up_write(&GC_I(sbi)->gc_rwsem);
>>>>>>  	}
>>>>>>  
>>>>>>  	if (*flags & SB_RDONLY ||
>>>>>> @@ -2771,6 +2775,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>  		goto free_meta_inode;
>>>>>>  	}
>>>>>>  
>>>>>> +	err = init_gc_context(sbi);
>>>>>> +	if (err)
>>>>>> +		goto free_checkpoint;
>>>>>> +
>>>>>>  	/* Initialize device list */
>>>>>>  	err = f2fs_scan_devices(sbi);
>>>>>>  	if (err) {
>>>>>> @@ -2981,6 +2989,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>>  	destroy_segment_manager(sbi);
>>>>>>  free_devices:
>>>>>>  	destroy_device_list(sbi);
>>>>>> +	destroy_gc_context(sbi);
>>>>>> +free_checkpoint:
>>>>>>  	kfree(sbi->ckpt);
>>>>>>  free_meta_inode:
>>>>>>  	make_bad_inode(sbi->meta_inode);
>>>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>>>> index 2c53de9251be..b8d09935e43f 100644
>>>>>> --- a/fs/f2fs/sysfs.c
>>>>>> +++ b/fs/f2fs/sysfs.c
>>>>>> @@ -46,7 +46,7 @@ struct f2fs_attr {
>>>>>>  static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
>>>>>>  {
>>>>>>  	if (struct_type == GC_THREAD)
>>>>>> -		return (unsigned char *)sbi->gc_thread;
>>>>>> +		return (unsigned char *)GC_I(sbi);
>>>>>>  	else if (struct_type == SM_INFO)
>>>>>>  		return (unsigned char *)SM_I(sbi);
>>>>>>  	else if (struct_type == DCC_INFO)
>>>>>> @@ -248,16 +248,28 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>>>>>  	if (!strcmp(a->attr.name, "trim_sections"))
>>>>>>  		return -EINVAL;
>>>>>>  
>>>>>> -	*ui = t;
>>>>>> -
>>>>>> -	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>>>>>> +	if (!strcmp(a->attr.name, "iostat_enable") && t == 0)
>>>>>>  		f2fs_reset_iostat(sbi);
>>>>>> -	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
>>>>>> -		sbi->gc_thread->gc_wake = 1;
>>>>>> -		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
>>>>>> +
>>>>>> +	if (a->struct_type == GC_THREAD) {
>>>>>> +		down_write(&GC_I(sbi)->gc_rwsem);
>>>>>> +		if (!GC_I(sbi)->f2fs_gc_task) {
>>>>>> +			up_write(&GC_I(sbi)->gc_rwsem);
>>>>>> +			return -EINVAL;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!strcmp(a->attr.name, "gc_urgent") && t == 1) {
>>>>>> +		GC_I(sbi)->gc_wake = 1;
>>>>>> +		wake_up_interruptible_all(&GC_I(sbi)->gc_wait_queue_head);
>>>>>>  		wake_up_discard_thread(sbi, true);
>>>>>>  	}
>>>>>>  
>>>>>> +	*ui = t;
>>>>>> +
>>>>>> +	if (a->struct_type == GC_THREAD)
>>>>>> +		up_write(&GC_I(sbi)->gc_rwsem);
>>>>>> +
>>>>>>  	return count;
>>>>>>  }
>>>>>>  
>>>>>> -- 
>>>>>> 2.15.0.55.gc2ece9dc4de6
>>>>>
>>>>> .
>>>>>
>>>
>>> .
>>>
> 
> .
> 
