Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635432173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546877600;
	bh=IxZK/QKjKw8nM4y2pcu1M0PmOOwY7WlQ8afgLuTY4H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sF+7cIGvKIGdJVSstWWFtVElO93U1Er84wvuCDaQhTBfETI8NDVWmPQNEtPAuua6s
	 8+9nu4fmyAq+yLSU77tYAk+h2nrw3gGOX4N8yx5GS16CjZs0AAfLyTFlbuyyTuVJQE
	 33I5hFzhraF2QsdKMHGJ84WrK3TQWqHX+TjD1MKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfAGQNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfAGQNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:13:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D12E2070C;
        Mon,  7 Jan 2019 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546877598;
        bh=IxZK/QKjKw8nM4y2pcu1M0PmOOwY7WlQ8afgLuTY4H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIoPVhNJ11+biXgpMhVUOkjxzXERCcoM4jHpe6wroqzPr6zqXY9zy9HUZmgJVWVNR
         Ijhh+Wp6jR3MabNu09GKbGpEldzi1cyTnz2g0k1xcGlRYTDQohYq+vSsCOMuzieczb
         ZFsNHcUKQGi5WuLtEhVUL43YH2FOhBRS5q3+ibvw=
Date:   Mon, 7 Jan 2019 17:13:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liujian <liujian56@huawei.com>
Cc:     michal.simek@xilinx.com, hamish.martin@alliedtelesis.co.nz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver: uio: fix possible memory leak and
 use-after-free in __uio_register_device
Message-ID: <20190107161315.GA25694@kroah.com>
References: <1546611548-205765-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546611548-205765-1-git-send-email-liujian56@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 10:19:08PM +0800, liujian wrote:
> 'idev' is malloced in __uio_register_device() and leak free it before
> leaving from the uio_get_minor() error handing case, it will cause
> memory leak.
> 
> Also, in uio_dev_add_attributes() error handing case, idev is used after
> device_unregister(), in which 'idev' has been released, touch idev cause
> use-after-free.
> 
> Fixes: a93e7b331568 ("uio: Prevent device destruction while fds are open")
> Fixes: e6789cd3dfb5 ("uio: Simplify uio error path by using devres functions")
> Signed-off-by: liujian <liujian56@huawei.com>
> Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> ---
> v1->v2:
> change git log and fix code
> 
>  drivers/uio/uio.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 1313422..be2a943 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -940,9 +940,12 @@ int __uio_register_device(struct module *owner,
>  	atomic_set(&idev->event, 0);
>  
>  	ret = uio_get_minor(idev);
> -	if (ret)
> +	if (ret) {
> +		kfree(idev);
>  		return ret;
> +	}
>  
> +	device_initialize(&idev->dev);
>  	idev->dev.devt = MKDEV(uio_major, idev->minor);
>  	idev->dev.class = &uio_class;
>  	idev->dev.parent = parent;
> @@ -953,7 +956,7 @@ int __uio_register_device(struct module *owner,
>  	if (ret)
>  		goto err_device_create;
>  
> -	ret = device_register(&idev->dev);
> +	ret = device_add(&idev->dev);
>  	if (ret)
>  		goto err_device_create;
>  
> @@ -985,9 +988,10 @@ int __uio_register_device(struct module *owner,
>  err_request_irq:
>  	uio_dev_del_attributes(idev);
>  err_uio_dev_add_attributes:
> -	device_unregister(&idev->dev);
> +	device_del(&idev->dev);
>  err_device_create:
>  	uio_free_minor(idev);
> +	put_device(&idev->dev);

device_del() and then put_device()?  I don't think that's a correct
error cleanup path do you?

Please fix one thing at a time here also, this should be a a patch
series, right?

thanks,

greg k-h
