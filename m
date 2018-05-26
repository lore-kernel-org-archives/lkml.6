Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031735AbeEZL15 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 07:27:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41081 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031606AbeEZL14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 07:27:56 -0400
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix overflow bug of start_sector
 when computing zone_align_start_offset
To: Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yuchao0@huawei.com>, <yunlong.song@icloud.com>
CC: <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <miaoxie@huawei.com>
References: <1527322189-114752-1-git-send-email-yunlong.song@huawei.com>
From: Junling Zheng <zhengjunling@huawei.com>
Message-ID: <74a1a174-f7fe-4c96-6d60-62345355f070@huawei.com>
Date: Sat, 26 May 2018 19:27:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1527322189-114752-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.155.88]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No neet to change zone_align_start_offset to u64, because zone_align_start_offset is always
smaller than zone_size_bytes, which is u32.

Thanks,
Junling

On 2018/5/26 16:09, Yunlong Song wrote:
> zone_align_start_offset should be u64, but config.start_sector is u32,
> so it may be overflow when computing zone_align_start_offset.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fsck/resize.c      | 7 ++++---
>  mkfs/f2fs_format.c | 4 ++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fsck/resize.c b/fsck/resize.c
> index d285dd7..8ac7d45 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -11,7 +11,8 @@
>  
>  static int get_new_sb(struct f2fs_super_block *sb)
>  {
> -	u_int32_t zone_size_bytes, zone_align_start_offset;
> +	u_int32_t zone_size_bytes;
> +	u_int64_t zone_align_start_offset;
>  	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
>  	u_int32_t sit_segments, nat_segments, diff, total_meta_segments;
>  	u_int32_t total_valid_blks_available;
> @@ -27,10 +28,10 @@ static int get_new_sb(struct f2fs_super_block *sb)
>  
>  	zone_size_bytes = segment_size_bytes * segs_per_zone;
>  	zone_align_start_offset =
> -		(c.start_sector * c.sector_size +
> +		((u_int64_t) c.start_sector * c.sector_size +
>  		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
>  		zone_size_bytes * zone_size_bytes -
> -		c.start_sector * c.sector_size;
> +		(u_int64_t) c.start_sector * c.sector_size;
>  
>  	set_sb(segment_count, (c.target_sectors * c.sector_size -
>  				zone_align_start_offset) / segment_size_bytes /
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 0a99a77..f045e23 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -212,10 +212,10 @@ static int f2fs_prepare_super_block(void)
>  	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
>  
>  	zone_align_start_offset =
> -		(c.start_sector * c.sector_size +
> +		((u_int64_t) c.start_sector * c.sector_size +
>  		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
>  		zone_size_bytes * zone_size_bytes -
> -		c.start_sector * c.sector_size;
> +		(u_int64_t) c.start_sector * c.sector_size;
>  
>  	if (c.start_sector % c.sectors_per_blk) {
>  		MSG(1, "\t%s: Align start sector number to the page unit\n",
> 
