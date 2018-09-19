Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEC7ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FA72151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+W5bRZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FA72151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeITBHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbeITBHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:07:03 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE5E208A3;
        Wed, 19 Sep 2018 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537385260;
        bh=s7wZIOQx9pYmJ2pDqKJhz5GkOq0SDz5Zy8uE0Vq1Bnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+W5bRZmrluIgePyMxJlKhabQAfkuNg9QRWSONT3kHal3hdcTOHZYM2VimDA7SQa4
         f1Itt25IdnPZHIU874uF+FUJVBT5jQKyfhJ3nG0FB+t9ix+q5fCsiqVaReNRvCIZXJ
         B9JsihG6L98wXTM6FcBrolsEHYGVEOJVaqk3hYmk=
Date:   Wed, 19 Sep 2018 12:27:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: allow out-place-update for direct IO in LFS mode
Message-ID: <20180919192739.GA64994@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180916133407.26802-1-chao@kernel.org>
 <20180918012701.GC79604@jaegeuk-macbookpro.roam.corp.google.com>
 <7ba874d6-9ba4-4247-e31d-488d8ffe7cca@huawei.com>
 <20180918162719.GA91945@jaegeuk-macbookpro.roam.corp.google.com>
 <84f67dc2-8907-cb2f-2b18-5278bc75c76a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f67dc2-8907-cb2f-2b18-5278bc75c76a@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19, Chao Yu wrote:
> On 2018/9/19 0:27, Jaegeuk Kim wrote:
> > On 09/18, Chao Yu wrote:
> >> On 2018/9/18 9:27, Jaegeuk Kim wrote:
> >>> On 09/16, Chao Yu wrote:
> >>>> From: Chao Yu <yuchao0@huawei.com>
> >>>>
> >>>> Normally, DIO uses in-pllace-update, but in LFS mode, f2fs doesn't
> >>>> allow triggering any in-place-update writes, so we fallback direct
> >>>> write to buffered write, result in bad performance of large size
> >>>> write.
> >>>
> >>> I remember this is to serialize all the IOs in one buffered IO path to keep
> >>> the IO sequence espeicially useful for SMR drivers. Could you confirm whether
> >>> there is any IO reordering problem?
> >>
> >> IMO, buffered IO will encounter reordering issue more easily, for example:
> >>
> >> User write 2mb data via DIO, but according to policy on LFS mode, it will
> >> fallback to buffered IO.
> >>
> >> Before dio triggers writeback, an async writeback from background is
> >> triggered, so all IO distribution can be:
> >>
> >> 		page		LBA range
> >> async IO:	0 - 255		x + 0, x + 255
> >> sync IO:	256 - 511	x + 256, x + 511
> >>
> >> Then block IO scheduler can issue sync IO before async IO, result IO
> >> reordering.
> >>
> >> Anyway, in DIO path we will suffer less IO reordering issue.
> > 
> > My concern was on mixed DIO and buffered IOs where we don't have a way to
> > serialize all the IOs.
> 
> As I explained above, even we always use buffered IO, there is no such
> guarantee for serializing all async/sync IO in block layer, am I missing
> something?
> 
> If you really don't want to change the logic for SMR, how about let me just
> leave that case?

Okay, that could be fine to me.
Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> This patch adds to support triggering out-place-update for direct IO
> >>>> to enhance its performance.
> >>>>
> >>>> Note that it needs to exclude direct read IO during direct write,
> >>>> since new data writing to new block address will no be valid until
> >>>> write finished.
> >>>>
> >>>> storage: zram
> >>>>
> >>>> time xfs_io -f -d /mnt/f2fs/file -c "pwrite 0 1073741824" -c "fsync"
> >>>>
> >>>> Before:
> >>>> real	0m13.061s
> >>>> user	0m0.327s
> >>>> sys	0m12.486s
> >>>>
> >>>> After:
> >>>> real	0m6.448s
> >>>> user	0m0.228s
> >>>> sys	0m6.212s
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>>  fs/f2fs/data.c | 41 +++++++++++++++++++++++++++++++++--------
> >>>>  fs/f2fs/f2fs.h | 39 +++++++++++++++++++++++++++++++++++----
> >>>>  fs/f2fs/file.c |  3 ++-
> >>>>  3 files changed, 70 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>> index 048f9cf1d589..9937dc2f384a 100644
> >>>> --- a/fs/f2fs/data.c
> >>>> +++ b/fs/f2fs/data.c
> >>>> @@ -894,7 +894,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
> >>>>  
> >>>>  	dn->data_blkaddr = datablock_addr(dn->inode,
> >>>>  				dn->node_page, dn->ofs_in_node);
> >>>> -	if (dn->data_blkaddr == NEW_ADDR)
> >>>> +	if (dn->data_blkaddr != NULL_ADDR)
> >>>>  		goto alloc;
> >>>>  
> >>>>  	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
> >>>> @@ -950,7 +950,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
> >>>>  
> >>>>  	if (direct_io) {
> >>>>  		map.m_seg_type = f2fs_rw_hint_to_seg_type(iocb->ki_hint);
> >>>> -		flag = f2fs_force_buffered_io(inode, WRITE) ?
> >>>> +		flag = f2fs_force_buffered_io(inode, iocb, from) ?
> >>>>  					F2FS_GET_BLOCK_PRE_AIO :
> >>>>  					F2FS_GET_BLOCK_PRE_DIO;
> >>>>  		goto map_blocks;
> >>>> @@ -1069,7 +1069,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >>>>  		goto sync_out;
> >>>>  	}
> >>>>  
> >>>> -	if (!is_valid_data_blkaddr(sbi, blkaddr)) {
> >>>> +	if (is_valid_data_blkaddr(sbi, blkaddr)) {
> >>>> +		/* use out-place-update for driect IO under LFS mode */
> >>>> +		if (test_opt(sbi, LFS) && create &&
> >>>> +				flag == F2FS_GET_BLOCK_DEFAULT) {
> >>>> +			err = __allocate_data_block(&dn, map->m_seg_type);
> >>>> +			if (!err)
> >>>> +				set_inode_flag(inode, FI_APPEND_WRITE);
> >>>> +		}
> >>>> +	} else {
> >>>>  		if (create) {
> >>>>  			if (unlikely(f2fs_cp_error(sbi))) {
> >>>>  				err = -EIO;
> >>>> @@ -2491,36 +2499,53 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >>>>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
> >>>>  	struct inode *inode = mapping->host;
> >>>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >>>> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> >>>>  	size_t count = iov_iter_count(iter);
> >>>>  	loff_t offset = iocb->ki_pos;
> >>>>  	int rw = iov_iter_rw(iter);
> >>>>  	int err;
> >>>>  	enum rw_hint hint = iocb->ki_hint;
> >>>>  	int whint_mode = F2FS_OPTION(sbi).whint_mode;
> >>>> +	bool lock_read;
> >>>>  
> >>>>  	err = check_direct_IO(inode, iter, offset);
> >>>>  	if (err)
> >>>>  		return err < 0 ? err : 0;
> >>>>  
> >>>> -	if (f2fs_force_buffered_io(inode, rw))
> >>>> +	if (f2fs_force_buffered_io(inode, iocb, iter))
> >>>>  		return 0;
> >>>>  
> >>>> +	lock_read = allow_outplace_dio(inode, iocb, iter);
> >>>> +
> >>>>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
> >>>>  
> >>>>  	if (rw == WRITE && whint_mode == WHINT_MODE_OFF)
> >>>>  		iocb->ki_hint = WRITE_LIFE_NOT_SET;
> >>>>  
> >>>> -	if (!down_read_trylock(&F2FS_I(inode)->i_gc_rwsem[rw])) {
> >>>> -		if (iocb->ki_flags & IOCB_NOWAIT) {
> >>>> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> >>>> +		if (!down_read_trylock(&fi->i_gc_rwsem[rw])) {
> >>>> +			iocb->ki_hint = hint;
> >>>> +			err = -EAGAIN;
> >>>> +			goto out;
> >>>> +		}
> >>>> +		if (lock_read && !down_read_trylock(&fi->i_gc_rwsem[READ])) {
> >>>> +			up_read(&fi->i_gc_rwsem[rw]);
> >>>>  			iocb->ki_hint = hint;
> >>>>  			err = -EAGAIN;
> >>>>  			goto out;
> >>>>  		}
> >>>> -		down_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
> >>>> +	} else {
> >>>> +		down_read(&fi->i_gc_rwsem[rw]);
> >>>> +		if (lock_read)
> >>>> +			down_read(&fi->i_gc_rwsem[READ]);
> >>>>  	}
> >>>>  
> >>>>  	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
> >>>> -	up_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
> >>>> +
> >>>> +	if (lock_read)
> >>>> +		up_read(&fi->i_gc_rwsem[READ]);
> >>>> +
> >>>> +	up_read(&fi->i_gc_rwsem[rw]);
> >>>>  
> >>>>  	if (rw == WRITE) {
> >>>>  		if (whint_mode == WHINT_MODE_OFF)
> >>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>> index 6f59ad180be7..a6dc9d581ee4 100644
> >>>> --- a/fs/f2fs/f2fs.h
> >>>> +++ b/fs/f2fs/f2fs.h
> >>>> @@ -8,6 +8,7 @@
> >>>>  #ifndef _LINUX_F2FS_H
> >>>>  #define _LINUX_F2FS_H
> >>>>  
> >>>> +#include <linux/uio.h>
> >>>>  #include <linux/types.h>
> >>>>  #include <linux/page-flags.h>
> >>>>  #include <linux/buffer_head.h>
> >>>> @@ -3461,11 +3462,41 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
> >>>>  #endif
> >>>>  }
> >>>>  
> >>>> -static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
> >>>> +static inline int block_unaligned_IO(struct inode *inode,
> >>>> +				struct kiocb *iocb, struct iov_iter *iter)
> >>>>  {
> >>>> -	return (f2fs_post_read_required(inode) ||
> >>>> -			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
> >>>> -			F2FS_I_SB(inode)->s_ndevs);
> >>>> +	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
> >>>> +	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
> >>>> +	loff_t offset = iocb->ki_pos;
> >>>> +	unsigned long align = offset | iov_iter_alignment(iter);
> >>>> +
> >>>> +	return align & blocksize_mask;
> >>>> +}
> >>>> +
> >>>> +static inline int allow_outplace_dio(struct inode *inode,
> >>>> +				struct kiocb *iocb, struct iov_iter *iter)
> >>>> +{
> >>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >>>> +	int rw = iov_iter_rw(iter);
> >>>> +
> >>>> +	return (test_opt(sbi, LFS) && (rw == WRITE) &&
> >>>> +				!block_unaligned_IO(inode, iocb, iter));
> >>>> +}
> >>>> +
> >>>> +static inline bool f2fs_force_buffered_io(struct inode *inode,
> >>>> +				struct kiocb *iocb, struct iov_iter *iter)
> >>>> +{
> >>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >>>> +	int rw = iov_iter_rw(iter);
> >>>> +
> >>>> +	if (f2fs_post_read_required(inode))
> >>>> +		return true;
> >>>> +	if (sbi->s_ndevs)
> >>>> +		return true;
> >>>> +	if (test_opt(sbi, LFS) && (rw == WRITE) &&
> >>>> +				block_unaligned_IO(inode, iocb, iter))
> >>>> +		return true;
> >>>> +	return false;
> >>>>  }
> >>>>  
> >>>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>> index 428e7398bd89..70491631e040 100644
> >>>> --- a/fs/f2fs/file.c
> >>>> +++ b/fs/f2fs/file.c
> >>>> @@ -3018,7 +3018,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >>>>  				if (!f2fs_overwrite_io(inode, iocb->ki_pos,
> >>>>  						iov_iter_count(from)) ||
> >>>>  					f2fs_has_inline_data(inode) ||
> >>>> -					f2fs_force_buffered_io(inode, WRITE)) {
> >>>> +					f2fs_force_buffered_io(inode,
> >>>> +							iocb, from)) {
> >>>>  						clear_inode_flag(inode,
> >>>>  								FI_NO_PREALLOC);
> >>>>  						inode_unlock(inode);
> >>>> -- 
> >>>> 2.18.0
> >>>
> >>> .
> >>>
> > 
> > .
> > 
