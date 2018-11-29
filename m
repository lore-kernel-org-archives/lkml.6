Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F034C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A662146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A662146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeK3EGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:06:23 -0500
Received: from foss.arm.com ([217.140.101.70]:39488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeK3EGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:06:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3321BA78;
        Thu, 29 Nov 2018 09:00:21 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 661513F59C;
        Thu, 29 Nov 2018 09:00:19 -0800 (PST)
Date:   Thu, 29 Nov 2018 17:00:16 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memblock: skip kmemleak for kasan_init()
Message-ID: <20181129170016.GD22027@arrakis.emea.arm.com>
References: <1543442925-17794-1-git-send-email-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543442925-17794-1-git-send-email-cai@gmx.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 05:08:45PM -0500, Qian Cai wrote:
> Kmemleak does not play well with KASAN (tested on both HPE Apollo 70 and
> Huawei TaiShan 2280 aarch64 servers).
> 
> After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early
> log buffer went from something like 280 to 260000 which caused kmemleak
> disabled and crash dump memory reservation failed. The multitude of
> kmemleak_alloc() calls is from nested loops while KASAN is setting up
> full memory mappings, so let early kmemleak allocations skip those
> memblock_alloc_internal() calls came from kasan_init() given that those
> early KASAN memory mappings should not reference to other memory.
> Hence, no kmemleak false positives.
> 
> kasan_init
>   kasan_map_populate [1]
>     kasan_pgd_populate [2]
>       kasan_pud_populate [3]
>         kasan_pmd_populate [4]
>           kasan_pte_populate [5]
>             kasan_alloc_zeroed_page
>               memblock_alloc_try_nid
>                 memblock_alloc_internal
>                   kmemleak_alloc
> 
> [1] for_each_memblock(memory, reg)
> [2] while (pgdp++, addr = next, addr != end)
> [3] while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp)))
> [4] while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp)))
> [5] while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)))
> 
> Signed-off-by: Qian Cai <cai@gmx.us>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(for both the kmemleak and arm64 changes)
