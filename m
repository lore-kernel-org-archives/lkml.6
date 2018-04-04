Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeDDGlk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:41:40 -0400
Received: from gateway32.websitewelcome.com ([192.185.144.98]:29387 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750812AbeDDGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:41:38 -0400
Subject: Re: [PATCH v2] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereferences
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Sunil Goutham <sgoutham@cavium.com>, Robert Richter <rric@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180403220423.GA718@embeddedor.com>
 <6aa876e8-c94c-1ab8-2a3a-02b2b77df65f@gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ddc66fb1-a04e-5c93-9521-2949f5112e44@embeddedor.com>
Date: Wed, 4 Apr 2018 01:41:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6aa876e8-c94c-1ab8-2a3a-02b2b77df65f@gmail.com>
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
X-Exim-ID: 1f3c6z-003Ry0-HY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:47908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2018 01:36 AM, Eric Dumazet wrote:
> 
> 
> On 04/03/2018 03:04 PM, Gustavo A. R. Silva wrote:
>> Add null check on kmalloc() return value in order to prevent
>> a null pointer dereference.
>>
>> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
>> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>   - Add a null check on a second kmalloc a few lines below. Thanks to
>>     Eric Dumazet for pointing this out.
>>
>>   drivers/net/ethernet/cavium/thunder/nicvf_main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> index 1e9a31f..f7b5ca5 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> @@ -1999,10 +1999,14 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>>   				struct xcast_addr *xaddr;
>>   
>>   				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
>> +				if (unlikely(!mc_list))
>> +					return;
>>   				INIT_LIST_HEAD(&mc_list->list);
>>   				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
>>   					xaddr = kmalloc(sizeof(*xaddr),
>>   							GFP_ATOMIC);
>> +					if (unlikely(!xaddr))
>> +						return;
> 
> So now you leak memory :/
> 

Oh god. I'm sorry.

I had problems with this file since the beginning.

I'll send v3 shortly.

Thanks
--
Gustavo
