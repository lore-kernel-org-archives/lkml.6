Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD43DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C93216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK6QTrga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C93216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeI1SWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbeI1SWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:22:19 -0400
Received: from [192.168.0.101] (unknown [49.77.227.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F61E215E4;
        Fri, 28 Sep 2018 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538135933;
        bh=iM4xINAl2PFUykcYcey0BDi+/MLi8Ynh/ybbjndesPs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=gK6QTrgaRYZyPbffRGYd2Q2zSp37IzlVds0hhR9Tw1dVj1qCf1fpsZfxDobBdR322
         vpMXWevjwB68pxQhE0gpcO6dkm+mSTUZVxJ/o5IjHKq6gzeEm94WK9llDNVIwqlzsL
         C51a6pM9DWeQFuLRfzDDBHaWfUrH2T89MoJ55QUc=
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: clear PageError on the read path
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180926014617.12369-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <04bbaf3a-e1ec-a5ae-a664-68d1299aaeb6@kernel.org>
Date:   Fri, 28 Sep 2018 19:58:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926014617.12369-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-9-26 9:46, Jaegeuk Kim wrote:
> When running fault injection test, I hit somewhat wrong behavior in f2fs_gc ->
> gc_data_segment():
> 
> 0. fault injection generated some PageError'ed pages
> 
> 1. gc_data_segment
>  -> f2fs_get_read_data_page(REQ_RAHEAD)
> 
> 2. move_data_page
>  -> f2fs_get_lock_data_page()
>   -> f2f_get_read_data_page()
>    -> f2fs_submit_page_read()
>     -> submit_bio(READ)
>   -> return EIO due to PageError
>   -> fail to move data
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 41102c227eee..cb3ebcae0398 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -77,7 +77,8 @@ static void __read_end_io(struct bio *bio)
>  		/* PG_error was set if any post_read step failed */
>  		if (bio->bi_status || PageError(page)) {
>  			ClearPageUptodate(page);
> -			SetPageError(page);
> +			/* will re-read again later */
> +			ClearPageError(page);
>  		} else {
>  			SetPageUptodate(page);

How about:

if (PaegeError(page))
	ClearPageError(page);

if (bio->bi_status) {
	ClearPageUptodate(page);
	SetPageError(page);
} else {
	SetPageUptodate(page);
	ClearPageError(page);
}

So that below codes are not needed.

Thanks,

>  		}
> @@ -591,6 +592,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
>  		bio_put(bio);
>  		return -EFAULT;
>  	}
> +	ClearPageError(page);
>  	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>  	return 0;
>  }
> @@ -1571,6 +1573,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
>  			goto submit_and_realloc;
>  
> +		ClearPageError(page);
>  		last_block_in_bio = block_nr;
>  		goto next_page;
>  set_error_page:
> 
