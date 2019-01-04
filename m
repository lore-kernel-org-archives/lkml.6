Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F09C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47A32184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfADDET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:04:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfADDET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:04:19 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 098B4E08D0429;
        Fri,  4 Jan 2019 11:04:15 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 11:04:07 +0800
Subject: Re: [PATCH 1/2] f2fs-dev: support multi-device direct IO
To:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190102090659.7974-1-sunqiuyang@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d38a6442-cb0e-2e77-62e6-31c9e71fb636@huawei.com>
Date:   Fri, 4 Jan 2019 11:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190102090659.7974-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/2 17:06, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> The physical blocks in struct f2fs_map_blocks must be in the same device.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> ---
>  fs/f2fs/data.c | 20 +++++++++++++++++++-
>  fs/f2fs/f2fs.h |  2 --
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e5cd3fd..7a6369e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1076,6 +1076,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	struct extent_info ei = {0,0,0};
>  	block_t blkaddr;
>  	unsigned int start_pgofs;
> +	int devi;
> +	block_t end_blk;
>  
>  	if (!maxblocks)
>  		return 0;
> @@ -1207,8 +1209,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  
>  		map->m_pblk = blkaddr;
>  		map->m_len = 1;
> +
> +		if (sbi->s_ndevs && blkaddr != NEW_ADDR &&
> +							blkaddr != NULL_ADDR) {

int devi;

devi = f2fs_target_device_index(sbi, blkaddr);

> +			devi = f2fs_target_device_index(sbi, blkaddr);
> +			end_blk = FDEV(devi).end_blk;
> +		}
>  	} else if ((map->m_pblk != NEW_ADDR &&
> -			blkaddr == (map->m_pblk + ofs)) ||
> +			blkaddr == (map->m_pblk + ofs) &&
> +			(!sbi->s_ndevs || blkaddr <= end_blk)) ||
>  			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
>  			flag == F2FS_GET_BLOCK_PRE_DIO) {
>  		ofs++;
> @@ -1322,6 +1331,8 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  {
>  	struct f2fs_map_blocks map;
>  	int err;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int devi;
>  
>  	map.m_lblk = iblock;
>  	map.m_len = bh->b_size >> inode->i_blkbits;
> @@ -1333,6 +1344,13 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  	err = f2fs_map_blocks(inode, &map, create, flag);
>  	if (!err) {
>  		map_bh(bh, inode->i_sb, map.m_pblk);
> +		if (sbi->s_ndevs) {

struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
int devi;

> +			devi = f2fs_target_device_index(sbi, map.m_pblk);
> +			if (devi) {

Is it possible that devi == 0?

> +				bh->b_bdev = FDEV(devi).bdev;
> +				bh->b_blocknr -= FDEV(devi).start_blk;
> +			}
> +		}
>  		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
>  		bh->b_size = (u64)map.m_len << inode->i_blkbits;

For the write IO, we need to call update_device_state() to set dirty flag
in current device, in order to trigger flush command on right device during
fsync/fdatasync.

Thanks,

>  	}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eeede26..b311471 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3595,8 +3595,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  
>  	if (f2fs_post_read_required(inode))
>  		return true;
> -	if (sbi->s_ndevs)
> -		return true;
>  	/*
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>  	 * all IOs can be serialized by log-structured write.
> 

