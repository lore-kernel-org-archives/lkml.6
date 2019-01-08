Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B569820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="hcb4wgrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfAHM41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:56:27 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:57450 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727473AbfAHM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:56:27 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 7F11B2105A;
        Tue,  8 Jan 2019 15:56:22 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id R7pwechRPO-uMbWlGsB;
        Tue, 08 Jan 2019 15:56:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1546952182; bh=TSLB06xsdrfXfY4i9m3b0UnjQObVvBo80ghKY2GKvZU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=hcb4wgrkG+k1WV3WhVDjvcCAyG8O6/KLfZn2bktShlx0HokCLO6D/pwut0je9nxrU
         Th4izi48lXmw4nIIWLzId1v8HZHDzI3n5CX/eusxfp5wltKuq1gkGj5mvYexSGQVdh
         9EojxCHoKIncVg2FHkOt5my7ip3FWQB8UKiJbiBo=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3712::1:4b])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id GJ9eC1H9w1-uMkiF0PB;
        Tue, 08 Jan 2019 15:56:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] net/core/neighbour: tell kmemleak about hash tables
To:     Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <154693980088.104235.16222977463502002037.stgit@buzz>
 <1e75f0ad-11f1-7325-b7a5-a7e21e8ee704@gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <024789b1-17c6-c606-8ec8-81447201ced2@yandex-team.ru>
Date:   Tue, 8 Jan 2019 15:56:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1e75f0ad-11f1-7325-b7a5-a7e21e8ee704@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.01.2019 14:59, Eric Dumazet wrote:
> 
> 
> On 01/08/2019 01:30 AM, Konstantin Khlebnikov wrote:
>> This fixes false-positive kmemleak reports about leaked neighbour entries:
>>
>> unreferenced object 0xffff8885c6e4d0a8 (size 1024):
> 
> 
> size 1024 object : should have been allocated by kzalloc(), right ?

Yep, neigh_alloc calls kzalloc.

Size might be bloated by lockdep.

> 
>>    comm "softirq", pid 0, jiffies 4294922664 (age 167640.804s)
>>    hex dump (first 32 bytes):
>>      00 00 00 00 00 00 00 00 20 2c f3 83 ff ff ff ff  ........ ,......
>>      08 c0 ef 5f 84 88 ff ff 01 8c 7d 02 01 00 00 00  ..._......}.....
>>    backtrace:
>>      [<00000000748509fe>] ip6_finish_output2+0x887/0x1e40
>>      [<0000000036d7a0d8>] ip6_output+0x1ba/0x600
>>      [<0000000027ea7dba>] ip6_send_skb+0x92/0x2f0
>>      [<00000000d6e2111d>] udp_v6_send_skb.isra.24+0x680/0x15e0
>>      [<000000000668a8be>] udpv6_sendmsg+0x18c9/0x27a0
>>      [<000000004bd5fa90>] sock_sendmsg+0xb3/0xf0
>>      [<000000008227b29f>] ___sys_sendmsg+0x745/0x8f0
>>      [<000000008698009d>] __sys_sendmsg+0xde/0x170
>>      [<00000000889dacf1>] do_syscall_64+0x9b/0x400
>>      [<0000000081cdb353>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>      [<000000005767ed39>] 0xffffffffffffffff
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   net/core/neighbour.c |   13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>> index 763a7b08df67..3e27a779f288 100644
>> --- a/net/core/neighbour.c
>> +++ b/net/core/neighbour.c
>> @@ -18,6 +18,7 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>>   #include <linux/slab.h>
>> +#include <linux/kmemleak.h>
>>   #include <linux/types.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> @@ -443,12 +444,14 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>>   	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
>>   	if (!ret)
>>   		return NULL;
>> -	if (size <= PAGE_SIZE)
>> +	if (size <= PAGE_SIZE) {
>>   		buckets = kzalloc(size, GFP_ATOMIC);
>> -	else
>> +	} else {
>>   		buckets = (struct neighbour __rcu **)
>>   			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
>>   					   get_order(size));
>> +		kmemleak_alloc(buckets, size, 0, GFP_ATOMIC);
>> +	}
>>   	if (!buckets) {
>>   		kfree(ret);
>>   		return NULL;
>> @@ -468,10 +471,12 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
>>   	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
>>   	struct neighbour __rcu **buckets = nht->hash_buckets;
>>   
>> -	if (size <= PAGE_SIZE)
>> +	if (size <= PAGE_SIZE) {
>>   		kfree(buckets);
>> -	else
>> +	} else {
>> +		kmemleak_free(buckets);
>>   		free_pages((unsigned long)buckets, get_order(size));
>> +	}
>>   	kfree(nht);
>>   }
>>   
>>
