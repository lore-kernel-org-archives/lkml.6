Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A233ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221C220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221C220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbeGXRKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:10:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57933 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388397AbeGXRKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:10:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1A6391C7F3449;
        Wed, 25 Jul 2018 00:03:39 +0800 (CST)
Received: from [127.0.0.1] (10.111.220.140) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Wed, 25 Jul 2018
 00:03:32 +0800
Subject: Re: [PATCH 4/5] f2fs: let BG_GC check every dirty segments and gc
 over a threshold
To:     Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>,
        <yuchao0@huawei.com>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
 <1532355022-163029-5-git-send-email-yunlong.song@huawei.com>
 <866f57e1-ef22-112c-6386-f80a054d1e32@kernel.org>
From:   Yunlong Song <yunlong.song@huawei.com>
Message-ID: <b3d5e584-66ff-a0ef-8730-7091d47790fd@huawei.com>
Date:   Wed, 25 Jul 2018 00:01:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <866f57e1-ef22-112c-6386-f80a054d1e32@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/24 22:52, Chao Yu wrote:
> On 2018/7/23 22:10, Yunlong Song wrote:
>> BG_GC is triggered in idle time, so it is better check every dirty
>> segment and finds the best victim to gc. Otherwise, BG_GC will be
>> limited to only 8G areas, and probably select a victim which has nearly
> If 8GB range is not enough and just hard code now, we can export it in sysfs and
> do the configuration.
There is already a sysfs entry called max_victim_search, but the default 
value is defined
as DEF_MAX_VICTIM_SEARCH, i.e., 4096, equals to 8GB. So can we increase 
this default
value to UINT_MAX?
>
>> full of valid blocks, resulting a big WAI. Besides, we also add a
> BGGC should move cold data anway, if we only consider WA, hot data section can
> be selected with very high probability, but hot data can do OPU itself sooner or
> later, so moving them will cause higher WA.
Yes, but this problem also appears in the default 8G area, even in 8G 
area, perhaps there is
still a victim section which has fewest valid blocks but with hot data 
type. This patch adds
a bggc_threshold to avoid big WA and wishes SSR write data to the 
section whose threshold
is over bggc_threshold but with cold data type. Since the initial 
min_cost in BG_GC is valued
as UINT_MAX, BG_GC can always successfully select a victim and move 
blocks in common case,
but sometimes it is not needed, for example, there are already enough 
free sections and each
dirty section has same valid blocks, if BG_GC continue its job, then 
there is a big WA.

>
> I think the better way is we can export a sysfs entry to adjust factor to
> control weight of aging or valid block of section. So that, user can adjust it
> to select less valid block candidate first instead of high aging one.
How about export the bggc_threshold as sysfs entry, the default value is 
defined as the old
fggc_threshold, i.e., (main - ovp) / (main - rsvd) * BLKS_PER_SEC. User 
can adjust this value
to control the WA and non-WA requirement.

>
> Thanks,
>
>> bggc_threshold (which is the old "fggc_threshold", so revert commit
>> "299254") to stop BG_GC when there is no good choice. This is especially
>> good for large section case to reduce WAI.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/f2fs.h    |  2 ++
>>   fs/f2fs/gc.c      | 23 ++++++++++++++++++++---
>>   fs/f2fs/segment.h |  9 +++++++++
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index f8a7b42..24a9d7f 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1220,6 +1220,8 @@ struct f2fs_sb_info {
>>   	unsigned int cur_fg_victim_sec;		/* current FG_GC victim section num */
>>   	unsigned int cur_bg_victim_sec;		/* current BG_GC victim section num */
>>   	unsigned int gc_mode;			/* current GC state */
>> +	/* threshold for selecting bg victims */
>> +	u64 bggc_threshold;
>>   	/* for skip statistic */
>>   	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
>>   
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 0e7a265..21e8d59 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -189,9 +189,8 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>>   		p->ofs_unit = sbi->segs_per_sec;
>>   	}
>>   
>> -	/* we need to check every dirty segments in the FG_GC case */
>> -	if (gc_type != FG_GC &&
>> -			(sbi->gc_mode != GC_URGENT) &&
>> +	/* we need to check every dirty segments in the GC case */
>> +	if (p->alloc_mode == SSR &&
>>   			p->max_search > sbi->max_victim_search)
>>   		p->max_search = sbi->max_victim_search;
>>   
>> @@ -230,6 +229,10 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
>>   	for_each_set_bit(secno, dirty_i->victim_secmap, MAIN_SECS(sbi)) {
>>   		if (sec_usage_check(sbi, secno))
>>   			continue;
>> +
>> +		if (no_bggc_candidate(sbi, secno))
>> +			continue;
>> +
>>   		clear_bit(secno, dirty_i->victim_secmap);
>>   		return GET_SEG_FROM_SEC(sbi, secno);
>>   	}
>> @@ -368,6 +371,10 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>>   		if (sec_usage_check(sbi, secno))
>>   			goto next;
>>   
>> +		if (gc_type == BG_GC && p.alloc_mode == LFS &&
>> +					no_bggc_candidate(sbi, secno))
>> +			goto next;
>> +
>>   		cost = get_gc_cost(sbi, segno, &p);
>>   
>>   		if (p.min_cost > cost) {
>> @@ -1140,8 +1147,18 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>   
>>   void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
>>   {
>> +	u64 main_count, resv_count, ovp_count;
>> +
>>   	DIRTY_I(sbi)->v_ops = &default_v_ops;
>>   
>> +	/* threshold of # of valid blocks in a section for victims of BG_GC */
>> +	main_count = SM_I(sbi)->main_segments << sbi->log_blocks_per_seg;
>> +	resv_count = SM_I(sbi)->reserved_segments << sbi->log_blocks_per_seg;
>> +	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
>> +
>> +	sbi->bggc_threshold = div64_u64((main_count - ovp_count) *
>> +					BLKS_PER_SEC(sbi), (main_count - resv_count));
>> +
>>   	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
>>   
>>   	/* give warm/cold data area from slower device */
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index b21bb96..932e59b 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -785,6 +785,15 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
>>   				- (base + 1) + type;
>>   }
>>   
>> +static inline bool no_bggc_candidate(struct f2fs_sb_info *sbi,
>> +                        unsigned int secno)
>> +{
>> +    if (get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true) >
>> +                        sbi->bggc_threshold)
>> +        return true;
>> +    return false;
>> +}
>> +
>>   static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
>>   {
>>   	if (IS_CURSEC(sbi, secno) || (sbi->cur_fg_victim_sec == secno) ||
>>
> .
>

-- 
Thanks,
Yunlong Song


