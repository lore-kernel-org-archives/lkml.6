Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeEDJ5B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:57:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37230 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751592AbeEDJ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:56:59 -0400
Subject: Re: [PATCH] f2fs-tools: fix the sector_size to default value
To: Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1525425645-127945-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <bd699a5e-1a4a-7da6-61f1-252b2f51fe30@huawei.com>
Date: Fri, 4 May 2018 17:56:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1525425645-127945-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/4 17:20, Yunlong Song wrote:
> f2fs-tools uses ioctl BLKSSZGET to get sector_size, however, this ioctl
> will return a value which may be larger than 512 (according to the value
> of q->limits.logical_block_size), then this will be inconsistent with
> the start_sector, since start_sector is got from ioctl HDIO_GETGEO and
> is always in 512 size unit for a sector. To fix this problem, just set
> the sector_size to the default value 512.

Please check below discussion:

https://sourceforge.net/p/linux-f2fs/mailman/message/36282479/

Anyway, we will not set sector_size to 512 by default for backward
compatibility, since some users may calculated total_sector_number by
theirselves via BLKSSZGET.

Usage: mkfs.f2fs [options] device [sectors]:
sectors: number of sectors. [default: determined by device size]

So how about changing as below?

	zone_align_start_offset =
		(c.start_sector * DEFAULT_SECTOR_SIZE +
		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
		zone_size_bytes * zone_size_bytes -
		c.start_sector * DEFAULT_SECTOR_SIZE;

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  lib/libf2fs.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 102e579..e160f2a 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -768,7 +768,6 @@ void get_kernel_uname_version(__u8 *version)
>  int get_device_info(int i)
>  {
>  	int32_t fd = 0;
> -	uint32_t sector_size;
>  #ifndef BLKGETSIZE64
>  	uint32_t total_sectors;
>  #endif
> @@ -822,12 +821,6 @@ int get_device_info(int i)
>  	} else if (S_ISREG(stat_buf->st_mode)) {
>  		dev->total_sectors = stat_buf->st_size / dev->sector_size;
>  	} else if (S_ISBLK(stat_buf->st_mode)) {
> -#ifdef BLKSSZGET
> -		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
> -			MSG(0, "\tError: Using the default sector size\n");
> -		else if (dev->sector_size < sector_size)
> -			dev->sector_size = sector_size;
> -#endif
>  #ifdef BLKGETSIZE64
>  		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
>  			MSG(0, "\tError: Cannot get the device size\n");
> 
