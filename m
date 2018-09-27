Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B5EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D56D21537
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D56D21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeI0MCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:02:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbeI0MCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:02:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15628B241C82E;
        Thu, 27 Sep 2018 13:45:46 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Thu, 27 Sep 2018
 13:45:43 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: avoid f2fs_bug_on if
 f2fs_get_meta_page_nofail got EIO
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180918021805.85032-2-jaegeuk@kernel.org>
 <20180918175648.GE91945@jaegeuk-macbookpro.roam.corp.google.com>
 <9813f294-3e09-ee2d-56f0-6bb476e88a5a@huawei.com>
 <20180920214656.GE35918@jaegeuk-macbookpro.roam.corp.google.com>
 <e36d331c-d368-fcc4-fa30-15f503b737d7@huawei.com>
 <20180926001806.GA3829@jaegeuk-macbookpro.roam.corp.google.com>
 <b251de75-6cf4-52a1-434a-d42025a35e8b@huawei.com>
 <2996d79d-c791-1a22-8abd-ad37d48edf17@huawei.com>
 <20180926194932.GA44119@jaegeuk-macbookpro.roam.corp.google.com>
 <49223ef7-88b9-99ed-35ff-52f11fbfeae3@huawei.com>
 <20180927045822.GA71203@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <350a2c1b-4d80-ccfe-b795-f06bcda91b16@huawei.com>
Date:   Thu, 27 Sep 2018 13:45:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927045822.GA71203@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/27 12:58, Jaegeuk Kim wrote:
> On 09/27, Chao Yu wrote:
>> On 2018/9/27 3:49, Jaegeuk Kim wrote:
>>> On 09/26, Chao Yu wrote:
>>>> On 2018/9/26 9:10, Chao Yu wrote:
>>>>> On 2018/9/26 8:18, Jaegeuk Kim wrote:
>>>>>> On 09/21, Chao Yu wrote:
>>>>>>> On 2018/9/21 5:46, Jaegeuk Kim wrote:
>>>>>>>> On 09/20, Chao Yu wrote:
>>>>>>>>> On 2018/9/19 1:56, Jaegeuk Kim wrote:
>>>>>>>>>> This patch avoids BUG_ON when f2fs_get_meta_page_nofail got EIO during
>>>>>>>>>> xfstests/generic/475.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>> Change log from v1:
>>>>>>>>>>  - propagate errno
>>>>>>>>>>  - drop sum_pages
>>>>>>>>>>
>>>>>>>>>>  fs/f2fs/checkpoint.c | 10 +++++-----
>>>>>>>>>>  fs/f2fs/f2fs.h       |  2 +-
>>>>>>>>>>  fs/f2fs/gc.c         |  9 +++++++++
>>>>>>>>>>  fs/f2fs/node.c       | 32 ++++++++++++++++++++++++--------
>>>>>>>>>>  fs/f2fs/recovery.c   |  2 ++
>>>>>>>>>>  fs/f2fs/segment.c    |  3 +++
>>>>>>>>>>  6 files changed, 44 insertions(+), 14 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>>>>>>> index 01e0d8f5bbbe..1ddf332ce4b2 100644
>>>>>>>>>> --- a/fs/f2fs/checkpoint.c
>>>>>>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>>>>>>> @@ -119,11 +119,8 @@ struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index)
>>>>>>>>>>  		if (PTR_ERR(page) == -EIO &&
>>>>>>>>>>  				++count <= DEFAULT_RETRY_IO_COUNT)
>>>>>>>>>>  			goto retry;
>>>>>>>>>> -
>>>>>>>>>>  		f2fs_stop_checkpoint(sbi, false);
>>>>>>>>>> -		f2fs_bug_on(sbi, 1);
>>>>>>>>>>  	}
>>>>>>>>>> -
>>>>>>>>>>  	return page;
>>>>>>>>>>  }
>>>>>>>>>>  
>>>>>>>>>> @@ -1512,7 +1509,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>>  	ckpt->checkpoint_ver = cpu_to_le64(++ckpt_ver);
>>>>>>>>>>  
>>>>>>>>>>  	/* write cached NAT/SIT entries to NAT/SIT area */
>>>>>>>>>> -	f2fs_flush_nat_entries(sbi, cpc);
>>>>>>>>>> +	err = f2fs_flush_nat_entries(sbi, cpc);
>>>>>>>>>> +	if (err)
>>>>>>>>>> +		goto stop;
>>>>>>>>>
>>>>>>>>> To make sure, if partial NAT pages become dirty, flush them back to device
>>>>>>>>> outside checkpoint() is not harmful, right?
>>>>>>>>
>>>>>>>> I think so.
>>>>>>>
>>>>>>> Oh, one more case, now we use NAT #0, if partial NAT pages were
>>>>>>> writebacked, then we start to use NAT #1, later, in another checkpoint(),
>>>>>>> we update those NAT pages again, we will write them to NAT #0, which is
>>>>>>> belong to last valid checkpoint(), it's may cause corrupted checkpoint in
>>>>>>> scenario of SPO. So it's harmfull, right?
>>>>>>
>>>>>> We already stopped checkpoint anymore, so there'd be no way to proceed another
>>>>>> checkpoint. Am I missing something?
>>>>>
>>>>> You're right, we have called f2fs_stop_checkpoint(), so we are safe now. :)
>>>>
>>>> Can we allow to writeback fs metadata (NAT/SIT/SSA) in prior to checkpoint
>>>> to mitigate IO stress of checkpoint?
>>>
>>> What's the point related to this patch?
>>
>> It's not related to this patch.
>>
>>> Anyway, do you mean f2fs_write_meta_pages is not enough?
>>
>> Yup, f2fs_write_meta_pages can only flush summary pages, I guess we can
>> allow to flush dirty nat/sit entries to NAT/SIT blocks in some conditions,
>> and then flush those block in background.
> 
> I see, then NAT/SIT will be dirtied and flushed during checkpoint. Do you
> mean flushing some of them partially in background, even if we don't know
> it will be flushed again? We may need to gather some data first.

Yes, agreed, let me check that.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Maybe below conditions can be consider to trigger writebacking:
>>>> a) dirty count of meta (NAT/SIT/SSA) exceeds threshold
>>>> b) exceed time threshold
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>  	f2fs_flush_sit_entries(sbi, cpc);
>>>>>>>>>>  
>>>>>>>>>>  	/* unlock all the fs_lock[] in do_checkpoint() */
>>>>>>>>>> @@ -1521,7 +1521,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>>  		f2fs_release_discard_addrs(sbi);
>>>>>>>>>>  	else
>>>>>>>>>>  		f2fs_clear_prefree_segments(sbi, cpc);
>>>>>>>>>> -
>>>>>>>>>> +stop:
>>>>>>>>>>  	unblock_operations(sbi);
>>>>>>>>>>  	stat_inc_cp_count(sbi->stat_info);
>>>>>>>>>>  
>>>>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>>>>> index a0c868127a7c..29021dbc8f2a 100644
>>>>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>>>>> @@ -2895,7 +2895,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
>>>>>>>>>>  int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
>>>>>>>>>>  int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
>>>>>>>>>>  			unsigned int segno, struct f2fs_summary_block *sum);
>>>>>>>>>> -void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>>>>>>>>>> +int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>>>>>>>>>>  int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
>>>>>>>>>>  void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
>>>>>>>>>>  int __init f2fs_create_node_manager_caches(void);
>>>>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>>>>>> index 4bcc8a59fdef..c7d14282dbf4 100644
>>>>>>>>>> --- a/fs/f2fs/gc.c
>>>>>>>>>> +++ b/fs/f2fs/gc.c
>>>>>>>>>> @@ -1070,6 +1070,15 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>>>>>>>>  	/* reference all summary page */
>>>>>>>>>>  	while (segno < end_segno) {
>>>>>>>>>>  		sum_page = f2fs_get_sum_page(sbi, segno++);
>>>>>>>>>> +		if (IS_ERR(sum_page)) {
>>>>>>>>>> +			end_segno = segno - 1;
>>>>>>>>>> +			for (segno = start_segno; segno < end_segno; segno++) {
>>>>>>>>>> +				sum_page = find_get_page(META_MAPPING(sbi),
>>>>>>>>>> +						GET_SUM_BLOCK(sbi, segno));
>>>>>>>>>> +				f2fs_put_page(sum_page, 0);
>>>>>>>>>
>>>>>>>>> find_get_page() will add one more reference on page, so we need to call
>>>>>>>>> f2fs_put_page(sum_page, 0) twice.
>>>>>>>>
>>>>>>>> Done.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>>> +			}
>>>>>>>>>> +			return PTR_ERR(sum_page);
>>>>>>>>>> +		}
>>>>>>>>>>  		unlock_page(sum_page);
>>>>>>>>>>  	}
>>>>>>>>>>  
>>>>>>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>>>>>>>> index fa2381c0bc47..79b6fee354f7 100644
>>>>>>>>>> --- a/fs/f2fs/node.c
>>>>>>>>>> +++ b/fs/f2fs/node.c
>>>>>>>>>> @@ -126,6 +126,8 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
>>>>>>>>>>  
>>>>>>>>>>  	/* get current nat block page with lock */
>>>>>>>>>>  	src_page = get_current_nat_page(sbi, nid);
>>>>>>>>>> +	if (IS_ERR(src_page))
>>>>>>>>>> +		return src_page;
>>>>>>>>>>  	dst_page = f2fs_grab_meta_page(sbi, dst_off);
>>>>>>>>>>  	f2fs_bug_on(sbi, PageDirty(src_page));
>>>>>>>>>>  
>>>>>>>>>> @@ -2265,15 +2267,19 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
>>>>>>>>>>  						nm_i->nat_block_bitmap)) {
>>>>>>>>>>  			struct page *page = get_current_nat_page(sbi, nid);
>>>>>>>>>>  
>>>>>>>>>> -			ret = scan_nat_page(sbi, page, nid);
>>>>>>>>>> -			f2fs_put_page(page, 1);
>>>>>>>>>> +			if (IS_ERR(page)) {
>>>>>>>>>> +				ret = PTR_ERR(page);
>>>>>>>>>> +			} else {
>>>>>>>>>> +				ret = scan_nat_page(sbi, page, nid);
>>>>>>>>>> +				f2fs_put_page(page, 1);
>>>>>>>>>> +			}
>>>>>>>>>>  
>>>>>>>>>>  			if (ret) {
>>>>>>>>>>  				up_read(&nm_i->nat_tree_lock);
>>>>>>>>>>  				f2fs_bug_on(sbi, !mount);
>>>>>>>>>>  				f2fs_msg(sbi->sb, KERN_ERR,
>>>>>>>>>>  					"NAT is corrupt, run fsck to fix it");
>>>>>>>>>> -				return -EINVAL;
>>>>>>>>>> +				return ret;
>>>>>>>>>>  			}
>>>>>>>>>>  		}
>>>>>>>>>>  
>>>>>>>>>> @@ -2700,7 +2706,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>>>>>>>>>>  		__clear_bit_le(nat_index, nm_i->full_nat_bits);
>>>>>>>>>>  }
>>>>>>>>>>  
>>>>>>>>>> -static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>>>>>>> +static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>>>>>>>  		struct nat_entry_set *set, struct cp_control *cpc)
>>>>>>>>>>  {
>>>>>>>>>>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>>>>>>>>> @@ -2724,6 +2730,9 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>>>>>>>  		down_write(&curseg->journal_rwsem);
>>>>>>>>>>  	} else {
>>>>>>>>>>  		page = get_next_nat_page(sbi, start_nid);
>>>>>>>>>> +		if (IS_ERR(page))
>>>>>>>>>> +			return PTR_ERR(page);
>>>>>>>>>> +
>>>>>>>>>>  		nat_blk = page_address(page);
>>>>>>>>>>  		f2fs_bug_on(sbi, !nat_blk);
>>>>>>>>>>  	}
>>>>>>>>>> @@ -2769,12 +2778,13 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>>>>>>>>>>  		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
>>>>>>>>>>  		kmem_cache_free(nat_entry_set_slab, set);
>>>>>>>>>>  	}
>>>>>>>>>> +	return 0;
>>>>>>>>>>  }
>>>>>>>>>>  
>>>>>>>>>>  /*
>>>>>>>>>>   * This function is called during the checkpointing process.
>>>>>>>>>>   */
>>>>>>>>>> -void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>> +int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>>  {
>>>>>>>>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>>>>>>>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>>>>>>>>> @@ -2784,6 +2794,7 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>>  	unsigned int found;
>>>>>>>>>>  	nid_t set_idx = 0;
>>>>>>>>>>  	LIST_HEAD(sets);
>>>>>>>>>> +	int err = 0;
>>>>>>>>>>  
>>>>>>>>>>  	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
>>>>>>>>>>  	if (enabled_nat_bits(sbi, cpc)) {
>>>>>>>>>> @@ -2793,7 +2804,7 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>>  	}
>>>>>>>>>>  
>>>>>>>>>>  	if (!nm_i->dirty_nat_cnt)
>>>>>>>>>> -		return;
>>>>>>>>>> +		return 0;
>>>>>>>>>>  
>>>>>>>>>>  	down_write(&nm_i->nat_tree_lock);
>>>>>>>>>>  
>>>>>>>>>> @@ -2816,11 +2827,16 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>>  	}
>>>>>>>>>>  
>>>>>>>>>>  	/* flush dirty nats in nat entry set */
>>>>>>>>>> -	list_for_each_entry_safe(set, tmp, &sets, set_list)
>>>>>>>>>> -		__flush_nat_entry_set(sbi, set, cpc);
>>>>>>>>>> +	list_for_each_entry_safe(set, tmp, &sets, set_list) {
>>>>>>>>>> +		err = __flush_nat_entry_set(sbi, set, cpc);
>>>>>>>>>> +		if (err)
>>>>>>>>>> +			break;
>>>>>>>>>> +	}
>>>>>>>>>>  
>>>>>>>>>>  	up_write(&nm_i->nat_tree_lock);
>>>>>>>>>>  	/* Allow dirty nats by node block allocation in write_begin */
>>>>>>>>>> +
>>>>>>>>>> +	return err;
>>>>>>>>>>  }
>>>>>>>>>>  
>>>>>>>>>>  static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>>>>>>>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>>>>>>>> index 56d34193a74b..ba678efe7cad 100644
>>>>>>>>>> --- a/fs/f2fs/recovery.c
>>>>>>>>>> +++ b/fs/f2fs/recovery.c
>>>>>>>>>> @@ -355,6 +355,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
>>>>>>>>>>  	}
>>>>>>>>>>  
>>>>>>>>>>  	sum_page = f2fs_get_sum_page(sbi, segno);
>>>>>>>>>> +	if (IS_ERR(sum_page))
>>>>>>>>>> +		return PTR_ERR(sum_page);
>>>>>>>>>>  	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
>>>>>>>>>>  	sum = sum_node->entries[blkoff];
>>>>>>>>>>  	f2fs_put_page(sum_page, 1);
>>>>>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>>>>>> index aa96a371aaf8..ab7386a7e9d3 100644
>>>>>>>>>> --- a/fs/f2fs/segment.c
>>>>>>>>>> +++ b/fs/f2fs/segment.c
>>>>>>>>>> @@ -2487,6 +2487,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
>>>>>>>>>>  	__next_free_blkoff(sbi, curseg, 0);
>>>>>>>>>>  
>>>>>>>>>>  	sum_page = f2fs_get_sum_page(sbi, new_segno);
>>>>>>>>>> +	f2fs_bug_on(sbi, IS_ERR(sum_page));
>>>>>>>>>>  	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
>>>>>>>>>>  	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
>>>>>>>>>>  	f2fs_put_page(sum_page, 1);
>>>>>>>>>> @@ -3971,6 +3972,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>>>>>>>>>>  
>>>>>>>>>>  			se = &sit_i->sentries[start];
>>>>>>>>>>  			page = get_current_sit_page(sbi, start);
>>>>>>>>>> +			if (IS_ERR(page))
>>>>>>>>>> +				return PTR_ERR(page);
>>>>>>>>>>  			sit_blk = (struct f2fs_sit_block *)page_address(page);
>>>>>>>>>>  			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
>>>>>>>>>>  			f2fs_put_page(page, 1);
>>>>>>>>>>
>>>>>>>>
>>>>>>>> .
>>>>>>>>
>>>>>>
>>>>>> .
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>
>>>>> .
>>>>>
>>>
>>> .
>>>
> 
> .
> 

