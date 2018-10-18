Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1230ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918292145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5ZGknYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918292145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJSHdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:33:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJSHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Oe0gAFgLoPVoAqEVJd+yxav/DQItH9hF0+wR+nEzCk=; b=f5ZGknYdri6+tE1rmw+tBS9T+
        bBWrrEBhvDH8U/DfTcxckElUs4mvaXx217XTVFI1sbZv7C4UaVDc4OiTmhpCRmSZbOfIxRd+IpQPv
        y07cRcBJh4zq3AxsCW8SHICxstFcq5ycHkwBev808pNXPIdMBQnC3GQhLXpFmyIN1neXr2OQvRKv5
        JwBKFBHbnTl2YYHZKkt0PRPS7uRHSoa8lYcCTKgLjiLpthqspFOAkQLSWoO1OQifrRf8qNze3xIBm
        Wrv9ocBxLf4LN9uT0mxX/4QZDKX+OufZOUVXNpMX6vJH+8jv4tWtKIrwCO6XEWNbUR2wkiduYXIpm
        ZSivvd/pA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDHjl-0000WJ-Ah; Thu, 18 Oct 2018 23:29:53 +0000
Subject: Re: [PATCH] usbip:vudc: BUG kmalloc-2048 (Not tainted): Poison
 overwritten
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181018161929.9330-1-shuah@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dc212111-a4a5-ca6c-8e30-ef4d91cec0ab@infradead.org>
Date:   Thu, 18 Oct 2018 16:29:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018161929.9330-1-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 9:19 AM, Shuah Khan (Samsung OSG) wrote:
> In rmmod path, usbip_vudc does platform_device_put() twice once from
> platform_device_unregister() and then from put_vudc_device().
> 
> The second put results in:
> 
> BUG kmalloc-2048 (Not tainted): Poison overwritten error or
> BUG: KASAN: use-after-free in kobject_put+0x1e/0x230 if KASAN is
> enabled.
> 
> [  169.042156] calling  init+0x0/0x1000 [usbip_vudc] @ 1697
> [  169.042396] =============================================================================
> [  169.043678] probe of usbip-vudc.0 returned 1 after 350 usecs
> [  169.044508] BUG kmalloc-2048 (Not tainted): Poison overwritten
> [  169.044509] -----------------------------------------------------------------------------
> ...
> [  169.057849] INFO: Freed in device_release+0x2b/0x80 age=4223 cpu=3 pid=1693
> [  169.057852] 	kobject_put+0x86/0x1b0
> [  169.057853] 	0xffffffffc0c30a96
> [  169.057855] 	__x64_sys_delete_module+0x157/0x240
> 
> Fix it to call platform_device_del() instead and let put_vudc_device() do
> the platform_device_put().
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> Cc: <stable@vger.kernel.org>

and
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/usb/usbip/vudc_main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/vudc_main.c b/drivers/usb/usbip/vudc_main.c
> index 3fc22037a82f..390733e6937e 100644
> --- a/drivers/usb/usbip/vudc_main.c
> +++ b/drivers/usb/usbip/vudc_main.c
> @@ -73,6 +73,10 @@ static int __init init(void)
>  cleanup:
>  	list_for_each_entry_safe(udc_dev, udc_dev2, &vudc_devices, dev_entry) {
>  		list_del(&udc_dev->dev_entry);
> +		/*
> +		 * Just do platform_device_del() here, put_vudc_device()
> +		 * calls the platform_device_put()
> +		 */
>  		platform_device_del(udc_dev->pdev);
>  		put_vudc_device(udc_dev);
>  	}
> @@ -89,7 +93,11 @@ static void __exit cleanup(void)
>  
>  	list_for_each_entry_safe(udc_dev, udc_dev2, &vudc_devices, dev_entry) {
>  		list_del(&udc_dev->dev_entry);
> -		platform_device_unregister(udc_dev->pdev);
> +		/*
> +		 * Just do platform_device_del() here, put_vudc_device()
> +		 * calls the platform_device_put()
> +		 */
> +		platform_device_del(udc_dev->pdev);
>  		put_vudc_device(udc_dev);
>  	}
>  	platform_driver_unregister(&vudc_driver);
> 


-- 
~Randy
