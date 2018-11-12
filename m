Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5C0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CD92245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsg5ejoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CD92245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeKMIlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeKMIlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:41:51 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E53D2241E;
        Mon, 12 Nov 2018 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542062797;
        bh=pRwFUrrmDebmsVml7eKn/wwvQfHTGFFUTys/G8T3PUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xsg5ejoCQZSXK4EyA9vQRuLmXzZmjcVwfw7JlkAdrWpQKFCIp3g7Iv45aG5a1r8/q
         6b5sIXvSRC0skj7Uqn0h6ADcT/WQyiwSK2+Qcef3kyp3P+O0KcPcgCc8X/1SNnGZ0a
         HtXThFH6d7Vm8ZcCiPe1IfTAFDloFQvLDg0fK+/Q=
Date:   Mon, 12 Nov 2018 14:46:36 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: erofs: unzip_vle.c: Replace comparison to
 NULL.
Message-ID: <20181112224636.GA12671@kroah.com>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
 <1542055439-24444-2-git-send-email-sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542055439-24444-2-git-send-email-sicilia.cristian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:43:57PM +0100, Cristian Sicilia wrote:
> Replace equal to NULL with logic unary operator,
> and removing not equal to NULL comparison.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/erofs/unzip_vle.c | 86 +++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 79d3ba6..1ffeeaa 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -20,8 +20,8 @@ static struct kmem_cache *z_erofs_workgroup_cachep __read_mostly;
>  
>  void z_erofs_exit_zip_subsystem(void)
>  {
> -	BUG_ON(z_erofs_workqueue == NULL);
> -	BUG_ON(z_erofs_workgroup_cachep == NULL);
> +	BUG_ON(!z_erofs_workqueue);
> +	BUG_ON(!z_erofs_workgroup_cachep);

Long-term, all of these BUG_ON need to be removed as they imply that the
developer has no idea what went wrong and can not recover.  For
something like this, we "know" these will be fine and odds are they can
just be removed entirely.

>  
>  	destroy_workqueue(z_erofs_workqueue);
>  	kmem_cache_destroy(z_erofs_workgroup_cachep);
> @@ -39,7 +39,7 @@ static inline int init_unzip_workqueue(void)
>  		WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
>  		onlinecpus + onlinecpus / 4);
>  
> -	return z_erofs_workqueue != NULL ? 0 : -ENOMEM;
> +	return z_erofs_workqueue ? 0 : -ENOMEM;

I hate ?: notation that is not in a function parameter, any way you can
just change this to:
	if (z_erofs_workqueue)
		return 0;
	return -ENOMEM;

Christian, this isn't your fault at all, I'm not rejecting this patch,
just providing hints on what else you can do here :)

thanks,

greg k-h
