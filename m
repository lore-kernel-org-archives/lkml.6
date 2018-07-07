Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B66C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD2F2255D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKm+lc3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD2F2255D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGGBLB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932374AbeGGBLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:11:00 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CC22254D;
        Sat,  7 Jul 2018 01:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530925860;
        bh=Ia9SYQ6yfphSm4TdHKWlOuxMyL7XirzkuO1yK43keys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKm+lc3ZoNKa3Zo0/+bMjN6RwJFxK1I31/3fOZKDw/Wr+nfJuTtH0mJwDTHHuLUK1
         3kH4FC+HktaGGHfwJetUxdwrmy1aW1Pjq8tYr3QiVE83KR9ujGPTYsV82i4SFqCrGY
         CkBAucGRmfZHnVbRKb3QUDprXteL1Wzk5qtfd7pc=
Date:   Fri, 6 Jul 2018 18:10:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: issue small discard by LBA order
Message-ID: <20180707011059.GC3767@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180705113701.3466-1-yuchao0@huawei.com>
 <20180705113701.3466-2-yuchao0@huawei.com>
 <20180706232345.GE77984@jaegeuk-macbookpro.roam.corp.google.com>
 <822c2d6b-1765-7956-2a30-09d0423e90a2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822c2d6b-1765-7956-2a30-09d0423e90a2@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/7/7 7:23, Jaegeuk Kim wrote:
> > On 07/05, Chao Yu wrote:
> >> For small granularity discard which size is smaller than 64KB, if we
> >> issue those kind of discards orderly by size, their IOs will be spread
> >> into entire logical address, so that in FTL, L2P table will be updated
> >> randomly, result bad wear rate in the table.
> >>
> >> In this patch, we choose to issue small discard by LBA order, by this
> >> way, we can expect that L2P table updates from adjacent discard IOs can
> >> be merged in the cache, so it can reduce lifetime wearing of flash.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/f2fs.h    |  2 ++
> >>  fs/f2fs/segment.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 73 insertions(+)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 47ac0a9b022f..8d592029328a 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -290,6 +290,7 @@ struct discard_policy {
> >>  	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
> >>  	bool io_aware;			/* issue discard in idle time */
> >>  	bool sync;			/* submit discard with REQ_SYNC flag */
> >> +	bool ordered;			/* issue discard by lba order */
> >>  	unsigned int granularity;	/* discard granularity */
> >>  };
> >>  
> >> @@ -306,6 +307,7 @@ struct discard_cmd_control {
> >>  	unsigned int max_discards;		/* max. discards to be issued */
> >>  	unsigned int discard_granularity;	/* discard granularity */
> >>  	unsigned int undiscard_blks;		/* # of undiscard blocks */
> >> +	unsigned int next_pos;			/* next discard position */
> >>  	atomic_t issued_discard;		/* # of issued discard */
> >>  	atomic_t issing_discard;		/* # of issing discard */
> >>  	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index f95bf618bc1e..df0d91dfb8ac 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -18,6 +18,7 @@
> >>  #include <linux/timer.h>
> >>  #include <linux/freezer.h>
> >>  #include <linux/sched/signal.h>
> >> +#include <linux/delay.h>
> > 
> > Why?
> 
> I forgot to remove this... will do it.
> 
> > 
> >>  
> >>  #include "f2fs.h"
> >>  #include "segment.h"
> >> @@ -936,6 +937,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
> >>  	/* common policy */
> >>  	dpolicy->type = discard_type;
> >>  	dpolicy->sync = true;
> >> +	dpolicy->ordered = false;
> >>  	dpolicy->granularity = granularity;
> >>  
> >>  	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
> >> @@ -947,6 +949,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
> >>  		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> >>  		dpolicy->io_aware = true;
> >>  		dpolicy->sync = false;
> >> +		dpolicy->ordered = true;
> >>  		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
> >>  			dpolicy->granularity = 1;
> >>  			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> >> @@ -1202,6 +1205,69 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
> >>  	return 0;
> >>  }
> >>  
> >> +static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> >> +					struct discard_policy *dpolicy)
> >> +{
> >> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> >> +	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> >> +	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> >> +	struct discard_cmd *dc;
> >> +	struct blk_plug plug;
> >> +	unsigned int pos = dcc->next_pos;
> >> +	unsigned int issued = 0, iter = 0;
> >> +	bool io_interrupted;
> >> +
> >> +	mutex_lock(&dcc->cmd_lock);
> >> +	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
> >> +					NULL, pos,
> >> +					(struct rb_entry **)&prev_dc,
> >> +					(struct rb_entry **)&next_dc,
> >> +					&insert_p, &insert_parent, true);
> >> +	if (!dc)
> >> +		dc = next_dc;
> >> +
> >> +	blk_start_plug(&plug);
> >> +
> >> +	while (dc) {
> >> +		struct rb_node *node;
> >> +
> >> +		if (dc->state != D_PREP)
> >> +			goto next;
> >> +retry:
> >> +		io_interrupted = false;
> >> +
> >> +		if (dpolicy->io_aware && !is_idle(sbi)) {
> >> +			io_interrupted = true;
> >> +			goto skip;
> > 
> > Please don't try, if user is doing something.
> 
> Just use 'break' instead of 'goto skip' here?

Yes, likewise as is.

> 
> > 
> >> +		}
> >> +
> >> +		__submit_discard_cmd(sbi, dpolicy, dc);
> >> +		issued++;
> >> +		dcc->next_pos = dc->lstart + dc->len;
> >> +skip:
> >> +		if (++iter >= dpolicy->max_requests)
> >> +			break;
> >> +
> >> +		if (io_interrupted)
> >> +			goto retry;
> >> +next:
> >> +		node = rb_next(&dc->rb_node);
> >> +		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> >> +	}
> >> +
> >> +	blk_finish_plug(&plug);
> >> +
> >> +	if (!dc)
> >> +		dcc->next_pos = 0;
> >> +
> >> +	mutex_unlock(&dcc->cmd_lock);
> >> +
> >> +	if (!issued && io_interrupted)
> >> +		issued = -1;
> >> +
> >> +	return issued;
> >> +}
> >> +
> >>  static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >>  					struct discard_policy *dpolicy)
> >>  {
> >> @@ -1215,6 +1281,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> >>  		if (i + 1 < dpolicy->granularity)
> >>  			break;
> >> +
> >> +		if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
> >> +			return __issue_discard_cmd_orderly(sbi, dpolicy);
> > 
> > So, at this moment, we usually expect there'd be a bunch of small candidates
> > only, and thus, it'd be better to issue small chunks in LBA order?
> 
> Yes, that's right. :)
> 
> Thanks,
> 
> > 
> >> +
> >>  		pend_list = &dcc->pend_list[i];
> >>  
> >>  		mutex_lock(&dcc->cmd_lock);
> >> @@ -1786,6 +1856,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
> >>  	dcc->nr_discards = 0;
> >>  	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
> >>  	dcc->undiscard_blks = 0;
> >> +	dcc->next_pos = 0;
> >>  	dcc->root = RB_ROOT;
> >>  	dcc->rbtree_check = false;
> >>  
> >> -- 
> >> 2.18.0.rc1
