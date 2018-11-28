Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37643C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C49D206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C49D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeK2FUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:20:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48134 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeK2FUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:20:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC5A80D;
        Wed, 28 Nov 2018 10:18:20 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FE7F3F59C;
        Wed, 28 Nov 2018 10:18:18 -0800 (PST)
Date:   Wed, 28 Nov 2018 18:18:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: skip kmemleak for kasan_init()
Message-ID: <20181128181815.GN3563@arrakis.emea.arm.com>
References: <1543426833-24378-1-git-send-email-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543426833-24378-1-git-send-email-cai@gmx.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:40:33PM -0500, Qian Cai wrote:
> Kmemleak does not play well with KASAN (tested on both HPE Apollo 70 and
> Huawei TaiShan 2280 aarch64 servers).
> 
> After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early
> log buffer went from something like 280 to 260000 which caused kmemleak
> disabled and crash dump memory reservation failed. The multitude of
> kmemleak_alloc() calls is from,
> 
> for_each_memblock(memory, reg) x \
> while (pgdp++, addr = next, addr != end) x \
> while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp))) \
> while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp))) \
> while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)))
> 
> Signed-off-by: Qian Cai <cai@gmx.us>

Sorry, I didn't get the chance to investigate this further. Hopefully
early next week.

> diff --git a/mm/memblock.c b/mm/memblock.c
> index 9a2d5ae..fd78e39 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1412,6 +1412,8 @@ static void * __init memblock_alloc_internal(
>  done:
>  	ptr = phys_to_virt(alloc);
>  
> +/* Skip kmemleak for kasan_init() due to high volume. */
> +#ifndef CONFIG_KASAN
>  	/*
>  	 * The min_count is set to 0 so that bootmem allocated blocks
>  	 * are never reported as leaks. This is because many of these blocks
> @@ -1419,6 +1421,7 @@ static void * __init memblock_alloc_internal(
>  	 * looked up by kmemleak.
>  	 */
>  	kmemleak_alloc(ptr, size, 0, 0);
> +#endif

This may render kmemleak unusable since it is not aware of the memblock
allocations and it would trigger lots of false positives.

-- 
Catalin
