Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403DDC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB7B20899
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKnDmheX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB7B20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeG2EYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeG2EYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:24:00 -0400
Received: from [192.168.0.101] (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E0220893;
        Sun, 29 Jul 2018 02:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532832915;
        bh=XNQIIyMejyT0rDQIgZ+xFJUpZxI5mRex5r5Nns2u+O0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sKnDmheXMfj/XIKMUTfGvNpmJ1k/dBk9zpM7mU1JRaGdheTvyAZAQsUpjCmorf1iB
         n8GUj0sUDWoZgD1iChv3ooC1zEPEPULlkDdVThpefIS49/PJ/M9HkqGeREfe0apkOW
         fYMBiDzU1iLubJ76GIyiVkU48WnsuJivArCVw52w=
Subject: Re: [PATCH v5 1/2] f2fs: fix to avoid broken of dnode block list
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180728013613.91304-1-yuchao0@huawei.com>
 <20180729013351.GE83620@jaegeuk-macbookpro.roam.corp.google.com>
 <3b94966d-5dc8-2bdf-2633-bdbb99fba74a@kernel.org>
 <20180729024917.GA94739@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5b5e0f89-090b-b939-2243-68f64b5ead87@kernel.org>
Date:   Sun, 29 Jul 2018 10:55:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729024917.GA94739@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/29 10:49, Jaegeuk Kim wrote:
> On 07/29, Chao Yu wrote:
>> On 2018/7/29 9:33, Jaegeuk Kim wrote:
>>> On 07/28, Chao Yu wrote:
>>>> f2fs recovery flow is relying on dnode block link list, it means fsynced
>>>> file recovery depends on previous dnode's persistence in the list, so
>>>> during fsync() we should wait on all regular inode's dnode writebacked
>>>> before issuing flush.
>>>>
>>>> By this way, we can avoid dnode block list being broken by out-of-order
>>>> IO submission due to IO scheduler or driver.
>>>>
>>>> Sheng Yong helps to do the test with this patch:
>>>>
>>>> Target:/data (f2fs, -)
>>>> 64MB / 32768KB / 4KB / 8
>>>>
>>>> 1 / PERSIST / Index
>>>>
>>>> Base:
>>>> 	SEQ-RD(MB/s)	SEQ-WR(MB/s)	RND-RD(IOPS)	RND-WR(IOPS)	Insert(TPS)	Update(TPS)	Delete(TPS)
>>>> 1	867.82		204.15		41440.03	41370.54	680.8		1025.94		1031.08
>>>> 2	871.87		205.87		41370.3		40275.2		791.14		1065.84		1101.7
>>>> 3	866.52		205.69		41795.67	40596.16	694.69		1037.16		1031.48
>>>> Avg	868.7366667	205.2366667	41535.33333	40747.3		722.21		1042.98		1054.753333
>>>>
>>>> After:
>>>> 	SEQ-RD(MB/s)	SEQ-WR(MB/s)	RND-RD(IOPS)	RND-WR(IOPS)	Insert(TPS)	Update(TPS)	Delete(TPS)
>>>> 1	798.81		202.5		41143		40613.87	602.71		838.08		913.83
>>>> 2	805.79		206.47		40297.2		41291.46	604.44		840.75		924.27
>>>> 3	814.83		206.17		41209.57	40453.62	602.85		834.66		927.91
>>>> Avg	806.4766667	205.0466667	40883.25667	40786.31667	603.3333333	837.83		922.0033333
>>>>
>>>> Patched/Original:
>>>> 	0.928332713	0.999074239	0.984300676	1.000957528	0.835398753	0.803303994	0.874141189
>>>
>>> I expect Sheng will provide more test results tho, at least it seems SEQ-RD
>>> in Base shows better than two After results, even if it doesn't matter with
>>> the issue. Please confirm it first in order for anybody to say there is no
>>> regression.
>>
>> Agreed.
> 
> Hmm, this patch breaks fault injection test where gives a panic in put_super
> having fsync_node_num.

Let me do the test and fix it.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> It looks like atomic write will suffer performance regression.
>>>>
>>>> I suspect that the criminal is that we forcing to wait all dnode being in
>>>> storage cache before we issue PREFLUSH+FUA.
>>>>
>>>> BTW, will commit ("f2fs: don't need to wait for node writes for atomic write")
>>>> cause the problem: we will lose data of last transaction after SPO, even if
>>>> atomic write return no error:
>>>>
>>>> - atomic_open();
>>>> - write() P1, P2, P3;
>>>> - atomic_commit();
>>>>  - writeback data: P1, P2, P3;
>>>>  - writeback node: N1, N2, N3;  <--- If N1, N2 is not writebacked, N3 with fsync_mark is
>>>> writebacked, In SPOR, we won't find N3 since node chain is broken, turns out that losing
>>>> last transaction.
>>>>  - preflush + fua;
>>>> - power-cut
>>>>
>>>> If we don't wait dnode writeback for atomic_write:
>>>>
>>>> 	SEQ-RD(MB/s)	SEQ-WR(MB/s)	RND-RD(IOPS)	RND-WR(IOPS)	Insert(TPS)	Update(TPS)	Delete(TPS)
>>>> 1	779.91		206.03		41621.5		40333.16	716.9		1038.21		1034.85
>>>> 2	848.51		204.35		40082.44	39486.17	791.83		1119.96		1083.77
>>>> 3	772.12		206.27		41335.25	41599.65	723.29		1055.07		971.92
>>>> Avg	800.18		205.55		41013.06333	40472.99333	744.0066667	1071.08		1030.18
>>>>
>>>> Patched/Original:
>>>> 	0.92108464	1.001526693	0.987425886	0.993268102	1.030180511	1.026942031	0.976702294
>>>>
>>>> SQLite's performance recovers.
>>>>
>>>> Jaegeuk:
>>>> "Practically, I don't see db corruption becase of this. We can excuse to lose
>>>> the last transaction."
>>>>
>>>> Finally, we decide to keep original implementation of atomic write interface
>>>> sematics that we don't wait all dnode writeback before preflush+fua submission.
>>>>
>>>> Tested-by: Sheng Yong <shengyong1@huawei.com>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>> v5:
>>>> - add missing Tested-by.
>>>> - fix f2fs_reset_fsync_node_info() to reset sbi->fsync_seg_id correctly.
>>>>  fs/f2fs/checkpoint.c |   2 +
>>>>  fs/f2fs/data.c       |   2 +
>>>>  fs/f2fs/f2fs.h       |  21 ++++++-
>>>>  fs/f2fs/file.c       |   5 +-
>>>>  fs/f2fs/node.c       | 144 +++++++++++++++++++++++++++++++++++--------
>>>>  fs/f2fs/super.c      |   4 ++
>>>>  6 files changed, 150 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index 581710760ba6..2136430f9f0d 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -1410,6 +1410,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>  
>>>>  	f2fs_release_ino_entry(sbi, false);
>>>>  
>>>> +	f2fs_reset_fsync_node_info(sbi);
>>>> +
>>>>  	clear_sbi_flag(sbi, SBI_IS_DIRTY);
>>>>  	clear_sbi_flag(sbi, SBI_NEED_CP);
>>>>  	__set_cp_next_pack(sbi);
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 6b8ca5011bfd..572c91e43337 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -177,6 +177,8 @@ static void f2fs_write_end_io(struct bio *bio)
>>>>  					page->index != nid_of_node(page));
>>>>  
>>>>  		dec_page_count(sbi, type);
>>>> +		if (f2fs_in_warm_node_list(sbi, page))
>>>> +			f2fs_del_fsync_node_entry(sbi, page);
>>>>  		clear_cold_data(page);
>>>>  		end_page_writeback(page);
>>>>  	}
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 0374f069520c..6627fef9ae38 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -228,6 +228,12 @@ struct inode_entry {
>>>>  	struct inode *inode;	/* vfs inode pointer */
>>>>  };
>>>>  
>>>> +struct fsync_node_entry {
>>>> +	struct list_head list;	/* list head */
>>>> +	struct page *page;	/* warm node page pointer */
>>>> +	unsigned int seq_id;	/* sequence id */
>>>> +};
>>>> +
>>>>  /* for the bitmap indicate blocks to be discarded */
>>>>  struct discard_entry {
>>>>  	struct list_head list;	/* list head */
>>>> @@ -1156,6 +1162,11 @@ struct f2fs_sb_info {
>>>>  
>>>>  	struct inode_management im[MAX_INO_ENTRY];      /* manage inode cache */
>>>>  
>>>> +	spinlock_t fsync_node_lock;		/* for node entry lock */
>>>> +	struct list_head fsync_node_list;	/* node list head */
>>>> +	unsigned int fsync_seg_id;		/* sequence id */
>>>> +	unsigned int fsync_node_num;		/* number of node entries */
>>>> +
>>>>  	/* for orphan inode, use 0'th array */
>>>>  	unsigned int max_orphans;		/* max orphan inodes */
>>>>  
>>>> @@ -2822,6 +2833,10 @@ struct node_info;
>>>>  
>>>>  int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
>>>>  bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
>>>> +bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct page *page);
>>>> +void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi);
>>>> +void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct page *page);
>>>> +void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi);
>>>>  int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid);
>>>>  bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid);
>>>>  bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino);
>>>> @@ -2831,7 +2846,8 @@ pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
>>>>  int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
>>>>  int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
>>>>  int f2fs_truncate_xattr_node(struct inode *inode);
>>>> -int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
>>>> +int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
>>>> +					unsigned int seq_id);
>>>>  int f2fs_remove_inode_page(struct inode *inode);
>>>>  struct page *f2fs_new_inode_page(struct inode *inode);
>>>>  struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
>>>> @@ -2840,7 +2856,8 @@ struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
>>>>  struct page *f2fs_get_node_page_ra(struct page *parent, int start);
>>>>  void f2fs_move_node_page(struct page *node_page, int gc_type);
>>>>  int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>>> -			struct writeback_control *wbc, bool atomic);
>>>> +			struct writeback_control *wbc, bool atomic,
>>>> +			unsigned int *seq_id);
>>>>  int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>>>>  			struct writeback_control *wbc,
>>>>  			bool do_balance, enum iostat_type io_type);
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index 8f9ab66858ca..7bd2412a8c37 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -213,6 +213,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>>  		.nr_to_write = LONG_MAX,
>>>>  		.for_reclaim = 0,
>>>>  	};
>>>> +	unsigned int seq_id = 0;
>>>>  
>>>>  	if (unlikely(f2fs_readonly(inode->i_sb)))
>>>>  		return 0;
>>>> @@ -275,7 +276,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>>  	}
>>>>  sync_nodes:
>>>>  	atomic_inc(&sbi->wb_sync_req[NODE]);
>>>> -	ret = f2fs_fsync_node_pages(sbi, inode, &wbc, atomic);
>>>> +	ret = f2fs_fsync_node_pages(sbi, inode, &wbc, atomic, &seq_id);
>>>>  	atomic_dec(&sbi->wb_sync_req[NODE]);
>>>>  	if (ret)
>>>>  		goto out;
>>>> @@ -301,7 +302,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>>  	 * given fsync mark.
>>>>  	 */
>>>>  	if (!atomic) {
>>>> -		ret = f2fs_wait_on_node_pages_writeback(sbi, ino);
>>>> +		ret = f2fs_wait_on_node_pages_writeback(sbi, seq_id);
>>>>  		if (ret)
>>>>  			goto out;
>>>>  	}
>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>> index 9d9f4c9750c4..e109c671cd84 100644
>>>> --- a/fs/f2fs/node.c
>>>> +++ b/fs/f2fs/node.c
>>>> @@ -28,6 +28,7 @@
>>>>  static struct kmem_cache *nat_entry_slab;
>>>>  static struct kmem_cache *free_nid_slab;
>>>>  static struct kmem_cache *nat_entry_set_slab;
>>>> +static struct kmem_cache *fsync_node_entry_slab;
>>>>  
>>>>  /*
>>>>   * Check whether the given nid is within node id range.
>>>> @@ -264,6 +265,72 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
>>>>  							start, nr);
>>>>  }
>>>>  
>>>> +bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct page *page)
>>>> +{
>>>> +	return NODE_MAPPING(sbi) == page->mapping &&
>>>> +			IS_DNODE(page) && is_cold_node(page);
>>>> +}
>>>> +
>>>> +void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
>>>> +{
>>>> +	spin_lock_init(&sbi->fsync_node_lock);
>>>> +	INIT_LIST_HEAD(&sbi->fsync_node_list);
>>>> +	sbi->fsync_seg_id = 0;
>>>> +	sbi->fsync_node_num = 0;
>>>> +}
>>>> +
>>>> +static unsigned int f2fs_add_fsync_node_entry(struct f2fs_sb_info *sbi,
>>>> +							struct page *page)
>>>> +{
>>>> +	struct fsync_node_entry *fn;
>>>> +	unsigned long flags;
>>>> +	unsigned int seq_id;
>>>> +
>>>> +	fn = f2fs_kmem_cache_alloc(fsync_node_entry_slab, GFP_NOFS);
>>>> +
>>>> +	get_page(page);
>>>> +	fn->page = page;
>>>> +	INIT_LIST_HEAD(&fn->list);
>>>> +
>>>> +	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
>>>> +	list_add_tail(&fn->list, &sbi->fsync_node_list);
>>>> +	fn->seq_id = sbi->fsync_seg_id++;
>>>> +	seq_id = fn->seq_id;
>>>> +	sbi->fsync_node_num++;
>>>> +	spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>>> +
>>>> +	return seq_id;
>>>> +}
>>>> +
>>>> +void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct page *page)
>>>> +{
>>>> +	struct fsync_node_entry *fn;
>>>> +	unsigned long flags;
>>>> +
>>>> +	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
>>>> +	list_for_each_entry(fn, &sbi->fsync_node_list, list) {
>>>> +		if (fn->page == page) {
>>>> +			list_del(&fn->list);
>>>> +			sbi->fsync_node_num--;
>>>> +			spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>>> +			kmem_cache_free(fsync_node_entry_slab, fn);
>>>> +			put_page(page);
>>>> +			return;
>>>> +		}
>>>> +	}
>>>> +	spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>>> +	f2fs_bug_on(sbi, 1);
>>>> +}
>>>> +
>>>> +void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi)
>>>> +{
>>>> +	unsigned long flags;
>>>> +
>>>> +	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
>>>> +	sbi->fsync_seg_id = 0;
>>>> +	spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>>> +}
>>>> +
>>>>  int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
>>>>  {
>>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>> @@ -1384,7 +1451,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
>>>>  
>>>>  static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>>  				struct writeback_control *wbc, bool do_balance,
>>>> -				enum iostat_type io_type)
>>>> +				enum iostat_type io_type, unsigned int *seq_id)
>>>>  {
>>>>  	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
>>>>  	nid_t nid;
>>>> @@ -1401,6 +1468,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>>  		.io_type = io_type,
>>>>  		.io_wbc = wbc,
>>>>  	};
>>>> +	unsigned int seq;
>>>>  
>>>>  	trace_f2fs_writepage(page, NODE);
>>>>  
>>>> @@ -1442,6 +1510,13 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>>  
>>>>  	set_page_writeback(page);
>>>>  	ClearPageError(page);
>>>> +
>>>> +	if (f2fs_in_warm_node_list(sbi, page)) {
>>>> +		seq = f2fs_add_fsync_node_entry(sbi, page);
>>>> +		if (seq_id)
>>>> +			*seq_id = seq;
>>>> +	}
>>>> +
>>>>  	fio.old_blkaddr = ni.blk_addr;
>>>>  	f2fs_do_write_node_page(nid, &fio);
>>>>  	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
>>>> @@ -1489,7 +1564,7 @@ void f2fs_move_node_page(struct page *node_page, int gc_type)
>>>>  			goto out_page;
>>>>  
>>>>  		if (__write_node_page(node_page, false, NULL,
>>>> -					&wbc, false, FS_GC_NODE_IO))
>>>> +					&wbc, false, FS_GC_NODE_IO, NULL))
>>>>  			unlock_page(node_page);
>>>>  		goto release_page;
>>>>  	} else {
>>>> @@ -1506,11 +1581,13 @@ void f2fs_move_node_page(struct page *node_page, int gc_type)
>>>>  static int f2fs_write_node_page(struct page *page,
>>>>  				struct writeback_control *wbc)
>>>>  {
>>>> -	return __write_node_page(page, false, NULL, wbc, false, FS_NODE_IO);
>>>> +	return __write_node_page(page, false, NULL, wbc, false,
>>>> +						FS_NODE_IO, NULL);
>>>>  }
>>>>  
>>>>  int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>>> -			struct writeback_control *wbc, bool atomic)
>>>> +			struct writeback_control *wbc, bool atomic,
>>>> +			unsigned int *seq_id)
>>>>  {
>>>>  	pgoff_t index;
>>>>  	pgoff_t last_idx = ULONG_MAX;
>>>> @@ -1591,7 +1668,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>>>>  			ret = __write_node_page(page, atomic &&
>>>>  						page == last_page,
>>>>  						&submitted, wbc, true,
>>>> -						FS_NODE_IO);
>>>> +						FS_NODE_IO, seq_id);
>>>>  			if (ret) {
>>>>  				unlock_page(page);
>>>>  				f2fs_put_page(last_page, 0);
>>>> @@ -1708,7 +1785,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>>>>  			set_dentry_mark(page, 0);
>>>>  
>>>>  			ret = __write_node_page(page, false, &submitted,
>>>> -						wbc, do_balance, io_type);
>>>> +						wbc, do_balance, io_type, NULL);
>>>>  			if (ret)
>>>>  				unlock_page(page);
>>>>  			else if (submitted)
>>>> @@ -1739,35 +1816,46 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
>>>> +int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
>>>> +						unsigned int seq_id)
>>>>  {
>>>> -	pgoff_t index = 0;
>>>> -	struct pagevec pvec;
>>>> +	struct fsync_node_entry *fn;
>>>> +	struct page *page;
>>>> +	struct list_head *head = &sbi->fsync_node_list;
>>>> +	unsigned long flags;
>>>> +	unsigned int cur_seq_id = 0;
>>>>  	int ret2, ret = 0;
>>>> -	int nr_pages;
>>>>  
>>>> -	pagevec_init(&pvec);
>>>> +	while (seq_id && cur_seq_id < seq_id) {
>>>> +		spin_lock_irqsave(&sbi->fsync_node_lock, flags);
>>>> +		if (list_empty(head)) {
>>>> +			spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>>> +			break;
>>>> +		}
>>>> +		fn = list_first_entry(head, struct fsync_node_entry, list);
>>>> +		if (fn->seq_id > seq_id) {
>>>> +			spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>>> +			break;
>>>> +		}
>>>> +		cur_seq_id = fn->seq_id;
>>>> +		page = fn->page;
>>>> +		get_page(page);
>>>> +		spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>>>  
>>>> -	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
>>>> -				PAGECACHE_TAG_WRITEBACK))) {
>>>> -		int i;
>>>> +		f2fs_wait_on_page_writeback(page, NODE, true);
>>>> +		if (TestClearPageError(page))
>>>> +			ret = -EIO;
>>>>  
>>>> -		for (i = 0; i < nr_pages; i++) {
>>>> -			struct page *page = pvec.pages[i];
>>>> +		put_page(page);
>>>>  
>>>> -			if (ino && ino_of_node(page) == ino) {
>>>> -				f2fs_wait_on_page_writeback(page, NODE, true);
>>>> -				if (TestClearPageError(page))
>>>> -					ret = -EIO;
>>>> -			}
>>>> -		}
>>>> -		pagevec_release(&pvec);
>>>> -		cond_resched();
>>>> +		if (ret)
>>>> +			break;
>>>>  	}
>>>>  
>>>>  	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
>>>>  	if (!ret)
>>>>  		ret = ret2;
>>>> +
>>>>  	return ret;
>>>>  }
>>>>  
>>>> @@ -2982,8 +3070,15 @@ int __init f2fs_create_node_manager_caches(void)
>>>>  			sizeof(struct nat_entry_set));
>>>>  	if (!nat_entry_set_slab)
>>>>  		goto destroy_free_nid;
>>>> +
>>>> +	fsync_node_entry_slab = f2fs_kmem_cache_create("fsync_node_entry",
>>>> +			sizeof(struct fsync_node_entry));
>>>> +	if (!fsync_node_entry_slab)
>>>> +		goto destroy_nat_entry_set;
>>>>  	return 0;
>>>>  
>>>> +destroy_nat_entry_set:
>>>> +	kmem_cache_destroy(nat_entry_set_slab);
>>>>  destroy_free_nid:
>>>>  	kmem_cache_destroy(free_nid_slab);
>>>>  destroy_nat_entry:
>>>> @@ -2994,6 +3089,7 @@ int __init f2fs_create_node_manager_caches(void)
>>>>  
>>>>  void f2fs_destroy_node_manager_caches(void)
>>>>  {
>>>> +	kmem_cache_destroy(fsync_node_entry_slab);
>>>>  	kmem_cache_destroy(nat_entry_set_slab);
>>>>  	kmem_cache_destroy(free_nid_slab);
>>>>  	kmem_cache_destroy(nat_entry_slab);
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 0eff4637fe55..cb1ba9f18353 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -1030,6 +1030,8 @@ static void f2fs_put_super(struct super_block *sb)
>>>>  	 */
>>>>  	f2fs_release_ino_entry(sbi, true);
>>>>  
>>>> +	f2fs_bug_on(sbi, sbi->fsync_node_num);
>>>> +
>>>>  	f2fs_leave_shrinker(sbi);
>>>>  	mutex_unlock(&sbi->umount_mutex);
>>>>  
>>>> @@ -2923,6 +2925,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>  
>>>>  	f2fs_init_ino_entry_info(sbi);
>>>>  
>>>> +	f2fs_init_fsync_node_info(sbi);
>>>> +
>>>>  	/* setup f2fs internal modules */
>>>>  	err = f2fs_build_segment_manager(sbi);
>>>>  	if (err) {
>>>> -- 
>>>> 2.18.0.rc1
