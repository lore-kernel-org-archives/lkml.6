Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DACCC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E53920866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E53920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeILGKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:10:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbeILGKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:10:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E50B745A87404;
        Wed, 12 Sep 2018 09:08:28 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 09:08:27 +0800
Subject: Re: [PATCH] f2fs: submit cached bio to avoid endless PageWriteback
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <kassey1216@gmail.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180911101847.129519-1-yuchao0@huawei.com>
 <20180911223916.GE55456@jaegeuk-macbookpro.roam.corp.google.com>
 <38085da9-b100-8013-7189-de1df7917d9c@kernel.org>
 <20180912001244.GA68887@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <93683ddf-6799-6089-31a0-eea3bbc095e6@huawei.com>
Date:   Wed, 12 Sep 2018 09:08:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912001244.GA68887@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, ;)

On 2018/9/12 8:12, Jaegeuk Kim wrote:
> On 09/12, Chao Yu wrote:
>> Jaegeuk,
>>
>> Could you update dev-test branch? so I can rebase this on yours, there are some
>> pending patches in my tree, I guess it can avoid conflict when you merge this.
> 
> Done.
> 
>>
>> On 2018/9/12 6:39, Jaegeuk Kim wrote:
>>> On 09/11, Chao Yu wrote:
>>>> When migrating encrypted block from background GC thread, we only add
>>>> them into f2fs inner bio cache, but forget to submit the cached bio, it
>>>> may cause potential deadlock when we are waiting page writebacked, fix
>>>> it.
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/gc.c | 42 +++++++++++++++++++++++++++++-------------
>>>>  1 file changed, 29 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index c4ea4009cf05..a2ea0d445345 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -687,7 +687,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>>>>   * Move data block via META_MAPPING while keeping locked data page.
>>>>   * This can be used to move blocks, aka LBAs, directly on disk.
>>>>   */
>>>> -static void move_data_block(struct inode *inode, block_t bidx,
>>>> +static int move_data_block(struct inode *inode, block_t bidx,
>>>>  				int gc_type, unsigned int segno, int off)
>>>>  {
>>>>  	struct f2fs_io_info fio = {
>>>> @@ -706,25 +706,29 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>  	struct node_info ni;
>>>>  	struct page *page, *mpage;
>>>>  	block_t newaddr;
>>>> -	int err;
>>>> +	int err = 0;
>>>>  	bool lfs_mode = test_opt(fio.sbi, LFS);
>>>>  
>>>>  	/* do not read out */
>>>>  	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
>>>>  	if (!page)
>>>> -		return;
>>>> +		return -ENOMEM;
>>>>  
>>>> -	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>> +	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
>>>> +		err = -ENOENT;
>>>>  		goto out;
>>>> +	}
>>>>  
>>>>  	if (f2fs_is_atomic_file(inode)) {
>>>>  		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
>>>>  		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
>>>> +		err = -EAGAIN;
>>>>  		goto out;
>>>>  	}
>>>>  
>>>>  	if (f2fs_is_pinned_file(inode)) {
>>>>  		f2fs_pin_file_control(inode, true);
>>>> +		err = -EAGAIN;
>>>>  		goto out;
>>>>  	}
>>>>  
>>>> @@ -735,6 +739,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>  
>>>>  	if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
>>>>  		ClearPageUptodate(page);
>>>> +		err = -ENOENT;
>>>>  		goto put_out;
>>>>  	}
>>>>  
>>>> @@ -817,6 +822,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>  	fio.new_blkaddr = newaddr;
>>>>  	f2fs_submit_page_write(&fio);
>>>>  	if (fio.retry) {
>>>> +		err = -EAGAIN;
>>>>  		if (PageWriteback(fio.encrypted_page))
>>>>  			end_page_writeback(fio.encrypted_page);
>>>>  		goto put_page_out;
>>>> @@ -840,6 +846,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>  	f2fs_put_dnode(&dn);
>>>>  out:
>>>>  	f2fs_put_page(page, 1);
>>>> +
>>>> +	return err;
>>>>  }
>>>>  
>>>>  static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>> @@ -919,7 +927,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>>   * If the parent node is not valid or the data block address is different,
>>>>   * the victim data block is ignored.
>>>>   */
>>>> -static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>> +static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>  		struct gc_inode_list *gc_list, unsigned int segno, int gc_type)
>>>>  {
>>>>  	struct super_block *sb = sbi->sb;
>>>> @@ -927,6 +935,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>  	block_t start_addr;
>>>>  	int off;
>>>>  	int phase = 0;
>>>> +	int submitted = 0;
>>>>  
>>>>  	start_addr = START_BLOCK(sbi, segno);
>>>>  
>>>> @@ -943,7 +952,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>  
>>>>  		/* stop BG_GC if there is not enough free sections. */
>>>>  		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
>>>> -			return;
>>>> +			return submitted;
>>>>  
>>>>  		if (check_valid_map(sbi, segno, off) == 0)
>>>>  			continue;
>>>> @@ -1015,6 +1024,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>  		if (inode) {
>>>>  			struct f2fs_inode_info *fi = F2FS_I(inode);
>>>>  			bool locked = false;
>>>> +			int err;
>>>>  
>>>>  			if (S_ISREG(inode->i_mode)) {
>>>>  				if (!down_write_trylock(&fi->i_gc_rwsem[READ]))
>>>> @@ -1033,12 +1043,15 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>  
>>>>  			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
>>>>  								+ ofs_in_node;
>>>> -			if (f2fs_post_read_required(inode))
>>>> -				move_data_block(inode, start_bidx, gc_type,
>>>> -								segno, off);
>>>> -			else
>>>> +			if (f2fs_post_read_required(inode)) {
>>>> +				err = move_data_block(inode, start_bidx,
>>>> +							gc_type, segno, off);
>>>> +				if (!err)
>>>> +					submitted++;
>>>> +			} else {
>>>>  				move_data_page(inode, start_bidx, gc_type,
>>>>  								segno, off);
>>>> +			}
>>>>  
>>>>  			if (locked) {
>>>>  				up_write(&fi->i_gc_rwsem[WRITE]);
>>>> @@ -1051,6 +1064,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>  
>>>>  	if (++phase < 5)
>>>>  		goto next_step;
>>>> +
>>>> +	return submitted;
>>>>  }
>>>>  
>>>>  static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
>>>> @@ -1078,6 +1093,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>>  	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
>>>>  						SUM_TYPE_DATA : SUM_TYPE_NODE;
>>>>  	unsigned int units = 0;
>>>> +	int submitted = 0;
>>>>  
>>>>  	/* start segno may point to middle of section, so adjust it */
>>>>  	if (__is_large_section(sbi))
>>>> @@ -1136,8 +1152,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>>  		if (type == SUM_TYPE_NODE)
>>>>  			gc_node_segment(sbi, sum->entries, segno, gc_type);
>>>>  		else
>>>> -			gc_data_segment(sbi, sum->entries, gc_list, segno,
>>>> -								gc_type);
>>>> +			submitted += gc_data_segment(sbi, sum->entries, gc_list,
>>>> +							segno, gc_type);
>>>>  
>>>>  		stat_inc_seg_count(sbi, type, gc_type);
>>>>  
>>>> @@ -1152,7 +1168,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>>  		f2fs_put_page(sum_page, 0);
>>>>  	}
>>>>  
>>>> -	if (gc_type == FG_GC)
>>>> +	if (gc_type == FG_GC || submitted)
>>>
>>> Do we need to check submitted for both of node and data? Then, we can remove
>>> FG_GC case?
>>
>> Yup, good idea, let me adjust.
>>
>> Thanks,
>>
>>>
>>>>  		f2fs_submit_merged_write(sbi,
>>>>  				(type == SUM_TYPE_NODE) ? NODE : DATA);
>>>>  
>>>> -- 
>>>> 2.18.0.rc1
> 
> .
> 

