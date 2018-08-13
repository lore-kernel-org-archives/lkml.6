Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A0DC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708832177D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708832177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeHMFAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:00:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeHMFAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:00:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B2F175695375A;
        Mon, 13 Aug 2018 10:20:05 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 10:20:04 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix performance issue observed with
 multi-thread sequential read
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180810023758.46974-1-jaegeuk@kernel.org>
 <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
 <20180810185640.GA63079@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <57149b77-3576-87ed-2cae-a3bc2e8088f2@huawei.com>
Date:   Mon, 13 Aug 2018 10:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180810185640.GA63079@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2018/8/11 2:56, Jaegeuk Kim wrote:
> This reverts the commit - "b93f771 - f2fs: remove writepages lock"
> to fix the drop in sequential read throughput.
> 
> Test: ./tiotest -t 32 -d /data/tio_tmp -f 32 -b 524288 -k 1 -k 3 -L
> device: UFS
> 
> Before -
> read throughput: 185 MB/s
> total read requests: 85177 (of these ~80000 are 4KB size requests).
> total write requests: 2546 (of these ~2208 requests are written in 512KB).
> 
> After -
> read throughput: 758 MB/s
> total read requests: 2417 (of these ~2042 are 512KB reads).
> total write requests: 2701 (of these ~2034 requests are written in 512KB).

IMO, it only impact sequential read performance in a large file which may be
fragmented during multi-thread writing.

In android environment, mostly, the large file should be cold type, such as apk,
mp3, rmvb, jpeg..., so I think we only need to serialize writepages() for cold
data area writer.

So how about adding a mount option to serialize writepage() for different type
of log, e.g. in android, using serialize=4; by default, using serialize=7
HOT_DATA	1
WARM_DATA	2
COLD_DATA	4

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> Changelog from v2:
>  - fix deadlock in f2fs_gc
> 
>  fs/f2fs/data.c  | 9 +++++++++
>  fs/f2fs/f2fs.h  | 1 +
>  fs/f2fs/super.c | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 45f043ee48bd..9f0149cdeed8 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2132,6 +2132,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct blk_plug plug;
>  	int ret;
> +	bool locked = false;
>  
>  	/* deal with chardevs and other special file */
>  	if (!mapping->a_ops->writepage)
> @@ -2162,10 +2163,18 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  	else if (atomic_read(&sbi->wb_sync_req[DATA]))
>  		goto skip_write;
>  
> +	if (!S_ISDIR(inode->i_mode)) {
> +		mutex_lock(&sbi->writepages);
> +		locked = true;
> +	}
> +
>  	blk_start_plug(&plug);
>  	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
>  	blk_finish_plug(&plug);
>  
> +	if (locked)
> +		mutex_unlock(&sbi->writepages);
> +
>  	if (wbc->sync_mode == WB_SYNC_ALL)
>  		atomic_dec(&sbi->wb_sync_req[DATA]);
>  	/*
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b1c127d8383b..29bbc55cbc0b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1133,6 +1133,7 @@ struct f2fs_sb_info {
>  	struct rw_semaphore sb_lock;		/* lock for raw super block */
>  	int valid_super_block;			/* valid super block no */
>  	unsigned long s_flag;				/* flags for sbi */
> +	struct mutex writepages;		/* mutex for writepages() */
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index be41dbd7b261..53d70b64fea1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2842,6 +2842,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	/* init f2fs-specific super block info */
>  	sbi->valid_super_block = valid_super_block;
>  	mutex_init(&sbi->gc_mutex);
> +	mutex_init(&sbi->writepages);
>  	mutex_init(&sbi->cp_mutex);
>  	init_rwsem(&sbi->node_write);
>  	init_rwsem(&sbi->node_change);
> 

