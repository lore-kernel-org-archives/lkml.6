Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84989C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174712086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174712086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeIKN5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:57:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40923 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbeIKN5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:57:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 896C75D99C99E;
        Tue, 11 Sep 2018 16:59:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Tue, 11 Sep 2018
 16:59:26 +0800
Message-ID: <5B9783ED.4080908@huawei.com>
Date:   Tue, 11 Sep 2018 16:59:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
References: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com> <a000b5a4-2907-70f9-70ed-7e1c6a797876@cogentembedded.com>
In-Reply-To: <a000b5a4-2907-70f9-70ed-7e1c6a797876@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/11 16:51, Sergei Shtylyov wrote:
> On 9/10/2018 5:38 PM, zhong jiang wrote:
>
>> The if condition can be removed if we use BUG_ON directly.
>> The issule is detected with the help of Coccinelle.
>
>   Issue?
>
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>   net/ipv4/tcp_input.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 62508a2..893bde3 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4934,8 +4934,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>>               BUG_ON(offset < 0);
>>               if (size > 0) {
>>                   size = min(copy, size);
>> -                if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
>> -                    BUG();
>> +                BUG(skb_copy_bits(skb, offset,
>
>    You said BUG_ON()?
 Yep. Do you think that it is worthing to do

 Thanks,
zhong jiang
>
>> +                          skb_put(nskb, size), size));
>>                   TCP_SKB_CB(nskb)->end_seq += size;
>>                   copy -= size;
>>                   start += size;
>> @@ -5327,8 +5327,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
>>           /* Is the urgent pointer pointing into this packet? */
>>           if (ptr < skb->len) {
>>               u8 tmp;
>> -            if (skb_copy_bits(skb, ptr, &tmp, 1))
>> -                BUG();
>> +
>> +            BUG(skb_copy_bits(skb, ptr, &tmp, 1));
>
>    Likewise.
>
> [...]
>
> MBR, Sergei
>
> .
>


