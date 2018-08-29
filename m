Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E402087F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E402087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeH2GJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:09:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbeH2GJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:09:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A38045AB1B507;
        Wed, 29 Aug 2018 10:14:31 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 29 Aug 2018
 10:14:32 +0800
Subject: Re: [PATCH] f2fs: avoid wrong decrypted data from disk
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <40e115de-0ec8-62e8-098a-57263b62595f@huawei.com>
Date:   Wed, 29 Aug 2018 10:14:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827225226.14272-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/28 6:52, Jaegeuk Kim wrote:
> 1. Create a file in an encrypted directory
> 2. Do GC & drop caches
> 3. Read stale data before its bio for metapage was not issued yet
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 382c1ef9a9e4..c3557fd4a0bd 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1550,6 +1550,13 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  			bio = NULL;
>  		}
>  		if (bio == NULL) {
> +			/*
> +			 * If the page is under writeback, we need to wait for
> +			 * its completion to see the correct decrypted data.
> +			 */
> +			if (unlikely(f2fs_encrypted_file(inode)))
> +				f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);

I think we have did this in f2fs_grab_read_bio(), so we just need to cover 'bio
!= NULL' case, right?

Thanks,

> +
>  			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
>  					is_readahead ? REQ_RAHEAD : 0);
>  			if (IS_ERR(bio)) {
> 

