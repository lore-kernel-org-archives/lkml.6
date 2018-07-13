Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0902ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C087214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C087214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbeGMDzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:55:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387722AbeGMDza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:55:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52BD6B9C6C30;
        Fri, 13 Jul 2018 11:42:37 +0800 (CST)
Received: from [127.0.0.1] (10.111.220.140) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 11:42:33 +0800
Subject: Re: [PATCH 5/5] f2fs: do not __punch_discard_cmd in lfs mode
To:     Chao Yu <yuchao0@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-6-git-send-email-yunlong.song@huawei.com>
 <7049c66a-867a-aef6-a58e-16ade179461e@huawei.com>
From:   Yunlong Song <yunlong.song@huawei.com>
Message-ID: <b84afb5e-2ea9-79c3-f95d-94dc1a4f9eb2@huawei.com>
Date:   Fri, 13 Jul 2018 11:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <7049c66a-867a-aef6-a58e-16ade179461e@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about change test_opt(sbi, LFS) to f2fs_sb_has_blkzoned(sbi->sb) in 
this patch, which can
avoid punch discard (creating small discard) in zoned block device.

On 2018/7/13 11:26, Chao Yu wrote:
> On 2018/7/12 23:09, Yunlong Song wrote:
>> In lfs mode, it is better to submit and wait for discard of the
>> new_blkaddr's overall section, rather than punch it which makes
>> more small discards and is not friendly with flash alignment. And
>> f2fs does not have to wait discard of each new_blkaddr except for the
>> start_block of each section with this patch.
> For non-zoned block device, unaligned discard can be allowed; and if synchronous
> discard is very slow, it will block block allocator here, rather than that, I
> prefer just punch 4k lba of discard entry for performance.
>
> If you don't want to encounter this condition, I suggest issue large size
> discard more quickly.
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>   fs/f2fs/segment.h |  7 ++++-
>>   2 files changed, 75 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index f6c20e0..bce321a 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -893,7 +893,19 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
>>   static void f2fs_submit_discard_endio(struct bio *bio)
>>   {
>>   	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
>> +	struct f2fs_sb_info *sbi = F2FS_SB(dc->bdev->bd_super);
>>   
>> +	if (test_opt(sbi, LFS)) {
>> +		unsigned int segno = GET_SEGNO(sbi, dc->lstart);
>> +		unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>> +		int cnt = (dc->len >> sbi->log_blocks_per_seg) /
>> +				sbi->segs_per_sec;
>> +
>> +		while (cnt--) {
>> +			set_bit(secno, FREE_I(sbi)->discard_secmap);
>> +			secno++;
>> +		}
>> +	}
>>   	dc->error = blk_status_to_errno(bio->bi_status);
>>   	dc->state = D_DONE;
>>   	complete_all(&dc->wait);
>> @@ -1349,8 +1361,15 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>>   	dc = (struct discard_cmd *)f2fs_lookup_rb_tree(&dcc->root,
>>   							NULL, blkaddr);
>>   	if (dc) {
>> -		if (dc->state == D_PREP) {
>> +		if (dc->state == D_PREP && !test_opt(sbi, LFS))
>>   			__punch_discard_cmd(sbi, dc, blkaddr);
>> +		else if (dc->state == D_PREP && test_opt(sbi, LFS)) {
>> +			struct discard_policy dpolicy;
>> +
>> +			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
>> +			__submit_discard_cmd(sbi, &dpolicy, dc);
>> +			dc->ref++;
>> +			need_wait = true;
>>   		} else {
>>   			dc->ref++;
>>   			need_wait = true;
>> @@ -2071,9 +2090,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
>>   	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
>>   	unsigned int left_start = hint;
>> -	bool init = true;
>> +	bool init = true, check_discard = test_opt(sbi, LFS) ? true : false;
>>   	int go_left = 0;
>>   	int i;
>> +	unsigned long *free_secmap;
>>   
>>   	spin_lock(&free_i->segmap_lock);
>>   
>> @@ -2084,11 +2104,25 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   			goto got_it;
>>   	}
>>   find_other_zone:
>> -	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>> +	if (check_discard) {
>> +		int entries = f2fs_bitmap_size(MAIN_SECS(sbi)) / sizeof(unsigned long);
>> +
>> +		free_secmap = free_i->tmp_secmap;
>> +		for (i = 0; i < entries; i++)
>> +			free_secmap[i] = (!(free_i->free_secmap[i] ^
>> +				free_i->discard_secmap[i])) | free_i->free_secmap[i];
>> +	} else
>> +		free_secmap = free_i->free_secmap;
>> +
>> +	secno = find_next_zero_bit(free_secmap, MAIN_SECS(sbi), hint);
>>   	if (secno >= MAIN_SECS(sbi)) {
>>   		if (dir == ALLOC_RIGHT) {
>> -			secno = find_next_zero_bit(free_i->free_secmap,
>> +			secno = find_next_zero_bit(free_secmap,
>>   							MAIN_SECS(sbi), 0);
>> +			if (secno >= MAIN_SECS(sbi) && check_discard) {
>> +				check_discard = false;
>> +				goto find_other_zone;
>> +			}
>>   			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>>   		} else {
>>   			go_left = 1;
>> @@ -2098,13 +2132,17 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   	if (go_left == 0)
>>   		goto skip_left;
>>   
>> -	while (test_bit(left_start, free_i->free_secmap)) {
>> +	while (test_bit(left_start, free_secmap)) {
>>   		if (left_start > 0) {
>>   			left_start--;
>>   			continue;
>>   		}
>> -		left_start = find_next_zero_bit(free_i->free_secmap,
>> +		left_start = find_next_zero_bit(free_secmap,
>>   							MAIN_SECS(sbi), 0);
>> +		if (left_start >= MAIN_SECS(sbi) && check_discard) {
>> +			check_discard = false;
>> +			goto find_other_zone;
>> +		}
>>   		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
>>   		break;
>>   	}
>> @@ -2719,7 +2757,18 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>>   
>>   	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
>>   
>> -	f2fs_wait_discard_bio(sbi, *new_blkaddr);
>> +	if (test_opt(sbi, LFS)) {
>> +		unsigned int start_segno, secno;
>> +
>> +		secno = GET_SEC_FROM_SEG(sbi, curseg->segno);
>> +		start_segno = secno * sbi->segs_per_sec;
>> +		if (*new_blkaddr == START_BLOCK(sbi, start_segno) &&
>> +				!test_bit(secno, FREE_I(sbi)->discard_secmap))
>> +			f2fs_wait_discard_bio(sbi, *new_blkaddr);
>> +		f2fs_bug_on(sbi, !test_bit(secno, FREE_I(sbi)->discard_secmap));
>> +	}
>> +	else
>> +		f2fs_wait_discard_bio(sbi, *new_blkaddr);
>>   
>>   	/*
>>   	 * __add_sum_entry should be resided under the curseg_mutex
>> @@ -3648,10 +3697,21 @@ static int build_free_segmap(struct f2fs_sb_info *sbi)
>>   	if (!free_i->free_secmap)
>>   		return -ENOMEM;
>>   
>> +	free_i->discard_secmap = f2fs_kvmalloc(sbi, sec_bitmap_size, GFP_KERNEL);
>> +	if (!free_i->discard_secmap)
>> +		return -ENOMEM;
>> +
>> +	free_i->tmp_secmap = f2fs_kvmalloc(sbi, sec_bitmap_size, GFP_KERNEL);
>> +	if (!free_i->tmp_secmap)
>> +		return -ENOMEM;
>> +
>>   	/* set all segments as dirty temporarily */
>>   	memset(free_i->free_segmap, 0xff, bitmap_size);
>>   	memset(free_i->free_secmap, 0xff, sec_bitmap_size);
>>   
>> +	/* set all sections as discarded temporarily */
>> +	memset(free_i->discard_secmap, 0xff, sec_bitmap_size);
>> +
>>   	/* init free segmap information */
>>   	free_i->start_segno = GET_SEGNO_FROM_SEG0(sbi, MAIN_BLKADDR(sbi));
>>   	free_i->free_segments = 0;
>> @@ -4047,6 +4107,8 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
>>   	SM_I(sbi)->free_info = NULL;
>>   	kvfree(free_i->free_segmap);
>>   	kvfree(free_i->free_secmap);
>> +	kvfree(free_i->discard_secmap);
>> +	kvfree(free_i->tmp_secmap);
>>   	kfree(free_i);
>>   }
>>   
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 5049551..b37a909 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -259,6 +259,8 @@ struct free_segmap_info {
>>   	spinlock_t segmap_lock;		/* free segmap lock */
>>   	unsigned long *free_segmap;	/* free segment bitmap */
>>   	unsigned long *free_secmap;	/* free section bitmap */
>> +	unsigned long *discard_secmap;	/* discard section bitmap */
>> +	unsigned long *tmp_secmap;	/* bitmap for temporal use */
>>   };
>>   
>>   /* Notice: The order of dirty type is same with CURSEG_XXX in f2fs.h */
>> @@ -453,8 +455,11 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
>>   		next = find_next_bit(free_i->free_segmap,
>>   				start_segno + sbi->segs_per_sec, start_segno);
>>   		if (next >= start_segno + sbi->segs_per_sec) {
>> -			if (test_and_clear_bit(secno, free_i->free_secmap))
>> +			if (test_and_clear_bit(secno, free_i->free_secmap)) {
>>   				free_i->free_sections++;
>> +				if (test_opt(sbi, LFS))
>> +					clear_bit(secno, free_i->discard_secmap);
>> +			}
>>   		}
>>   	}
>>   skip_free:
>>
>
> .
>

-- 
Thanks,
Yunlong Song


