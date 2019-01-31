Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D00CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0E42086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfAaRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:25:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33354 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfAaRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:25:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 053AA14F7B5D9;
        Thu, 31 Jan 2019 09:25:58 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:25:58 -0800 (PST)
Message-Id: <20190131.092558.965594555882861991.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     isdn@linux-pingi.de, gustavo@embeddedor.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] mISDN: hfcsusb: Fix potential NULL pointer
 dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <b565e6fa-a52f-f4f1-21b9-c63332d06ea0@huawei.com>
References: <20190130101902.19744-1-yuehaibing@huawei.com>
        <20190130.101013.1464226067584735951.davem@davemloft.net>
        <b565e6fa-a52f-f4f1-21b9-c63332d06ea0@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 31 Jan 2019 09:25:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 31 Jan 2019 17:41:46 +0800

> On 2019/1/31 2:10, David Miller wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>> Date: Wed, 30 Jan 2019 18:19:02 +0800
>> 
>>> There is a potential NULL pointer dereference in case
>>> kzalloc() fails and returns NULL.
>>>
>>> Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/isdn/hardware/mISDN/hfcsusb.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
>>> index 124ff53..5660d5a 100644
>>> --- a/drivers/isdn/hardware/mISDN/hfcsusb.c
>>> +++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
>>> @@ -263,6 +263,8 @@ hfcsusb_ph_info(struct hfcsusb *hw)
>>>  	int i;
>>>  
>>>  	phi = kzalloc(struct_size(phi, bch, dch->dev.nrbchan), GFP_ATOMIC);
>>> +	if (!phi)
>>> +		return;
>> 
>> If we fail with an error and do not perform the operation we were requested to
>> make, we must return an error to the caller, and the caller must do something
>> reasonable with that error (perhaps return it to it's caller) and so on and
>> so forth.
> 
> 
> hfcsusb_ph_info alloced the 'phi'，then use it _alloc_mISDN_skb in _queue_data.
> while _alloc_mISDN_skb fails, it also just return without err handling,then kfree(phi).
> It seems that all the caller of hfcsusb_ph_info doesn't care the return value.

And that's a bug!
