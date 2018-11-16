Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E689F2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E689F2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeKQGTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:19:22 -0500
Received: from mail.bugwerft.de ([46.23.86.59]:59468 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbeKQGTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:19:21 -0500
Received: from [192.168.178.170] (pD95EF84F.dip0.t-ipconnect.de [217.94.248.79])
        by mail.bugwerft.de (Postfix) with ESMTPSA id DEB512C0BE0;
        Fri, 16 Nov 2018 20:05:31 +0000 (UTC)
Subject: Re: [PATCH -next] video: fbdev: pxafb: Fix "WARNING: invalid free of
 devm_ allocated data"
To:     YueHaibing <yuehaibing@huawei.com>, b.zolnierkie@samsung.com,
        robert.jarzmik@free.fr
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20181116110255.19736-1-yuehaibing@huawei.com>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <ac93008d-05a0-834f-fcdd-649b0d12c212@zonque.org>
Date:   Fri, 16 Nov 2018 21:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116110255.19736-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2018 12:02 PM, YueHaibing wrote:
> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
> 
> This gives this error message:
>    ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Oh, yes. Thanks for spotting this!

Could you please add these lines to the patch and resubmit?


Fixes: c8f96304ec8b4 ("video: fbdev: pxafb: switch to devm_* API")
Cc: stable@kernel.org [v4.19+]
Reviewed-by: Daniel Mack <daniel@zonque.org>




> ---
>   drivers/video/fbdev/pxafb.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index bbed039..d59c8a5 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2234,10 +2234,8 @@ static struct pxafb_mach_info *of_pxafb_of_mach_info(struct device *dev)
>   	if (!info)
>   		return ERR_PTR(-ENOMEM);
>   	ret = of_get_pxafb_mode_info(dev, info);
> -	if (ret) {
> -		kfree(info->modes);
> +	if (ret)
>   		return ERR_PTR(ret);
> -	}
>   
>   	/*
>   	 * On purpose, neither lccrX registers nor video memory size can be
> 

