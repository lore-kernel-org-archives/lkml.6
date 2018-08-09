Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD277C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B19021B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B19021B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeHIEFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:05:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeHIEFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:05:07 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F055B230036F8;
        Thu,  9 Aug 2018 09:42:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Thu, 9 Aug 2018
 09:42:46 +0800
Message-ID: <5B6B9C15.4050106@huawei.com>
Date:   Thu, 9 Aug 2018 09:42:45 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <davem@davemloft.net>, <edumazet@google.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/net/usb/r8152: change rtl8152_system_suspend
 to be void function
References: <1533738407-10495-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533738407-10495-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igore the patch, will repost, Thanks
On 2018/8/8 22:26, zhong jiang wrote:
> rtl8152_system_suspend defines the variable "ret", but it is not modified
> after initialization. Further, I find that any of the callees do not
> handle the return value. So It is safe to drop the variable and make it to
> be void function.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/net/usb/r8152.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 124211a..cc51ac8 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -4412,10 +4412,9 @@ static int rtl8152_runtime_suspend(struct r8152 *tp)
>  	return ret;
>  }
>  
> -static int rtl8152_system_suspend(struct r8152 *tp)
> +static void rtl8152_system_suspend(struct r8152 *tp)
>  {
>  	struct net_device *netdev = tp->netdev;
> -	int ret = 0;
>  
>  	netif_device_detach(netdev);
>  
> @@ -4429,8 +4428,6 @@ static int rtl8152_system_suspend(struct r8152 *tp)
>  		tp->rtl_ops.down(tp);
>  		napi_enable(napi);
>  	}
> -
> -	return ret;
>  }
>  
>  static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
> @@ -4443,7 +4440,7 @@ static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
>  	if (PMSG_IS_AUTO(message))
>  		ret = rtl8152_runtime_suspend(tp);
>  	else
> -		ret = rtl8152_system_suspend(tp);
> +		rtl8152_system_suspend(tp);
>  
>  	mutex_unlock(&tp->control);
>  


