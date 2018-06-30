Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66355C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6DE254A2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6DE254A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932432AbeF3Gax (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 02:30:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752523AbeF3Gav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 02:30:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC6F4FE058C89;
        Sat, 30 Jun 2018 14:30:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Sat, 30 Jun 2018
 14:30:36 +0800
Subject: Re: [PATCH] atmel: using strlcpy() to avoid possible buffer overflows
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180629025135.12236-1-yuehaibing@huawei.com>
 <CAHp75Vet-vTz_Ld=Lturmm8NSpK1etvoj-7Wzn4-h=bM2FQgZg@mail.gmail.com>
 <CAHp75VcTVtzLuwH=Ff6DBKJyQE4t=HT7hB2O=gvgN+V-38LH5g@mail.gmail.com>
CC:     <simon@thekelleys.org.uk>, Kalle Valo <kvalo@codeaurora.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <1639a6d7-622a-99fc-9321-989661e4b923@huawei.com>
Date:   Sat, 30 Jun 2018 14:30:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcTVtzLuwH=Ff6DBKJyQE4t=HT7hB2O=gvgN+V-38LH5g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/6/30 5:51, Andy Shevchenko wrote:
> On Sat, Jun 30, 2018 at 12:47 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Jun 29, 2018 at 5:51 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>>> 'firmware' is a module param which may been longer than firmware_id,
>>> so using strlcpy() to guard against overflows
>>
>> strncat() is against overflow, this does a bit more.
>>
>>>         priv->firmware_id[0] = '\0';
>> ...
>>>         if (firmware) /* module parameter */
>>> -               strcpy(priv->firmware_id, firmware);
>>> +               strlcpy(priv->firmware_id, firmware, sizeof(priv->firmware_id));
>>
>> In either case the above '\0' is not needed.
>> But it looks like the intention was to use strncat() / strlcat().
> 
> Ah, this is under condition, yes. If no parameter supplied, this needs
> to be clean, but
> priv is allocated with zeroed memory
> https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L8369

so just remove this line:
	 priv->firmware_id[0] = '\0';

and using strlcpy while 'firmware' NOT null is enough.

Will send v2.

> 

