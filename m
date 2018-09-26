Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE87DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A20B2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A20B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeIZUTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:19:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbeIZUTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:19:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 24CCDF61F32AA;
        Wed, 26 Sep 2018 22:06:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 22:06:22 +0800
Message-ID: <5BAB925D.1030803@huawei.com>
Date:   Wed, 26 Sep 2018 22:06:21 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Christophe LEROY <christophe.leroy@c-s.fr>
CC:     <paulus@samba.org>, <benh@kernel.crashing.org>,
        <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com> <fb8bc993-2adc-6a70-2643-6195ba5f020f@c-s.fr>
In-Reply-To: <fb8bc993-2adc-6a70-2643-6195ba5f020f@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/26 21:58, Christophe LEROY wrote:
>
>
> Le 26/09/2018 à 13:46, zhong jiang a écrit :
>> It is safe to move dereference below a NULL test.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>   arch/powerpc/kernel/cacheinfo.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
>> index a8f20e5..7f19714 100644
>> --- a/arch/powerpc/kernel/cacheinfo.c
>> +++ b/arch/powerpc/kernel/cacheinfo.c
>> @@ -401,14 +401,13 @@ static struct cache *cache_lookup_or_instantiate(struct device_node *node,
>>       struct cache *cache;
>>         cache = cache_lookup_by_node(node);
>> +    if (!cache)
>> +        cache = cache_do_one_devnode(node, level);
>
> But by doing this, you change the meaning of the following warning. Is that what you want ? In that case the text of the WARN_ONCE() should be changed, because the mismatch is not only on lookup now.
>
Yep, I forget the WARN_ONCE. I think we should just remove it. Thought?

Thanks,
zhong jiang
> Christophe
>
>>         WARN_ONCE(cache && cache->level != level,
>>             "cache level mismatch on lookup (got %d, expected %d)\n",
>>             cache->level, level);
>>   -    if (!cache)
>> -        cache = cache_do_one_devnode(node, level);
>> -
>>       return cache;
>>   }
>>  
>
> .
>


