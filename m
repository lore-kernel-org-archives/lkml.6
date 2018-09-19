Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEEDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7FE214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7FE214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeISHGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:06:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbeISHGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:06:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 06DDB149AB54D;
        Wed, 19 Sep 2018 09:31:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 09:30:57 +0800
Message-ID: <5BA1A6D0.4090506@huawei.com>
Date:   Wed, 19 Sep 2018 09:30:56 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Michael Ira Krufky <mkrufky@linuxtv.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Brad Love <brad@nextdimension.cc>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: dvb-frontends: Use kmemdup instead of duplicating
 its function
References: <1537284628-62020-1-git-send-email-zhongjiang@huawei.com> <CAOcJUbzfv8DLpRAbAiodqDDQ5wH1uyqjJ-sKN+qJGr=xagQBNg@mail.gmail.com>
In-Reply-To: <CAOcJUbzfv8DLpRAbAiodqDDQ5wH1uyqjJ-sKN+qJGr=xagQBNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 3:58, Michael Ira Krufky wrote:
> On Tue, Sep 18, 2018 at 11:42 AM zhong jiang <zhongjiang@huawei.com> wrote:
>> kmemdup has implemented the function that kmalloc() + memcpy().
>> We prefer to kmemdup rather than code opened implementation.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/media/dvb-frontends/lgdt3306a.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
>> index 0e1f5da..abec2e5 100644
>> --- a/drivers/media/dvb-frontends/lgdt3306a.c
>> +++ b/drivers/media/dvb-frontends/lgdt3306a.c
>> @@ -2205,15 +2205,13 @@ static int lgdt3306a_probe(struct i2c_client *client,
>>         struct dvb_frontend *fe;
>>         int ret;
>>
>> -       config = kzalloc(sizeof(struct lgdt3306a_config), GFP_KERNEL);
>> +       onfig = kmemdup(client->dev.platform_data,
>> +                       sizeof(struct lgdt3306a_config), GFP_KERNEL);
>>         if (config == NULL) {
>>                 ret = -ENOMEM;
>>                 goto fail;
>>         }
>>
>> -       memcpy(config, client->dev.platform_data,
>> -                       sizeof(struct lgdt3306a_config));
>> -
>>         config->i2c_addr = client->addr;
>>         fe = lgdt3306a_attach(config, client->adapter);
>>         if (fe == NULL) {
> Thank you for this patch, Zhong.  I suspect, however, that the patch
> might contain a typo.  It looks like the `c` got dropped off of the
> `config` variable.
I am sorry.  It's my fault.:-[ . Will repost

Thanks,
zhong jiang
> Did you test this before sending it in?
>
> Thanks again and best regards,
>
> Michael Krufky
>
> .
>


