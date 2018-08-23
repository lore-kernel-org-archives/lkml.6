Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A893208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A893208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeHWQwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:52:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729498AbeHWQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:52:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89ABD3A7E8E43;
        Thu, 23 Aug 2018 21:22:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 21:22:36 +0800
Message-ID: <5B7EB51B.9080901@huawei.com>
Date:   Thu, 23 Aug 2018 21:22:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <Claudiu.Beznea@microchip.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: pm: call put_device instead of of_node_put in at91_pm_config_ws
References: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com> <5B7E9E26.3050209@huawei.com> <20180823121921.GE21707@piout.net>
In-Reply-To: <20180823121921.GE21707@piout.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/23 20:19, Alexandre Belloni wrote:
> On 23/08/2018 19:44:38+0800, zhong jiang wrote:
>> Hi, alexandre
>>
>> Can you pick up the patch?  Thanks
>>
> We are still in the merge window, this has to wait for v4.19-rc1.
 Fine.  Thank you for let me know .
>> Best wishes,
>> zhong jiang
>>
>> On 2018/8/16 18:26, zhong jiang wrote:
>>> of_find_device_by_node takes a reference to the struct device when it
>>> finds a match via get_device. but it fails to put_device in
>>> at91_pm_config_ws, for_each_matching_node_and_match will get and put
>>> the node properly, there is no need to call the of_put_node. Therefore,
>>> just call put_device instead of of_node_put in at91_pm_config_ws.
>>>
>>> Fixes: d7484f5c6b3b ("ARM: at91: pm: configure wakeup sources for ULP1 mode")
>>> Suggested-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  arch/arm/mach-at91/pm.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>>> index 32fae4d..6574f00 100644
>>> --- a/arch/arm/mach-at91/pm.c
>>> +++ b/arch/arm/mach-at91/pm.c
>>> @@ -143,15 +143,15 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>>>  
>>>  			/* Check if enabled on SHDWC. */
>>>  			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
>>> -				goto put_node;
>>> +				goto put_device;
>>>  
>>>  			mode |= wsi->pmc_fsmr_bit;
>>>  			if (wsi->set_polarity)
>>>  				polarity |= wsi->pmc_fsmr_bit;
>>>  		}
>>>  
>>> -put_node:
>>> -		of_node_put(np);
>>> +put_device:
>>> +		put_device(&pdev->dev);
>>>  	}
>>>  
>>>  	if (mode) {
>>


