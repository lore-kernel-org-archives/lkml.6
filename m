Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D25ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA9D214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA9D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeIZUL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:11:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40472 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeIZUL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:11:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42L00S6PV6z9ttfr;
        Wed, 26 Sep 2018 15:58:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XzXnEebpN7Lz; Wed, 26 Sep 2018 15:58:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42L00S5kY8z9ttfn;
        Wed, 26 Sep 2018 15:58:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 525B78B817;
        Wed, 26 Sep 2018 15:58:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uIZE3cJYrG0Z; Wed, 26 Sep 2018 15:58:49 +0200 (CEST)
Received: from PO15451 (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C3E98B803;
        Wed, 26 Sep 2018 15:58:49 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
To:     zhong jiang <zhongjiang@huawei.com>, paulus@samba.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fb8bc993-2adc-6a70-2643-6195ba5f020f@c-s.fr>
Date:   Wed, 26 Sep 2018 15:58:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/09/2018 à 13:46, zhong jiang a écrit :
> It is safe to move dereference below a NULL test.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>   arch/powerpc/kernel/cacheinfo.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
> index a8f20e5..7f19714 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -401,14 +401,13 @@ static struct cache *cache_lookup_or_instantiate(struct device_node *node,
>   	struct cache *cache;
>   
>   	cache = cache_lookup_by_node(node);
> +	if (!cache)
> +		cache = cache_do_one_devnode(node, level);

But by doing this, you change the meaning of the following warning. Is 
that what you want ? In that case the text of the WARN_ONCE() should be 
changed, because the mismatch is not only on lookup now.

Christophe

>   
>   	WARN_ONCE(cache && cache->level != level,
>   		  "cache level mismatch on lookup (got %d, expected %d)\n",
>   		  cache->level, level);
>   
> -	if (!cache)
> -		cache = cache_do_one_devnode(node, level);
> -
>   	return cache;
>   }
>   
> 
