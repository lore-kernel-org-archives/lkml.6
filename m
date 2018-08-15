Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76819C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062AC21501
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062AC21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeHOKIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:08:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeHOKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:08:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 605864D7E5BB9;
        Wed, 15 Aug 2018 15:17:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Wed, 15 Aug 2018
 15:16:57 +0800
Message-ID: <5B73D368.5010205@huawei.com>
Date:   Wed, 15 Aug 2018 15:16:56 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <baruch@tkos.co.il>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc:rtc-digicolor: Use PTR_ERR_OR_ZERO to replace
 the open code
References: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com> <1534159885-25364-2-git-send-email-zhongjiang@huawei.com> <20180814161541.GP943@piout.net>
In-Reply-To: <20180814161541.GP943@piout.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/15 0:15, Alexandre Belloni wrote:
> Hi,
>
> On 13/08/2018 19:31:24+0800, zhong jiang wrote:
>> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
>> just replace them rather than duplicating its implement.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/rtc/rtc-digicolor.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
>> index b253bf1..fd6850c 100644
>> --- a/drivers/rtc/rtc-digicolor.c
>> +++ b/drivers/rtc/rtc-digicolor.c
>> @@ -202,10 +202,8 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
>>  	platform_set_drvdata(pdev, rtc);
>>  	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
>>  						&dc_rtc_ops, THIS_MODULE);
>> -	if (IS_ERR(rtc->rtc_dev))
>> -		return PTR_ERR(rtc->rtc_dev);
>>  
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
> As many other maintainers, I don't find that kind of change useful and
> I'm not taking them unless there are other improvements in the driver.
>
>
Hi,  Alexandre

The issue is detected with the help of  Coccinelle.  It simplify the code with specific
function rather than duplicating its implementation.

The patch clean up the code.   of course,  it is not a bug.  if you do not care about it.
I am ok with that.

Thanks,
zhong jiang

