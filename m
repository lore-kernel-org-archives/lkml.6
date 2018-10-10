Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E0DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11936214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11936214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJJT0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:26:16 -0400
Received: from ozlabs.org ([203.11.71.1]:36195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbeJJT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:26:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42VXnp63kdz9s7W;
        Wed, 10 Oct 2018 23:04:13 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-um@lists.infradead.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] memblock: stop using implicit alignement to SMP_CACHE_BYTES
In-Reply-To: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
Date:   Wed, 10 Oct 2018 23:04:12 +1100
Message-ID: <87o9c22ekj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@linux.vnet.ibm.com> writes:

> When a memblock allocation APIs are called with align = 0, the alignment is
> implicitly set to SMP_CACHE_BYTES.
>
> Replace all such uses of memblock APIs with the 'align' parameter explicitly
> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> memblock internal allocation functions.
>
> For the case when memblock APIs are used via helper functions, e.g. like
> iommu_arena_new_node() in Alpha, the helper functions were detected with
> Coccinelle's help and then manually examined and updated where appropriate.
>
> The direct memblock APIs users were updated using the semantic patch below:
>
> @@
> expression size, min_addr, max_addr, nid;
> @@
> (
> |
> - memblock_alloc_try_nid_raw(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid_raw(size, SMP_CACHE_BYTES, min_addr, max_addr,
> nid)
> |
> - memblock_alloc_try_nid_nopanic(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid_nopanic(size, SMP_CACHE_BYTES, min_addr, max_addr,
> nid)
> |
> - memblock_alloc_try_nid(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid(size, SMP_CACHE_BYTES, min_addr, max_addr, nid)
> |
> - memblock_alloc(size, 0)
> + memblock_alloc(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_raw(size, 0)
> + memblock_alloc_raw(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_from(size, 0, min_addr)
> + memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr)
> |
> - memblock_alloc_nopanic(size, 0)
> + memblock_alloc_nopanic(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_low(size, 0)
> + memblock_alloc_low(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_low_nopanic(size, 0)
> + memblock_alloc_low_nopanic(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_from_nopanic(size, 0, min_addr)
> + memblock_alloc_from_nopanic(size, SMP_CACHE_BYTES, min_addr)
> |
> - memblock_alloc_node(size, 0, nid)
> + memblock_alloc_node(size, SMP_CACHE_BYTES, nid)
> )
>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
...
>  arch/powerpc/kernel/pci_32.c              |  3 ++-
>  arch/powerpc/lib/alloc.c                  |  2 +-
>  arch/powerpc/mm/mmu_context_nohash.c      |  7 +++---
>  arch/powerpc/platforms/powermac/nvram.c   |  2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c |  6 ++---
>  arch/powerpc/sysdev/msi_bitmap.c          |  2 +-

The powerpc changes all look fine.

I'm not quite clear on how SMP_CACHE_BYTES is getting included.

I think it's: memblock.h -> mm.h -> mmzone.h -> cache.h

So that's probably fine.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers
