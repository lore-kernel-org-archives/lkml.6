Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D002147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfA1NbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:31:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:43114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfA1NbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:31:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D90A3AF6F;
        Mon, 28 Jan 2019 13:31:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2B3771E3FEF; Mon, 28 Jan 2019 14:31:03 +0100 (CET)
Date:   Mon, 28 Jan 2019 14:31:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4.4 068/104] loop: Fold __loop_release into loop_release
Message-ID: <20190128133103.GD27972@quack2.suse.cz>
References: <20190124190154.968308875@linuxfoundation.org>
 <20190124190203.062416837@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124190203.062416837@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-01-19 20:19:57, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jan Kara <jack@suse.cz>
> 
> commit 967d1dc144b50ad005e5eecdfadfbcfb399ffff6 upstream.
> 
> __loop_release() has a single call site. Fold it there. This is
> currently not a huge win but it will make following replacement of
> loop_index_mutex more obvious.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Hello Greg!

This and the following two (patches 69 & 70) loop patches are just
preparatory cleanups for commits 0da03cab87e632 "loop: Fix deadlock when
calling blkdev_reread_part()" and 1dded9acf6dc9a "loop: Avoid circular
locking dependency between loop_ctl_mutex and bd_mutex". As such they don't
fix anything and it doesn't make sense to carry them in stable unless
someone backports also the other patches in the series including the fixes
themselves (which honestly I don't think is worth it for stable).

								Honza

> ---
>  drivers/block/loop.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1586,12 +1586,15 @@ out:
>  	return err;
>  }
>  
> -static void __lo_release(struct loop_device *lo)
> +static void lo_release(struct gendisk *disk, fmode_t mode)
>  {
> +	struct loop_device *lo;
>  	int err;
>  
> +	mutex_lock(&loop_index_mutex);
> +	lo = disk->private_data;
>  	if (atomic_dec_return(&lo->lo_refcnt))
> -		return;
> +		goto unlock_index;
>  
>  	mutex_lock(&loop_ctl_mutex);
>  	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
> @@ -1601,7 +1604,7 @@ static void __lo_release(struct loop_dev
>  		 */
>  		err = loop_clr_fd(lo);
>  		if (!err)
> -			return;
> +			goto unlock_index;
>  	} else {
>  		/*
>  		 * Otherwise keep thread (if running) and config,
> @@ -1611,12 +1614,7 @@ static void __lo_release(struct loop_dev
>  	}
>  
>  	mutex_unlock(&loop_ctl_mutex);
> -}
> -
> -static void lo_release(struct gendisk *disk, fmode_t mode)
> -{
> -	mutex_lock(&loop_index_mutex);
> -	__lo_release(disk->private_data);
> +unlock_index:
>  	mutex_unlock(&loop_index_mutex);
>  }
>  
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
