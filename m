Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A635C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E061E21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E061E21C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeHILVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:21:10 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:46544 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHILVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:21:09 -0400
Received: from [IPv6:2003:e9:d709:f021:3252:cbff:fe54:190f] (p200300E9D709F0213252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:e9:d709:f021:3252:cbff:fe54:190f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id A71A0C859F;
        Thu,  9 Aug 2018 10:57:16 +0200 (CEST)
Subject: Re: [PATCH net-next] ieee802154: Use kmemdup instead of duplicating
 it in ca8210_test_int_driver_write
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        h.morris@cascoda.com, alex.aring@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wpan@vger.kernel.org
References: <20180809064429.13348-1-yuehaibing@huawei.com>
 <488f54b7-cfe2-f64b-168e-11f79d4d4e96@datenfreihafen.org>
 <aaf879dd-c630-a201-b8ae-66c39a359a99@huawei.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <e2f699bf-a8c6-f1c0-a268-9b18518ae595@datenfreihafen.org>
Date:   Thu, 9 Aug 2018 10:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <aaf879dd-c630-a201-b8ae-66c39a359a99@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yue.

On 08/09/2018 10:44 AM, YueHaibing wrote:
> On 2018/8/9 16:13, Stefan Schmidt wrote:
>> Hello.
>>
>> On 08/09/2018 08:44 AM, YueHaibing wrote:
>>> Replace calls to kmalloc followed by a memcpy with a direct call to
>>> kmemdup.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> Is Yue your forname and Haibing your surname? In that case having it
>> written as
>>
>> Yue Haibing <yuehaibing@huawei.com>
> 
> Well, It should be this, but it's been a long time to use the former

Never to late to fix something I guess. :-)
Not blocking this patch base on this though.

>> in the from line as well as in the SOB would be better.
>>
>>> ---
>>>  drivers/net/ieee802154/ca8210.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
>>> index 58299fb..e21279d 100644
>>> --- a/drivers/net/ieee802154/ca8210.c
>>> +++ b/drivers/net/ieee802154/ca8210.c
>>> @@ -634,10 +634,9 @@ static int ca8210_test_int_driver_write(
>>>  	for (i = 0; i < len; i++)
>>>  		dev_dbg(&priv->spi->dev, "%#03x\n", buf[i]);
>>>  
>>> -	fifo_buffer = kmalloc(len, GFP_KERNEL);
>>> +	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
>>>  	if (!fifo_buffer)
>>>  		return -ENOMEM;
>>> -	memcpy(fifo_buffer, buf, len);
>>>  	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
>>>  	wake_up_interruptible(&priv->test.readq);
>>
>> Is this some kernel tree wide change you are submitting patches for or
>> only for the ca8210 driver? Is there any specific problem you see with
>> the kmalloc and memcpy code here? To me it looks fine.
>>
>> The reason I ask is to understand if this is bug fix or a cleanup.
> 
> It just a code cleanup only for ca8210.

Thanks for the info. I will wait for Harry's ack and apply it to
wpan-next afterwards.

regards
Stefan Schmidt
