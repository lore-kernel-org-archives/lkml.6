Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E4EECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890FF21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890FF21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbeIUHdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:33:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbeIUHdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:33:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D52848E35BE2;
        Fri, 21 Sep 2018 09:46:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 09:46:54 +0800
Message-ID: <5BA44D8E.3070708@huawei.com>
Date:   Fri, 21 Sep 2018 09:46:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: logitech: fix a used uninitialized GCC warning
References: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri

Can you pick up the patch?

Thanks
zhong jiang

On 2018/9/13 15:41, zhong jiang wrote:
> Fix the following compile warning:
>
> drivers/hid/hid-logitech-hidpp.c: In function 'hi_res_scroll_enable':
> drivers/hid/hid-logitech-hidpp.c:2714:54: warning: 'multiplier' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v1->v2:
>      According to Benjamin's suggestion, To initialize the value
> and remove the duplicated assignement. 
>
>  drivers/hid/hid-logitech-hidpp.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 5f0c080..f012808 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1231,7 +1231,6 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
>  	*multiplier = response.fap.params[0];
>  	return 0;
>  return_default:
> -	*multiplier = 8;
>  	hid_warn(hidpp->hid_dev,
>  		 "Couldn't get wheel multiplier (error %d), assuming %d.\n",
>  		 ret, *multiplier);
> @@ -2696,7 +2695,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
>  static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>  {
>  	int ret;
> -	u8 multiplier;
> +	u8 multiplier = 8;
>  
>  	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
>  		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> @@ -2704,10 +2703,9 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>  	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
>  		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
>  							   &multiplier);
> -	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
> +	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */
>  		ret = hidpp10_enable_scrolling_acceleration(hidpp);
> -		multiplier = 8;
> -	}
> +
>  	if (ret)
>  		return ret;
>  


