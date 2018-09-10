Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF35C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04B62087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04B62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeIJSn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:43:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIJSn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:43:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D91755261AC65;
        Mon, 10 Sep 2018 21:49:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Mon, 10 Sep 2018
 21:49:08 +0800
Message-ID: <5B967653.1030007@huawei.com>
Date:   Mon, 10 Sep 2018 21:49:07 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Himanshu Jha <himanshujha199640@gmail.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: remove unnecessary condition judgment in am2315_trigger_handler
References: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com> <20180908122913.GA4445@himanshu-Vostro-3559> <20180908151751.20e7396f@archlinux>
In-Reply-To: <20180908151751.20e7396f@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/8 22:17, Jonathan Cameron wrote:
> On Sat, 8 Sep 2018 17:59:13 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>
>> On Sat, Sep 08, 2018 at 06:57:36PM +0800, zhong jiang wrote:
>>> The iterator in for_each_set_bit is never null, therefore, remove
>>> the redundant conditional judgment.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/iio/humidity/am2315.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
>>> index 7d8669d..dc12e37 100644
>>> --- a/drivers/iio/humidity/am2315.c
>>> +++ b/drivers/iio/humidity/am2315.c
>>> @@ -176,8 +176,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
>>>  		i = 0;
>>>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>>>  				 indio_dev->masklength) {
>>> -			data->buffer[i] = (bit ? sensor_data.temp_data :
>>> -						 sensor_data.hum_data);
>>> +			data->buffer[i] = sensor_data.temp_data;  
>> No, this seems wrong!
>>
>> We have buffer support to either take both readings(temp & humid)
>> simultaneously, or only single channel using specified scan mask.
> Key think is that bit most definitely can be 0 if the 0th bit is set.
> This isn't a null check at all.
>
> I'm curious, was this a by inspection case or did some script throw
> this one up?
 Hi,  Jonathan

 bit is a iterator that find the non-zero bit in indio_dev->active_scan_mask. if  all bit is
 zero ,  it should return the masklength.

 Yep.  I find the issue with the help of Coccinelle.

 Thanks
zhong jiang
> Thanks,
>
> Jonathan
>
>> Patch title should be:
>>
>> "iio: humidity: am2315: .... .. "
>>
>>
>> Thanks
>
> .
>


