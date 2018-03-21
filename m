Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeCUN5X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:57:23 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.102]:34815 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751923AbeCUN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:57:20 -0400
Subject: Re: [PATCH] mac80211: aes-cmac: remove VLA usage
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180321134247.GA1275@embeddedgus>
 <1521640094.2645.29.camel@sipsolutions.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b367cf76-e6c5-3d6d-5d81-a68ae245e6b9@embeddedor.com>
Date: Wed, 21 Mar 2018 08:57:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521640094.2645.29.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1eyeEx-000WlG-1c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:45358
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 26
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2018 08:48 AM, Johannes Berg wrote:
> On Wed, 2018-03-21 at 08:42 -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLAs and replace them
>> with dynamic memory allocation instead.
>>
>> The use of stack Variable Length Arrays needs to be avoided, as they
>> can be a vector for stack exhaustion, which can be both a runtime bug
>> or a security flaw. Also, in general, as code evolves it is easy to
>> lose track of how big a VLA can get. Thus, we can end up having runtime
>> failures that are hard to debug.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   net/mac80211/aes_cmac.c | 36 ++++++++++++++++++++++++------------
>>   1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
>> index 2fb6558..c9444bf 100644
>> --- a/net/mac80211/aes_cmac.c
>> +++ b/net/mac80211/aes_cmac.c
>> @@ -27,30 +27,42 @@ static const u8 zero[CMAC_TLEN_256];
>>   void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
>>   			const u8 *data, size_t data_len, u8 *mic)
>>   {
>> -	SHASH_DESC_ON_STACK(desc, tfm);
>> +	struct shash_desc *shash;
>>   	u8 out[AES_BLOCK_SIZE];
>>   
>> -	desc->tfm = tfm;
>> +	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
>> +			GFP_KERNEL);
>> +	if (!shash)
>> +		return;
> 
> Honestly, this seems like a really bad idea - you're now hitting
> kmalloc for every TX/RX frame here.
> 
> SHA_DESC_ON_STACK() should just be fixed to not need a VLA, but take
> some sort of maximum, I guess?
> 

SHA_DESC_ON_STACK is currently being used in multiple places. But, yeah, 
I think we can define multiple macros of the same kind and adjust to the 
characteristics of each the component.

How big do you think tfm can get?

Thanks
--
Gustavo
