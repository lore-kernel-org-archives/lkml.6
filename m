Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9108E20685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH9Aiwx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9108E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeI2Azs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbeI2Azr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:55:47 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9D820685;
        Fri, 28 Sep 2018 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538159446;
        bh=NXh/N8DrFfLTD8ARmHcuuurf//znJV3gnPfivqnlW+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lH9Aiwx06f3v2wGXmOl6ITRuVPJQ3UAd9fwRNYD/xMGYIjZ29ynd4ujOIwFpB/Eee
         iaNFsNp5Fc+DNdbQpVxlagLeI4f9iGvFiAPDpRJqcKoBSRfUzXuxrpvKptJrSERJ2N
         Xq0K2YgMNH2qxREYlEFyinFZGhCbULGTRiubXYk0=
Date:   Fri, 28 Sep 2018 11:30:44 -0700
From:   Shaohua Li <shli@kernel.org>
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     neilb@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: Re: [PATCH] md/bitmap: use mddev_suspend/resume instead of
 ->quiesce()
Message-ID: <20180928183044.GA12491@kernel.org>
References: <1538035677-20770-1-git-send-email-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538035677-20770-1-git-send-email-jinpuwang@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:07:57AM +0200, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@profitbricks.com>
> 
> After 9e1cc0a54556 ("md: use mddev_suspend/resume instead of ->quiesce()")
> We still have similar left in bitmap functions.
> 
> Replace quiesce() with mddev_suspend/resume.
> 
> Also move md_bitmap_create out of mddev_suspend. and move mddev_resume
> after md_bitmap_destroy. as we did in set_bitmap_file.
> 
> Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> 
> ---
> v2->v1: add reviewed-by.
> ---
>  drivers/md/md-bitmap.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 2fc8c113977f..c369f1753ea6 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -2123,7 +2123,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
>  	}
>  
>  	if (!init)
> -		bitmap->mddev->pers->quiesce(bitmap->mddev, 1);
> +		mddev_suspend(bitmap->mddev);


mddev_suspend is supposed to be called with reconfig_mutex hold. At least one
place this isn't true with this change, for example, raid_preresume doesn't
call md_bitmap_resize with the lock hold. Could you please double check the
lock usage?
 
>  	store.file = bitmap->storage.file;
>  	bitmap->storage.file = NULL;
> @@ -2239,7 +2239,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
>  
>  	if (!init) {
>  		md_bitmap_unplug(bitmap);
> -		bitmap->mddev->pers->quiesce(bitmap->mddev, 0);
> +		mddev_resume(bitmap->mddev);
>  	}
>  	ret = 0;
>  err:
> @@ -2288,9 +2288,9 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
>  			goto out;
>  		}
>  		if (mddev->pers) {
> -			mddev->pers->quiesce(mddev, 1);
> +			mddev_suspend(mddev);
>  			md_bitmap_destroy(mddev);
> -			mddev->pers->quiesce(mddev, 0);
> +			mddev_resume(mddev);
>  		}
>  		mddev->bitmap_info.offset = 0;
>  		if (mddev->bitmap_info.file) {
> @@ -2327,8 +2327,8 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
>  			mddev->bitmap_info.offset = offset;
>  			if (mddev->pers) {
>  				struct bitmap *bitmap;
> -				mddev->pers->quiesce(mddev, 1);
>  				bitmap = md_bitmap_create(mddev, -1);
> +				mddev_suspend(mddev);
>  				if (IS_ERR(bitmap))
>  					rv = PTR_ERR(bitmap);
>  				else {
> @@ -2337,11 +2337,12 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
>  					if (rv)
>  						mddev->bitmap_info.offset = 0;
>  				}
> -				mddev->pers->quiesce(mddev, 0);
>  				if (rv) {
>  					md_bitmap_destroy(mddev);
> +					mddev_resume(mddev);
>  					goto out;
>  				}
> +				mddev_resume(mddev);
>  			}
>  		}
>  	}
> -- 
> 2.7.4
> 
