Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D25C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4141D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4141D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeKSLqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:46:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727237AbeKSLqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:46:02 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3CA036B35A136;
        Mon, 19 Nov 2018 09:24:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Mon, 19 Nov 2018
 09:23:58 +0800
Subject: Re: [PATCH -next] video: fbdev: pxafb: Fix "WARNING: invalid free of
 devm_ allocated data"
To:     Daniel Mack <daniel@zonque.org>, <b.zolnierkie@samsung.com>,
        <robert.jarzmik@free.fr>
References: <20181116110255.19736-1-yuehaibing@huawei.com>
 <ac93008d-05a0-834f-fcdd-649b0d12c212@zonque.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <e8ab2a91-9779-5062-3a39-1b5ee1c824c7@huawei.com>
Date:   Mon, 19 Nov 2018 09:23:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <ac93008d-05a0-834f-fcdd-649b0d12c212@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/17 4:05, Daniel Mack wrote:
> On 16/11/2018 12:02 PM, YueHaibing wrote:
>> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
>>
>> This gives this error message:
>>    ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Oh, yes. Thanks for spotting this!
> 
> Could you please add these lines to the patch and resubmit?
> 

Sure, will send v2.

> 
> Fixes: c8f96304ec8b4 ("video: fbdev: pxafb: switch to devm_* API")
> Cc: stable@kernel.org [v4.19+]
> Reviewed-by: Daniel Mack <daniel@zonque.org>
> 
> 
> 
> 
>> ---
>>   drivers/video/fbdev/pxafb.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
>> index bbed039..d59c8a5 100644
>> --- a/drivers/video/fbdev/pxafb.c
>> +++ b/drivers/video/fbdev/pxafb.c
>> @@ -2234,10 +2234,8 @@ static struct pxafb_mach_info *of_pxafb_of_mach_info(struct device *dev)
>>       if (!info)
>>           return ERR_PTR(-ENOMEM);
>>       ret = of_get_pxafb_mode_info(dev, info);
>> -    if (ret) {
>> -        kfree(info->modes);
>> +    if (ret)
>>           return ERR_PTR(ret);
>> -    }
>>         /*
>>        * On purpose, neither lccrX registers nor video memory size can be
>>
> 
> 
> .
> 

