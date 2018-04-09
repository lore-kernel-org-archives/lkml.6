Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDIOtA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:49:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40893 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeDIOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:48:56 -0400
X-Google-Smtp-Source: AIpwx48o9L57Gv1N7gH5Rasoi4XtbCDBbDCZOJWVCfr7uXKNYt6rR780AvmButrZeKtB8d63clWsJA==
Subject: Re: [PATCH] net: decnet: Replace GFP_ATOMIC with GFP_KERNEL in
 dn_route_init
To: Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        kafai@fb.com, weiwan@google.com, dsa@cumulusnetworks.com,
        johannes.berg@intel.com, fw@strlen.de
Cc: linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523283035-25639-1-git-send-email-baijiaju1990@gmail.com>
 <945ed4f2-e1e2-a038-2808-f18a79a35732@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <92500938-e1c1-906c-58a7-404645df5b81@gmail.com>
Date: Mon, 9 Apr 2018 22:48:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <945ed4f2-e1e2-a038-2808-f18a79a35732@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/9 22:44, Eric Dumazet wrote:
>
> On 04/09/2018 07:10 AM, Jia-Ju Bai wrote:
>> dn_route_init() is never called in atomic context.
>>
>> The call chain ending up at dn_route_init() is:
>> [1] dn_route_init() <- decnet_init()
>> decnet_init() is only set as a parameter of module_init().
>>
>> Despite never getting called from atomic context,
>> dn_route_init() calls __get_free_pages() with GFP_ATOMIC,
>> which waits busily for allocation.
>> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
>> to avoid busy waiting and improve the possibility of sucessful allocation.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   net/decnet/dn_route.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
>> index 0bd3afd..59ed12a 100644
>> --- a/net/decnet/dn_route.c
>> +++ b/net/decnet/dn_route.c
>> @@ -1898,7 +1898,7 @@ void __init dn_route_init(void)
>>   		while(dn_rt_hash_mask & (dn_rt_hash_mask - 1))
>>   			dn_rt_hash_mask--;
>>   		dn_rt_hash_table = (struct dn_rt_hash_bucket *)
>> -			__get_free_pages(GFP_ATOMIC, order);
>> +			__get_free_pages(GFP_KERNEL, order);
>>   	} while (dn_rt_hash_table == NULL && --order > 0);
>>   
>>   	if (!dn_rt_hash_table)
>>
> This might OOM under pressure.

Sorry, I do not understand this.
Could you please explain the reason?

> This would need __GFP_NOWARN | __GFP_NORETRY  I guess, and would target net-next
>

Do you mean
__get_free_pages(__GFP_NOWARN | __GFP_NORETRY) or
__get_free_pages(__GFP_NOWARN | __GFP_NORETRY | GFP_KERNEL)?


Best wishes,
Jia-Ju Bai
