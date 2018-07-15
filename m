Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC21ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE952089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYrcXZKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE952089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbeGOD0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 23:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731946AbeGOD0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 23:26:04 -0400
Received: from localhost (unknown [104.132.152.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AFDA2089F;
        Sun, 15 Jul 2018 03:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531623885;
        bh=OhK5r9Kq+YDqGLfFiTXAIp/gHXZ98e43h4MsT/cfmu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYrcXZKRfCacz8S6uEZxLr1Au4fcNd3kGLa2K/4WJ+90656F0HgFxGXTIsdgpxKQ5
         /+CvZSYr7jzuICDRX4jDJFtWwLHMoRrtpwFWxATy/UPA78UTH9Q+JLx4cTxMgZN6TD
         AA7d5ooQYCcS2HDgQ0iOHXgj/KdDrX5XHm0/kI7Q=
Date:   Sun, 15 Jul 2018 12:04:43 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 5/5] f2fs: fix to propagate error from
 __get_meta_page()
Message-ID: <20180715030443.GG11571@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180710150045.6231-1-chao@kernel.org>
 <20180715015708.GB11571@jaegeuk-macbookpro.roam.corp.google.com>
 <f19760e4-fe29-d560-06f6-c55486c98698@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19760e4-fe29-d560-06f6-c55486c98698@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/15, Chao Yu wrote:
> On 2018/7/15 9:57, Jaegeuk Kim wrote:
> > On 07/10, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> If caller of __get_meta_page() can handle error, let's propagate error
> >> from __get_meta_page().
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >> v2:
> >> - handle error path in __get_meta_page() correctly.
> >>  fs/f2fs/checkpoint.c | 21 +++++++++++++++++----
> >>  fs/f2fs/f2fs.h       |  2 +-
> >>  fs/f2fs/node.c       | 27 +++++++++++++++++++--------
> >>  fs/f2fs/recovery.c   |  8 ++++++++
> >>  fs/f2fs/segment.c    | 33 +++++++++++++++++++++++++++------
> >>  5 files changed, 72 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index 41e6e5769a2c..b672fc1cdb05 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -71,6 +71,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
> >>  		.encrypted_page = NULL,
> >>  		.is_meta = is_meta,
> >>  	};
> >> +	int err;
> >>  
> >>  	if (unlikely(!is_meta))
> >>  		fio.op_flags &= ~REQ_META;
> >> @@ -85,11 +86,12 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
> >>  
> >>  	fio.page = page;
> >>  
> >> -	if (f2fs_submit_page_bio(&fio)) {
> >> +	err = f2fs_submit_page_bio(&fio);
> >> +	if (err) {
> >>  		memset(page_address(page), 0, PAGE_SIZE);
> > 
> > No reason to do memset(), if we handle an error?
> 
> Agreed.
> 
> > 
> >> +		f2fs_put_page(page, 1);
> >>  		f2fs_stop_checkpoint(sbi, false);
> >> -		f2fs_bug_on(sbi, 1);
> > 
> > Keep to f2fs_bug_on(1)?
> 
> If we want to report error return value to caller, we should not let system
> panic here?
> 
> > 
> >> -		return page;
> >> +		return ERR_PTR(err);
> >>  	}
> >>  
> >>  	lock_page(page);
> > 
> > Need to return an error if read_end_io is failed below in the path.
> 
> Agreed, previously, I found that if we propagate the error to get_node_info(),
> it will be a little hard to handle, anyway, let me try.
> 
> > 
> >> @@ -658,9 +660,15 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
> >>  	f2fs_ra_meta_pages(sbi, start_blk, orphan_blocks, META_CP, true);
> >>  
> >>  	for (i = 0; i < orphan_blocks; i++) {
> >> -		struct page *page = f2fs_get_meta_page(sbi, start_blk + i);
> >> +		struct page *page;
> >>  		struct f2fs_orphan_block *orphan_blk;
> >>  
> >> +		page = f2fs_get_meta_page(sbi, start_blk + i);
> >> +		if (IS_ERR(page)) {
> >> +			err = PTR_ERR(page);
> >> +			goto out;
> >> +		}
> >> +
> >>  		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
> >>  		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
> >>  			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
> >> @@ -751,6 +759,9 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
> >>  	__u32 crc = 0;
> >>  
> >>  	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
> >> +	if (IS_ERR(*cp_page))
> >> +		return PTR_ERR(*cp_page);
> >> +
> >>  	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
> >>  
> >>  	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
> >> @@ -876,6 +887,8 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
> >>  		unsigned char *ckpt = (unsigned char *)sbi->ckpt;
> >>  
> >>  		cur_page = f2fs_get_meta_page(sbi, cp_blk_no + i);
> >> +		if (IS_ERR(cur_page))
> >> +			goto free_fail_no_cp;
> >>  		sit_bitmap_ptr = page_address(cur_page);
> >>  		memcpy(ckpt + i * blk_size, sit_bitmap_ptr, blk_size);
> >>  		f2fs_put_page(cur_page, 1);
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 359526d88d3f..76b51a0de3cd 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -2864,7 +2864,7 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
> >>  void f2fs_recover_inline_xattr(struct inode *inode, struct page *page);
> >>  int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
> >>  int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
> >> -void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >> +int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >>  			unsigned int segno, struct f2fs_summary_block *sum);
> >>  void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
> >>  int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
> >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >> index c48e2a2e5e82..248d401bf40a 100644
> >> --- a/fs/f2fs/node.c
> >> +++ b/fs/f2fs/node.c
> >> @@ -113,25 +113,26 @@ static void clear_node_page_dirty(struct page *page)
> >>  
> >>  static struct page *get_current_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
> >>  {
> >> -	pgoff_t index = current_nat_addr(sbi, nid);
> >> -	return f2fs_get_meta_page(sbi, index);
> >> +	struct page *page;
> >> +
> >> +	page = f2fs_get_meta_page(sbi, current_nat_addr(sbi, nid));
> >> +	BUG_ON(IS_ERR(page));
> > 
> > Do we need this at this moment?
> 
> How can we handle this condition if there occurs read failure in
> __get_meta_page()? just retrying f2fs_get_meta_page()?

IMO, retrying Would be better, since I've concerned about fault injection test.

Thanks,

> 
> > 
> >> +	return page;
> >>  }
> >>  
> >>  static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
> >>  {
> >>  	struct page *src_page;
> >>  	struct page *dst_page;
> >> -	pgoff_t src_off;
> >>  	pgoff_t dst_off;
> >>  	void *src_addr;
> >>  	void *dst_addr;
> >>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >>  
> >> -	src_off = current_nat_addr(sbi, nid);
> >> -	dst_off = next_nat_addr(sbi, src_off);
> >> +	dst_off = next_nat_addr(sbi, current_nat_addr(sbi, nid));
> >>  
> >>  	/* get current nat block page with lock */
> >> -	src_page = f2fs_get_meta_page(sbi, src_off);
> >> +	src_page = get_current_nat_page(sbi, nid);
> > 
> > This is a different clean-up change.
> 
> Yes, let me split this into another cleanup patch.
> 
> Thanks,
> 
> > 
> >>  	dst_page = f2fs_grab_meta_page(sbi, dst_off);
> >>  	f2fs_bug_on(sbi, PageDirty(src_page));
> >>  
> >> @@ -2502,7 +2503,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
> >>  	return 0;
> >>  }
> >>  
> >> -void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >> +int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >>  			unsigned int segno, struct f2fs_summary_block *sum)
> >>  {
> >>  	struct f2fs_node *rn;
> >> @@ -2524,6 +2525,9 @@ void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >>  		for (idx = addr; idx < addr + nrpages; idx++) {
> >>  			struct page *page = f2fs_get_tmp_page(sbi, idx);
> >>  
> >> +			if (IS_ERR(page))
> >> +				return PTR_ERR(page);
> >> +
> >>  			rn = F2FS_NODE(page);
> >>  			sum_entry->nid = rn->footer.nid;
> >>  			sum_entry->version = 0;
> >> @@ -2535,6 +2539,7 @@ void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >>  		invalidate_mapping_pages(META_MAPPING(sbi), addr,
> >>  							addr + nrpages);
> >>  	}
> >> +	return 0;
> >>  }
> >>  
> >>  static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> >> @@ -2771,7 +2776,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
> >>  	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
> >>  						nm_i->nat_bits_blocks;
> >>  	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
> >> -		struct page *page = f2fs_get_meta_page(sbi, nat_bits_addr++);
> >> +		struct page *page;
> >> +
> >> +		page = f2fs_get_meta_page(sbi, nat_bits_addr++);
> >> +		if (IS_ERR(page)) {
> >> +			disable_nat_bits(sbi, true);
> >> +			return PTR_ERR(page);
> >> +		}
> >>  
> >>  		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
> >>  					page_address(page), F2FS_BLKSIZE);
> >> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> >> index 0d927ae26c48..ac70d5547a97 100644
> >> --- a/fs/f2fs/recovery.c
> >> +++ b/fs/f2fs/recovery.c
> >> @@ -256,6 +256,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
> >>  			return 0;
> >>  
> >>  		page = f2fs_get_tmp_page(sbi, blkaddr);
> >> +		if (IS_ERR(page)) {
> >> +			err = PTR_ERR(page);
> >> +			break;
> >> +		}
> >>  
> >>  		if (!is_recoverable_dnode(page))
> >>  			break;
> >> @@ -574,6 +578,10 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
> >>  		f2fs_ra_meta_pages_cond(sbi, blkaddr);
> >>  
> >>  		page = f2fs_get_tmp_page(sbi, blkaddr);
> >> +		if (IS_ERR(page)) {
> >> +			err = PTR_ERR(page);
> >> +			break;
> >> +		}
> >>  
> >>  		if (!is_recoverable_dnode(page)) {
> >>  			f2fs_put_page(page, 1);
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index e55188975fcc..22600002c690 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -2096,7 +2096,11 @@ int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
> >>   */
> >>  struct page *f2fs_get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
> >>  {
> >> -	return f2fs_get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
> >> +	struct page *page;
> >> +
> >> +	page = f2fs_get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
> >> +	BUG_ON(IS_ERR(page));
> > 
> > Ditto.
> > 
> >> +	return page;
> >>  }
> >>  
> >>  void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
> >> @@ -3122,7 +3126,7 @@ void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
> >>  	}
> >>  }
> >>  
> >> -static void read_compacted_summaries(struct f2fs_sb_info *sbi)
> >> +static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> >>  {
> >>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> >>  	struct curseg_info *seg_i;
> >> @@ -3134,6 +3138,8 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
> >>  	start = start_sum_block(sbi);
> >>  
> >>  	page = f2fs_get_meta_page(sbi, start++);
> >> +	if (IS_ERR(page))
> >> +		return PTR_ERR(page);
> >>  	kaddr = (unsigned char *)page_address(page);
> >>  
> >>  	/* Step 1: restore nat cache */
> >> @@ -3174,11 +3180,14 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
> >>  			page = NULL;
> >>  
> >>  			page = f2fs_get_meta_page(sbi, start++);
> >> +			if (IS_ERR(page))
> >> +				return PTR_ERR(page);
> >>  			kaddr = (unsigned char *)page_address(page);
> >>  			offset = 0;
> >>  		}
> >>  	}
> >>  	f2fs_put_page(page, 1);
> >> +	return 0;
> >>  }
> >>  
> >>  static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
> >> @@ -3190,6 +3199,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
> >>  	unsigned short blk_off;
> >>  	unsigned int segno = 0;
> >>  	block_t blk_addr = 0;
> >> +	int err = 0;
> >>  
> >>  	/* get segment number and block addr */
> >>  	if (IS_DATASEG(type)) {
> >> @@ -3213,6 +3223,8 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
> >>  	}
> >>  
> >>  	new = f2fs_get_meta_page(sbi, blk_addr);
> >> +	if (IS_ERR(new))
> >> +		return PTR_ERR(new);
> >>  	sum = (struct f2fs_summary_block *)page_address(new);
> >>  
> >>  	if (IS_NODESEG(type)) {
> >> @@ -3224,7 +3236,9 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
> >>  				ns->ofs_in_node = 0;
> >>  			}
> >>  		} else {
> >> -			f2fs_restore_node_summary(sbi, segno, sum);
> >> +			err = f2fs_restore_node_summary(sbi, segno, sum);
> >> +			if (err)
> >> +				goto out;
> >>  		}
> >>  	}
> >>  
> >> @@ -3244,8 +3258,9 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
> >>  	curseg->alloc_type = ckpt->alloc_type[type];
> >>  	curseg->next_blkoff = blk_off;
> >>  	mutex_unlock(&curseg->curseg_mutex);
> >> +out:
> >>  	f2fs_put_page(new, 1);
> >> -	return 0;
> >> +	return err;
> >>  }
> >>  
> >>  static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
> >> @@ -3263,7 +3278,9 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
> >>  							META_CP, true);
> >>  
> >>  		/* restore for compacted data summary */
> >> -		read_compacted_summaries(sbi);
> >> +		err = read_compacted_summaries(sbi);
> >> +		if (err)
> >> +			return err;
> >>  		type = CURSEG_HOT_NODE;
> >>  	}
> >>  
> >> @@ -3394,7 +3411,11 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
> >>  static struct page *get_current_sit_page(struct f2fs_sb_info *sbi,
> >>  					unsigned int segno)
> >>  {
> >> -	return f2fs_get_meta_page(sbi, current_sit_addr(sbi, segno));
> >> +	struct page *page;
> >> +
> >> +	page = f2fs_get_meta_page(sbi, current_sit_addr(sbi, segno));
> >> +	BUG_ON(IS_ERR(page));
> > 
> > Ditoo.
> > 
> >> +	return page;
> >>  }
> >>  
> >>  static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
> >> -- 
> >> 2.16.2.17.g38e79b1fd
