Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F307C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB51208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB51208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbeIXXWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:22:48 -0400
Received: from www381.your-server.de ([78.46.137.84]:49298 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbeIXXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:22:47 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1g4UWF-0003Tg-3R; Mon, 24 Sep 2018 19:19:35 +0200
Received: from [188.174.126.27] (helo=[192.168.178.22])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1g4UWE-0005v4-SN; Mon, 24 Sep 2018 19:19:34 +0200
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180918125314.GA12752@embeddedor.com>
 <20180922144230.7d5e6c80@archlinux>
 <b16657d2-250e-2cef-5aca-2c32b3fac8a4@metafoo.de>
Message-ID: <01297ad3-34a9-994a-f6f4-874dfeb9242b@metafoo.de>
Date:   Mon, 24 Sep 2018 19:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b16657d2-250e-2cef-5aca-2c32b3fac8a4@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/24981/Mon Sep 24 15:50:40 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 07:18 PM, Lars-Peter Clausen wrote:
> On 09/22/2018 03:42 PM, Jonathan Cameron wrote:
>> On Tue, 18 Sep 2018 07:53:14 -0500
>> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>
>>> Cast factor to s64 in order to give the compiler complete information
>>> about the proper arithmetic to use and avoid a potential integer
>>> overflow. Notice that such variable is being used in a context
>>> that expects an expression of type s64 (64 bits, signed).
>>>
>>> Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
>>> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
>>> index dcd7fb5..e360e27 100644
>>> --- a/drivers/iio/adc/qcom-vadc-common.c
>>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>>> @@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
>>>  	voltage = div64_s64(voltage, data->full_scale_code_volt);
>>>  	if (voltage > 0) {
>>>  		voltage *= prescale->den;
>>> -		temp = prescale->num * factor;
>>> +		temp = prescale->num * (s64)factor;
>> So factor is an unsigned int so could be 32 bits.  In reality it only
>> takes a small set of values between 1 and 1000
>>
>> Maximum numerator is 10 so a maximum of 10,000.
>>
>> Hence this is a false positive, be it one that would be very hard
>> for a static checker to identify.
> 
> I think the reason why it complains is because temp is s64. So it infers
> that the idea was that the result of the multiplication can be larger
> than 64 bit. For 32bit * 32bit -> 32bit it should not complain.

"lager than 32 bit"

> 
>>
>> So that moves it from a fix to a warning suppression change.
>> I have no problem with those, but description needs to reflect that.
> 
> Maybe just change the type of temp to u32. There is also
> mul_u64_u32_div() which could be used here to further simplify things.
> 

