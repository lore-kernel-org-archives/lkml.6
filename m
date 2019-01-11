Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C58DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB420878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbfAKSpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:45:07 -0500
Received: from relay.sw.ru ([185.231.240.75]:41722 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbfAKSpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:45:05 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gi1ni-0006ek-Ka; Fri, 11 Jan 2019 21:45:02 +0300
Subject: Re: [PATCH] page_poison: plays nicely with KASAN
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190107223636.80593-1-cai@lca.pw>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <2e46c139-70d3-dc86-28c9-a9f263651b57@virtuozzo.com>
Date:   Fri, 11 Jan 2019 21:45:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107223636.80593-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/19 1:36 AM, Qian Cai wrote:

>  
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index f0c15e9017c0..e546b70e592a 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -6,6 +6,7 @@
>  #include <linux/page_ext.h>
>  #include <linux/poison.h>
>  #include <linux/ratelimit.h>
> +#include <linux/kasan.h>
>  
>  static bool want_page_poisoning __read_mostly;
>  
> @@ -40,6 +41,7 @@ static void poison_page(struct page *page)
>  {
>  	void *addr = kmap_atomic(page);
>  
> +	kasan_unpoison_shadow(addr, PAGE_SIZE);
>  	memset(addr, PAGE_POISON, PAGE_SIZE);

kasan_disable/enable_current() should be slightly more efficient for this case.

>  	kunmap_atomic(addr);
>  }
> 
