Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeCJDzY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:55:24 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.130]:31677 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932299AbeCJDzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 22:55:23 -0500
Subject: Re: [PATCH] Input: stmpe-keypad - remove VLA usage
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180309224208.GA7080@embeddedor.com>
 <20180309233235.GC60941@dtor-ws>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <849affd1-712c-bdf7-625c-facd4b573bca@embeddedor.com>
Date: Fri, 9 Mar 2018 21:32:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309233235.GC60941@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euVF7-003J0Y-Go
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:34086
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 03/09/2018 05:32 PM, Dmitry Torokhov wrote:
> On Fri, Mar 09, 2018 at 04:42:08PM -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with a fixed-length array instead.
>>
>> Fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>   drivers/input/keyboard/stmpe-keypad.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
>> index 8c6c0b9..cfa1dbe 100644
>> --- a/drivers/input/keyboard/stmpe-keypad.c
>> +++ b/drivers/input/keyboard/stmpe-keypad.c
>> @@ -48,6 +48,8 @@
>>   #define STMPE_KEYPAD_KEYMAP_MAX_SIZE \
>>   	(STMPE_KEYPAD_MAX_ROWS * STMPE_KEYPAD_MAX_COLS)
>>   
>> +#define MAX_NUM_DATA			5
>> +
>>   /**
>>    * struct stmpe_keypad_variant - model-specific attributes
>>    * @auto_increment: whether the KPC_DATA_BYTE register address
>> @@ -74,7 +76,7 @@ struct stmpe_keypad_variant {
>>   static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>>   	[STMPE1601] = {
>>   		.auto_increment		= true,
>> -		.num_data		= 5,
>> +		.num_data		= MAX_NUM_DATA,
>>   		.num_normal_data	= 3,
>>   		.max_cols		= 8,
>>   		.max_rows		= 8,
>> @@ -84,7 +86,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>>   	[STMPE2401] = {
>>   		.auto_increment		= false,
>>   		.set_pullup		= true,
>> -		.num_data		= 3,
>> +		.num_data		= MAX_NUM_DATA - 2,
> 
> Logically MAX_NUM_DATA - 2 does not mean anything, it is simply a way
> for you to get to 3, so I'd rather we did not do that.
> 

Yeah. I agree.

> Can we do
> 
> #define STMPE1601_NUM_DATA	5
> #define STMPE2401_NUM_DATA	3
> #define STMPE2403_NUM_DATA	5
> #define MAX_NUM_DATA		max3(STMPE1601_NUM_DATA, \
> 				     STMPE2401_NUM_DATA, \
> 				     STMPE2403_NUM_DATA)
> 
> 
> or simply
> 
> /* Make sure it covers all cases above */
> #define MAX_NUM_DATA		5

This one works just fine.

I'll send v2 of this patch shortly.

Thanks for the feedback.
I appreciate it.
--
Gustavo

> 
>>   		.num_normal_data	= 2,
>>   		.max_cols		= 8,
>>   		.max_rows		= 12,
>> @@ -94,7 +96,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>>   	[STMPE2403] = {
>>   		.auto_increment		= true,
>>   		.set_pullup		= true,
>> -		.num_data		= 5,
>> +		.num_data		= MAX_NUM_DATA,
>>   		.num_normal_data	= 3,
>>   		.max_cols		= 8,
>>   		.max_rows		= 12,
>> @@ -156,7 +158,7 @@ static irqreturn_t stmpe_keypad_irq(int irq, void *dev)
>>   	struct stmpe_keypad *keypad = dev;
>>   	struct input_dev *input = keypad->input;
>>   	const struct stmpe_keypad_variant *variant = keypad->variant;
>> -	u8 fifo[variant->num_data];
>> +	u8 fifo[MAX_NUM_DATA];
>>   	int ret;
>>   	int i;
>>   
>> -- 
>> 2.7.4
>>
> 
> Thanks.
> 
