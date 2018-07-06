Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E51C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FDA22B46
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYbRIQVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FDA22B46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeGFXfi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932774AbeGFXfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:35:36 -0400
Received: from [192.168.0.101] (unknown [49.77.239.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D7322B40;
        Fri,  6 Jul 2018 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530920135;
        bh=W/YLi+rWc9tLRut1WfqxOyoEeWdT6fIBTBXTY5JGbBc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oYbRIQVk4BU+utMuf6+zcn00QnPws/RbAyFV1GUcCaGz0wjl8/wtfbRnF5aVOu/ZS
         Zq40eU2MzjH3db7+4dpf1nf0pDMEdGRVIi7dgLUQOVGXl1zCTnh2bI8YFgCBsCnYB3
         fjuFVio7aUSAedE0rxfQCC9qP32ECmSXqhrMYfq4=
Subject: Re: [PATCH] f2fs: split discard command in prior to block layer
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
References: <20180704153746.2510-1-chao@kernel.org>
 <20180706224533.GC77984@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fd8f7ecb-a1e7-7e10-f6c6-2b908cf9841b@kernel.org>
Date:   Sat, 7 Jul 2018 07:35:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706224533.GC77984@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2018/7/7 6:45, Jaegeuk Kim wrote:
> On 07/04, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Some devices has small max_{hw,}discard_sectors, so that in
>> __blkdev_issue_discard(), one big size discard bio can be split
>> into multiple small size discard bios, result in heavy load in IO
>> scheduler and device, which can hang other sync IO for long time.
>>
>> Now, f2fs is trying to control discard commands more elaboratively,
>> in order to make less conflict in between discard IO and user IO
>> to enhance application's performance, so in this patch, we will
>> split discard bio in f2fs in prior to in block layer to reduce
>> issuing multiple discard bios in a short time.
> 
> Hi Chao,
> 
> In terms of # of candidates, can we control this when actually issuing
> the discard commands?

IIUC, you mean once we pick one discard entry in rbtree, if
max_{hw,}discard_sectors is smaller than size of this discard, then we can split
it into smaller ones by discard_sectors, and just issue one or partials of them?

Thanks,

> 
> Thanks,
> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h    | 13 ++++++-------
>>  fs/f2fs/segment.c | 25 ++++++++++++++++++++++---
>>  2 files changed, 28 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index a9da5a089cb4..a09d2b2d9520 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -178,7 +178,6 @@ enum {
>>  
>>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
>>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
>> -#define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
>>  #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
>>  #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
>>  #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
>> @@ -701,22 +700,22 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
>>  }
>>  
>>  static inline bool __is_discard_mergeable(struct discard_info *back,
>> -						struct discard_info *front)
>> +			struct discard_info *front, unsigned int max_len)
>>  {
>>  	return (back->lstart + back->len == front->lstart) &&
>> -		(back->len + front->len < DEF_MAX_DISCARD_LEN);
>> +		(back->len + front->len <= max_len);
>>  }
>>  
>>  static inline bool __is_discard_back_mergeable(struct discard_info *cur,
>> -						struct discard_info *back)
>> +			struct discard_info *back, unsigned int max_len)
>>  {
>> -	return __is_discard_mergeable(back, cur);
>> +	return __is_discard_mergeable(back, cur, max_len);
>>  }
>>  
>>  static inline bool __is_discard_front_mergeable(struct discard_info *cur,
>> -						struct discard_info *front)
>> +			struct discard_info *front, unsigned int max_len)
>>  {
>> -	return __is_discard_mergeable(cur, front);
>> +	return __is_discard_mergeable(cur, front, max_len);
>>  }
>>  
>>  static inline bool __is_extent_mergeable(struct extent_info *back,
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 4648561e2bfd..8e417a12684d 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1086,6 +1086,9 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>  	struct discard_cmd *dc;
>>  	struct discard_info di = {0};
>>  	struct rb_node **insert_p = NULL, *insert_parent = NULL;
>> +	struct request_queue *q = bdev_get_queue(bdev);
>> +	unsigned int max_discard_blocks =
>> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
>>  	block_t end = lstart + len;
>>  
>>  	mutex_lock(&dcc->cmd_lock);
>> @@ -1129,7 +1132,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>  
>>  		if (prev_dc && prev_dc->state == D_PREP &&
>>  			prev_dc->bdev == bdev &&
>> -			__is_discard_back_mergeable(&di, &prev_dc->di)) {
>> +			__is_discard_back_mergeable(&di, &prev_dc->di,
>> +							max_discard_blocks)) {
>>  			prev_dc->di.len += di.len;
>>  			dcc->undiscard_blks += di.len;
>>  			__relocate_discard_cmd(dcc, prev_dc);
>> @@ -1140,7 +1144,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>  
>>  		if (next_dc && next_dc->state == D_PREP &&
>>  			next_dc->bdev == bdev &&
>> -			__is_discard_front_mergeable(&di, &next_dc->di)) {
>> +			__is_discard_front_mergeable(&di, &next_dc->di,
>> +							max_discard_blocks)) {
>>  			next_dc->di.lstart = di.lstart;
>>  			next_dc->di.len += di.len;
>>  			next_dc->di.start = di.start;
>> @@ -1170,7 +1175,11 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>  static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>>  		struct block_device *bdev, block_t blkstart, block_t blklen)
>>  {
>> +	struct request_queue *q = bdev_get_queue(bdev);
>> +	unsigned int max_discard_blocks =
>> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
>>  	block_t lblkstart = blkstart;
>> +	block_t total_len = blklen;
>>  
>>  	trace_f2fs_queue_discard(bdev, blkstart, blklen);
>>  
>> @@ -1179,7 +1188,17 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>>  
>>  		blkstart -= FDEV(devi).start_blk;
>>  	}
>> -	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
>> +
>> +	while (total_len) {
>> +		if (blklen > max_discard_blocks)
>> +			blklen = max_discard_blocks;
>> +		__update_discard_tree_range(sbi, bdev, lblkstart,
>> +						blkstart, blklen);
>> +		lblkstart += blklen;
>> +		blkstart += blklen;
>> +		total_len -= blklen;
>> +		blklen = total_len;
>> +	}
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.16.2.17.g38e79b1fd
