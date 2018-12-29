Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F0A21908
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeL2GrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 01:47:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbeL2GrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 01:47:14 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6FEC44106F70F;
        Sat, 29 Dec 2018 14:47:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Sat, 29 Dec 2018
 14:47:06 +0800
Subject: Re: [PATCH] ipv4: fib_rules: Fix possible infinite loop in
 fib_empty_table
To:     David Miller <davem@davemloft.net>
References: <20181226083420.20436-1-yuehaibing@huawei.com>
 <20181228.211503.1983080144355610600.davem@davemloft.net>
CC:     <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3cb9f28c-534f-701a-19bf-63ebadac303f@huawei.com>
Date:   Sat, 29 Dec 2018 14:46:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181228.211503.1983080144355610600.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/29 13:15, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Wed, 26 Dec 2018 16:34:20 +0800
> 
>> diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
>> index f8eb78d..1567e12 100644
>> --- a/net/ipv4/fib_rules.c
>> +++ b/net/ipv4/fib_rules.c
>> @@ -200,9 +200,13 @@ static struct fib_table *fib_empty_table(struct net *net)
>>  {
>>  	u32 id;
>>  
>> -	for (id = 1; id <= RT_TABLE_MAX; id++)
>> +	for (id = 1; id <= RT_TABLE_MAX; id++) {
>>  		if (!fib_get_table(net, id))
>>  			return fib_new_table(net, id);
>> +
>> +		if (id == RT_TABLE_MAX)
>> +			break;
>> +	}
>>  	return NULL;
>>  }
> 
> The loop now has two exit conditions, one of which (by your analysis
> is completely impossible).
> 

Thanks, will do it in v2.

> Please clean this up into a loop with better structure and no
> impossible tests.  One approach could be simply:
> 
> 	id = 1;
> 	while (1) {
> 	...
> 		if (id++ == RT_TABLE_MAX)
> 			break;
> 	}
> 
> Or even:
> 
> 	id = 0;
> 	while (++id) {
> 	...
> 	}
> 
> .
> 

