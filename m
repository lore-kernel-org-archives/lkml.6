Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbeE3CeC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeE3Cd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:33:59 -0400
Date: Tue, 29 May 2018 19:33:57 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: Yunlong Song <yunlong.song@huawei.com>, chao@kernel.org,
        yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com,
        shengyong1@huawei.com, heyunlei@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs-tools: fix overflow bug of start_sector when
 computing zone_align_start_offset
Message-ID: <20180530023357.GB39056@jaegeuk-macbookpro.roam.corp.google.com>
References: <1527322189-114752-1-git-send-email-yunlong.song@huawei.com>
 <a6732361-57a7-249b-ba75-3dd5e5bb18a2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6732361-57a7-249b-ba75-3dd5e5bb18a2@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28, Chao Yu wrote:
> On 2018/5/26 16:09, Yunlong Song wrote:
> > zone_align_start_offset should be u64, but config.start_sector is u32,
> > so it may be overflow when computing zone_align_start_offset.
> 
> Could you rebase this patch on top of "f2fs-tools: fix to match with the
> start_sector"?

Yes, please. I updated dev-test. :P

> 
> Thanks,
> 
> > 
> > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> > ---
> >  fsck/resize.c      | 7 ++++---
> >  mkfs/f2fs_format.c | 4 ++--
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fsck/resize.c b/fsck/resize.c
> > index d285dd7..8ac7d45 100644
> > --- a/fsck/resize.c
> > +++ b/fsck/resize.c
> > @@ -11,7 +11,8 @@
> >  
> >  static int get_new_sb(struct f2fs_super_block *sb)
> >  {
> > -	u_int32_t zone_size_bytes, zone_align_start_offset;
> > +	u_int32_t zone_size_bytes;
> > +	u_int64_t zone_align_start_offset;
> >  	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
> >  	u_int32_t sit_segments, nat_segments, diff, total_meta_segments;
> >  	u_int32_t total_valid_blks_available;
> > @@ -27,10 +28,10 @@ static int get_new_sb(struct f2fs_super_block *sb)
> >  
> >  	zone_size_bytes = segment_size_bytes * segs_per_zone;
> >  	zone_align_start_offset =
> > -		(c.start_sector * c.sector_size +
> > +		((u_int64_t) c.start_sector * c.sector_size +
> >  		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> >  		zone_size_bytes * zone_size_bytes -
> > -		c.start_sector * c.sector_size;
> > +		(u_int64_t) c.start_sector * c.sector_size;
> >  
> >  	set_sb(segment_count, (c.target_sectors * c.sector_size -
> >  				zone_align_start_offset) / segment_size_bytes /
> > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > index 0a99a77..f045e23 100644
> > --- a/mkfs/f2fs_format.c
> > +++ b/mkfs/f2fs_format.c
> > @@ -212,10 +212,10 @@ static int f2fs_prepare_super_block(void)
> >  	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
> >  
> >  	zone_align_start_offset =
> > -		(c.start_sector * c.sector_size +
> > +		((u_int64_t) c.start_sector * c.sector_size +
> >  		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> >  		zone_size_bytes * zone_size_bytes -
> > -		c.start_sector * c.sector_size;
> > +		(u_int64_t) c.start_sector * c.sector_size;
> >  
> >  	if (c.start_sector % c.sectors_per_blk) {
> >  		MSG(1, "\t%s: Align start sector number to the page unit\n",
> > 
