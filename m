Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D58C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C72218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfAaJlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:41:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbfAaJlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:41:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2B2C7D7F67FD7A7144DD;
        Thu, 31 Jan 2019 17:41:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 17:41:47 +0800
Subject: Re: [PATCH -next] mISDN: hfcsusb: Fix potential NULL pointer
 dereference
To:     David Miller <davem@davemloft.net>
References: <20190130101902.19744-1-yuehaibing@huawei.com>
 <20190130.101013.1464226067584735951.davem@davemloft.net>
CC:     <isdn@linux-pingi.de>, <gustavo@embeddedor.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <b565e6fa-a52f-f4f1-21b9-c63332d06ea0@huawei.com>
Date:   Thu, 31 Jan 2019 17:41:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190130.101013.1464226067584735951.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/31 2:10, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Wed, 30 Jan 2019 18:19:02 +0800
> 
>> There is a potential NULL pointer dereference in case
>> kzalloc() fails and returns NULL.
>>
>> Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/isdn/hardware/mISDN/hfcsusb.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
>> index 124ff53..5660d5a 100644
>> --- a/drivers/isdn/hardware/mISDN/hfcsusb.c
>> +++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
>> @@ -263,6 +263,8 @@ hfcsusb_ph_info(struct hfcsusb *hw)
>>  	int i;
>>  
>>  	phi = kzalloc(struct_size(phi, bch, dch->dev.nrbchan), GFP_ATOMIC);
>> +	if (!phi)
>> +		return;
> 
> If we fail with an error and do not perform the operation we were requested to
> make, we must return an error to the caller, and the caller must do something
> reasonable with that error (perhaps return it to it's caller) and so on and
> so forth.


hfcsusb_ph_info alloced the 'phi'，then use it _alloc_mISDN_skb in _queue_data.
while _alloc_mISDN_skb fails, it also just return without err handling,then kfree(phi).
It seems that all the caller of hfcsusb_ph_info doesn't care the return value.

> 
> .
> 

