Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ACE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfAORY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:24:59 -0500
Received: from relay.sw.ru ([185.231.240.75]:54032 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfAORY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:24:59 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gjSSP-0004cU-Nd; Tue, 15 Jan 2019 20:24:57 +0300
Subject: Re: [PATCH v2] page_poison: play nicely with KASAN
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <2e46c139-70d3-dc86-28c9-a9f263651b57@virtuozzo.com>
 <20190114233405.67843-1-cai@lca.pw>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <3a2aefb4-f108-5354-ddb9-7a35d8e0b3f2@virtuozzo.com>
Date:   Tue, 15 Jan 2019 20:25:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114233405.67843-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 2:34 AM, Qian Cai wrote:
> KASAN does not play well with the page poisoning
> (CONFIG_PAGE_POISONING). It triggers false positives in the allocation
> path,
> 
> BUG: KASAN: use-after-free in memchr_inv+0x2ea/0x330
> Read of size 8 at addr ffff88881f800000 by task swapper/0
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1+ #54
> Call Trace:
>  dump_stack+0xe0/0x19a
>  print_address_description.cold.2+0x9/0x28b
>  kasan_report.cold.3+0x7a/0xb5
>  __asan_report_load8_noabort+0x19/0x20
>  memchr_inv+0x2ea/0x330
>  kernel_poison_pages+0x103/0x3d5
>  get_page_from_freelist+0x15e7/0x4d90
> 
> because KASAN has not yet unpoisoned the shadow page for allocation
> before it checks memchr_inv() but only found a stale poison pattern.
> 
> Also, false positives in free path,
> 
> BUG: KASAN: slab-out-of-bounds in kernel_poison_pages+0x29e/0x3d5
> Write of size 4096 at addr ffff8888112cc000 by task swapper/0/1
> CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1+ #55
> Call Trace:
>  dump_stack+0xe0/0x19a
>  print_address_description.cold.2+0x9/0x28b
>  kasan_report.cold.3+0x7a/0xb5
>  check_memory_region+0x22d/0x250
>  memset+0x28/0x40
>  kernel_poison_pages+0x29e/0x3d5
>  __free_pages_ok+0x75f/0x13e0
> 
> due to KASAN adds poisoned redzones around slab objects, but the page
> poisoning needs to poison the whole page.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
