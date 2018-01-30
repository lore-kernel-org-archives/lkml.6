Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeA3J5Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:57:24 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:55153 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751249AbeA3J5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:57:22 -0500
Subject: Re: [PATCH 8/8] platform: vivid-cec: fix potential integer overflow
 in vivid_cec_pin_adap_events
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1517268667.git.gustavo@embeddedor.com>
 <00eea53890802b679c138fc7f68a0f162261d95c.1517268668.git.gustavo@embeddedor.com>
 <2e1afa55-d214-f932-4ba7-2e21f6a2cd3d@xs4all.nl>
 <20180130025141.Horde.h4aoQSwrqdPlpFtSKtB9DuS@gator4166.hostgator.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <43652014-30af-1e4b-c0a9-c23f9633fb2f@xs4all.nl>
Date: Tue, 30 Jan 2018 10:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180130025141.Horde.h4aoQSwrqdPlpFtSKtB9DuS@gator4166.hostgator.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLW4g3B2XMo2+dfcc55TivQkWj5Nkrdy19dYmpGCReWRiXDMYx65lDlSHIpgQojWSvoXN4vbdg0ij+FThwc+LktV5r+443j4hwBnuX9kivYStFyXrvcF
 ExWgqtSxo5T6S1PsTHH3TW2Tq0cH++3XkwZQlZ7gK9iHfjM3Pf7xCr19xkCeivsrq/Jt0qRZIrKZsYOrUFb13MLrCgIay7HFfQMsxTl05GLLh6SnN2gp6IDn
 8y6xerEzkiI61H9saqHHk66jk7YIue0pX56fwmt6q4PwiwWCZHQq7c3syl2I2O1JOrInymurCHuD+kdZKxon/A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 09:51 AM, Gustavo A. R. Silva wrote:
> Hi Hans,
> 
> Quoting Hans Verkuil <hverkuil@xs4all.nl>:
> 
>> Hi Gustavo,
>>
>> On 01/30/2018 01:33 AM, Gustavo A. R. Silva wrote:
>>> Cast len to const u64 in order to avoid a potential integer
>>> overflow. This variable is being used in a context that expects
>>> an expression of type const u64.
>>>
>>> Addresses-Coverity-ID: 1454996 ("Unintentional integer overflow")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/media/platform/vivid/vivid-cec.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/vivid/vivid-cec.c  
>>> b/drivers/media/platform/vivid/vivid-cec.c
>>> index b55d278..30240ab 100644
>>> --- a/drivers/media/platform/vivid/vivid-cec.c
>>> +++ b/drivers/media/platform/vivid/vivid-cec.c
>>> @@ -83,7 +83,7 @@ static void vivid_cec_pin_adap_events(struct  
>>> cec_adapter *adap, ktime_t ts,
>>>  	if (adap == NULL)
>>>  		return;
>>>  	ts = ktime_sub_us(ts, (CEC_TIM_START_BIT_TOTAL +
>>> -			       len * 10 * CEC_TIM_DATA_BIT_TOTAL));
>>> +			       (const u64)len * 10 * CEC_TIM_DATA_BIT_TOTAL));
>>
>> This makes no sense. Certainly the const part is pointless. And given that
>> len is always <= 16 there definitely is no overflow.
>>
> 
> Yeah, I understand your point and I know there is no chance of an  
> overflow in this particular case.
> 
>> I don't really want this cast in the code.
>>
>> Sorry,
>>
> 
> I'm working through all the Linux kernel Coverity reports, and I  
> thought of sending a patch for this because IMHO it doesn't hurt to  
> give the compiler complete information about the arithmetic in which  
> an expression is intended to be evaluated.
> 
> I agree that the _const_ part is a bit odd. What do you think about  
> the cast to u64 alone?

What happens if you do: ((u64)CEC_TIM_START_BIT_TOTAL +

I think that forces everything else in the expression to be evaluated
as u64.

It definitely needs a comment that this fixes a bogus Coverity report.

Regards,

	Hans

> 
> I appreciate your feedback.
> 
> Thanks
> --
> Gustavo
> 
> 
> 
> 
> 
