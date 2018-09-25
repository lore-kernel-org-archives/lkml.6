Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B65C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D9220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D9220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeIYNAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:00:24 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:23487 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYNAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:00:24 -0400
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="17716566"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Sep 2018 23:54:18 -0700
Received: from [10.145.6.126] (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Mon, 24 Sep 2018
 23:54:17 -0700
Subject: Re: [PATCH 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        <stable@vger.kernel.org>
References: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
 <20180922113123.2c8da044@archlinux>
 <9846e106-8baf-b491-29ca-8306be9527ee@microchip.com>
 <20180924210056.2cae9439@archlinux> <20180924212701.400e21f7@archlinux>
From:   Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <5ee8253a-5b07-94ce-a86d-b453911fce0a@microchip.com>
Date:   Tue, 25 Sep 2018 09:50:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924212701.400e21f7@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.09.2018 23:27, Jonathan Cameron wrote:
> On Mon, 24 Sep 2018 21:00:56 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Mon, 24 Sep 2018 09:19:43 +0300
>> Eugen Hristev <eugen.hristev@microchip.com> wrote:
>>
>>> On 22.09.2018 13:31, Jonathan Cameron wrote:
>>>> On Thu, 20 Sep 2018 15:40:37 +0300
>>>> Eugen Hristev <eugen.hristev@microchip.com> wrote:
>>>>      
>>>>> When doing simple conversions, the driver did not acknowledge the DRDY irq.
>>>>> If this irq is not acked, it will be left pending, and as soon as a trigger
>>>>> is enabled, the irq handler will be called, it doesn't know why this irq
>>>>> has occurred because no channel is pending, and then we will have irq loop
>>>>> and board will hang.
>>>>>
>>>>> Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>>>> ---
>>>>>    drivers/iio/adc/at91_adc.c | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>>>>> index 44b5168..e85f859 100644
>>>>> --- a/drivers/iio/adc/at91_adc.c
>>>>> +++ b/drivers/iio/adc/at91_adc.c
>>>>> @@ -712,6 +712,11 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>>>>>    		at91_adc_writel(st, AT91_ADC_CHDR,
>>>>>    				AT91_ADC_CH(chan->channel));
>>>>>    		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
>>>>> +		/*
>>>>> +		 * we need to ack the DRDY irq, otherwise it will be
>>>>> +		 * left pending and irq handler will be confused
>>>>> +		 */
>>>>> +		at91_adc_readl(st, AT91_ADC_LCDR);
>>>>
>>>> I'm curious as to how things were working before.  Does this only occur
>>>> if we do a raw_read whilst the buffer is enabled?
>>>
>>> No. The situation is that the read raw does not properly cleans itself
>>> up after it's done.
>>> The DRDY bit is cleared only when LCDR (last converted data ) is being read.
>>> Even if we read the per channel conversion data, the LCDR still needs to
>>> be read to clear this irq status.
>>> The driver does not use the DRDY irq but this irq status is still being
>>> set in the status register.
>>
>> Hmm. That is somewhat nasty if it results in false interrupts when you
>> then enable them.
> 
> I'm talking rubbish here.  Please ignore!
> 
>>
>>>    
>>>>
>>>> I would have assumed when it's not enabled, the irq would be masked and
>>>> never generated in the first place...
>>>>
>>>> It may be that what we actually need to do is to prevent read_raw accesses
>>>> when the buffer is enabled (like lots of other drivers do precisely to
>>>> avoid this sort of condition). The problem there comes if we have
>>>> existing applications doing this combination as we are then breaking
>>>> userspace. If that's the case we'll need to be a bit more clever.
>>>>
>>>> Hammering down an irq state in a non irq handling path isn't a good
>>>> solution.
>>>
>>> Ok, I will move the clearing of the DRDY (LCDR read) in the irq path
>>> then, and send a v2.
>>
>> If that can be done cleanly, let us go with that approach. If not
>> what you have here with the addition of a comments saying that the
>> interrupt status is not masked, merely the interrupt and as a result needs
>> clearing for when you later enabled the interrupt, is fine.
>>
>> This definitely sounds like one of those bits of hardware that
>> you can write software to use safely but they certainly didn't make
>> it easy to do so!

For what it's worth a small explanation:

The status in the ISR (interrupt status) is updated regardless of 
whether the IRQ is enabled in the IER (interrupt enable) or not. 
Actually "enabling DRDY" makes the hardware start raising the interrupt 
line on DRDY event if it's the case. but DRDY bit is still being 
asserted in the ISR. It works like this because someone might want to 
write some simple driver without IRQ, just poll the ISR for the status.

One other thing, in my driver, at91-sama5d2_adc, I had the same issue, 
and I am reading the DRDY in the EOC part after waking up from the wait. 
This makes the IRQ handler shorter by a few hundred cycles : read LCDR 
in the userspace-called read_raw.
Do you want me to have a patch at some point to move the LCDR read in 
the IRQ handler for at91-sama5d2_adc as well ?

Eugen

>>
>> Jonathan
>>>
>>>    
>>>>
>>>> Jonathan
>>>>      
>>>>>    
>>>>>    		st->last_value = 0;
>>>>>    		st->done = false;
>>>>      
>>
> 
> 
