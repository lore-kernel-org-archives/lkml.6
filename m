Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeA3Ivo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:51:44 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.253]:28769 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751496AbeA3Ivn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:51:43 -0500
Date: Tue, 30 Jan 2018 02:51:41 -0600
Message-ID: <20180130025141.Horde.h4aoQSwrqdPlpFtSKtB9DuS@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] platform: vivid-cec: fix potential integer overflow
 in vivid_cec_pin_adap_events
References: <cover.1517268667.git.gustavo@embeddedor.com>
 <00eea53890802b679c138fc7f68a0f162261d95c.1517268668.git.gustavo@embeddedor.com>
 <2e1afa55-d214-f932-4ba7-2e21f6a2cd3d@xs4all.nl>
In-Reply-To: <2e1afa55-d214-f932-4ba7-2e21f6a2cd3d@xs4all.nl>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1egRdm-000PJ9-7H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:51843
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Quoting Hans Verkuil <hverkuil@xs4all.nl>:

> Hi Gustavo,
>
> On 01/30/2018 01:33 AM, Gustavo A. R. Silva wrote:
>> Cast len to const u64 in order to avoid a potential integer
>> overflow. This variable is being used in a context that expects
>> an expression of type const u64.
>>
>> Addresses-Coverity-ID: 1454996 ("Unintentional integer overflow")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/media/platform/vivid/vivid-cec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/vivid/vivid-cec.c  
>> b/drivers/media/platform/vivid/vivid-cec.c
>> index b55d278..30240ab 100644
>> --- a/drivers/media/platform/vivid/vivid-cec.c
>> +++ b/drivers/media/platform/vivid/vivid-cec.c
>> @@ -83,7 +83,7 @@ static void vivid_cec_pin_adap_events(struct  
>> cec_adapter *adap, ktime_t ts,
>>  	if (adap == NULL)
>>  		return;
>>  	ts = ktime_sub_us(ts, (CEC_TIM_START_BIT_TOTAL +
>> -			       len * 10 * CEC_TIM_DATA_BIT_TOTAL));
>> +			       (const u64)len * 10 * CEC_TIM_DATA_BIT_TOTAL));
>
> This makes no sense. Certainly the const part is pointless. And given that
> len is always <= 16 there definitely is no overflow.
>

Yeah, I understand your point and I know there is no chance of an  
overflow in this particular case.

> I don't really want this cast in the code.
>
> Sorry,
>

I'm working through all the Linux kernel Coverity reports, and I  
thought of sending a patch for this because IMHO it doesn't hurt to  
give the compiler complete information about the arithmetic in which  
an expression is intended to be evaluated.

I agree that the _const_ part is a bit odd. What do you think about  
the cast to u64 alone?

I appreciate your feedback.

Thanks
--
Gustavo
