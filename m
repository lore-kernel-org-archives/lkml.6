Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbeDTDYA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:24:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60349 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753964AbeDTDX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:23:59 -0400
Subject: Re: [PATCH 4/5] f2fs: show GC failure info in debugfs
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180418094505.98888-1-yuchao0@huawei.com>
 <20180418094505.98888-4-yuchao0@huawei.com>
 <20180420031525.GD39280@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <357d4213-1e0b-3934-1e9a-a6ea8ee6020a@huawei.com>
Date: Fri, 20 Apr 2018 11:24:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180420031525.GD39280@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/20 11:15, Jaegeuk Kim wrote:
> On 04/18, Chao Yu wrote:
>> This patch adds to show GC failure information in debugfs, now it just
>> shows count of failure caused by atomic write.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/debug.c |  5 +++++
>>  fs/f2fs/f2fs.h  |  1 +
>>  fs/f2fs/gc.c    | 13 +++++++------
>>  fs/f2fs/gc.h    |  2 +-
>>  4 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
>> index a66107b5cfff..715beb85e9db 100644
>> --- a/fs/f2fs/debug.c
>> +++ b/fs/f2fs/debug.c
>> @@ -104,6 +104,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>>  	si->avail_nids = NM_I(sbi)->available_nids;
>>  	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
>>  	si->bg_gc = sbi->bg_gc;
>> +	si->bg_atomic = sbi->gc_thread->atomic_file[BG_GC];
>> +	si->fg_atomic = sbi->gc_thread->atomic_file[FG_GC];
> 
> Need to change the naming like skipped_atomic_files?

OK

> 
>>  	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
>>  		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
>>  		/ 2;
>> @@ -342,6 +344,9 @@ static int stat_show(struct seq_file *s, void *v)
>>  				si->bg_data_blks);
>>  		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
>>  				si->bg_node_blks);
>> +		seq_printf(s, "Failure : atomic write %d (%d)\n",
> 
> It's not failure.

Alright... just skip..

> 
>> +				si->bg_atomic + si->fg_atomic,
>> +				si->bg_atomic);
>>  		seq_puts(s, "\nExtent Cache:\n");
>>  		seq_printf(s, "  - Hit Count: L1-1:%llu L1-2:%llu L2:%llu\n",
>>  				si->hit_largest, si->hit_cached,
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 3453288d6a71..567c6bb57ae3 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3003,6 +3003,7 @@ struct f2fs_stat_info {
>>  	int bg_node_segs, bg_data_segs;
>>  	int tot_blks, data_blks, node_blks;
>>  	int bg_data_blks, bg_node_blks;
>> +	unsigned int bg_atomic, fg_atomic;
>>  	int curseg[NR_CURSEG_TYPE];
>>  	int cursec[NR_CURSEG_TYPE];
>>  	int curzone[NR_CURSEG_TYPE];
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 495876ca62b6..da89ca16a55d 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -135,7 +135,8 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>>  	gc_th->gc_urgent = 0;
>>  	gc_th->gc_wake= 0;
>>  
>> -	gc_th->atomic_file = 0;
>> +	gc_th->atomic_file[BG_GC] = 0;
>> +	gc_th->atomic_file[FG_GC] = 0;
> 
> Need to merge the previous patch with this.

Let me merge them. :)

Thanks,

> 
>>  
>>  	sbi->gc_thread = gc_th;
>>  	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
>> @@ -633,7 +634,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>  		goto out;
>>  
>>  	if (f2fs_is_atomic_file(inode)) {
>> -		F2FS_I_SB(inode)->gc_thread->atomic_file++;
>> +		F2FS_I_SB(inode)->gc_thread->atomic_file[gc_type]++;
>>  		goto out;
>>  	}
>>  
>> @@ -742,7 +743,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>  		goto out;
>>  
>>  	if (f2fs_is_atomic_file(inode)) {
>> -		F2FS_I_SB(inode)->gc_thread->atomic_file++;
>> +		F2FS_I_SB(inode)->gc_thread->atomic_file[gc_type]++;
>>  		goto out;
>>  	}
>>  	if (f2fs_is_pinned_file(inode)) {
>> @@ -1024,7 +1025,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>  		.ilist = LIST_HEAD_INIT(gc_list.ilist),
>>  		.iroot = RADIX_TREE_INIT(GFP_NOFS),
>>  	};
>> -	unsigned int last_atomic_file = sbi->gc_thread->atomic_file;
>> +	unsigned int last_atomic_file = sbi->gc_thread->atomic_file[FG_GC];
>>  	unsigned int skipped_round = 0, round = 0;
>>  
>>  	trace_f2fs_gc_begin(sbi->sb, sync, background,
>> @@ -1078,9 +1079,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>  	total_freed += seg_freed;
>>  
>>  	if (gc_type == FG_GC) {
>> -		if (sbi->gc_thread->atomic_file > last_atomic_file)
>> +		if (sbi->gc_thread->atomic_file[FG_GC] > last_atomic_file)
>>  			skipped_round++;
>> -		last_atomic_file = sbi->gc_thread->atomic_file;
>> +		last_atomic_file = sbi->gc_thread->atomic_file[FG_GC];
>>  		round++;
>>  	}
>>  
>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
>> index bc1d21d46ae7..a6cffe6b249b 100644
>> --- a/fs/f2fs/gc.h
>> +++ b/fs/f2fs/gc.h
>> @@ -41,7 +41,7 @@ struct f2fs_gc_kthread {
>>  	unsigned int gc_wake;
>>  
>>  	/* for stuck statistic */
>> -	unsigned int atomic_file;
>> +	unsigned int atomic_file[2];
>>  };
>>  
>>  struct gc_inode_list {
>> -- 
>> 2.15.0.55.gc2ece9dc4de6
> 
> .
> 
