Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 03:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2117A21722
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 03:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2117A21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeHUGsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 02:48:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725733AbeHUGsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 02:48:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D8DADCD4973FE;
        Tue, 21 Aug 2018 11:30:25 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Tue, 21 Aug 2018
 11:30:23 +0800
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: fix performance issue observed with
 multi-thread sequential read
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180810023758.46974-1-jaegeuk@kernel.org>
 <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
 <20180810185640.GA63079@jaegeuk-macbookpro.roam.corp.google.com>
 <20180817182944.GA58612@jaegeuk-macbookpro.roam.corp.google.com>
 <20180821023626.GB20263@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <782a0bae-a398-9afe-745e-cca31e8fc8e8@huawei.com>
Date:   Tue, 21 Aug 2018 11:30:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821023626.GB20263@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/21 10:36, Jaegeuk Kim wrote:
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
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> Change log from v4:
>  - add __should_serialize_io
>  - fix wrong condition
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
>  fs/f2fs/data.c                          | 21 +++++++++++++++++++++
>  fs/f2fs/f2fs.h                          |  2 ++
>  fs/f2fs/segment.c                       |  1 +
>  fs/f2fs/super.c                         |  1 +
>  fs/f2fs/sysfs.c                         |  2 ++
>  6 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 9b0123388f18..94a24aedcdb2 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -51,6 +51,14 @@ Description:
>  		 Controls the dirty page count condition for the in-place-update
>  		 policies.
>  
> +What:		/sys/fs/f2fs/<disk>/min_seq_blocks
> +Date:		August 2018
> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:
> +		 Controls the dirty page count condition for batched sequential
> +		 writes in ->writepages.
> +
> +
>  What:		/sys/fs/f2fs/<disk>/min_hot_blocks
>  Date:		March 2017
>  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 43d3723dc886..bdcb023506a7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2122,6 +2122,18 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	return ret;
>  }
>  
> +static inline bool __should_serialize_io(struct inode *inode,
> +					struct writeback_control *wbc)
> +{
> +	if (!S_ISREG(inode->i_mode))

Good catch! Will be better. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

