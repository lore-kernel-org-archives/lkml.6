Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D74C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF73621850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JUcSIVau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeLRRsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:48:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34630 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeLRRsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:48:23 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so8816222itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SQja1o6bp64fDaaqlw9M9j7Kjmp3Kjz39K8MIu4uNNA=;
        b=JUcSIVaupQqpx0kCpcTCsy8PZzPR2sgP0ihJMzd1g6vnC7JjaQHf7WhfdDCg1KoH9U
         Sy1HYcxmZg/Srikn1yYVaHMSmpXFASx63oj6aDCHmGPjqP9mg1iTh07nGEpDNZdlSk50
         pNu2BX150PROlIOlbnDdOSdvV8ZWIBuI5QIwOdEfHsciWRxp7rrDWFLOLnemXuWoV0ML
         9HoR+GdaV63OONxrJKkJu8B49fyKxGVj9S64f0lLxZMJ5zCrsm3aIpH0laecxOB++ZsZ
         Rs76y0V+Ij7laBnQKgGpelRCjimw0FBALvaLBcBiT7DUqSTdLjfBlaWo98sZ2nyGOkfU
         VO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SQja1o6bp64fDaaqlw9M9j7Kjmp3Kjz39K8MIu4uNNA=;
        b=oS4QC0QIgD46okyOPfxAvnCRDUvktmepLFk5wEjIWk0kTNFuA8j1AkOuOzKL0t13aL
         hzmYplZwIuAPmfHTSPlZ0irGfbN8dzzO0bINg4vndlyzTP6oDLZcTCtQ0Nycg6B0OoPR
         Pz6F+eHkilR0thSvioUs4lgSJv5IVhbegqPBLpH7z98lEW0o4rn3ILl1TYaHgmyMGP+9
         JqpoACZOzn6VxxXIyvoyz5eCXim6Q91TaC8aRYl7I4I8DIU3keBZqvjbGUmbmZlQp6hx
         nphzGqtDd4sYFzqjdSf/b4nAke7no7W2DeypYfqIJycWCE1w8bbtnP9sVloyZhAbhEco
         rr+Q==
X-Gm-Message-State: AA+aEWZvGBdFwitggbpHmwLvIrHQfv5xzLalOA2FBlRGgZnU6hEVPWdi
        9yJLzTb5uTTFeB0TQodRZxfZwQ==
X-Google-Smtp-Source: AFSGD/WdDN2a2gHkBHjK2Zo7ugKsifVyzLP5dxoSb82/9xYWkMQkQHNPg7iu07tKclZnjZ/ykIDgxQ==
X-Received: by 2002:a24:3282:: with SMTP id j124mr3712479ita.173.1545155301800;
        Tue, 18 Dec 2018 09:48:21 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y21sm7486675iof.51.2018.12.18.09.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 09:48:20 -0800 (PST)
Subject: Re: [PATCH v2] loop: drop caches if offset or block_size are changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20181214203223.7063-1-jaegeuk@kernel.org>
 <20181217194236.GA50659@jaegeuk-macbookpro.roam.corp.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29369548-df14-a5a7-2bee-a40b3479df68@kernel.dk>
Date:   Tue, 18 Dec 2018 10:48:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217194236.GA50659@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 12:42 PM, Jaegeuk Kim wrote:
> If we don't drop caches used in old offset or block_size, we can get old data
> from new offset/block_size, which gives unexpected data to user.
> 
> For example, Martijn found a loopback bug in the below scenario.
> 1) LOOP_SET_FD loads first two pages on loop file
> 2) LOOP_SET_STATUS64 changes the offset on the loop file
> 3) mount is failed due to the cached pages having wrong superblock
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Reported-by: Martijn Coenen <maco@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> v1 to v2:
>  - cover block_size change
> 
>  drivers/block/loop.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cb0cc8685076..382557c81674 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1154,6 +1154,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  
>  	if (lo->lo_offset != info->lo_offset ||
>  	    lo->lo_sizelimit != info->lo_sizelimit) {
> +		struct block_device *bdev = lo->lo_device;
> +
> +		/* drop stale caches used in old offset */
> +		sync_blockdev(bdev);
> +		kill_bdev(bdev);
> +
>  		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
>  			err = -EFBIG;
>  			goto exit;
> @@ -1388,6 +1394,15 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
>  	blk_queue_io_min(lo->lo_queue, arg);
>  	loop_update_dio(lo);
>  
> +	/* Don't change the size if it is same as current */
> +	if (lo->lo_queue->limits.logical_block_size != arg) {
> +		struct block_device *bdev = lo->lo_device;
> +
> +		/* drop stale caches likewise set_blocksize */
> +		sync_blockdev(bdev);
> +		kill_bdev(bdev);
> +	}
> +
>  	blk_mq_unfreeze_queue(lo->lo_queue);
>  
>  	return 0;

Looks fine to me, my only worry would be verifying that we're fine calling
sync/kill from those contexts. The queue is frozen at this point, what
happens if we do need to flush out dirty data?

-- 
Jens Axboe

