Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeDKIgY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:36:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38749 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeDKIgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:36:22 -0400
X-Google-Smtp-Source: AIpwx484BuUkxMV7EP7ItHMa/2VwuzyGZEJRla09rlGI05qfgQP75dth74OwjvMR4/PmGWTZaV1MbA==
Subject: Re: [PATCH 1/2] ide: pdc202xx_new: Replace mdelay with usleep_range
 in detect_pll_input_clock
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        davem@davemloft.net, frankt@promise.com, andre@linux-ide.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523433162-3910-1-git-send-email-baijiaju1990@gmail.com>
 <7558e956-62bd-39b9-6ff1-4d5f7ee2c9a3@cogentembedded.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <00b11f19-0a4b-df83-923b-001bc5393229@gmail.com>
Date: Wed, 11 Apr 2018 16:35:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <7558e956-62bd-39b9-6ff1-4d5f7ee2c9a3@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/11 16:33, Sergei Shtylyov wrote:
> Hello!
>
> On 4/11/2018 10:52 AM, Jia-Ju Bai wrote:
>
>> detect_pll_input_clock() is never called in atomic context.
>>
>> detect_pll_input_clock() is only called by init_chipset_pdcnew(), which
>> is set as ".init_chipset" in struct ide_port_info.
>> This function is not called in atomic context.
>>
>> Despite never getting called from atomic context, 
>> detect_pll_input_clock()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with usleep_range() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/ide/pdc202xx_new.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
>> index b33646b..6afa66d 100644
>> --- a/drivers/ide/pdc202xx_new.c
>> +++ b/drivers/ide/pdc202xx_new.c
>> @@ -258,7 +258,7 @@ static long detect_pll_input_clock(unsigned long 
>> dma_base)
>>       outb(scr1 | 0x40, dma_base + 0x03);
>>         /* Let the counter run for 10 ms. */
>> -    mdelay(10);
>> +    usleep_range(10);
>
>    This function takes 2 arguments.
>
> [...]
>
> MBR, Sergei

Oops, sorry for my fault.
Thanks for telling me this :)
I will modify it and send V2.


Best wishes,
Jia-Ju Bai
