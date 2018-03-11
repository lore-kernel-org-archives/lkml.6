Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeCKWMO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:12:14 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.95]:37405 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932337AbeCKWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:12:13 -0400
Subject: Re: [RFC] netfilter: cttimeout: remove VLA in
 ctnl_timeout_parse_policy
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180306184755.GA7628@embeddedgus>
 <20180311220414.feda33aw72zw2rko@salvia>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <20df6b07-b3e7-7733-ee05-b12589bd287f@embeddedor.com>
Date: Sun, 11 Mar 2018 17:12:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180311220414.feda33aw72zw2rko@salvia>
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
X-Exim-ID: 1ev9CN-003eme-2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:53220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pablo,

On 03/11/2018 05:04 PM, Pablo Neira Ayuso wrote:
> On Tue, Mar 06, 2018 at 12:47:55PM -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with dynamic memory allocation.
> 
> Looks good but...
> 
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   net/netfilter/nfnetlink_cttimeout.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
>> index 95b0470..a2f7d92 100644
>> --- a/net/netfilter/nfnetlink_cttimeout.c
>> +++ b/net/netfilter/nfnetlink_cttimeout.c
>> @@ -52,18 +52,26 @@ ctnl_timeout_parse_policy(void *timeouts,
>>   			  struct net *net, const struct nlattr *attr)
>>   {
>>   	int ret = 0;
>> +	struct nlattr **tb = NULL;
> 
> I think we don't need to initialize this, right?
> 

We actually do have to initialized it because in the unlikely case that 
the code block inside the 'if' below is not executed, then we will end 
up freeing an uninitialized pointer.

Thanks
--
Gustavo

>>   
>>   	if (likely(l4proto->ctnl_timeout.nlattr_to_obj)) {
>> -		struct nlattr *tb[l4proto->ctnl_timeout.nlattr_max+1];
>> +		tb = kcalloc(l4proto->ctnl_timeout.nlattr_max + 1, sizeof(*tb),
>> +			     GFP_KERNEL);
>> +
>> +		if (!tb)
>> +			return -ENOMEM;
>>   
>>   		ret = nla_parse_nested(tb, l4proto->ctnl_timeout.nlattr_max,
>>   				       attr, l4proto->ctnl_timeout.nla_policy,
>>   				       NULL);
>>   		if (ret < 0)
>> -			return ret;
>> +			goto err;
>>   
>>   		ret = l4proto->ctnl_timeout.nlattr_to_obj(tb, net, timeouts);
>>   	}
>> +
>> +err:
>> +	kfree(tb);
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.7.4
>>
