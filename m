Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A24C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E843921566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E843921566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeHBXGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:06:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeHBXF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:05:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C49AAE43;
        Thu,  2 Aug 2018 21:13:05 +0000 (UTC)
Date:   Thu, 2 Aug 2018 14:13:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-Id: <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
In-Reply-To: <20180802051112.86174-1-minchan@kernel.org>
References: <20180802051112.86174-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 14:11:12 +0900 Minchan Kim <minchan@kernel.org> wrote:

> If zram supports writeback feature, it's no more syncrhonous
> device beause zram does synchronous IO opeation for
> incompressible page.
> 
> Do not pretend to be syncrhonous IO device. It makes system
> very sluggish as waiting IO completion from upper layer.
> 
> Furthermore, it makes user-after-free problem because swap
> think the opearion is done when the IO functions returns so
> it could free page by will(e.g., lock_page_or_retry and
> goto out_release in do_swap_page) but in fact, IO is
> asynchrnous so driver could access just freed page afterward.
> 
> This patch fixes the problem.

That changelog is rather hard to follow.  Please review my edits:

: If zram supports writeback feature, it's no longer a BD_CAP_SYNCHRONOUS_IO
: device beause zram does synchronous IO operations for incompressible pages.
: 
: Do not pretend to be synchronous IO device.  It makes the system very
: sluggish due to waiting for IO completion from upper layers.
: 
: Furthermore, it causes a user-after-free problem because swap thinks the
: opearion is done when the IO functions returns so it can free the page
: (e.g., lock_page_or_retry and goto out_release in do_swap_page) but in
: fact, IO is asynchrnous so the driver could access a just freed page
: afterward.
: 
: This patch fixes the problem. 

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 7436b2d27fa3..0b6eda1bd77a 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -298,7 +298,8 @@ static void reset_bdev(struct zram *zram)
>  	zram->backing_dev = NULL;
>  	zram->old_block_size = 0;
>  	zram->bdev = NULL;
> -
> +	zram->disk->queue->backing_dev_info->capabilities |=
> +				BDI_CAP_SYNCHRONOUS_IO;
>  	kvfree(zram->bitmap);
>  	zram->bitmap = NULL;
>  }
> @@ -400,6 +401,8 @@ static ssize_t backing_dev_store(struct device *dev,
>  	zram->backing_dev = backing_dev;
>  	zram->bitmap = bitmap;
>  	zram->nr_pages = nr_pages;
> +	zram->disk->queue->backing_dev_info->capabilities &=
> +			~BDI_CAP_SYNCHRONOUS_IO;
>  	up_write(&zram->init_lock);
>  
>  	pr_info("setup backing device %s\n", file_name);

A reader looking at this would wonder "why the heck are we doing that".
Adding a code comment would help them.

Is it legitimate to be altering the bdi capabilities at this level?  Or
is this hacky?

If "yes" then should reset_bdev() be unconditionally setting
BDI_CAP_SYNCHRONOUS_IO?  Shouldn't it be restoring that flag to its
previous setting?

