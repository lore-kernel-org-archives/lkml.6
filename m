Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBEVy2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:54:28 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.105]:41184 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751960AbeBEVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:54:21 -0500
Date: Mon, 05 Feb 2018 15:54:19 -0600
Message-ID: <20180205155419.Horde.WgpJoLkqF8wsBtPMp9n7V8U@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] platform: vivid-cec: use 64-bit arithmetic
 instead of 32-bit
References: <cover.1517856716.git.gustavo@embeddedor.com>
 <cca3c728f123d714dc8e4ed87510aeb2e2d63db6.1517856716.git.gustavo@embeddedor.com>
 <dc931d9d-8cbd-bbd2-0199-b1846e41f274@xs4all.nl>
In-Reply-To: <dc931d9d-8cbd-bbd2-0199-b1846e41f274@xs4all.nl>
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
X-Exim-ID: 1eioiS-000RVZ-6v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:46053
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Quoting Hans Verkuil <hverkuil@xs4all.nl>:

> On 02/05/2018 09:36 PM, Gustavo A. R. Silva wrote:
>> Add suffix ULL to constant 10 in order to give the compiler complete
>> information about the proper arithmetic to use. Notice that this
>> constant is used in a context that expects an expression of type
>> u64 (64 bits, unsigned).
>>
>> The expression len * 10 * CEC_TIM_DATA_BIT_TOTAL is currently being
>> evaluated using 32-bit arithmetic.
>>
>> Also, remove unnecessary parentheses and add a code comment to make it
>> clear what is the reason of the code change.
>>
>> Addresses-Coverity-ID: 1454996
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>  - Update subject and changelog to better reflect the proposed code changes.
>>  - Add suffix ULL to constant instead of casting a variable.
>>  - Remove unncessary parentheses.
>
> unncessary -> unnecessary
>

Thanks for this.

>>  - Add code comment.
>>
>>  drivers/media/platform/vivid/vivid-cec.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/vivid/vivid-cec.c  
>> b/drivers/media/platform/vivid/vivid-cec.c
>> index b55d278..614787b 100644
>> --- a/drivers/media/platform/vivid/vivid-cec.c
>> +++ b/drivers/media/platform/vivid/vivid-cec.c
>> @@ -82,8 +82,15 @@ static void vivid_cec_pin_adap_events(struct  
>> cec_adapter *adap, ktime_t ts,
>>
>>  	if (adap == NULL)
>>  		return;
>> -	ts = ktime_sub_us(ts, (CEC_TIM_START_BIT_TOTAL +
>> -			       len * 10 * CEC_TIM_DATA_BIT_TOTAL));
>> +
>> +	/*
>> +	 * Suffix ULL on constant 10 makes the expression
>> +	 * CEC_TIM_START_BIT_TOTAL + 10ULL * len * CEC_TIM_DATA_BIT_TOTAL
>> +	 * be evaluated using 64-bit unsigned arithmetic (u64), which
>> +	 * is what ktime_sub_us expects as second argument.
>> +	 */
>
> That's not really the comment that I was looking for. It still doesn't
> explain *why* this is needed at all. How about something like this:
>

In MHO the reason for the change is simply the discrepancy between the  
arithmetic expected by
the function ktime_sub_us and the arithmetic in which the expression  
is being evaluated. And this
has nothing to do with any particular tool.

> /*
>  * Add the ULL suffix to the constant 10 to work around a false Coverity
>  * "Unintentional integer overflow" warning. Coverity isn't smart enough
>  * to understand that len is always <= 16, so there is no chance of an
>  * integer overflow.
>  */
>

:P

In my opinion it is not a good idea to tie the code to a particular tool.
There are only three appearances of the word 'Coverity' in the whole  
code base, and, honestly I don't want to add more.

So I think I will document this issue as a FP in the Coverity platform.

Thanks!
--
Gustavo

> Regards,
>
> 	Hans
>
>> +	ts = ktime_sub_us(ts, CEC_TIM_START_BIT_TOTAL +
>> +			       10ULL * len * CEC_TIM_DATA_BIT_TOTAL);
>>  	cec_queue_pin_cec_event(adap, false, ts);
>>  	ts = ktime_add_us(ts, CEC_TIM_START_BIT_LOW);
>>  	cec_queue_pin_cec_event(adap, true, ts);
>>
