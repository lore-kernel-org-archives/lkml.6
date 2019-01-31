Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE516C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4CE218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548948986;
	bh=mWopoVAjgMRfkLrl+BMNDnHxKYQbwDyd8WmgxzENBmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hT0ujY0b2nUbNqGUzDYbDKQhFfqIVNQCgwTcAJops+ZsSrIXw0hl5YMdf7BUZL8sQ
	 EEXYW7TLvfz+KgTfHHryRuWxGt/bD39VM3doeGSVdzhoMKh1509bAkzG4VH182pdFR
	 xHkoczEre8nSnE3wYMFgJlXXVHwT6giFj8pKOSfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbfAaPgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfAaPgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:36:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786AE20B1F;
        Thu, 31 Jan 2019 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548948984;
        bh=mWopoVAjgMRfkLrl+BMNDnHxKYQbwDyd8WmgxzENBmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/kS357R/V/dgijJaOgSRkAg30aYhM32Wvu8uw+5OybtZSy5QijjBcMNBcD2JPl0y
         RTKwujRGFEhIQLl/3n+TG17p9yfV/9Jw4/Xbl/63evcTLBg6VfbLdM1X70z+oTDhCw
         90BqrrtXjnckI4GjOHjAGryJ7vnt8DN7M5mtPz40=
Date:   Thu, 31 Jan 2019 16:36:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Jian <liujian56@huawei.com>
Cc:     xiubli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] driver: uio: fix possible memory leak in uio_open
Message-ID: <20190131153621.GA16678@kroah.com>
References: <1548196704-352035-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548196704-352035-1-git-send-email-liujian56@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 06:38:24AM +0800, Liu Jian wrote:
> If 'idev->info' is NULL, we need to  free 'listener'
> 
> Fixes: 57c5f4df0a5a ("uio: fix crash after the device is unregistered")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v1->v2:
> rename the "err_infoopen" to "err_idev_info"
> v2->3:
> put the extra info after the "--"
> v3-v4:
> add git log
> v4-v5:
> correct git log
> 
>  drivers/uio/uio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 1313422..b4ae2d9 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -491,18 +491,19 @@ static int uio_open(struct inode *inode, struct file *filep)
>  	if (!idev->info) {
>  		mutex_unlock(&idev->info_lock);
>  		ret = -EINVAL;
> -		goto err_alloc_listener;
> +		goto err_idev_info;
>  	}
>  
>  	if (idev->info && idev->info->open)
>  		ret = idev->info->open(idev->info, inode);
>  	mutex_unlock(&idev->info_lock);
>  	if (ret)
> -		goto err_infoopen;
> +		goto err_idev_info;
>  
>  	return 0;
>  
> -err_infoopen:
> +err_idev_info:
> +	filep->private_data = NULL;
>  	kfree(listener);
>  
>  err_alloc_listener:
> -- 
> 2.7.4
> 

This does not apply to my tree at all :(

Please rebase it against the char-misc-next branch of my char-misc.git
tree and resend.

thanks,

greg k-h
