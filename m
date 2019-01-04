Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B7220645
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfADImN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:42:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34673 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725958AbfADImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:42:12 -0500
X-IronPort-AV: E=Sophos;i="5.56,437,1539619200"; 
   d="scan'208";a="51272739"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jan 2019 16:42:10 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 49D944B7D57E;
        Fri,  4 Jan 2019 16:42:08 +0800 (CST)
Received: from [10.167.225.53] (10.167.225.53) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 4 Jan 2019 16:42:05 +0800
Subject: Re: [PATCH] vti4: Fix a ipip packet processing bug in 'IPCOMP'
 virtual tunnel
To:     Steffen Klassert <steffen.klassert@secunet.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyanjun218@gmail.com>
References: <1546519721-30837-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190104074333.GE3581@gauss3.secunet.de>
From:   "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
Message-ID: <a289564b-c33a-d2fb-dab2-31e15695844f@cn.fujitsu.com>
Date:   Fri, 4 Jan 2019 16:42:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190104074333.GE3581@gauss3.secunet.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.225.53]
X-yoursite-MailScanner-ID: 49D944B7D57E.ACD90
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/2019 3:43 PM, Steffen Klassert wrote:

> On Thu, Jan 03, 2019 at 07:48:41AM -0500, Su Yanjun wrote:
>> Recently we run a network test over ipcomp virtual tunnel.We find that
>> if a ipv4 packet needs fragment, then the peer can't receive
>> it.
>>
>> We deep into the code and find that when packet need fragment the smaller
>> fragment will be encapsulated by ipip not ipcomp. So when the ipip packet
>> goes into xfrm, it's skb->dev is not properly set. The ipv4 reassembly code
>> always set skb'dev to the last fragment's dev. After ipv4 defrag processing,
>> when the kernel rp_filter parameter is set, the skb will be drop by -EXDEV
>> error.
> Why not just leaving rp_filter disabled or in 'loose mode' if you use ipcomp?
In my option rp_filter should not affect the ip_vti functionality.
The root cause is the origin tunnel code doesn't update skb->dev.
vti only cares about ipcomp, esp, ah packets.
>> This patch adds compatible support for the ipip process in ipcomp virtual tunnel.
>>
>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
>> ---
>>   net/ipv4/ip_vti.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
>> index de31b30..63de2f6 100644
>> --- a/net/ipv4/ip_vti.c
>> +++ b/net/ipv4/ip_vti.c
>> @@ -65,6 +65,9 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
>>   
>>   		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
>>   
>> +		if (iph->protocol == IPPROTO_IPIP)
>> +			skb->dev = tunnel->dev;
>> +
>>   		return xfrm_input(skb, nexthdr, spi, encap_type);
>>   	}
>>   
>> @@ -76,10 +79,15 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
>>   
>>   static int vti_rcv(struct sk_buff *skb)
>>   {
>> +	__be32 spi = 0;
>> +	
>>   	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
>>   	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
>> +	
>> +	if (ip_hdr(skb)->protocol == IPPROTO_IPIP)
>> +		spi = ip_hdr(skb)->saddr;
>>   
>> -	return vti_input(skb, ip_hdr(skb)->protocol, 0, 0);
>> +	return vti_input(skb, ip_hdr(skb)->protocol, spi, 0);
> You use the src address as spi, how is this supposed to work?
>
This code derives from xfrm4_tunnel and i just want the vti can handle 
ipip packet as xfrm4 tunnel does.


Thanks,
Su


