Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771272085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfAGBeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 20:34:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfAGBeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 20:34:21 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CB2F8FBDF1A3CBA8AEDC;
        Mon,  7 Jan 2019 09:34:18 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 7 Jan 2019
 09:32:16 +0800
Subject: Re: [PATCH v2 1/2] f2fs-dev: support multi-device direct IO
To:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190104112439.48918-1-sunqiuyang@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8c019269-a55b-35a1-5158-46bb773cd555@huawei.com>
Date:   Mon, 7 Jan 2019 09:32:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190104112439.48918-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/4 19:24, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Changelog v1 ==> v2:
> 1. Modify the definition of update_device_state(),
>    and call it in direct write;
> 2. Move some local variables into branches where they are used.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> ---
>  fs/f2fs/data.c    | 25 ++++++++++++++++++++++++-
>  fs/f2fs/f2fs.h    |  3 +--
>  fs/f2fs/segment.c | 11 +++++------
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e5cd3fd..010300c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1076,6 +1076,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	struct extent_info ei = {0,0,0};
>  	block_t blkaddr;
>  	unsigned int start_pgofs;
> +	block_t end_blk;
>  
>  	if (!maxblocks)
>  		return 0;
> @@ -1207,8 +1208,17 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  
>  		map->m_pblk = blkaddr;
>  		map->m_len = 1;
> +
> +		if (sbi->s_ndevs && blkaddr != NEW_ADDR &&
> +							blkaddr != NULL_ADDR) {
> +			int devi;
> +
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
> @@ -1322,6 +1332,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  {
>  	struct f2fs_map_blocks map;
>  	int err;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  
>  	map.m_lblk = iblock;
>  	map.m_len = bh->b_size >> inode->i_blkbits;
> @@ -1333,6 +1344,18 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  	err = f2fs_map_blocks(inode, &map, create, flag);
>  	if (!err) {
>  		map_bh(bh, inode->i_sb, map.m_pblk);
> +		if (sbi->s_ndevs) {

struct f2fs_sb_info *sbi = F2FS_I_SB(inode);

No need to get sbi in single device filesystem.

> +			int devi;
> +
> +			devi = f2fs_target_device_index(sbi, map.m_pblk);
> +			if (devi) {
> +				bh->b_bdev = FDEV(devi).bdev;
> +				bh->b_blocknr -= FDEV(devi).start_blk;
> +			}
> +			if (may_write)
> +				update_device_state(sbi, inode->i_ino,
> +								map.m_pblk);
> +		}
>  		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
>  		bh->b_size = (u64)map.m_len << inode->i_blkbits;
>  	}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eeede26..659e1e0 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3056,6 +3056,7 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
>  int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
>  enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>  			enum page_type type, enum temp_type temp);
> +void update_device_state(struct f2fs_sb_info *sbi, nid_t ino, block_t blkaddr);

It will be better to rename it to f2fs_update_device_state like other
exported function name, otherwise it can pollute global namespace of
function in kernel.

Thanks,

>  
>  /*
>   * checkpoint.c
> @@ -3595,8 +3596,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  
>  	if (f2fs_post_read_required(inode))
>  		return true;
> -	if (sbi->s_ndevs)
> -		return true;
>  	/*
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>  	 * all IOs can be serialized by log-structured write.
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a361d61..eec5db1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3050,18 +3050,17 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	up_read(&SM_I(sbi)->curseg_lock);
>  }
>  
> -static void update_device_state(struct f2fs_io_info *fio)
> +void update_device_state(struct f2fs_sb_info *sbi, nid_t ino, block_t blkaddr)
>  {
> -	struct f2fs_sb_info *sbi = fio->sbi;
>  	unsigned int devidx;
>  
>  	if (!sbi->s_ndevs)
>  		return;
>  
> -	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
> +	devidx = f2fs_target_device_index(sbi, blkaddr);
>  
>  	/* update device state for fsync */
> -	f2fs_set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
> +	f2fs_set_dirty_device(sbi, ino, devidx, FLUSH_INO);
>  
>  	/* update device state for checkpoint */
>  	if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
> @@ -3092,7 +3091,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>  		goto reallocate;
>  	}
>  
> -	update_device_state(fio);
> +	update_device_state(fio->sbi, fio->ino, fio->new_blkaddr);
>  
>  	if (keep_order)
>  		up_read(&fio->sbi->io_order_lock);
> @@ -3168,7 +3167,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>  	else
>  		err = f2fs_submit_page_bio(fio);
>  	if (!err)
> -		update_device_state(fio);
> +		update_device_state(fio->sbi, fio->ino, fio->new_blkaddr);
>  
>  	f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
>  
> 

