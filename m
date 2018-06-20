Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B01C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DD420652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pP+/2NG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DD420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932828AbeFTXhm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:37:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFTXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ebEpAZ6xpKd3n59cmZ3B11PEc1b3uhbWYkJZz9uNS64=; b=pP+/2NG6R5L+qc+sXX4EwgWIDr
        V1RJAN/kpjWIwFKLoblGSrRrBt0VnT0ZqpPp5e/5h65lr6lRZAjd5eulopOxq+OAXZ8wjHQrQPHHz
        9/iSop3Pbe4ZEowAQ59DqNRlFGGS8SG3LaLtKHmIb9lx7EHmqYuxTvkTC0mmRfK+cBqAM40lXNn0z
        9zm7DUYyZRHGIC7xjh5SNK+iZBscRE2zm+sHuTvCspNb8pQ6tH1yHk6skN1pBM8jRWYOKH3LZRmRX
        N9yX2uy0zk0+9AmIuOCRB5vnCH7AdHaizY5Y8ecaf6kdk22Gco8WsYCv2oK4fguo1f4FRuwQU8lDt
        mZegCw4Q==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVmfS-0001Py-M2; Wed, 20 Jun 2018 23:37:38 +0000
Date:   Wed, 20 Jun 2018 16:37:36 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Mihai =?utf-8?B?RG9uyJt1?= <mihai.dontu@gmail.com>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
Message-ID: <20180620233736.GA3250@fury>
References: <20180620213141.GA8957@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620213141.GA8957@beast>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 02:31:41PM -0700, Kees Cook wrote:
> The probe handler_data was being allocated with __get_free_pages()
> for no reason I could find. The error path was using kfree(). Since

v4 of Mario's series used kmalloc:
https://patchwork.kernel.org/patch/9985827/

This was changed in v10 to use __get_free_pages:
https://patchwork.kernel.org/patch/10018023/

But... I'm not finding the discussion that led to this change.... Mario,
do you recall? Something about contiguous memory? We had a similar
discussion on an earlier series:

https://patchwork.kernel.org/patch/9975277/


> other things are happily using kmalloc() in the probe path, switch to
> kmalloc() entirely. This fixes the error path mismatch and will avoid
> issues with CONFIG_HARDENED_USERCOPY_PAGESPAN=y.
> 
> Reported-by: Mihai Donțu <mihai.dontu@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/platform/x86/wmi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 8e3d0146ff8c..04791ea5d97b 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -895,7 +895,6 @@ static int wmi_dev_probe(struct device *dev)
>  	struct wmi_driver *wdriver =
>  		container_of(dev->driver, struct wmi_driver, driver);
>  	int ret = 0;
> -	int count;
>  	char *buf;
>  
>  	if (ACPI_FAILURE(wmi_method_enable(wblock, 1)))
> @@ -917,9 +916,8 @@ static int wmi_dev_probe(struct device *dev)
>  			goto probe_failure;
>  		}
>  
> -		count = get_order(wblock->req_buf_size);
> -		wblock->handler_data = (void *)__get_free_pages(GFP_KERNEL,
> -								count);
> +		wblock->handler_data = kmalloc(wblock->req_buf_size,
> +					       GFP_KERNEL);
>  		if (!wblock->handler_data) {
>  			ret = -ENOMEM;
>  			goto probe_failure;
> @@ -964,8 +962,7 @@ static int wmi_dev_remove(struct device *dev)
>  	if (wdriver->filter_callback) {
>  		misc_deregister(&wblock->char_dev);
>  		kfree(wblock->char_dev.name);
> -		free_pages((unsigned long)wblock->handler_data,
> -			   get_order(wblock->req_buf_size));
> +		kfree(wblock->handler_data);
>  	}
>  
>  	if (wdriver->remove)
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security
> 

-- 
Darren Hart
VMware Open Source Technology Center
