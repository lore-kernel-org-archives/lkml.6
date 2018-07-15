Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE89ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003A4208CC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="00xB6NhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003A4208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbeGODec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 23:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732717AbeGODec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 23:34:32 -0400
Received: from localhost (unknown [104.132.152.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26BB52089F;
        Sun, 15 Jul 2018 03:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531624391;
        bh=oN4zGWyAW7wnFdERo2Fd0oT+ycizu/Y4vgqKqkoZu2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=00xB6NhHJ4kR2My658j87wnOsKBA9XlEAA6r0Rd/rJeHdTlxX5vhQApI2LXQowqda
         OwleVe+afRaZ+CRsqhwQexTnJjukk33Z/WCxW8tNtY++TWJ4y4TlIm37ur8ubCFZFK
         ohqCwf24v/Xj2AYurrztvrMbeb+bENDB9PjitSMA=
Date:   Sun, 15 Jul 2018 12:13:08 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: split discard command in prior to block layer
Message-ID: <20180715031308.GI11571@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180708141433.24182-1-chao@kernel.org>
 <20180715012700.GA11571@jaegeuk-macbookpro.roam.corp.google.com>
 <4f2fafdd-eb5a-0dcd-272b-65aac5080677@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2fafdd-eb5a-0dcd-272b-65aac5080677@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/15, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/7/15 9:27, Jaegeuk Kim wrote:
> > On 07/08, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> Some devices has small max_{hw,}discard_sectors, so that in
> >> __blkdev_issue_discard(), one big size discard bio can be split
> >> into multiple small size discard bios, result in heavy load in IO
> >> scheduler and device, which can hang other sync IO for long time.
> >>
> >> Now, f2fs is trying to control discard commands more elaboratively,
> >> in order to make less conflict in between discard IO and user IO
> >> to enhance application's performance, so in this patch, we will
> >> split discard bio in f2fs in prior to in block layer to reduce
> >> issuing multiple discard bios in a short time.
> > 
> > Can we just change __submit_discard_cmd() to submit the large candidate
> > partially and adjust lstart in the original candidate?
> 
> Yep, could you check __submit_discard_cmd() implementation below? Does that
> match the thoughts from you?
> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >> v2:
> >> - change to split discard command entry before submission.
> >>  fs/f2fs/f2fs.h    |  13 +++---
> >>  fs/f2fs/segment.c | 117 +++++++++++++++++++++++++++++++++++++-----------------
> >>  2 files changed, 86 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index c48b655d5d8d..359526d88d3f 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -178,7 +178,6 @@ enum {
> >>  
> >>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
> >>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
> >> -#define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
> >>  #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
> >>  #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
> >>  #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
> >> @@ -709,22 +708,22 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
> >>  }
> >>  
> >>  static inline bool __is_discard_mergeable(struct discard_info *back,
> >> -						struct discard_info *front)
> >> +			struct discard_info *front, unsigned int max_len)
> >>  {
> >>  	return (back->lstart + back->len == front->lstart) &&
> >> -		(back->len + front->len < DEF_MAX_DISCARD_LEN);
> >> +		(back->len + front->len <= max_len);
> >>  }
> >>  
> >>  static inline bool __is_discard_back_mergeable(struct discard_info *cur,
> >> -						struct discard_info *back)
> >> +			struct discard_info *back, unsigned int max_len)
> >>  {
> >> -	return __is_discard_mergeable(back, cur);
> >> +	return __is_discard_mergeable(back, cur, max_len);
> >>  }
> >>  
> >>  static inline bool __is_discard_front_mergeable(struct discard_info *cur,
> >> -						struct discard_info *front)
> >> +			struct discard_info *front, unsigned int max_len)
> >>  {
> >> -	return __is_discard_mergeable(cur, front);
> >> +	return __is_discard_mergeable(cur, front, max_len);
> >>  }
> >>  
> >>  static inline bool __is_extent_mergeable(struct extent_info *back,
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index f7f56dd091b4..cbf8f3f9a8e7 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -966,17 +966,24 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
> >>  	}
> >>  }
> >>  
> >> -

===================== BEGIN

> >> +static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
> >> +				struct block_device *bdev, block_t lstart,
> >> +				block_t start, block_t len);
> >>  /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
> >>  static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
> >>  						struct discard_policy *dpolicy,
> >> -						struct discard_cmd *dc)
> >> +						struct discard_cmd *dc,
> >> +						unsigned int *issued)
> >>  {
> >> +	struct block_device *bdev = dc->bdev;
> >> +	struct request_queue *q = bdev_get_queue(bdev);
> >> +	unsigned int max_discard_blocks =
> >> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
> >>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> >>  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> >>  					&(dcc->fstrim_list) : &(dcc->wait_list);
> >> -	struct bio *bio = NULL;
> >>  	int flag = dpolicy->sync ? REQ_SYNC : 0;
> >> +	block_t lstart, start, len, total_len;
> >>  
> >>  	if (dc->state != D_PREP)
> >>  		return;
> >> @@ -984,30 +991,63 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
> >>  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> >>  		return;
> >>  
> >> -	trace_f2fs_issue_discard(dc->bdev, dc->start, dc->len);
> >> -
> >> -	dc->error = __blkdev_issue_discard(dc->bdev,
> >> -				SECTOR_FROM_BLOCK(dc->start),
> >> -				SECTOR_FROM_BLOCK(dc->len),
> >> -				GFP_NOFS, 0, &bio);
> >> -	if (!dc->error) {
> >> -		/* should keep before submission to avoid D_DONE right away */
> >> -		dc->state = D_SUBMIT;
> >> -		atomic_inc(&dcc->issued_discard);
> >> -		atomic_inc(&dcc->issing_discard);
> >> -		if (bio) {
> >> -			bio->bi_private = dc;
> >> -			bio->bi_end_io = f2fs_submit_discard_endio;
> >> -			bio->bi_opf |= flag;
> >> -			submit_bio(bio);
> >> -			list_move_tail(&dc->list, wait_list);
> >> -			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
> >> -
> >> -			f2fs_update_iostat(sbi, FS_DISCARD, 1);
> >> +	trace_f2fs_issue_discard(bdev, dc->start, dc->len);
> >> +
> >> +	lstart = dc->lstart;
> >> +	start = dc->start;
> >> +	len = dc->len;
> >> +	total_len = len;
> >> +
> >> +	while (total_len && *issued < dpolicy->max_requests) {
> >> +		struct bio *bio = NULL;
> >> +
> >> +		if (len > max_discard_blocks)
> >> +			len = max_discard_blocks;
> >> +
> >> +		dc->error = __blkdev_issue_discard(bdev,
> >> +					SECTOR_FROM_BLOCK(start),
> >> +					SECTOR_FROM_BLOCK(len),
> >> +					GFP_NOFS, 0, &bio);
> >> +		if (!dc->error) {
> >> +			/*
> >> +			 * should keep before submission to avoid D_DONE
> >> +			 * right away
> >> +			 */
> >> +			dc->state = D_SUBMIT;
> >> +			dc->len = len;
> >> +			atomic_inc(&dcc->issued_discard);
> >> +			atomic_inc(&dcc->issing_discard);
> >> +			if (bio) {
> >> +				bio->bi_private = dc;
> >> +				bio->bi_end_io = f2fs_submit_discard_endio;
> >> +				bio->bi_opf |= flag;
> >> +				submit_bio(bio);
> >> +				list_move_tail(&dc->list, wait_list);
> >> +				__check_sit_bitmap(sbi, dc->start,
> >> +							dc->start + dc->len);
> >> +
> >> +				f2fs_update_iostat(sbi, FS_DISCARD, 1);
> >> +			}
> >> +		} else {
> >> +			__remove_discard_cmd(sbi, dc);

Keep the original one, since it's partially failed?

> >> +			return;
> >> +		}
> >> +		lstart += len;
> >> +		start += len;
> >> +		total_len -= len;
> >> +		len = total_len;
> >> +		(*issued)++;
> >> +
> >> +		if (len) {
> >> +			__update_discard_tree_range(sbi, bdev, lstart,
> >> +								start, len);

Do we really need this? We already grabbed one candidate which was not merged
well.

> >> +			dc = (struct discard_cmd *)f2fs_lookup_rb_tree(
> >> +						&dcc->root, NULL, lstart);
> >> +			f2fs_bug_on(sbi, !dc);
> >>  		}
> >> -	} else {
> >> -		__remove_discard_cmd(sbi, dc);
> >>  	}
> >> +
> >> +	return;
> >>  }

======================= END


> >>  
> >>  static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
> >> @@ -1088,10 +1128,11 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
> >>  	struct discard_cmd *dc;
> >>  	struct discard_info di = {0};
> >>  	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> >> +	struct request_queue *q = bdev_get_queue(bdev);
> >> +	unsigned int max_discard_blocks =
> >> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
> >>  	block_t end = lstart + len;
> >>  
> >> -	mutex_lock(&dcc->cmd_lock);
> >> -
> >>  	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
> >>  					NULL, lstart,
> >>  					(struct rb_entry **)&prev_dc,
> >> @@ -1131,7 +1172,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
> >>  
> >>  		if (prev_dc && prev_dc->state == D_PREP &&
> >>  			prev_dc->bdev == bdev &&
> >> -			__is_discard_back_mergeable(&di, &prev_dc->di)) {
> >> +			__is_discard_back_mergeable(&di, &prev_dc->di,
> >> +							max_discard_blocks)) {
> >>  			prev_dc->di.len += di.len;
> >>  			dcc->undiscard_blks += di.len;
> >>  			__relocate_discard_cmd(dcc, prev_dc);
> >> @@ -1142,7 +1184,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
> >>  
> >>  		if (next_dc && next_dc->state == D_PREP &&
> >>  			next_dc->bdev == bdev &&
> >> -			__is_discard_front_mergeable(&di, &next_dc->di)) {
> >> +			__is_discard_front_mergeable(&di, &next_dc->di,
> >> +							max_discard_blocks)) {
> >>  			next_dc->di.lstart = di.lstart;
> >>  			next_dc->di.len += di.len;
> >>  			next_dc->di.start = di.start;
> >> @@ -1165,8 +1208,6 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
> >>  		node = rb_next(&prev_dc->rb_node);
> >>  		next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> >>  	}
> >> -
> >> -	mutex_unlock(&dcc->cmd_lock);
> >>  }
> >>  
> >>  static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
> >> @@ -1181,7 +1222,9 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
> >>  
> >>  		blkstart -= FDEV(devi).start_blk;
> >>  	}
> >> +	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
> >>  	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
> >> +	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
> >>  	return 0;
> >>  }
> >>  
> >> @@ -1220,9 +1263,9 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> >>  		}
> >>  
> >>  		dcc->next_pos = dc->lstart + dc->len;
> >> -		__submit_discard_cmd(sbi, dpolicy, dc);
> >> +		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> >>  
> >> -		if (++issued >= dpolicy->max_requests)
> >> +		if (issued >= dpolicy->max_requests)
> >>  			break;
> >>  next:
> >>  		node = rb_next(&dc->rb_node);
> >> @@ -1277,9 +1320,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >>  				break;
> >>  			}
> >>  
> >> -			__submit_discard_cmd(sbi, dpolicy, dc);
> >> +			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> >>  
> >> -			if (++issued >= dpolicy->max_requests)
> >> +			if (issued >= dpolicy->max_requests)
> >>  				break;
> >>  		}
> >>  		blk_finish_plug(&plug);
> >> @@ -2475,9 +2518,9 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
> >>  			goto skip;
> >>  		}
> >>  
> >> -		__submit_discard_cmd(sbi, dpolicy, dc);
> >> +		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> >>  
> >> -		if (++issued >= dpolicy->max_requests) {
> >> +		if (issued >= dpolicy->max_requests) {
> >>  			start = dc->lstart + dc->len;
> >>  
> >>  			blk_finish_plug(&plug);
> >> -- 
> >> 2.16.2.17.g38e79b1fd
