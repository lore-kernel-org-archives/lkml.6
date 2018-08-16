Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01ADC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D848D214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQnf36Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D848D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeHPE3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeHPE3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:29:47 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060CC20869;
        Thu, 16 Aug 2018 01:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534383294;
        bh=LWZYSxq6Hhghli7jv5evYHIkTMFU4M5ctWaImA3YzDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQnf36Y0DmOkeTl7maMj4Cev29dPQ1zGTsiPsuo58VZpdGL0NOh0UD0HnkblM4b9P
         eko6tBMOIJ4v5r2wUuPo5hN+b4CI0Ax8+5hqkY4KpOThn+Am8bB9zn1EuQKLzLjEK/
         gRy5awxWbsGxOtkSRo7HwkphazZSm3tBC7hqBtU0=
Date:   Wed, 15 Aug 2018 18:34:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix performance issue observed with
 multi-thread sequential read
Message-ID: <20180816013452.GA12293@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180810185640.GA63079@jaegeuk-macbookpro.roam.corp.google.com>
 <57149b77-3576-87ed-2cae-a3bc2e8088f2@huawei.com>
 <20180813201150.GA27044@jaegeuk-macbookpro.roam.corp.google.com>
 <0e07e79b-5b67-9355-1fa0-402a5d118bd1@huawei.com>
 <20180814040434.GA52730@jaegeuk-macbookpro.roam.corp.google.com>
 <7194f3d2-b875-376a-4c46-37c598bf3e8e@huawei.com>
 <20180814172837.GD56510@jaegeuk-macbookpro.roam.corp.google.com>
 <167ce8f1-ee4d-2ffc-3518-32850465cd0c@huawei.com>
 <20180815021524.GA84720@jaegeuk-macbookpro.roam.corp.google.com>
 <aba79ead-0d26-8caf-e677-e674002fa534@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba79ead-0d26-8caf-e677-e674002fa534@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Chao Yu wrote:
> On 2018/8/15 10:15, Jaegeuk Kim wrote:
> > On 08/15, Chao Yu wrote:
> >> On 2018/8/15 1:28, Jaegeuk Kim wrote:
> >>> On 08/14, Chao Yu wrote:
> >>>> On 2018/8/14 12:04, Jaegeuk Kim wrote:
> >>>>> On 08/14, Chao Yu wrote:
> >>>>>> On 2018/8/14 4:11, Jaegeuk Kim wrote:
> >>>>>>> On 08/13, Chao Yu wrote:
> >>>>>>>> Hi Jaegeuk,
> >>>>>>>>
> >>>>>>>> On 2018/8/11 2:56, Jaegeuk Kim wrote:
> >>>>>>>>> This reverts the commit - "b93f771 - f2fs: remove writepages lock"
> >>>>>>>>> to fix the drop in sequential read throughput.
> >>>>>>>>>
> >>>>>>>>> Test: ./tiotest -t 32 -d /data/tio_tmp -f 32 -b 524288 -k 1 -k 3 -L
> >>>>>>>>> device: UFS
> >>>>>>>>>
> >>>>>>>>> Before -
> >>>>>>>>> read throughput: 185 MB/s
> >>>>>>>>> total read requests: 85177 (of these ~80000 are 4KB size requests).
> >>>>>>>>> total write requests: 2546 (of these ~2208 requests are written in 512KB).
> >>>>>>>>>
> >>>>>>>>> After -
> >>>>>>>>> read throughput: 758 MB/s
> >>>>>>>>> total read requests: 2417 (of these ~2042 are 512KB reads).
> >>>>>>>>> total write requests: 2701 (of these ~2034 requests are written in 512KB).
> >>>>>>>>
> >>>>>>>> IMO, it only impact sequential read performance in a large file which may be
> >>>>>>>> fragmented during multi-thread writing.
> >>>>>>>>
> >>>>>>>> In android environment, mostly, the large file should be cold type, such as apk,
> >>>>>>>> mp3, rmvb, jpeg..., so I think we only need to serialize writepages() for cold
> >>>>>>>> data area writer.
> >>>>>>>>
> >>>>>>>> So how about adding a mount option to serialize writepage() for different type
> >>>>>>>> of log, e.g. in android, using serialize=4; by default, using serialize=7
> >>>>>>>> HOT_DATA	1
> >>>>>>>> WARM_DATA	2
> >>>>>>>> COLD_DATA	4
> >>>>>>>
> >>>>>>> Well, I don't think we need to give too many mount options for this fragmented
> >>>>>>> case. How about doing this for the large files only like this?
> >>>>>>
> >>>>>> Thread A write 512 pages			Thread B write 8 pages
> >>>>>>
> >>>>>> - writepages()
> >>>>>>  - mutex_lock(&sbi->writepages);
> >>>>>>   - writepage();
> >>>>>> ...
> >>>>>> 						- writepages()
> >>>>>> 						 - writepage()
> >>>>>> 						  ....
> >>>>>>   - writepage();
> >>>>>> ...
> >>>>>>  - mutex_unlock(&sbi->writepages);
> >>>>>>
> >>>>>> Above case will also cause fragmentation since we didn't serialize all
> >>>>>> concurrent IO with the lock.
> >>>>>>
> >>>>>> Do we need to consider such case?
> >>>>>
> >>>>> We can simply allow 512 and 8 in the same segment, which would not a big deal,
> >>>>> when considering starvation of Thread B.
> >>>>
> >>>> Yeah, but in reality, there would be more threads competing in same log header,
> >>>> so I worry that the effect of defragmenting will not so good as we expect,
> >>>> anyway, for benchmark, it's enough.
> >>>
> >>> Basically, I think this is not a benchmark issue. :) It just reveals the issue
> >>> much easily. Let me think about three cases:
> >>> 1) WB_SYNC_NONE & WB_SYNC_NONE
> >>>  -> can simply use mutex_lock
> >>>
> >>> 2) WB_SYNC_ALL & WB_SYNC_NONE
> >>>  -> can use mutex_lock on WB_SYNC_ALL having >512 blocks, while WB_SYNC_NONE
> >>>     will skip writing blocks
> >>>
> >>> 3) WB_SYNC_ALL & WB_SYNC_ALL
> >>>  -> can use mutex_lock on WB_SYNC_ALL having >512 blocks, in order to avoid
> >>>     starvation.
> >>>
> >>>
> >>> I've been testing the below.
> >>>
> >>> if (!S_ISDIR(inode->i_mode) && (wbc->sync_mode != WB_SYNC_ALL ||
> >>>                 get_dirty_pages(inode) <= SM_I(sbi)->min_seq_blocks)) {
> >>>         mutex_lock(&sbi->writepages);
> >>>         locked = true;
> >>
> >> Just cover buffered IO? how about covering Direct IO and atomic write as well?
> > 
> > I'd expect direct IO does in-place-updates, and not sure whether we need to
> 
> For initial writes, they are not IPU.

It's a little bit different. DIO allocates blocks first in the bulk mode, and
sumbit bios later. So, it'd be more likely to allocate consecutive blocks by
get_data_block_dio, if user gave a big chunk to write. I'm more concerend about
lock contention, and don't think we have to serialize all the block allocation.

> 
> > add another lock contention between buffered or direct IO. Atomic writes
> > would be covered by ->min_seq_blocks.
> 
> Okay. :)
> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>> }
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>
> >>>>>>> >From 4fea0b6e4da8512a72dd52afc7a51beb35966ad9 Mon Sep 17 00:00:00 2001
> >>>>>>> From: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>>> Date: Thu, 9 Aug 2018 17:53:34 -0700
> >>>>>>> Subject: [PATCH] f2fs: fix performance issue observed with multi-thread
> >>>>>>>  sequential read
> >>>>>>>
> >>>>>>> This reverts the commit - "b93f771 - f2fs: remove writepages lock"
> >>>>>>> to fix the drop in sequential read throughput.
> >>>>>>>
> >>>>>>> Test: ./tiotest -t 32 -d /data/tio_tmp -f 32 -b 524288 -k 1 -k 3 -L
> >>>>>>> device: UFS
> >>>>>>>
> >>>>>>> Before -
> >>>>>>> read throughput: 185 MB/s
> >>>>>>> total read requests: 85177 (of these ~80000 are 4KB size requests).
> >>>>>>> total write requests: 2546 (of these ~2208 requests are written in 512KB).
> >>>>>>>
> >>>>>>> After -
> >>>>>>> read throughput: 758 MB/s
> >>>>>>> total read requests: 2417 (of these ~2042 are 512KB reads).
> >>>>>>> total write requests: 2701 (of these ~2034 requests are written in 512KB).
> >>>>>>>
> >>>>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>>> ---
> >>>>>>>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
> >>>>>>>  fs/f2fs/data.c                          | 10 ++++++++++
> >>>>>>>  fs/f2fs/f2fs.h                          |  2 ++
> >>>>>>>  fs/f2fs/segment.c                       |  1 +
> >>>>>>>  fs/f2fs/super.c                         |  1 +
> >>>>>>>  fs/f2fs/sysfs.c                         |  2 ++
> >>>>>>>  6 files changed, 24 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> >>>>>>> index 9b0123388f18..94a24aedcdb2 100644
> >>>>>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> >>>>>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> >>>>>>> @@ -51,6 +51,14 @@ Description:
> >>>>>>>  		 Controls the dirty page count condition for the in-place-update
> >>>>>>>  		 policies.
> >>>>>>>  
> >>>>>>> +What:		/sys/fs/f2fs/<disk>/min_seq_blocks
> >>>>>>> +Date:		August 2018
> >>>>>>> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> >>>>>>> +Description:
> >>>>>>> +		 Controls the dirty page count condition for batched sequential
> >>>>>>> +		 writes in ->writepages.
> >>>>>>> +
> >>>>>>> +
> >>>>>>>  What:		/sys/fs/f2fs/<disk>/min_hot_blocks
> >>>>>>>  Date:		March 2017
> >>>>>>>  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> >>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>>> index 45f043ee48bd..f09231b1cc74 100644
> >>>>>>> --- a/fs/f2fs/data.c
> >>>>>>> +++ b/fs/f2fs/data.c
> >>>>>>> @@ -2132,6 +2132,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> >>>>>>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >>>>>>>  	struct blk_plug plug;
> >>>>>>>  	int ret;
> >>>>>>> +	bool locked = false;
> >>>>>>>  
> >>>>>>>  	/* deal with chardevs and other special file */
> >>>>>>>  	if (!mapping->a_ops->writepage)
> >>>>>>> @@ -2162,10 +2163,19 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> >>>>>>>  	else if (atomic_read(&sbi->wb_sync_req[DATA]))
> >>>>>>>  		goto skip_write;
> >>>>>>>  
> >>>>>>> +	if (!S_ISDIR(inode->i_mode) &&
> >>>>>>> +			get_dirty_pages(inode) <= SM_I(sbi)->min_seq_blocks) {
> >>>>>>> +		mutex_lock(&sbi->writepages);
> >>>>>>> +		locked = true;
> >>>>>>> +	}
> >>>>>>> +
> >>>>>>>  	blk_start_plug(&plug);
> >>>>>>>  	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
> >>>>>>>  	blk_finish_plug(&plug);
> >>>>>>>  
> >>>>>>> +	if (locked)
> >>>>>>> +		mutex_unlock(&sbi->writepages);
> >>>>>>> +
> >>>>>>>  	if (wbc->sync_mode == WB_SYNC_ALL)
> >>>>>>>  		atomic_dec(&sbi->wb_sync_req[DATA]);
> >>>>>>>  	/*
> >>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>>>>> index 375aa9f30cfa..098bdedc28bf 100644
> >>>>>>> --- a/fs/f2fs/f2fs.h
> >>>>>>> +++ b/fs/f2fs/f2fs.h
> >>>>>>> @@ -913,6 +913,7 @@ struct f2fs_sm_info {
> >>>>>>>  	unsigned int ipu_policy;	/* in-place-update policy */
> >>>>>>>  	unsigned int min_ipu_util;	/* in-place-update threshold */
> >>>>>>>  	unsigned int min_fsync_blocks;	/* threshold for fsync */
> >>>>>>> +	unsigned int min_seq_blocks;	/* threshold for sequential blocks */
> >>>>>>>  	unsigned int min_hot_blocks;	/* threshold for hot block allocation */
> >>>>>>>  	unsigned int min_ssr_sections;	/* threshold to trigger SSR allocation */
> >>>>>>>  
> >>>>>>> @@ -1133,6 +1134,7 @@ struct f2fs_sb_info {
> >>>>>>>  	struct rw_semaphore sb_lock;		/* lock for raw super block */
> >>>>>>>  	int valid_super_block;			/* valid super block no */
> >>>>>>>  	unsigned long s_flag;				/* flags for sbi */
> >>>>>>> +	struct mutex writepages;		/* mutex for writepages() */
> >>>>>>>  
> >>>>>>>  #ifdef CONFIG_BLK_DEV_ZONED
> >>>>>>>  	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
> >>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>>>> index 63fc647f9ac2..ffea2d1303bd 100644
> >>>>>>> --- a/fs/f2fs/segment.c
> >>>>>>> +++ b/fs/f2fs/segment.c
> >>>>>>> @@ -4131,6 +4131,7 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi)
> >>>>>>>  		sm_info->ipu_policy = 1 << F2FS_IPU_FSYNC;
> >>>>>>>  	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
> >>>>>>>  	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
> >>>>>>> +	sm_info->min_seq_blocks = sbi->blocks_per_seg * sbi->segs_per_sec;
> >>>>>>>  	sm_info->min_hot_blocks = DEF_MIN_HOT_BLOCKS;
> >>>>>>>  	sm_info->min_ssr_sections = reserved_sections(sbi);
> >>>>>>>  
> >>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>>>>>> index be41dbd7b261..53d70b64fea1 100644
> >>>>>>> --- a/fs/f2fs/super.c
> >>>>>>> +++ b/fs/f2fs/super.c
> >>>>>>> @@ -2842,6 +2842,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>>>>>>  	/* init f2fs-specific super block info */
> >>>>>>>  	sbi->valid_super_block = valid_super_block;
> >>>>>>>  	mutex_init(&sbi->gc_mutex);
> >>>>>>> +	mutex_init(&sbi->writepages);
> >>>>>>>  	mutex_init(&sbi->cp_mutex);
> >>>>>>>  	init_rwsem(&sbi->node_write);
> >>>>>>>  	init_rwsem(&sbi->node_change);
> >>>>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>>>>>> index cd2e030e47b8..81c0e5337443 100644
> >>>>>>> --- a/fs/f2fs/sysfs.c
> >>>>>>> +++ b/fs/f2fs/sysfs.c
> >>>>>>> @@ -397,6 +397,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
> >>>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
> >>>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
> >>>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
> >>>>>>> +F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_seq_blocks, min_seq_blocks);
> >>>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_hot_blocks, min_hot_blocks);
> >>>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ssr_sections, min_ssr_sections);
> >>>>>>>  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
> >>>>>>> @@ -449,6 +450,7 @@ static struct attribute *f2fs_attrs[] = {
> >>>>>>>  	ATTR_LIST(ipu_policy),
> >>>>>>>  	ATTR_LIST(min_ipu_util),
> >>>>>>>  	ATTR_LIST(min_fsync_blocks),
> >>>>>>> +	ATTR_LIST(min_seq_blocks),
> >>>>>>>  	ATTR_LIST(min_hot_blocks),
> >>>>>>>  	ATTR_LIST(min_ssr_sections),
> >>>>>>>  	ATTR_LIST(max_victim_search),
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
