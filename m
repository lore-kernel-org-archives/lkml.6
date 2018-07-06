Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7571022B26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+d90xCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7571022B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeGFWpf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754151AbeGFWpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:45:34 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82762254A;
        Fri,  6 Jul 2018 22:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530917134;
        bh=m1AHk0kxn8cU6eoYLpljWt81Wyc9fqlz4RpKYugmF2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+d90xCPiF+zqVDlHegibjwHqjKpGgBuCkRDZXkPGBsEuB1Ya128nNWigOfoShEjz
         0uB52UbnB7klPjbX9lS/5GhjXsjahYKKlKOJruFOt2WPrsRAr1O7ACBQhS2C7Ob0f2
         Rbss21pLDAKme38mrKHQygB2bphSTOw0PX0ZZ3x4=
Date:   Fri, 6 Jul 2018 15:45:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: split discard command in prior to block layer
Message-ID: <20180706224533.GC77984@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180704153746.2510-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704153746.2510-1-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Some devices has small max_{hw,}discard_sectors, so that in
> __blkdev_issue_discard(), one big size discard bio can be split
> into multiple small size discard bios, result in heavy load in IO
> scheduler and device, which can hang other sync IO for long time.
> 
> Now, f2fs is trying to control discard commands more elaboratively,
> in order to make less conflict in between discard IO and user IO
> to enhance application's performance, so in this patch, we will
> split discard bio in f2fs in prior to in block layer to reduce
> issuing multiple discard bios in a short time.

Hi Chao,

In terms of # of candidates, can we control this when actually issuing
the discard commands?

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h    | 13 ++++++-------
>  fs/f2fs/segment.c | 25 ++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a9da5a089cb4..a09d2b2d9520 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -178,7 +178,6 @@ enum {
>  
>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
> -#define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
>  #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
>  #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
>  #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
> @@ -701,22 +700,22 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
>  }
>  
>  static inline bool __is_discard_mergeable(struct discard_info *back,
> -						struct discard_info *front)
> +			struct discard_info *front, unsigned int max_len)
>  {
>  	return (back->lstart + back->len == front->lstart) &&
> -		(back->len + front->len < DEF_MAX_DISCARD_LEN);
> +		(back->len + front->len <= max_len);
>  }
>  
>  static inline bool __is_discard_back_mergeable(struct discard_info *cur,
> -						struct discard_info *back)
> +			struct discard_info *back, unsigned int max_len)
>  {
> -	return __is_discard_mergeable(back, cur);
> +	return __is_discard_mergeable(back, cur, max_len);
>  }
>  
>  static inline bool __is_discard_front_mergeable(struct discard_info *cur,
> -						struct discard_info *front)
> +			struct discard_info *front, unsigned int max_len)
>  {
> -	return __is_discard_mergeable(cur, front);
> +	return __is_discard_mergeable(cur, front, max_len);
>  }
>  
>  static inline bool __is_extent_mergeable(struct extent_info *back,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4648561e2bfd..8e417a12684d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1086,6 +1086,9 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  	struct discard_cmd *dc;
>  	struct discard_info di = {0};
>  	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	unsigned int max_discard_blocks =
> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
>  	block_t end = lstart + len;
>  
>  	mutex_lock(&dcc->cmd_lock);
> @@ -1129,7 +1132,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  
>  		if (prev_dc && prev_dc->state == D_PREP &&
>  			prev_dc->bdev == bdev &&
> -			__is_discard_back_mergeable(&di, &prev_dc->di)) {
> +			__is_discard_back_mergeable(&di, &prev_dc->di,
> +							max_discard_blocks)) {
>  			prev_dc->di.len += di.len;
>  			dcc->undiscard_blks += di.len;
>  			__relocate_discard_cmd(dcc, prev_dc);
> @@ -1140,7 +1144,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  
>  		if (next_dc && next_dc->state == D_PREP &&
>  			next_dc->bdev == bdev &&
> -			__is_discard_front_mergeable(&di, &next_dc->di)) {
> +			__is_discard_front_mergeable(&di, &next_dc->di,
> +							max_discard_blocks)) {
>  			next_dc->di.lstart = di.lstart;
>  			next_dc->di.len += di.len;
>  			next_dc->di.start = di.start;
> @@ -1170,7 +1175,11 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>  		struct block_device *bdev, block_t blkstart, block_t blklen)
>  {
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	unsigned int max_discard_blocks =
> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
>  	block_t lblkstart = blkstart;
> +	block_t total_len = blklen;
>  
>  	trace_f2fs_queue_discard(bdev, blkstart, blklen);
>  
> @@ -1179,7 +1188,17 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>  
>  		blkstart -= FDEV(devi).start_blk;
>  	}
> -	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
> +
> +	while (total_len) {
> +		if (blklen > max_discard_blocks)
> +			blklen = max_discard_blocks;
> +		__update_discard_tree_range(sbi, bdev, lblkstart,
> +						blkstart, blklen);
> +		lblkstart += blklen;
> +		blkstart += blklen;
> +		total_len -= blklen;
> +		blklen = total_len;
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.16.2.17.g38e79b1fd
