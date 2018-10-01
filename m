Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6312089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F59yjXaV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V9Aiuhgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6312089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeJAM7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:59:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeJAM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:59:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14DD760265; Mon,  1 Oct 2018 06:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538375020;
        bh=oAiqR396/E54yR0Ax1mSvAJpoxGLbSTU+rN1F77pQ/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F59yjXaVVKbZ1qZrvj/yf0SefVwT2OpPXNa5WKILKgWepMH3WOrjVfqVRhopdyIAw
         EguYVGDNObtOKWlzZJA9sVZXBKOMF7xrScEKk9FIn1p6HVlYDaAwOMIzoopofr5FH7
         JEe1JS8QUWCU/nlJvEUz/3GB32vMIU1XNLEd2VTI=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B215A60265;
        Mon,  1 Oct 2018 06:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538375017;
        bh=oAiqR396/E54yR0Ax1mSvAJpoxGLbSTU+rN1F77pQ/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9AiuhguNu8aefi2qK5hG5GT8P7m35+px4AOf9JAZDIZWca3MT396PrWC/lNKS1G0
         /yHgha50vGU7mOoBoeVpnc9TjTIalATz0uDbmjMDPbOUv/X+EZAlX9y53PzTThJNCw
         gfbw1Cj1r36MzRTiTkUNJjQ+sioeekZMH72K4AT8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B215A60265
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 1 Oct 2018 11:53:32 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: submit cached bio to avoid endless
 PageWriteback
Message-ID: <20181001062332.GL22939@codeaurora.org>
References: <8b1571fa-ef41-4ab3-187c-d6caf7a2ebe1@huawei.com>
 <20180918020226.GA83471@jaegeuk-macbookpro.roam.corp.google.com>
 <acb91226-bb83-3d7f-3ac8-db7a3ee24172@huawei.com>
 <ab15ea97-0ad8-ce85-3f3c-197ecc0c4e16@kernel.org>
 <20180926002033.GB3829@jaegeuk-macbookpro.roam.corp.google.com>
 <f230fe9c-9560-1f16-178b-810b54461d1f@huawei.com>
 <20180926014221.GD3829@jaegeuk-macbookpro.roam.corp.google.com>
 <8a3256b9-e198-e0e1-6dea-4ac5d06e21b1@huawei.com>
 <20180926033226.GH3829@jaegeuk-macbookpro.roam.corp.google.com>
 <02874ab0-ea45-8f99-4551-a73b8a615024@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02874ab0-ea45-8f99-4551-a73b8a615024@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:20:38PM +0800, Chao Yu wrote:

Hi Chao, Jaegeuk,

Is there any further any conclusion on this thread?

I think we still need this patch in addition to another patch from Chao -
"Revert: "f2fs: check last page index in cached bio to decide submission""
to make sure it covers the encrypted data block path as well.

Thanks,
Sahitya.

> On 2018/9/26 11:32, Jaegeuk Kim wrote:
> > On 09/26, Chao Yu wrote:
> >> On 2018/9/26 9:42, Jaegeuk Kim wrote:
> >>> On 09/26, Chao Yu wrote:
> >>>> On 2018/9/26 8:20, Jaegeuk Kim wrote:
> >>>>> On 09/21, Chao Yu wrote:
> >>>>>> On 2018/9/18 10:14, Chao Yu wrote:
> >>>>>>> On 2018/9/18 10:02, Jaegeuk Kim wrote:
> >>>>>>>> On 09/18, Chao Yu wrote:
> >>>>>>>>> On 2018/9/18 9:37, Jaegeuk Kim wrote:
> >>>>>>>>>> On 09/18, Chao Yu wrote:
> >>>>>>>>>>> On 2018/9/18 9:04, Jaegeuk Kim wrote:
> >>>>>>>>>>>> On 09/13, Chao Yu wrote:
> >>>>>>>>>>>>> From: Chao Yu <yuchao0@huawei.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> When migrating encrypted block from background GC thread, we only add
> >>>>>>>>>>>>> them into f2fs inner bio cache, but forget to submit the cached bio, it
> >>>>>>>>>>>>> may cause potential deadlock when we are waiting page writebacked, fix
> >>>>>>>>>>>>> it.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>> v3:
> >>>>>>>>>>>>> clean up codes suggested by Jaegeuk.
> >>>>>>>>>>>>>  fs/f2fs/f2fs.h |  2 +-
> >>>>>>>>>>>>>  fs/f2fs/gc.c   | 71 +++++++++++++++++++++++++++++++++++---------------
> >>>>>>>>>>>>>  fs/f2fs/node.c | 13 ++++++---
> >>>>>>>>>>>>>  3 files changed, 61 insertions(+), 25 deletions(-)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>>>>>>>>>> index b676b82312e0..917b2ca76aac 100644
> >>>>>>>>>>>>> --- a/fs/f2fs/f2fs.h
> >>>>>>>>>>>>> +++ b/fs/f2fs/f2fs.h
> >>>>>>>>>>>>> @@ -2869,7 +2869,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
> >>>>>>>>>>>>>  void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
> >>>>>>>>>>>>>  struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
> >>>>>>>>>>>>>  struct page *f2fs_get_node_page_ra(struct page *parent, int start);
> >>>>>>>>>>>>> -void f2fs_move_node_page(struct page *node_page, int gc_type);
> >>>>>>>>>>>>> +int f2fs_move_node_page(struct page *node_page, int gc_type);
> >>>>>>>>>>>>>  int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> >>>>>>>>>>>>>  			struct writeback_control *wbc, bool atomic,
> >>>>>>>>>>>>>  			unsigned int *seq_id);
> >>>>>>>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>>>>>>>>>>>> index a4c1a419611d..f57622cfe058 100644
> >>>>>>>>>>>>> --- a/fs/f2fs/gc.c
> >>>>>>>>>>>>> +++ b/fs/f2fs/gc.c
> >>>>>>>>>>>>> @@ -461,7 +461,7 @@ static int check_valid_map(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>   * On validity, copy that node with cold status, otherwise (invalid node)
> >>>>>>>>>>>>>   * ignore that.
> >>>>>>>>>>>>>   */
> >>>>>>>>>>>>> -static void gc_node_segment(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>> +static int gc_node_segment(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  		struct f2fs_summary *sum, unsigned int segno, int gc_type)
> >>>>>>>>>>>>>  {
> >>>>>>>>>>>>>  	struct f2fs_summary *entry;
> >>>>>>>>>>>>> @@ -469,6 +469,7 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  	int off;
> >>>>>>>>>>>>>  	int phase = 0;
> >>>>>>>>>>>>>  	bool fggc = (gc_type == FG_GC);
> >>>>>>>>>>>>> +	int submitted = 0;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	start_addr = START_BLOCK(sbi, segno);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> @@ -482,10 +483,11 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  		nid_t nid = le32_to_cpu(entry->nid);
> >>>>>>>>>>>>>  		struct page *node_page;
> >>>>>>>>>>>>>  		struct node_info ni;
> >>>>>>>>>>>>> +		int err;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  		/* stop BG_GC if there is not enough free sections. */
> >>>>>>>>>>>>>  		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
> >>>>>>>>>>>>> -			return;
> >>>>>>>>>>>>> +			return submitted;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  		if (check_valid_map(sbi, segno, off) == 0)
> >>>>>>>>>>>>>  			continue;
> >>>>>>>>>>>>> @@ -522,7 +524,9 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  			continue;
> >>>>>>>>>>>>>  		}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> -		f2fs_move_node_page(node_page, gc_type);
> >>>>>>>>>>>>> +		err = f2fs_move_node_page(node_page, gc_type);
> >>>>>>>>>>>>> +		if (!err && gc_type == FG_GC)
> >>>>>>>>>>>>> +			submitted++;
> >>>>>>>>>>>>>  		stat_inc_node_blk_count(sbi, 1, gc_type);
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> @@ -531,6 +535,7 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	if (fggc)
> >>>>>>>>>>>>>  		atomic_dec(&sbi->wb_sync_req[NODE]);
> >>>>>>>>>>>>> +	return submitted;
> >>>>>>>>>>>>>  }
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  /*
> >>>>>>>>>>>>> @@ -666,7 +671,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
> >>>>>>>>>>>>>   * Move data block via META_MAPPING while keeping locked data page.
> >>>>>>>>>>>>>   * This can be used to move blocks, aka LBAs, directly on disk.
> >>>>>>>>>>>>>   */
> >>>>>>>>>>>>> -static void move_data_block(struct inode *inode, block_t bidx,
> >>>>>>>>>>>>> +static int move_data_block(struct inode *inode, block_t bidx,
> >>>>>>>>>>>>>  				int gc_type, unsigned int segno, int off)
> >>>>>>>>>>>>
> >>>>>>>>>>>> We don't need to submit IOs in this case.
> >>>>>>>>>>>
> >>>>>>>>>>> Actually, previously, we missed to submit IOs for encrypted block only in
> >>>>>>>>>>> BGGC, so we fix to submit for this case, all other codes are cleanups. Right?
> >>>>>>>>>>
> >>>>>>>>>> The move_data_block migrates encrypted blocks all the time with meta page IOs.
> >>>>>>>>>> I don't know what you're saying about BGGC.
> >>>>>>>>>
> >>>>>>>>> In move_data_block(), we use f2fs_submit_page_write() to add encrypted page
> >>>>>>>>> in to sbi->write_io[META].bio cache, so before exit GC, we need to submit
> >>>>>>>>> this cache by f2fs_submit_merged_write(), otherwise bio with encrypted page
> >>>>>>>>> will be cached in sbi->write_io[META].bio for long time, since we only
> >>>>>>>>> submmit this bio cache in foreground GC.
> >>>>>>>>>
> >>>>>>>>> if (gc_type == FG_GC)
> >>>>>>>>> 	f2fs_submit_merged_write(sbi,
> >>>>>>>>> 				(type == SUM_TYPE_NODE) ? NODE : DATA);
> >>>>>>>>
> >>>>>>>> Does this issue pending META IOs? I think META won't block any NODE/DATA
> >>>>>>>> pages. Moreover checkpoint or reading the moved block make the IOs be flushed,
> >>>>>>>> so it doesn't hurt the consistency.
> >>>>>>
> >>>>>> It may cause long latency before someone flushes the meta IO, how about flushing
> >>>>>> IO like other flows, like writepages?
> >>>>>>
> >>>>>> Or is there any benefit that we still cache meta IO after GC?
> >>>>>>
> >>>>>>>
> >>>>>>> I just guess below endless waiting for page writeback is cased by this case
> >>>>>>
> >>>>>> Any thoughts?
> >>>>>
> >>>>> I'm waiting for the previous reported issue. Do we have this in products?
> >>>>
> >>>> I didn't see such stack in products.
> >>>>
> >>>> BTW, I added one patch in my tree, although this patch is not correct now
> >>>> since it is missing to submit bio in some cases, it can easily reproduce
> >>>> such stack, so I guess there is still at least one place we didn't submit
> >>>> bio correctly.
> >>>
> >>> How can we easily reproduce this? Why do we need to submit all of them?
> >>
> >> In f2fs_write_cache_pages(), if we only check page with last_idx is not enough?
> >>
> >> 1. cache page (idx = 1) in cold data bio cache
> >> 2. cache page (idx = 2) in warm data bio cache and submitted bio cache
> >> 3. f2fs_submit_merged_write_cond tries to check page (idx = 2), but this
> >> page is not in bio cache, so we missed to submit code data bio cache, right?
> > 
> > Oh, do we need to check temp when submit_bio? e.g., if it's different temp,
> > we can submit the previous fio.
> 
> Oh, I suspect that we will submit bio unnecessarily, or do I misunderstand
> your idea?
> 
> IMO, how about just checking whether there is page in all [HOT|WARM|COLD]
> bio caches belong to inode which caller want to flush/fsync, if there is,
> then submit that bio.
> 
> That would be more simple to implement.
> 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=2ca666658fc1958ab176030d435efa2ce325aa52
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> -000|__switch_to()
> >>>>>>>
> >>>>>>> -001|__schedule()
> >>>>>>>
> >>>>>>> -002|need_resched(inline)
> >>>>>>>
> >>>>>>> -002|schedule()
> >>>>>>>
> >>>>>>> -003|schedule_timeout()
> >>>>>>>
> >>>>>>> -004|get_current(inline)
> >>>>>>>
> >>>>>>> -004|io_schedule_timeout()
> >>>>>>>
> >>>>>>> -005|bit_wait_io()
> >>>>>>>
> >>>>>>> -006|__wait_on_bit()
> >>>>>>>
> >>>>>>> -007|wait_on_page_bit()
> >>>>>>>
> >>>>>>> -008|PageWriteback(inline)
> >>>>>>>
> >>>>>>> -008|wait_on_page_writeback(inline)
> >>>>>>>
> >>>>>>> -008|__filemap_fdatawait_range()
> >>>>>>>
> >>>>>>> -009|filemap_fdatawait_keep_errors()
> >>>>>>>
> >>>>>>> -010|sync_inodes_sb()
> >>>>>>>
> >>>>>>> -011|__sync_filesystem(inline)
> >>>>>>>
> >>>>>>> -011|sync_filesystem()
> >>>>>>>
> >>>>>>> -012|generic_shutdown_super()
> >>>>>>>
> >>>>>>> -013|kill_block_super()
> >>>>>>>
> >>>>>>> -014|kill_f2fs_super()
> >>>>>>>
> >>>>>>> -015|deactivate_locked_super()
> >>>>>>>
> >>>>>>> -016|deactivate_super()
> >>>>>>>
> >>>>>>> -017|mnt_free_id(inline)
> >>>>>>>
> >>>>>>> -017|cleanup_mnt()
> >>>>>>>
> >>>>>>> -018|__cleanup_mnt()
> >>>>>>>
> >>>>>>> -019|task_work_run()
> >>>>>>>
> >>>>>>> -020|do_notify_resume()
> >>>>>>>
> >>>>>>> -021|work_pending(asm)
> >>>>>>>
> >>>>>>> -->|exception
> >>>>>>>
> >>>>>>> -022|NUX:0x539E58(asm)
> >>>>>>>
> >>>>>>> ---|end of frame
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>>  {
> >>>>>>>>>>>>>  	struct f2fs_io_info fio = {
> >>>>>>>>>>>>> @@ -685,25 +690,29 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >>>>>>>>>>>>>  	struct node_info ni;
> >>>>>>>>>>>>>  	struct page *page, *mpage;
> >>>>>>>>>>>>>  	block_t newaddr;
> >>>>>>>>>>>>> -	int err;
> >>>>>>>>>>>>> +	int err = 0;
> >>>>>>>>>>>>>  	bool lfs_mode = test_opt(fio.sbi, LFS);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	/* do not read out */
> >>>>>>>>>>>>>  	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
> >>>>>>>>>>>>>  	if (!page)
> >>>>>>>>>>>>> -		return;
> >>>>>>>>>>>>> +		return -ENOMEM;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> -	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> >>>>>>>>>>>>> +	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
> >>>>>>>>>>>>> +		err = -ENOENT;
> >>>>>>>>>>>>>  		goto out;
> >>>>>>>>>>>>> +	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	if (f2fs_is_atomic_file(inode)) {
> >>>>>>>>>>>>>  		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
> >>>>>>>>>>>>>  		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
> >>>>>>>>>>>>> +		err = -EAGAIN;
> >>>>>>>>>>>>>  		goto out;
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	if (f2fs_is_pinned_file(inode)) {
> >>>>>>>>>>>>>  		f2fs_pin_file_control(inode, true);
> >>>>>>>>>>>>> +		err = -EAGAIN;
> >>>>>>>>>>>>>  		goto out;
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> @@ -714,6 +723,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
> >>>>>>>>>>>>>  		ClearPageUptodate(page);
> >>>>>>>>>>>>> +		err = -ENOENT;
> >>>>>>>>>>>>>  		goto put_out;
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> @@ -796,6 +806,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >>>>>>>>>>>>>  	fio.new_blkaddr = newaddr;
> >>>>>>>>>>>>>  	f2fs_submit_page_write(&fio);
> >>>>>>>>>>>>>  	if (fio.retry) {
> >>>>>>>>>>>>> +		err = -EAGAIN;
> >>>>>>>>>>>>>  		if (PageWriteback(fio.encrypted_page))
> >>>>>>>>>>>>>  			end_page_writeback(fio.encrypted_page);
> >>>>>>>>>>>>>  		goto put_page_out;
> >>>>>>>>>>>>> @@ -819,34 +830,42 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >>>>>>>>>>>>>  	f2fs_put_dnode(&dn);
> >>>>>>>>>>>>>  out:
> >>>>>>>>>>>>>  	f2fs_put_page(page, 1);
> >>>>>>>>>>>>> +	return err;
> >>>>>>>>>>>>>  }
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> -static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >>>>>>>>>>>>> +static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >>>>>>>>>>>>>  							unsigned int segno, int off)
> >>>>>>>>>>>>>  {
> >>>>>>>>>>>>>  	struct page *page;
> >>>>>>>>>>>>> +	int err = 0;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	page = f2fs_get_lock_data_page(inode, bidx, true);
> >>>>>>>>>>>>>  	if (IS_ERR(page))
> >>>>>>>>>>>>> -		return;
> >>>>>>>>>>>>> +		return PTR_ERR(page);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> -	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> >>>>>>>>>>>>> +	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
> >>>>>>>>>>>>> +		err = -ENOENT;
> >>>>>>>>>>>>>  		goto out;
> >>>>>>>>>>>>> +	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	if (f2fs_is_atomic_file(inode)) {
> >>>>>>>>>>>>>  		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
> >>>>>>>>>>>>>  		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
> >>>>>>>>>>>>> +		err = -EAGAIN;
> >>>>>>>>>>>>>  		goto out;
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  	if (f2fs_is_pinned_file(inode)) {
> >>>>>>>>>>>>>  		if (gc_type == FG_GC)
> >>>>>>>>>>>>>  			f2fs_pin_file_control(inode, true);
> >>>>>>>>>>>>> +		err = -EAGAIN;
> >>>>>>>>>>>>>  		goto out;
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	if (gc_type == BG_GC) {
> >>>>>>>>>>>>> -		if (PageWriteback(page))
> >>>>>>>>>>>>> +		if (PageWriteback(page)) {
> >>>>>>>>>>>>> +			err = -EAGAIN;
> >>>>>>>>>>>>>  			goto out;
> >>>>>>>>>>>>> +		}
> >>>>>>>>>>>>>  		set_page_dirty(page);
> >>>>>>>>>>>>>  		set_cold_data(page);
> >>>>>>>>>>>>>  	} else {
> >>>>>>>>>>>>> @@ -864,7 +883,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >>>>>>>>>>>>>  			.io_type = FS_GC_DATA_IO,
> >>>>>>>>>>>>>  		};
> >>>>>>>>>>>>>  		bool is_dirty = PageDirty(page);
> >>>>>>>>>>>>> -		int err;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  retry:
> >>>>>>>>>>>>>  		set_page_dirty(page);
> >>>>>>>>>>>>> @@ -889,6 +907,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  out:
> >>>>>>>>>>>>>  	f2fs_put_page(page, 1);
> >>>>>>>>>>>>> +	return err;
> >>>>>>>>>>>>>  }
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  /*
> >>>>>>>>>>>>> @@ -898,7 +917,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >>>>>>>>>>>>>   * If the parent node is not valid or the data block address is different,
> >>>>>>>>>>>>>   * the victim data block is ignored.
> >>>>>>>>>>>>>   */
> >>>>>>>>>>>>> -static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>>>>>>>>>> +static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>>>>>>>>>>  		struct gc_inode_list *gc_list, unsigned int segno, int gc_type)
> >>>>>>>>>>>>>  {
> >>>>>>>>>>>>>  	struct super_block *sb = sbi->sb;
> >>>>>>>>>>>>> @@ -906,6 +925,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>>>>>>>>>>  	block_t start_addr;
> >>>>>>>>>>>>>  	int off;
> >>>>>>>>>>>>>  	int phase = 0;
> >>>>>>>>>>>>> +	int submitted = 0;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	start_addr = START_BLOCK(sbi, segno);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> @@ -922,7 +942,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  		/* stop BG_GC if there is not enough free sections. */
> >>>>>>>>>>>>>  		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
> >>>>>>>>>>>>> -			return;
> >>>>>>>>>>>>> +			return submitted;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  		if (check_valid_map(sbi, segno, off) == 0)
> >>>>>>>>>>>>>  			continue;
> >>>>>>>>>>>>> @@ -994,6 +1014,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>>>>>>>>>>  		if (inode) {
> >>>>>>>>>>>>>  			struct f2fs_inode_info *fi = F2FS_I(inode);
> >>>>>>>>>>>>>  			bool locked = false;
> >>>>>>>>>>>>> +			int err;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  			if (S_ISREG(inode->i_mode)) {
> >>>>>>>>>>>>>  				if (!down_write_trylock(&fi->i_gc_rwsem[READ]))
> >>>>>>>>>>>>> @@ -1013,12 +1034,16 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>>>>>>>>>>  			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
> >>>>>>>>>>>>>  								+ ofs_in_node;
> >>>>>>>>>>>>>  			if (f2fs_post_read_required(inode))
> >>>>>>>>>>>>> -				move_data_block(inode, start_bidx, gc_type,
> >>>>>>>>>>>>> -								segno, off);
> >>>>>>>>>>>>> +				err = move_data_block(inode, start_bidx,
> >>>>>>>>>>>>> +							gc_type, segno, off);
> >>>>>>>>>>>>>  			else
> >>>>>>>>>>>>> -				move_data_page(inode, start_bidx, gc_type,
> >>>>>>>>>>>>> +				err = move_data_page(inode, start_bidx, gc_type,
> >>>>>>>>>>>>>  								segno, off);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> +			if (!err && (gc_type == FG_GC ||
> >>>>>>>>>>>>> +					f2fs_post_read_required(inode)))
> >>>>>>>>>>>>> +				submitted++;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>>  			if (locked) {
> >>>>>>>>>>>>>  				up_write(&fi->i_gc_rwsem[WRITE]);
> >>>>>>>>>>>>>  				up_write(&fi->i_gc_rwsem[READ]);
> >>>>>>>>>>>>> @@ -1030,6 +1055,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	if (++phase < 5)
> >>>>>>>>>>>>>  		goto next_step;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +	return submitted;
> >>>>>>>>>>>>>  }
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
> >>>>>>>>>>>>> @@ -1057,6 +1084,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  	int seg_freed = 0;
> >>>>>>>>>>>>>  	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
> >>>>>>>>>>>>>  						SUM_TYPE_DATA : SUM_TYPE_NODE;
> >>>>>>>>>>>>> +	int submitted = 0;
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  	/* readahead multi ssa blocks those have contiguous address */
> >>>>>>>>>>>>>  	if (sbi->segs_per_sec > 1)
> >>>>>>>>>>>>> @@ -1100,10 +1128,11 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  		 *                                  - lock_page(sum_page)
> >>>>>>>>>>>>>  		 */
> >>>>>>>>>>>>>  		if (type == SUM_TYPE_NODE)
> >>>>>>>>>>>>> -			gc_node_segment(sbi, sum->entries, segno, gc_type);
> >>>>>>>>>>>>> -		else
> >>>>>>>>>>>>> -			gc_data_segment(sbi, sum->entries, gc_list, segno,
> >>>>>>>>>>>>> +			submitted += gc_node_segment(sbi, sum->entries, segno,
> >>>>>>>>>>>>>  								gc_type);
> >>>>>>>>>>>>> +		else
> >>>>>>>>>>>>> +			submitted += gc_data_segment(sbi, sum->entries, gc_list,
> >>>>>>>>>>>>> +							segno, gc_type);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  		stat_inc_seg_count(sbi, type, gc_type);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> @@ -1114,7 +1143,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> >>>>>>>>>>>>>  		f2fs_put_page(sum_page, 0);
> >>>>>>>>>>>>>  	}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> -	if (gc_type == FG_GC)
> >>>>>>>>>>>>> +	if (submitted)
> >>>>>>>>>>>>>  		f2fs_submit_merged_write(sbi,
> >>>>>>>>>>>>>  				(type == SUM_TYPE_NODE) ? NODE : DATA);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >>>>>>>>>>>>> index fa2381c0bc47..214dd6326b4b 100644
> >>>>>>>>>>>>> --- a/fs/f2fs/node.c
> >>>>>>>>>>>>> +++ b/fs/f2fs/node.c
> >>>>>>>>>>>>> @@ -1584,8 +1584,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
> >>>>>>>>>>>>>  	return AOP_WRITEPAGE_ACTIVATE;
> >>>>>>>>>>>>>  }
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>> -void f2fs_move_node_page(struct page *node_page, int gc_type)
> >>>>>>>>>>>>> +int f2fs_move_node_page(struct page *node_page, int gc_type)
> >>>>>>>>>>>>>  {
> >>>>>>>>>>>>> +	int err = 0;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>>  	if (gc_type == FG_GC) {
> >>>>>>>>>>>>>  		struct writeback_control wbc = {
> >>>>>>>>>>>>>  			.sync_mode = WB_SYNC_ALL,
> >>>>>>>>>>>>> @@ -1597,12 +1599,16 @@ void f2fs_move_node_page(struct page *node_page, int gc_type)
> >>>>>>>>>>>>>  		f2fs_wait_on_page_writeback(node_page, NODE, true);
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  		f2fs_bug_on(F2FS_P_SB(node_page), PageWriteback(node_page));
> >>>>>>>>>>>>> -		if (!clear_page_dirty_for_io(node_page))
> >>>>>>>>>>>>> +		if (!clear_page_dirty_for_io(node_page)) {
> >>>>>>>>>>>>> +			err = -EAGAIN;
> >>>>>>>>>>>>>  			goto out_page;
> >>>>>>>>>>>>> +		}
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  		if (__write_node_page(node_page, false, NULL,
> >>>>>>>>>>>>> -					&wbc, false, FS_GC_NODE_IO, NULL))
> >>>>>>>>>>>>> +					&wbc, false, FS_GC_NODE_IO, NULL)) {
> >>>>>>>>>>>>> +			err = -EAGAIN;
> >>>>>>>>>>>>>  			unlock_page(node_page);
> >>>>>>>>>>>>> +		}
> >>>>>>>>>>>>>  		goto release_page;
> >>>>>>>>>>>>>  	} else {
> >>>>>>>>>>>>>  		/* set page dirty and write it */
> >>>>>>>>>>>>> @@ -1613,6 +1619,7 @@ void f2fs_move_node_page(struct page *node_page, int gc_type)
> >>>>>>>>>>>>>  	unlock_page(node_page);
> >>>>>>>>>>>>>  release_page:
> >>>>>>>>>>>>>  	f2fs_put_page(node_page, 0);
> >>>>>>>>>>>>> +	return err;
> >>>>>>>>>>>>>  }
> >>>>>>>>>>>>>  
> >>>>>>>>>>>>>  static int f2fs_write_node_page(struct page *page,
> >>>>>>>>>>>>> -- 
> >>>>>>>>>>>>> 2.18.0
> >>>>>>>>>>>>
> >>>>>>>>>>>> .
> >>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> .
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>>> .
> >>>>>>>>
> >>>>>>>
> >>>>>
> >>>>> .
> >>>>>
> >>>
> >>> .
> >>>
> > 
> > .
> > 
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
