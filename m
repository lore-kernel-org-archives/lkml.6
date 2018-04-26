Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756845AbeDZQIX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754462AbeDZQIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:08:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323B421745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Thu, 26 Apr 2018 10:08:19 -0600
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: maintain discard interface separately
Message-ID: <20180426160819.GI68594@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180425093831.124591-1-yuchao0@huawei.com>
 <20180425093831.124591-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425093831.124591-3-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25, Chao Yu wrote:
> This patch adds a new file discard.c to maintain discard related
> function separately.

I don't think we need this at all.
Thanks,

> 
> BTW, fix below checkpatch errors:
> 
> ERROR: space required before the open brace '{'
> +		} else if (issued == -1){
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> +				devi, sbi->s_ndevs ? FDEV(devi).path: "",
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/Makefile  |    2 +-
>  fs/f2fs/discard.c | 1009 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h    |   34 +-
>  fs/f2fs/segment.c |  991 +---------------------------------------------------
>  4 files changed, 1037 insertions(+), 999 deletions(-)
>  create mode 100644 fs/f2fs/discard.c
> 
> diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
> index 776c4b936504..43513c7b69aa 100644
> --- a/fs/f2fs/Makefile
> +++ b/fs/f2fs/Makefile
> @@ -3,7 +3,7 @@ obj-$(CONFIG_F2FS_FS) += f2fs.o
>  
>  f2fs-y		:= dir.o file.o inode.o namei.o hash.o super.o inline.o
>  f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
> -f2fs-y		+= shrinker.o extent_cache.o sysfs.o
> +f2fs-y		+= shrinker.o extent_cache.o sysfs.o discard.o
>  f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
>  f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
>  f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
> diff --git a/fs/f2fs/discard.c b/fs/f2fs/discard.c
> new file mode 100644
> index 000000000000..af6efb3c797b
> --- /dev/null
> +++ b/fs/f2fs/discard.c
> @@ -0,0 +1,1009 @@
> +/*
> + * f2fs discard support
> + *
> + * Copyright (c) 2018 Chao Yu <chao@kernel.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/f2fs_fs.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
> +#include <linux/sched/signal.h>
> +
> +#include "f2fs.h"
> +#include "segment.h"
> +#include "gc.h"
> +#include <trace/events/f2fs.h>
> +
> +static struct kmem_cache *discard_entry_slab;
> +static struct kmem_cache *discard_cmd_slab;
> +
> +static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
> +		struct block_device *bdev, block_t lstart,
> +		block_t start, block_t len)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct list_head *pend_list;
> +	struct discard_cmd *dc;
> +
> +	f2fs_bug_on(sbi, !len);
> +
> +	pend_list = &dcc->pend_list[plist_idx(len)];
> +
> +	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
> +	INIT_LIST_HEAD(&dc->list);
> +	dc->bdev = bdev;
> +	dc->lstart = lstart;
> +	dc->start = start;
> +	dc->len = len;
> +	dc->ref = 0;
> +	dc->state = D_PREP;
> +	dc->error = 0;
> +	init_completion(&dc->wait);
> +	list_add_tail(&dc->list, pend_list);
> +	atomic_inc(&dcc->discard_cmd_cnt);
> +	dcc->undiscard_blks += len;
> +
> +	return dc;
> +}
> +
> +static struct discard_cmd *__attach_discard_cmd(struct f2fs_sb_info *sbi,
> +				struct block_device *bdev, block_t lstart,
> +				block_t start, block_t len,
> +				struct rb_node *parent, struct rb_node **p)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_cmd *dc;
> +
> +	dc = __create_discard_cmd(sbi, bdev, lstart, start, len);
> +
> +	rb_link_node(&dc->rb_node, parent, p);
> +	rb_insert_color(&dc->rb_node, &dcc->root);
> +
> +	return dc;
> +}
> +
> +static void __detach_discard_cmd(struct discard_cmd_control *dcc,
> +							struct discard_cmd *dc)
> +{
> +	if (dc->state == D_DONE)
> +		atomic_dec(&dcc->issing_discard);
> +
> +	list_del(&dc->list);
> +	rb_erase(&dc->rb_node, &dcc->root);
> +	dcc->undiscard_blks -= dc->len;
> +
> +	kmem_cache_free(discard_cmd_slab, dc);
> +
> +	atomic_dec(&dcc->discard_cmd_cnt);
> +}
> +
> +static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
> +							struct discard_cmd *dc)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
> +	trace_f2fs_remove_discard(dc->bdev, dc->start, dc->len);
> +
> +	f2fs_bug_on(sbi, dc->ref);
> +
> +	if (dc->error == -EOPNOTSUPP)
> +		dc->error = 0;
> +
> +	if (dc->error)
> +		f2fs_msg(sbi->sb, KERN_INFO,
> +			"Issue discard(%u, %u, %u) failed, ret: %d",
> +			dc->lstart, dc->start, dc->len, dc->error);
> +	__detach_discard_cmd(dcc, dc);
> +}
> +
> +static void f2fs_submit_discard_endio(struct bio *bio)
> +{
> +	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> +
> +	dc->error = blk_status_to_errno(bio->bi_status);
> +	dc->state = D_DONE;
> +	complete_all(&dc->wait);
> +	bio_put(bio);
> +}
> +
> +static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> +				block_t start, block_t end)
> +{
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	struct seg_entry *sentry;
> +	unsigned int segno;
> +	block_t blk = start;
> +	unsigned long offset, size, max_blocks = sbi->blocks_per_seg;
> +	unsigned long *map;
> +
> +	while (blk < end) {
> +		segno = GET_SEGNO(sbi, blk);
> +		sentry = get_seg_entry(sbi, segno);
> +		offset = GET_BLKOFF_FROM_SEG0(sbi, blk);
> +
> +		if (end < START_BLOCK(sbi, segno + 1))
> +			size = GET_BLKOFF_FROM_SEG0(sbi, end);
> +		else
> +			size = max_blocks;
> +		map = (unsigned long *)(sentry->cur_valid_map);
> +		offset = __find_rev_next_bit(map, size, offset);
> +		f2fs_bug_on(sbi, offset != size);
> +		blk = START_BLOCK(sbi, segno + 1);
> +	}
> +#endif
> +}
> +
> +/* this function is copied from blkdev_issue_discard from block/blk-lib.c */
> +static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
> +						struct discard_policy *dpolicy,
> +						struct discard_cmd *dc)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> +					&(dcc->fstrim_list) : &(dcc->wait_list);
> +	struct bio *bio = NULL;
> +	int flag = dpolicy->sync ? REQ_SYNC : 0;
> +
> +	if (dc->state != D_PREP)
> +		return;
> +
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> +		return;
> +
> +	trace_f2fs_issue_discard(dc->bdev, dc->start, dc->len);
> +
> +	dc->error = __blkdev_issue_discard(dc->bdev,
> +				SECTOR_FROM_BLOCK(dc->start),
> +				SECTOR_FROM_BLOCK(dc->len),
> +				GFP_NOFS, 0, &bio);
> +	if (!dc->error) {
> +		/* should keep before submission to avoid D_DONE right away */
> +		dc->state = D_SUBMIT;
> +		atomic_inc(&dcc->issued_discard);
> +		atomic_inc(&dcc->issing_discard);
> +		if (bio) {
> +			bio->bi_private = dc;
> +			bio->bi_end_io = f2fs_submit_discard_endio;
> +			bio->bi_opf |= flag;
> +			submit_bio(bio);
> +			list_move_tail(&dc->list, wait_list);
> +			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
> +
> +			f2fs_update_iostat(sbi, FS_DISCARD, 1);
> +		}
> +	} else {
> +		__remove_discard_cmd(sbi, dc);
> +	}
> +}
> +
> +static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
> +				struct block_device *bdev, block_t lstart,
> +				block_t start, block_t len,
> +				struct rb_node **insert_p,
> +				struct rb_node *insert_parent)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct rb_node **p;
> +	struct rb_node *parent = NULL;
> +	struct discard_cmd *dc = NULL;
> +
> +	if (insert_p && insert_parent) {
> +		parent = insert_parent;
> +		p = insert_p;
> +		goto do_insert;
> +	}
> +
> +	p = __lookup_rb_tree_for_insert(sbi, &dcc->root, &parent, lstart);
> +do_insert:
> +	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent, p);
> +	if (!dc)
> +		return NULL;
> +
> +	return dc;
> +}
> +
> +static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
> +						struct discard_cmd *dc)
> +{
> +	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->len)]);
> +}
> +
> +static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
> +				struct discard_cmd *dc, block_t blkaddr)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_info di = dc->di;
> +	bool modified = false;
> +
> +	if (dc->state == D_DONE || dc->len == 1) {
> +		__remove_discard_cmd(sbi, dc);
> +		return;
> +	}
> +
> +	dcc->undiscard_blks -= di.len;
> +
> +	if (blkaddr > di.lstart) {
> +		dc->len = blkaddr - dc->lstart;
> +		dcc->undiscard_blks += dc->len;
> +		__relocate_discard_cmd(dcc, dc);
> +		modified = true;
> +	}
> +
> +	if (blkaddr < di.lstart + di.len - 1) {
> +		if (modified) {
> +			__insert_discard_tree(sbi, dc->bdev, blkaddr + 1,
> +					di.start + blkaddr + 1 - di.lstart,
> +					di.lstart + di.len - 1 - blkaddr,
> +					NULL, NULL);
> +		} else {
> +			dc->lstart++;
> +			dc->len--;
> +			dc->start++;
> +			dcc->undiscard_blks += dc->len;
> +			__relocate_discard_cmd(dcc, dc);
> +		}
> +	}
> +}
> +
> +static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
> +				struct block_device *bdev, block_t lstart,
> +				block_t start, block_t len)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> +	struct discard_cmd *dc;
> +	struct discard_info di = {0};
> +	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> +	block_t end = lstart + len;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +
> +	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
> +					NULL, lstart,
> +					(struct rb_entry **)&prev_dc,
> +					(struct rb_entry **)&next_dc,
> +					&insert_p, &insert_parent, true);
> +	if (dc)
> +		prev_dc = dc;
> +
> +	if (!prev_dc) {
> +		di.lstart = lstart;
> +		di.len = next_dc ? next_dc->lstart - lstart : len;
> +		di.len = min(di.len, len);
> +		di.start = start;
> +	}
> +
> +	while (1) {
> +		struct rb_node *node;
> +		bool merged = false;
> +		struct discard_cmd *tdc = NULL;
> +
> +		if (prev_dc) {
> +			di.lstart = prev_dc->lstart + prev_dc->len;
> +			if (di.lstart < lstart)
> +				di.lstart = lstart;
> +			if (di.lstart >= end)
> +				break;
> +
> +			if (!next_dc || next_dc->lstart > end)
> +				di.len = end - di.lstart;
> +			else
> +				di.len = next_dc->lstart - di.lstart;
> +			di.start = start + di.lstart - lstart;
> +		}
> +
> +		if (!di.len)
> +			goto next;
> +
> +		if (prev_dc && prev_dc->state == D_PREP &&
> +			prev_dc->bdev == bdev &&
> +			__is_discard_back_mergeable(&di, &prev_dc->di)) {
> +			prev_dc->di.len += di.len;
> +			dcc->undiscard_blks += di.len;
> +			__relocate_discard_cmd(dcc, prev_dc);
> +			di = prev_dc->di;
> +			tdc = prev_dc;
> +			merged = true;
> +		}
> +
> +		if (next_dc && next_dc->state == D_PREP &&
> +			next_dc->bdev == bdev &&
> +			__is_discard_front_mergeable(&di, &next_dc->di)) {
> +			next_dc->di.lstart = di.lstart;
> +			next_dc->di.len += di.len;
> +			next_dc->di.start = di.start;
> +			dcc->undiscard_blks += di.len;
> +			__relocate_discard_cmd(dcc, next_dc);
> +			if (tdc)
> +				__remove_discard_cmd(sbi, tdc);
> +			merged = true;
> +		}
> +
> +		if (!merged) {
> +			__insert_discard_tree(sbi, bdev, di.lstart, di.start,
> +							di.len, NULL, NULL);
> +		}
> + next:
> +		prev_dc = next_dc;
> +		if (!prev_dc)
> +			break;
> +
> +		node = rb_next(&prev_dc->rb_node);
> +		next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> +	}
> +
> +	mutex_unlock(&dcc->cmd_lock);
> +}
> +
> +static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
> +		struct block_device *bdev, block_t blkstart, block_t blklen)
> +{
> +	block_t lblkstart = blkstart;
> +
> +	trace_f2fs_queue_discard(bdev, blkstart, blklen);
> +
> +	if (sbi->s_ndevs) {
> +		int devi = f2fs_target_device_index(sbi, blkstart);
> +
> +		blkstart -= FDEV(devi).start_blk;
> +	}
> +	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
> +	return 0;
> +}
> +
> +static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
> +					struct discard_policy *dpolicy,
> +					unsigned int start, unsigned int end)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> +	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> +	struct discard_cmd *dc;
> +	struct blk_plug plug;
> +	int issued;
> +
> +next:
> +	issued = 0;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
> +
> +	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
> +					NULL, start,
> +					(struct rb_entry **)&prev_dc,
> +					(struct rb_entry **)&next_dc,
> +					&insert_p, &insert_parent, true);
> +	if (!dc)
> +		dc = next_dc;
> +
> +	blk_start_plug(&plug);
> +
> +	while (dc && dc->lstart <= end) {
> +		struct rb_node *node;
> +
> +		if (dc->len < dpolicy->granularity)
> +			goto skip;
> +
> +		if (dc->state != D_PREP) {
> +			list_move_tail(&dc->list, &dcc->fstrim_list);
> +			goto skip;
> +		}
> +
> +		__submit_discard_cmd(sbi, dpolicy, dc);
> +
> +		if (++issued >= dpolicy->max_requests) {
> +			start = dc->lstart + dc->len;
> +
> +			blk_finish_plug(&plug);
> +			mutex_unlock(&dcc->cmd_lock);
> +
> +			schedule();
> +
> +			goto next;
> +		}
> +skip:
> +		node = rb_next(&dc->rb_node);
> +		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> +
> +		if (fatal_signal_pending(current))
> +			break;
> +	}
> +
> +	blk_finish_plug(&plug);
> +	mutex_unlock(&dcc->cmd_lock);
> +}
> +
> +static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> +					struct discard_policy *dpolicy)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct list_head *pend_list;
> +	struct discard_cmd *dc, *tmp;
> +	struct blk_plug plug;
> +	int i, iter = 0, issued = 0;
> +	bool io_interrupted = false;
> +
> +	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> +		if (i + 1 < dpolicy->granularity)
> +			break;
> +		pend_list = &dcc->pend_list[i];
> +
> +		mutex_lock(&dcc->cmd_lock);
> +		if (list_empty(pend_list))
> +			goto next;
> +		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
> +		blk_start_plug(&plug);
> +		list_for_each_entry_safe(dc, tmp, pend_list, list) {
> +			f2fs_bug_on(sbi, dc->state != D_PREP);
> +
> +			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
> +								!is_idle(sbi)) {
> +				io_interrupted = true;
> +				goto skip;
> +			}
> +
> +			__submit_discard_cmd(sbi, dpolicy, dc);
> +			issued++;
> +skip:
> +			if (++iter >= dpolicy->max_requests)
> +				break;
> +		}
> +		blk_finish_plug(&plug);
> +next:
> +		mutex_unlock(&dcc->cmd_lock);
> +
> +		if (iter >= dpolicy->max_requests)
> +			break;
> +	}
> +
> +	if (!issued && io_interrupted)
> +		issued = -1;
> +
> +	return issued;
> +}
> +
> +static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct list_head *pend_list;
> +	struct discard_cmd *dc, *tmp;
> +	int i;
> +	bool dropped = false;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> +		pend_list = &dcc->pend_list[i];
> +		list_for_each_entry_safe(dc, tmp, pend_list, list) {
> +			f2fs_bug_on(sbi, dc->state != D_PREP);
> +			__remove_discard_cmd(sbi, dc);
> +			dropped = true;
> +		}
> +	}
> +	mutex_unlock(&dcc->cmd_lock);
> +
> +	return dropped;
> +}
> +
> +void drop_discard_cmd(struct f2fs_sb_info *sbi)
> +{
> +	__drop_discard_cmd(sbi);
> +}
> +
> +static unsigned int __wait_one_discard_bio(struct f2fs_sb_info *sbi,
> +							struct discard_cmd *dc)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	unsigned int len = 0;
> +
> +	wait_for_completion_io(&dc->wait);
> +	mutex_lock(&dcc->cmd_lock);
> +	f2fs_bug_on(sbi, dc->state != D_DONE);
> +	dc->ref--;
> +	if (!dc->ref) {
> +		if (!dc->error)
> +			len = dc->len;
> +		__remove_discard_cmd(sbi, dc);
> +	}
> +	mutex_unlock(&dcc->cmd_lock);
> +
> +	return len;
> +}
> +
> +static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
> +						struct discard_policy *dpolicy,
> +						block_t start, block_t end)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> +					&(dcc->fstrim_list) : &(dcc->wait_list);
> +	struct discard_cmd *dc, *tmp;
> +	bool need_wait;
> +	unsigned int trimmed = 0;
> +
> +next:
> +	need_wait = false;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	list_for_each_entry_safe(dc, tmp, wait_list, list) {
> +		if (dc->lstart + dc->len <= start || end <= dc->lstart)
> +			continue;
> +		if (dc->len < dpolicy->granularity)
> +			continue;
> +		if (dc->state == D_DONE && !dc->ref) {
> +			wait_for_completion_io(&dc->wait);
> +			if (!dc->error)
> +				trimmed += dc->len;
> +			__remove_discard_cmd(sbi, dc);
> +		} else {
> +			dc->ref++;
> +			need_wait = true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&dcc->cmd_lock);
> +
> +	if (need_wait) {
> +		trimmed += __wait_one_discard_bio(sbi, dc);
> +		goto next;
> +	}
> +
> +	return trimmed;
> +}
> +
> +static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
> +						struct discard_policy *dpolicy)
> +{
> +	__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
> +}
> +
> +/* This should be covered by global mutex, &sit_i->sentry_lock */
> +void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_cmd *dc;
> +	bool need_wait = false;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	dc = (struct discard_cmd *)__lookup_rb_tree(&dcc->root, NULL, blkaddr);
> +	if (dc) {
> +		if (dc->state == D_PREP) {
> +			__punch_discard_cmd(sbi, dc, blkaddr);
> +		} else {
> +			dc->ref++;
> +			need_wait = true;
> +		}
> +	}
> +	mutex_unlock(&dcc->cmd_lock);
> +
> +	if (need_wait)
> +		__wait_one_discard_bio(sbi, dc);
> +}
> +
> +void stop_discard_thread(struct f2fs_sb_info *sbi)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
> +	if (dcc && dcc->f2fs_issue_discard) {
> +		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
> +
> +		dcc->f2fs_issue_discard = NULL;
> +		kthread_stop(discard_thread);
> +	}
> +}
> +
> +/* This comes from f2fs_put_super */
> +bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_policy dpolicy;
> +	bool dropped;
> +
> +	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
> +	__issue_discard_cmd(sbi, &dpolicy);
> +	dropped = __drop_discard_cmd(sbi);
> +	__wait_all_discard_cmd(sbi, &dpolicy);
> +
> +	return dropped;
> +}
> +
> +static int issue_discard_thread(void *data)
> +{
> +	struct f2fs_sb_info *sbi = data;
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	wait_queue_head_t *q = &dcc->discard_wait_queue;
> +	struct discard_policy dpolicy;
> +	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> +	int issued;
> +
> +	set_freezable();
> +
> +	do {
> +		init_discard_policy(&dpolicy, DPOLICY_BG,
> +					dcc->discard_granularity);
> +
> +		wait_event_interruptible_timeout(*q,
> +				kthread_should_stop() || freezing(current) ||
> +				dcc->discard_wake,
> +				msecs_to_jiffies(wait_ms));
> +		if (try_to_freeze())
> +			continue;
> +		if (f2fs_readonly(sbi->sb))
> +			continue;
> +		if (kthread_should_stop())
> +			return 0;
> +		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> +			wait_ms = dpolicy.max_interval;
> +			continue;
> +		}
> +
> +		if (dcc->discard_wake)
> +			dcc->discard_wake = 0;
> +
> +		down_read(&GC_I(sbi)->gc_rwsem);
> +		if (GC_I(sbi)->f2fs_gc_task && GC_I(sbi)->gc_urgent)
> +			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
> +		up_read(&GC_I(sbi)->gc_rwsem);
> +
> +		sb_start_intwrite(sbi->sb);
> +
> +		issued = __issue_discard_cmd(sbi, &dpolicy);
> +		if (issued > 0) {
> +			__wait_all_discard_cmd(sbi, &dpolicy);
> +			wait_ms = dpolicy.min_interval;
> +		} else if (issued == -1) {
> +			wait_ms = dpolicy.mid_interval;
> +		} else {
> +			wait_ms = dpolicy.max_interval;
> +		}
> +
> +		sb_end_intwrite(sbi->sb);
> +
> +	} while (!kthread_should_stop());
> +	return 0;
> +}
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
> +		struct block_device *bdev, block_t blkstart, block_t blklen)
> +{
> +	sector_t sector, nr_sects;
> +	block_t lblkstart = blkstart;
> +	int devi = 0;
> +
> +	if (sbi->s_ndevs) {
> +		devi = f2fs_target_device_index(sbi, blkstart);
> +		blkstart -= FDEV(devi).start_blk;
> +	}
> +
> +	/*
> +	 * We need to know the type of the zone: for conventional zones,
> +	 * use regular discard if the drive supports it. For sequential
> +	 * zones, reset the zone write pointer.
> +	 */
> +	switch (get_blkz_type(sbi, bdev, blkstart)) {
> +
> +	case BLK_ZONE_TYPE_CONVENTIONAL:
> +		if (!blk_queue_discard(bdev_get_queue(bdev)))
> +			return 0;
> +		return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
> +	case BLK_ZONE_TYPE_SEQWRITE_REQ:
> +	case BLK_ZONE_TYPE_SEQWRITE_PREF:
> +		sector = SECTOR_FROM_BLOCK(blkstart);
> +		nr_sects = SECTOR_FROM_BLOCK(blklen);
> +
> +		if (sector & (bdev_zone_sectors(bdev) - 1) ||
> +				nr_sects != bdev_zone_sectors(bdev)) {
> +			f2fs_msg(sbi->sb, KERN_INFO,
> +				"(%d) %s: Unaligned discard attempted (block %x + %x)",
> +				devi, sbi->s_ndevs ? FDEV(devi).path : "",
> +				blkstart, blklen);
> +			return -EIO;
> +		}
> +		trace_f2fs_issue_reset_zone(bdev, blkstart);
> +		return blkdev_reset_zones(bdev, sector,
> +					  nr_sects, GFP_NOFS);
> +	default:
> +		/* Unknown zone type: broken device ? */
> +		return -EIO;
> +	}
> +}
> +#endif
> +
> +static int __issue_discard_async(struct f2fs_sb_info *sbi,
> +		struct block_device *bdev, block_t blkstart, block_t blklen)
> +{
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (f2fs_sb_has_blkzoned(sbi->sb) &&
> +				bdev_zoned_model(bdev) != BLK_ZONED_NONE)
> +		return __f2fs_issue_discard_zone(sbi, bdev, blkstart, blklen);
> +#endif
> +	return __queue_discard_cmd(sbi, bdev, blkstart, blklen);
> +}
> +
> +int f2fs_issue_discard(struct f2fs_sb_info *sbi,
> +				block_t blkstart, block_t blklen)
> +{
> +	sector_t start = blkstart, len = 0;
> +	struct block_device *bdev;
> +	struct seg_entry *se;
> +	unsigned int offset;
> +	block_t i;
> +	int err = 0;
> +
> +	bdev = f2fs_target_device(sbi, blkstart, NULL);
> +
> +	for (i = blkstart; i < blkstart + blklen; i++, len++) {
> +		if (i != start) {
> +			struct block_device *bdev2 =
> +				f2fs_target_device(sbi, i, NULL);
> +
> +			if (bdev2 != bdev) {
> +				err = __issue_discard_async(sbi, bdev,
> +						start, len);
> +				if (err)
> +					return err;
> +				bdev = bdev2;
> +				start = i;
> +				len = 0;
> +			}
> +		}
> +
> +		se = get_seg_entry(sbi, GET_SEGNO(sbi, i));
> +		offset = GET_BLKOFF_FROM_SEG0(sbi, i);
> +
> +		if (!f2fs_test_and_set_bit(offset, se->discard_map))
> +			sbi->discard_blks--;
> +	}
> +
> +	if (len)
> +		err = __issue_discard_async(sbi, bdev, start, len);
> +	return err;
> +}
> +
> +bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
> +							bool check_only)
> +{
> +	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> +	int max_blocks = sbi->blocks_per_seg;
> +	struct seg_entry *se = get_seg_entry(sbi, cpc->trim_start);
> +	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> +	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
> +	unsigned long *discard_map = (unsigned long *)se->discard_map;
> +	unsigned long *dmap = SIT_I(sbi)->tmp_map;
> +	unsigned int start = 0, end = -1;
> +	bool force = (cpc->reason & CP_DISCARD);
> +	struct discard_entry *de = NULL;
> +	struct list_head *head = &SM_I(sbi)->dcc_info->entry_list;
> +	int i;
> +
> +	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
> +		return false;
> +
> +	if (!force) {
> +		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
> +			SM_I(sbi)->dcc_info->nr_discards >=
> +				SM_I(sbi)->dcc_info->max_discards)
> +			return false;
> +	}
> +
> +	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
> +	for (i = 0; i < entries; i++)
> +		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
> +				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
> +
> +	while (force || SM_I(sbi)->dcc_info->nr_discards <=
> +				SM_I(sbi)->dcc_info->max_discards) {
> +		start = __find_rev_next_bit(dmap, max_blocks, end + 1);
> +		if (start >= max_blocks)
> +			break;
> +
> +		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
> +		if (force && start && end != max_blocks
> +					&& (end - start) < cpc->trim_minlen)
> +			continue;
> +
> +		if (check_only)
> +			return true;
> +
> +		if (!de) {
> +			de = f2fs_kmem_cache_alloc(discard_entry_slab,
> +								GFP_F2FS_ZERO);
> +			de->start_blkaddr = START_BLOCK(sbi, cpc->trim_start);
> +			list_add_tail(&de->list, head);
> +		}
> +
> +		for (i = start; i < end; i++)
> +			__set_bit_le(i, (void *)de->discard_map);
> +
> +		SM_I(sbi)->dcc_info->nr_discards += end - start;
> +	}
> +	return false;
> +}
> +
> +void release_discard_addr(struct discard_entry *entry)
> +{
> +	list_del(&entry->list);
> +	kmem_cache_free(discard_entry_slab, entry);
> +}
> +
> +void release_discard_addrs(struct f2fs_sb_info *sbi)
> +{
> +	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
> +	struct discard_entry *entry, *this;
> +
> +	/* drop caches */
> +	list_for_each_entry_safe(entry, this, head, list) {
> +		list_del(&entry->list);
> +		kmem_cache_free(discard_entry_slab, entry);
> +	}
> +}
> +
> +void init_discard_policy(struct discard_policy *dpolicy,
> +				int discard_type, unsigned int granularity)
> +{
> +	/* common policy */
> +	dpolicy->type = discard_type;
> +	dpolicy->sync = true;
> +	dpolicy->granularity = granularity;
> +
> +	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
> +	dpolicy->io_aware_gran = MAX_PLIST_NUM;
> +
> +	if (discard_type == DPOLICY_BG) {
> +		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> +		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
> +		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> +		dpolicy->io_aware = true;
> +		dpolicy->sync = false;
> +	} else if (discard_type == DPOLICY_FORCE) {
> +		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> +		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
> +		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> +		dpolicy->io_aware = false;
> +	} else if (discard_type == DPOLICY_FSTRIM) {
> +		dpolicy->io_aware = false;
> +	} else if (discard_type == DPOLICY_UMOUNT) {
> +		dpolicy->max_requests = UINT_MAX;
> +		dpolicy->io_aware = false;
> +	}
> +}
> +
> +int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
> +{
> +	__u64 start = F2FS_BYTES_TO_BLK(range->start);
> +	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
> +	unsigned int start_segno, end_segno;
> +	block_t start_block, end_block;
> +	struct cp_control cpc;
> +	struct discard_policy dpolicy;
> +	unsigned long long trimmed = 0;
> +	int err = 0;
> +
> +	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
> +		return -EINVAL;
> +
> +	if (end <= MAIN_BLKADDR(sbi))
> +		return -EINVAL;
> +
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +			"Found FS corruption, run fsck to fix.");
> +		return -EIO;
> +	}
> +
> +	/* start/end segment number in main_area */
> +	start_segno = (start <= MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start);
> +	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
> +						GET_SEGNO(sbi, end);
> +
> +	cpc.reason = CP_DISCARD;
> +	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
> +	cpc.trim_start = start_segno;
> +	cpc.trim_end = end_segno;
> +
> +	if (sbi->discard_blks == 0)
> +		goto out;
> +
> +	mutex_lock(&sbi->gc_mutex);
> +	err = write_checkpoint(sbi, &cpc);
> +	mutex_unlock(&sbi->gc_mutex);
> +	if (err)
> +		goto out;
> +
> +	start_block = START_BLOCK(sbi, start_segno);
> +	end_block = START_BLOCK(sbi, end_segno + 1);
> +
> +	init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
> +	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
> +	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
> +					start_block, end_block);
> +out:
> +	range->len = F2FS_BLK_TO_BYTES(trimmed);
> +	return err;
> +}
> +
> +int create_discard_cmd_control(struct f2fs_sb_info *sbi)
> +{
> +	dev_t dev = sbi->sb->s_bdev->bd_dev;
> +	struct discard_cmd_control *dcc;
> +	int err = 0, i;
> +
> +	if (SM_I(sbi)->dcc_info) {
> +		dcc = SM_I(sbi)->dcc_info;
> +		goto init_thread;
> +	}
> +
> +	dcc = f2fs_kzalloc(sbi, sizeof(struct discard_cmd_control), GFP_KERNEL);
> +	if (!dcc)
> +		return -ENOMEM;
> +
> +	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
> +	INIT_LIST_HEAD(&dcc->entry_list);
> +	for (i = 0; i < MAX_PLIST_NUM; i++)
> +		INIT_LIST_HEAD(&dcc->pend_list[i]);
> +	INIT_LIST_HEAD(&dcc->wait_list);
> +	INIT_LIST_HEAD(&dcc->fstrim_list);
> +	mutex_init(&dcc->cmd_lock);
> +	atomic_set(&dcc->issued_discard, 0);
> +	atomic_set(&dcc->issing_discard, 0);
> +	atomic_set(&dcc->discard_cmd_cnt, 0);
> +	dcc->nr_discards = 0;
> +	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
> +	dcc->undiscard_blks = 0;
> +	dcc->root = RB_ROOT;
> +
> +	init_waitqueue_head(&dcc->discard_wait_queue);
> +	SM_I(sbi)->dcc_info = dcc;
> +init_thread:
> +	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> +				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> +	if (IS_ERR(dcc->f2fs_issue_discard)) {
> +		err = PTR_ERR(dcc->f2fs_issue_discard);
> +		kfree(dcc);
> +		SM_I(sbi)->dcc_info = NULL;
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
> +void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
> +	if (!dcc)
> +		return;
> +
> +	stop_discard_thread(sbi);
> +
> +	kfree(dcc);
> +	SM_I(sbi)->dcc_info = NULL;
> +}
> +
> +int __init create_discard_caches(void)
> +{
> +	discard_entry_slab = f2fs_kmem_cache_create("discard_entry",
> +			sizeof(struct discard_entry));
> +	if (!discard_entry_slab)
> +		goto fail;
> +
> +	discard_cmd_slab = f2fs_kmem_cache_create("discard_cmd",
> +			sizeof(struct discard_cmd));
> +	if (!discard_cmd_slab)
> +		goto destroy_discard_entry;
> +	return 0;
> +destroy_discard_entry:
> +	kmem_cache_destroy(discard_entry_slab);
> +fail:
> +	return -ENOMEM;
> +}
> +
> +void destroy_discard_caches(void)
> +{
> +	kmem_cache_destroy(discard_cmd_slab);
> +	kmem_cache_destroy(discard_entry_slab);
> +}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c8d6d27384f1..64e3677998d8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2803,6 +2803,10 @@ void destroy_node_manager_caches(void);
>  /*
>   * segment.c
>   */
> +unsigned long __find_rev_next_bit(const unsigned long *addr,
> +				unsigned long size, unsigned long offset);
> +unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
> +			unsigned long size, unsigned long offset);
>  bool need_SSR(struct f2fs_sb_info *sbi);
>  void register_inmem_page(struct inode *inode, struct page *page);
>  void drop_inmem_pages_all(struct f2fs_sb_info *sbi);
> @@ -2817,16 +2821,9 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
>  void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
>  void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
>  bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
> -void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
> -						unsigned int granularity);
> -void drop_discard_cmd(struct f2fs_sb_info *sbi);
> -void stop_discard_thread(struct f2fs_sb_info *sbi);
> -bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
>  void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
> -void release_discard_addrs(struct f2fs_sb_info *sbi);
>  int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
>  void allocate_new_segments(struct f2fs_sb_info *sbi);
> -int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
>  bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>  struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno);
>  void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr);
> @@ -2856,8 +2853,6 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
>  void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>  int build_segment_manager(struct f2fs_sb_info *sbi);
>  void destroy_segment_manager(struct f2fs_sb_info *sbi);
> -int __init create_discard_caches(void);
> -void destroy_discard_caches(void);
>  int __init create_segment_manager_caches(void);
>  void destroy_segment_manager_caches(void);
>  int rw_hint_to_seg_type(enum rw_hint hint);
> @@ -3246,6 +3241,27 @@ void f2fs_exit_sysfs(void);
>  int f2fs_register_sysfs(struct f2fs_sb_info *sbi);
>  void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi);
>  
> +/*
> + * discard.c
> + */
> +void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
> +						unsigned int granularity);
> +void drop_discard_cmd(struct f2fs_sb_info *sbi);
> +void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr);
> +void stop_discard_thread(struct f2fs_sb_info *sbi);
> +bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
> +int f2fs_issue_discard(struct f2fs_sb_info *sbi,
> +				block_t blkstart, block_t blklen);
> +bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
> +							bool check_only);
> +void release_discard_addr(struct discard_entry *entry);
> +void release_discard_addrs(struct f2fs_sb_info *sbi);
> +int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
> +int create_discard_cmd_control(struct f2fs_sb_info *sbi);
> +void destroy_discard_cmd_control(struct f2fs_sb_info *sbi);
> +int __init create_discard_caches(void);
> +void destroy_discard_caches(void);
> +
>  /*
>   * crypto support
>   */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 187f957747be..f85a537100d7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -28,8 +28,6 @@
>  
>  #define __reverse_ffz(x) __reverse_ffs(~(x))
>  
> -static struct kmem_cache *discard_entry_slab;
> -static struct kmem_cache *discard_cmd_slab;
>  static struct kmem_cache *sit_entry_set_slab;
>  static struct kmem_cache *inmem_entry_slab;
>  
> @@ -96,7 +94,7 @@ static inline unsigned long __reverse_ffs(unsigned long word)
>   *   f2fs_set_bit(0, bitmap) => 1000 0000
>   *   f2fs_set_bit(7, bitmap) => 0000 0001
>   */
> -static unsigned long __find_rev_next_bit(const unsigned long *addr,
> +unsigned long __find_rev_next_bit(const unsigned long *addr,
>  			unsigned long size, unsigned long offset)
>  {
>  	const unsigned long *p = addr + BIT_WORD(offset);
> @@ -132,7 +130,7 @@ static unsigned long __find_rev_next_bit(const unsigned long *addr,
>  	return result - size + __reverse_ffs(tmp);
>  }
>  
> -static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
> +unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
>  			unsigned long size, unsigned long offset)
>  {
>  	const unsigned long *p = addr + BIT_WORD(offset);
> @@ -806,825 +804,6 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
>  	mutex_unlock(&dirty_i->seglist_lock);
>  }
>  
> -static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
> -		struct block_device *bdev, block_t lstart,
> -		block_t start, block_t len)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct list_head *pend_list;
> -	struct discard_cmd *dc;
> -
> -	f2fs_bug_on(sbi, !len);
> -
> -	pend_list = &dcc->pend_list[plist_idx(len)];
> -
> -	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
> -	INIT_LIST_HEAD(&dc->list);
> -	dc->bdev = bdev;
> -	dc->lstart = lstart;
> -	dc->start = start;
> -	dc->len = len;
> -	dc->ref = 0;
> -	dc->state = D_PREP;
> -	dc->error = 0;
> -	init_completion(&dc->wait);
> -	list_add_tail(&dc->list, pend_list);
> -	atomic_inc(&dcc->discard_cmd_cnt);
> -	dcc->undiscard_blks += len;
> -
> -	return dc;
> -}
> -
> -static struct discard_cmd *__attach_discard_cmd(struct f2fs_sb_info *sbi,
> -				struct block_device *bdev, block_t lstart,
> -				block_t start, block_t len,
> -				struct rb_node *parent, struct rb_node **p)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct discard_cmd *dc;
> -
> -	dc = __create_discard_cmd(sbi, bdev, lstart, start, len);
> -
> -	rb_link_node(&dc->rb_node, parent, p);
> -	rb_insert_color(&dc->rb_node, &dcc->root);
> -
> -	return dc;
> -}
> -
> -static void __detach_discard_cmd(struct discard_cmd_control *dcc,
> -							struct discard_cmd *dc)
> -{
> -	if (dc->state == D_DONE)
> -		atomic_dec(&dcc->issing_discard);
> -
> -	list_del(&dc->list);
> -	rb_erase(&dc->rb_node, &dcc->root);
> -	dcc->undiscard_blks -= dc->len;
> -
> -	kmem_cache_free(discard_cmd_slab, dc);
> -
> -	atomic_dec(&dcc->discard_cmd_cnt);
> -}
> -
> -static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
> -							struct discard_cmd *dc)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -
> -	trace_f2fs_remove_discard(dc->bdev, dc->start, dc->len);
> -
> -	f2fs_bug_on(sbi, dc->ref);
> -
> -	if (dc->error == -EOPNOTSUPP)
> -		dc->error = 0;
> -
> -	if (dc->error)
> -		f2fs_msg(sbi->sb, KERN_INFO,
> -			"Issue discard(%u, %u, %u) failed, ret: %d",
> -			dc->lstart, dc->start, dc->len, dc->error);
> -	__detach_discard_cmd(dcc, dc);
> -}
> -
> -static void f2fs_submit_discard_endio(struct bio *bio)
> -{
> -	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> -
> -	dc->error = blk_status_to_errno(bio->bi_status);
> -	dc->state = D_DONE;
> -	complete_all(&dc->wait);
> -	bio_put(bio);
> -}
> -
> -static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> -				block_t start, block_t end)
> -{
> -#ifdef CONFIG_F2FS_CHECK_FS
> -	struct seg_entry *sentry;
> -	unsigned int segno;
> -	block_t blk = start;
> -	unsigned long offset, size, max_blocks = sbi->blocks_per_seg;
> -	unsigned long *map;
> -
> -	while (blk < end) {
> -		segno = GET_SEGNO(sbi, blk);
> -		sentry = get_seg_entry(sbi, segno);
> -		offset = GET_BLKOFF_FROM_SEG0(sbi, blk);
> -
> -		if (end < START_BLOCK(sbi, segno + 1))
> -			size = GET_BLKOFF_FROM_SEG0(sbi, end);
> -		else
> -			size = max_blocks;
> -		map = (unsigned long *)(sentry->cur_valid_map);
> -		offset = __find_rev_next_bit(map, size, offset);
> -		f2fs_bug_on(sbi, offset != size);
> -		blk = START_BLOCK(sbi, segno + 1);
> -	}
> -#endif
> -}
> -
> -/* this function is copied from blkdev_issue_discard from block/blk-lib.c */
> -static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
> -						struct discard_policy *dpolicy,
> -						struct discard_cmd *dc)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> -					&(dcc->fstrim_list) : &(dcc->wait_list);
> -	struct bio *bio = NULL;
> -	int flag = dpolicy->sync ? REQ_SYNC : 0;
> -
> -	if (dc->state != D_PREP)
> -		return;
> -
> -	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> -		return;
> -
> -	trace_f2fs_issue_discard(dc->bdev, dc->start, dc->len);
> -
> -	dc->error = __blkdev_issue_discard(dc->bdev,
> -				SECTOR_FROM_BLOCK(dc->start),
> -				SECTOR_FROM_BLOCK(dc->len),
> -				GFP_NOFS, 0, &bio);
> -	if (!dc->error) {
> -		/* should keep before submission to avoid D_DONE right away */
> -		dc->state = D_SUBMIT;
> -		atomic_inc(&dcc->issued_discard);
> -		atomic_inc(&dcc->issing_discard);
> -		if (bio) {
> -			bio->bi_private = dc;
> -			bio->bi_end_io = f2fs_submit_discard_endio;
> -			bio->bi_opf |= flag;
> -			submit_bio(bio);
> -			list_move_tail(&dc->list, wait_list);
> -			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
> -
> -			f2fs_update_iostat(sbi, FS_DISCARD, 1);
> -		}
> -	} else {
> -		__remove_discard_cmd(sbi, dc);
> -	}
> -}
> -
> -static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
> -				struct block_device *bdev, block_t lstart,
> -				block_t start, block_t len,
> -				struct rb_node **insert_p,
> -				struct rb_node *insert_parent)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct rb_node **p;
> -	struct rb_node *parent = NULL;
> -	struct discard_cmd *dc = NULL;
> -
> -	if (insert_p && insert_parent) {
> -		parent = insert_parent;
> -		p = insert_p;
> -		goto do_insert;
> -	}
> -
> -	p = __lookup_rb_tree_for_insert(sbi, &dcc->root, &parent, lstart);
> -do_insert:
> -	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent, p);
> -	if (!dc)
> -		return NULL;
> -
> -	return dc;
> -}
> -
> -static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
> -						struct discard_cmd *dc)
> -{
> -	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->len)]);
> -}
> -
> -static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
> -				struct discard_cmd *dc, block_t blkaddr)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct discard_info di = dc->di;
> -	bool modified = false;
> -
> -	if (dc->state == D_DONE || dc->len == 1) {
> -		__remove_discard_cmd(sbi, dc);
> -		return;
> -	}
> -
> -	dcc->undiscard_blks -= di.len;
> -
> -	if (blkaddr > di.lstart) {
> -		dc->len = blkaddr - dc->lstart;
> -		dcc->undiscard_blks += dc->len;
> -		__relocate_discard_cmd(dcc, dc);
> -		modified = true;
> -	}
> -
> -	if (blkaddr < di.lstart + di.len - 1) {
> -		if (modified) {
> -			__insert_discard_tree(sbi, dc->bdev, blkaddr + 1,
> -					di.start + blkaddr + 1 - di.lstart,
> -					di.lstart + di.len - 1 - blkaddr,
> -					NULL, NULL);
> -		} else {
> -			dc->lstart++;
> -			dc->len--;
> -			dc->start++;
> -			dcc->undiscard_blks += dc->len;
> -			__relocate_discard_cmd(dcc, dc);
> -		}
> -	}
> -}
> -
> -static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
> -				struct block_device *bdev, block_t lstart,
> -				block_t start, block_t len)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> -	struct discard_cmd *dc;
> -	struct discard_info di = {0};
> -	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> -	block_t end = lstart + len;
> -
> -	mutex_lock(&dcc->cmd_lock);
> -
> -	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
> -					NULL, lstart,
> -					(struct rb_entry **)&prev_dc,
> -					(struct rb_entry **)&next_dc,
> -					&insert_p, &insert_parent, true);
> -	if (dc)
> -		prev_dc = dc;
> -
> -	if (!prev_dc) {
> -		di.lstart = lstart;
> -		di.len = next_dc ? next_dc->lstart - lstart : len;
> -		di.len = min(di.len, len);
> -		di.start = start;
> -	}
> -
> -	while (1) {
> -		struct rb_node *node;
> -		bool merged = false;
> -		struct discard_cmd *tdc = NULL;
> -
> -		if (prev_dc) {
> -			di.lstart = prev_dc->lstart + prev_dc->len;
> -			if (di.lstart < lstart)
> -				di.lstart = lstart;
> -			if (di.lstart >= end)
> -				break;
> -
> -			if (!next_dc || next_dc->lstart > end)
> -				di.len = end - di.lstart;
> -			else
> -				di.len = next_dc->lstart - di.lstart;
> -			di.start = start + di.lstart - lstart;
> -		}
> -
> -		if (!di.len)
> -			goto next;
> -
> -		if (prev_dc && prev_dc->state == D_PREP &&
> -			prev_dc->bdev == bdev &&
> -			__is_discard_back_mergeable(&di, &prev_dc->di)) {
> -			prev_dc->di.len += di.len;
> -			dcc->undiscard_blks += di.len;
> -			__relocate_discard_cmd(dcc, prev_dc);
> -			di = prev_dc->di;
> -			tdc = prev_dc;
> -			merged = true;
> -		}
> -
> -		if (next_dc && next_dc->state == D_PREP &&
> -			next_dc->bdev == bdev &&
> -			__is_discard_front_mergeable(&di, &next_dc->di)) {
> -			next_dc->di.lstart = di.lstart;
> -			next_dc->di.len += di.len;
> -			next_dc->di.start = di.start;
> -			dcc->undiscard_blks += di.len;
> -			__relocate_discard_cmd(dcc, next_dc);
> -			if (tdc)
> -				__remove_discard_cmd(sbi, tdc);
> -			merged = true;
> -		}
> -
> -		if (!merged) {
> -			__insert_discard_tree(sbi, bdev, di.lstart, di.start,
> -							di.len, NULL, NULL);
> -		}
> - next:
> -		prev_dc = next_dc;
> -		if (!prev_dc)
> -			break;
> -
> -		node = rb_next(&prev_dc->rb_node);
> -		next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> -	}
> -
> -	mutex_unlock(&dcc->cmd_lock);
> -}
> -
> -static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
> -		struct block_device *bdev, block_t blkstart, block_t blklen)
> -{
> -	block_t lblkstart = blkstart;
> -
> -	trace_f2fs_queue_discard(bdev, blkstart, blklen);
> -
> -	if (sbi->s_ndevs) {
> -		int devi = f2fs_target_device_index(sbi, blkstart);
> -
> -		blkstart -= FDEV(devi).start_blk;
> -	}
> -	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
> -	return 0;
> -}
> -
> -static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
> -					struct discard_policy *dpolicy,
> -					unsigned int start, unsigned int end)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> -	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> -	struct discard_cmd *dc;
> -	struct blk_plug plug;
> -	int issued;
> -
> -next:
> -	issued = 0;
> -
> -	mutex_lock(&dcc->cmd_lock);
> -	f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
> -
> -	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
> -					NULL, start,
> -					(struct rb_entry **)&prev_dc,
> -					(struct rb_entry **)&next_dc,
> -					&insert_p, &insert_parent, true);
> -	if (!dc)
> -		dc = next_dc;
> -
> -	blk_start_plug(&plug);
> -
> -	while (dc && dc->lstart <= end) {
> -		struct rb_node *node;
> -
> -		if (dc->len < dpolicy->granularity)
> -			goto skip;
> -
> -		if (dc->state != D_PREP) {
> -			list_move_tail(&dc->list, &dcc->fstrim_list);
> -			goto skip;
> -		}
> -
> -		__submit_discard_cmd(sbi, dpolicy, dc);
> -
> -		if (++issued >= dpolicy->max_requests) {
> -			start = dc->lstart + dc->len;
> -
> -			blk_finish_plug(&plug);
> -			mutex_unlock(&dcc->cmd_lock);
> -
> -			schedule();
> -
> -			goto next;
> -		}
> -skip:
> -		node = rb_next(&dc->rb_node);
> -		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> -
> -		if (fatal_signal_pending(current))
> -			break;
> -	}
> -
> -	blk_finish_plug(&plug);
> -	mutex_unlock(&dcc->cmd_lock);
> -}
> -
> -static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> -					struct discard_policy *dpolicy)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct list_head *pend_list;
> -	struct discard_cmd *dc, *tmp;
> -	struct blk_plug plug;
> -	int i, iter = 0, issued = 0;
> -	bool io_interrupted = false;
> -
> -	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> -		if (i + 1 < dpolicy->granularity)
> -			break;
> -		pend_list = &dcc->pend_list[i];
> -
> -		mutex_lock(&dcc->cmd_lock);
> -		if (list_empty(pend_list))
> -			goto next;
> -		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
> -		blk_start_plug(&plug);
> -		list_for_each_entry_safe(dc, tmp, pend_list, list) {
> -			f2fs_bug_on(sbi, dc->state != D_PREP);
> -
> -			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
> -								!is_idle(sbi)) {
> -				io_interrupted = true;
> -				goto skip;
> -			}
> -
> -			__submit_discard_cmd(sbi, dpolicy, dc);
> -			issued++;
> -skip:
> -			if (++iter >= dpolicy->max_requests)
> -				break;
> -		}
> -		blk_finish_plug(&plug);
> -next:
> -		mutex_unlock(&dcc->cmd_lock);
> -
> -		if (iter >= dpolicy->max_requests)
> -			break;
> -	}
> -
> -	if (!issued && io_interrupted)
> -		issued = -1;
> -
> -	return issued;
> -}
> -
> -static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct list_head *pend_list;
> -	struct discard_cmd *dc, *tmp;
> -	int i;
> -	bool dropped = false;
> -
> -	mutex_lock(&dcc->cmd_lock);
> -	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> -		pend_list = &dcc->pend_list[i];
> -		list_for_each_entry_safe(dc, tmp, pend_list, list) {
> -			f2fs_bug_on(sbi, dc->state != D_PREP);
> -			__remove_discard_cmd(sbi, dc);
> -			dropped = true;
> -		}
> -	}
> -	mutex_unlock(&dcc->cmd_lock);
> -
> -	return dropped;
> -}
> -
> -void drop_discard_cmd(struct f2fs_sb_info *sbi)
> -{
> -	__drop_discard_cmd(sbi);
> -}
> -
> -static unsigned int __wait_one_discard_bio(struct f2fs_sb_info *sbi,
> -							struct discard_cmd *dc)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	unsigned int len = 0;
> -
> -	wait_for_completion_io(&dc->wait);
> -	mutex_lock(&dcc->cmd_lock);
> -	f2fs_bug_on(sbi, dc->state != D_DONE);
> -	dc->ref--;
> -	if (!dc->ref) {
> -		if (!dc->error)
> -			len = dc->len;
> -		__remove_discard_cmd(sbi, dc);
> -	}
> -	mutex_unlock(&dcc->cmd_lock);
> -
> -	return len;
> -}
> -
> -static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
> -						struct discard_policy *dpolicy,
> -						block_t start, block_t end)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> -					&(dcc->fstrim_list) : &(dcc->wait_list);
> -	struct discard_cmd *dc, *tmp;
> -	bool need_wait;
> -	unsigned int trimmed = 0;
> -
> -next:
> -	need_wait = false;
> -
> -	mutex_lock(&dcc->cmd_lock);
> -	list_for_each_entry_safe(dc, tmp, wait_list, list) {
> -		if (dc->lstart + dc->len <= start || end <= dc->lstart)
> -			continue;
> -		if (dc->len < dpolicy->granularity)
> -			continue;
> -		if (dc->state == D_DONE && !dc->ref) {
> -			wait_for_completion_io(&dc->wait);
> -			if (!dc->error)
> -				trimmed += dc->len;
> -			__remove_discard_cmd(sbi, dc);
> -		} else {
> -			dc->ref++;
> -			need_wait = true;
> -			break;
> -		}
> -	}
> -	mutex_unlock(&dcc->cmd_lock);
> -
> -	if (need_wait) {
> -		trimmed += __wait_one_discard_bio(sbi, dc);
> -		goto next;
> -	}
> -
> -	return trimmed;
> -}
> -
> -static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
> -						struct discard_policy *dpolicy)
> -{
> -	__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
> -}
> -
> -/* This should be covered by global mutex, &sit_i->sentry_lock */
> -static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct discard_cmd *dc;
> -	bool need_wait = false;
> -
> -	mutex_lock(&dcc->cmd_lock);
> -	dc = (struct discard_cmd *)__lookup_rb_tree(&dcc->root, NULL, blkaddr);
> -	if (dc) {
> -		if (dc->state == D_PREP) {
> -			__punch_discard_cmd(sbi, dc, blkaddr);
> -		} else {
> -			dc->ref++;
> -			need_wait = true;
> -		}
> -	}
> -	mutex_unlock(&dcc->cmd_lock);
> -
> -	if (need_wait)
> -		__wait_one_discard_bio(sbi, dc);
> -}
> -
> -void stop_discard_thread(struct f2fs_sb_info *sbi)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -
> -	if (dcc && dcc->f2fs_issue_discard) {
> -		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
> -
> -		dcc->f2fs_issue_discard = NULL;
> -		kthread_stop(discard_thread);
> -	}
> -}
> -
> -/* This comes from f2fs_put_super */
> -bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct discard_policy dpolicy;
> -	bool dropped;
> -
> -	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
> -	__issue_discard_cmd(sbi, &dpolicy);
> -	dropped = __drop_discard_cmd(sbi);
> -	__wait_all_discard_cmd(sbi, &dpolicy);
> -
> -	return dropped;
> -}
> -
> -static int issue_discard_thread(void *data)
> -{
> -	struct f2fs_sb_info *sbi = data;
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	wait_queue_head_t *q = &dcc->discard_wait_queue;
> -	struct discard_policy dpolicy;
> -	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> -	int issued;
> -
> -	set_freezable();
> -
> -	do {
> -		init_discard_policy(&dpolicy, DPOLICY_BG,
> -					dcc->discard_granularity);
> -
> -		wait_event_interruptible_timeout(*q,
> -				kthread_should_stop() || freezing(current) ||
> -				dcc->discard_wake,
> -				msecs_to_jiffies(wait_ms));
> -		if (try_to_freeze())
> -			continue;
> -		if (f2fs_readonly(sbi->sb))
> -			continue;
> -		if (kthread_should_stop())
> -			return 0;
> -		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> -			wait_ms = dpolicy.max_interval;
> -			continue;
> -		}
> -
> -		if (dcc->discard_wake)
> -			dcc->discard_wake = 0;
> -
> -		down_read(&GC_I(sbi)->gc_rwsem);
> -		if (GC_I(sbi)->f2fs_gc_task && GC_I(sbi)->gc_urgent)
> -			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
> -		up_read(&GC_I(sbi)->gc_rwsem);
> -
> -		sb_start_intwrite(sbi->sb);
> -
> -		issued = __issue_discard_cmd(sbi, &dpolicy);
> -		if (issued > 0) {
> -			__wait_all_discard_cmd(sbi, &dpolicy);
> -			wait_ms = dpolicy.min_interval;
> -		} else if (issued == -1){
> -			wait_ms = dpolicy.mid_interval;
> -		} else {
> -			wait_ms = dpolicy.max_interval;
> -		}
> -
> -		sb_end_intwrite(sbi->sb);
> -
> -	} while (!kthread_should_stop());
> -	return 0;
> -}
> -
> -#ifdef CONFIG_BLK_DEV_ZONED
> -static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
> -		struct block_device *bdev, block_t blkstart, block_t blklen)
> -{
> -	sector_t sector, nr_sects;
> -	block_t lblkstart = blkstart;
> -	int devi = 0;
> -
> -	if (sbi->s_ndevs) {
> -		devi = f2fs_target_device_index(sbi, blkstart);
> -		blkstart -= FDEV(devi).start_blk;
> -	}
> -
> -	/*
> -	 * We need to know the type of the zone: for conventional zones,
> -	 * use regular discard if the drive supports it. For sequential
> -	 * zones, reset the zone write pointer.
> -	 */
> -	switch (get_blkz_type(sbi, bdev, blkstart)) {
> -
> -	case BLK_ZONE_TYPE_CONVENTIONAL:
> -		if (!blk_queue_discard(bdev_get_queue(bdev)))
> -			return 0;
> -		return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
> -	case BLK_ZONE_TYPE_SEQWRITE_REQ:
> -	case BLK_ZONE_TYPE_SEQWRITE_PREF:
> -		sector = SECTOR_FROM_BLOCK(blkstart);
> -		nr_sects = SECTOR_FROM_BLOCK(blklen);
> -
> -		if (sector & (bdev_zone_sectors(bdev) - 1) ||
> -				nr_sects != bdev_zone_sectors(bdev)) {
> -			f2fs_msg(sbi->sb, KERN_INFO,
> -				"(%d) %s: Unaligned discard attempted (block %x + %x)",
> -				devi, sbi->s_ndevs ? FDEV(devi).path: "",
> -				blkstart, blklen);
> -			return -EIO;
> -		}
> -		trace_f2fs_issue_reset_zone(bdev, blkstart);
> -		return blkdev_reset_zones(bdev, sector,
> -					  nr_sects, GFP_NOFS);
> -	default:
> -		/* Unknown zone type: broken device ? */
> -		return -EIO;
> -	}
> -}
> -#endif
> -
> -static int __issue_discard_async(struct f2fs_sb_info *sbi,
> -		struct block_device *bdev, block_t blkstart, block_t blklen)
> -{
> -#ifdef CONFIG_BLK_DEV_ZONED
> -	if (f2fs_sb_has_blkzoned(sbi->sb) &&
> -				bdev_zoned_model(bdev) != BLK_ZONED_NONE)
> -		return __f2fs_issue_discard_zone(sbi, bdev, blkstart, blklen);
> -#endif
> -	return __queue_discard_cmd(sbi, bdev, blkstart, blklen);
> -}
> -
> -static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
> -				block_t blkstart, block_t blklen)
> -{
> -	sector_t start = blkstart, len = 0;
> -	struct block_device *bdev;
> -	struct seg_entry *se;
> -	unsigned int offset;
> -	block_t i;
> -	int err = 0;
> -
> -	bdev = f2fs_target_device(sbi, blkstart, NULL);
> -
> -	for (i = blkstart; i < blkstart + blklen; i++, len++) {
> -		if (i != start) {
> -			struct block_device *bdev2 =
> -				f2fs_target_device(sbi, i, NULL);
> -
> -			if (bdev2 != bdev) {
> -				err = __issue_discard_async(sbi, bdev,
> -						start, len);
> -				if (err)
> -					return err;
> -				bdev = bdev2;
> -				start = i;
> -				len = 0;
> -			}
> -		}
> -
> -		se = get_seg_entry(sbi, GET_SEGNO(sbi, i));
> -		offset = GET_BLKOFF_FROM_SEG0(sbi, i);
> -
> -		if (!f2fs_test_and_set_bit(offset, se->discard_map))
> -			sbi->discard_blks--;
> -	}
> -
> -	if (len)
> -		err = __issue_discard_async(sbi, bdev, start, len);
> -	return err;
> -}
> -
> -static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
> -							bool check_only)
> -{
> -	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> -	int max_blocks = sbi->blocks_per_seg;
> -	struct seg_entry *se = get_seg_entry(sbi, cpc->trim_start);
> -	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> -	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
> -	unsigned long *discard_map = (unsigned long *)se->discard_map;
> -	unsigned long *dmap = SIT_I(sbi)->tmp_map;
> -	unsigned int start = 0, end = -1;
> -	bool force = (cpc->reason & CP_DISCARD);
> -	struct discard_entry *de = NULL;
> -	struct list_head *head = &SM_I(sbi)->dcc_info->entry_list;
> -	int i;
> -
> -	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
> -		return false;
> -
> -	if (!force) {
> -		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
> -			SM_I(sbi)->dcc_info->nr_discards >=
> -				SM_I(sbi)->dcc_info->max_discards)
> -			return false;
> -	}
> -
> -	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
> -	for (i = 0; i < entries; i++)
> -		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
> -				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
> -
> -	while (force || SM_I(sbi)->dcc_info->nr_discards <=
> -				SM_I(sbi)->dcc_info->max_discards) {
> -		start = __find_rev_next_bit(dmap, max_blocks, end + 1);
> -		if (start >= max_blocks)
> -			break;
> -
> -		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
> -		if (force && start && end != max_blocks
> -					&& (end - start) < cpc->trim_minlen)
> -			continue;
> -
> -		if (check_only)
> -			return true;
> -
> -		if (!de) {
> -			de = f2fs_kmem_cache_alloc(discard_entry_slab,
> -								GFP_F2FS_ZERO);
> -			de->start_blkaddr = START_BLOCK(sbi, cpc->trim_start);
> -			list_add_tail(&de->list, head);
> -		}
> -
> -		for (i = start; i < end; i++)
> -			__set_bit_le(i, (void *)de->discard_map);
> -
> -		SM_I(sbi)->dcc_info->nr_discards += end - start;
> -	}
> -	return false;
> -}
> -
> -void release_discard_addr(struct discard_entry *entry)
> -{
> -	list_del(&entry->list);
> -	kmem_cache_free(discard_entry_slab, entry);
> -}
> -
> -void release_discard_addrs(struct f2fs_sb_info *sbi)
> -{
> -	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
> -	struct discard_entry *entry, *this;
> -
> -	/* drop caches */
> -	list_for_each_entry_safe(entry, this, head, list)
> -		release_discard_addr(entry);
> -}
> -
>  /*
>   * Should call clear_prefree_segments after checkpoint is done.
>   */
> @@ -1729,94 +908,6 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	wake_up_discard_thread(sbi, false);
>  }
>  
> -void init_discard_policy(struct discard_policy *dpolicy,
> -				int discard_type, unsigned int granularity)
> -{
> -	/* common policy */
> -	dpolicy->type = discard_type;
> -	dpolicy->sync = true;
> -	dpolicy->granularity = granularity;
> -
> -	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
> -	dpolicy->io_aware_gran = MAX_PLIST_NUM;
> -
> -	if (discard_type == DPOLICY_BG) {
> -		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> -		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
> -		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> -		dpolicy->io_aware = true;
> -		dpolicy->sync = false;
> -	} else if (discard_type == DPOLICY_FORCE) {
> -		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> -		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
> -		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> -		dpolicy->io_aware = false;
> -	} else if (discard_type == DPOLICY_FSTRIM) {
> -		dpolicy->io_aware = false;
> -	} else if (discard_type == DPOLICY_UMOUNT) {
> -		dpolicy->max_requests = UINT_MAX;
> -		dpolicy->io_aware = false;
> -	}
> -}
> -
> -static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
> -{
> -	dev_t dev = sbi->sb->s_bdev->bd_dev;
> -	struct discard_cmd_control *dcc;
> -	int err = 0, i;
> -
> -	if (SM_I(sbi)->dcc_info) {
> -		dcc = SM_I(sbi)->dcc_info;
> -		goto init_thread;
> -	}
> -
> -	dcc = f2fs_kzalloc(sbi, sizeof(struct discard_cmd_control), GFP_KERNEL);
> -	if (!dcc)
> -		return -ENOMEM;
> -
> -	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
> -	INIT_LIST_HEAD(&dcc->entry_list);
> -	for (i = 0; i < MAX_PLIST_NUM; i++)
> -		INIT_LIST_HEAD(&dcc->pend_list[i]);
> -	INIT_LIST_HEAD(&dcc->wait_list);
> -	INIT_LIST_HEAD(&dcc->fstrim_list);
> -	mutex_init(&dcc->cmd_lock);
> -	atomic_set(&dcc->issued_discard, 0);
> -	atomic_set(&dcc->issing_discard, 0);
> -	atomic_set(&dcc->discard_cmd_cnt, 0);
> -	dcc->nr_discards = 0;
> -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
> -	dcc->undiscard_blks = 0;
> -	dcc->root = RB_ROOT;
> -
> -	init_waitqueue_head(&dcc->discard_wait_queue);
> -	SM_I(sbi)->dcc_info = dcc;
> -init_thread:
> -	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> -				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> -	if (IS_ERR(dcc->f2fs_issue_discard)) {
> -		err = PTR_ERR(dcc->f2fs_issue_discard);
> -		kfree(dcc);
> -		SM_I(sbi)->dcc_info = NULL;
> -		return err;
> -	}
> -
> -	return err;
> -}
> -
> -static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -
> -	if (!dcc)
> -		return;
> -
> -	stop_discard_thread(sbi);
> -
> -	kfree(dcc);
> -	SM_I(sbi)->dcc_info = NULL;
> -}
> -
>  static bool __mark_sit_entry_dirty(struct f2fs_sb_info *sbi, unsigned int segno)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
> @@ -2399,60 +1490,6 @@ bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	return has_candidate;
>  }
>  
> -int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
> -{
> -	__u64 start = F2FS_BYTES_TO_BLK(range->start);
> -	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
> -	unsigned int start_segno, end_segno;
> -	block_t start_block, end_block;
> -	struct cp_control cpc;
> -	struct discard_policy dpolicy;
> -	unsigned long long trimmed = 0;
> -	int err = 0;
> -
> -	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
> -		return -EINVAL;
> -
> -	if (end <= MAIN_BLKADDR(sbi))
> -		return -EINVAL;
> -
> -	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> -		f2fs_msg(sbi->sb, KERN_WARNING,
> -			"Found FS corruption, run fsck to fix.");
> -		return -EIO;
> -	}
> -
> -	/* start/end segment number in main_area */
> -	start_segno = (start <= MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start);
> -	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
> -						GET_SEGNO(sbi, end);
> -
> -	cpc.reason = CP_DISCARD;
> -	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
> -	cpc.trim_start = start_segno;
> -	cpc.trim_end = end_segno;
> -
> -	if (sbi->discard_blks == 0)
> -		goto out;
> -
> -	mutex_lock(&sbi->gc_mutex);
> -	err = write_checkpoint(sbi, &cpc);
> -	mutex_unlock(&sbi->gc_mutex);
> -	if (err)
> -		goto out;
> -
> -	start_block = START_BLOCK(sbi, start_segno);
> -	end_block = START_BLOCK(sbi, end_segno + 1);
> -
> -	init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
> -	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
> -	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
> -					start_block, end_block);
> -out:
> -	range->len = F2FS_BLK_TO_BYTES(trimmed);
> -	return err;
> -}
> -
>  static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
>  {
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
> @@ -3993,30 +3030,6 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
>  	kfree(sm_info);
>  }
>  
> -int __init create_discard_caches(void)
> -{
> -	discard_entry_slab = f2fs_kmem_cache_create("discard_entry",
> -			sizeof(struct discard_entry));
> -	if (!discard_entry_slab)
> -		goto fail;
> -
> -	discard_cmd_slab = f2fs_kmem_cache_create("discard_cmd",
> -			sizeof(struct discard_cmd));
> -	if (!discard_cmd_slab)
> -		goto destroy_discard_entry;
> -	return 0;
> -destroy_discard_entry:
> -	kmem_cache_destroy(discard_entry_slab);
> -fail:
> -	return -ENOMEM;
> -}
> -
> -void destroy_discard_caches(void)
> -{
> -	kmem_cache_destroy(discard_cmd_slab);
> -	kmem_cache_destroy(discard_entry_slab);
> -}
> -
>  int __init create_segment_manager_caches(void)
>  {
>  	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
> -- 
> 2.15.0.55.gc2ece9dc4de6
