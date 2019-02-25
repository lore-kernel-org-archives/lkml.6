Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8438B2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rScxGX1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfBYSY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:24:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10003 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfBYSY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:24:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 447VjF3pMxz9v6Yl;
        Mon, 25 Feb 2019 19:24:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rScxGX1a; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Jt7jjelN9kFt; Mon, 25 Feb 2019 19:24:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 447VjF1gh0z9v6Yj;
        Mon, 25 Feb 2019 19:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1551119089; bh=YCJ8My48sFZEbNzDotzQVsv46FDU3mcvMuGNaeQJIRA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=rScxGX1aQ84h7VcroAnW8nTXRn+hk3kUJZWk9bla4Iu5LTYQofDgGQhOO2Kn7wa3g
         oiEaI/DrnwQYOHwMSLPO+CNy1WGKoTX3p4JUjF9gnqVL0U+NhI5MbfwZX4iLsjQC6z
         WdronPul+CxuhFisXtNoLpSFYRVW8sThhsmhdyWo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95BD18B909;
        Mon, 25 Feb 2019 19:24:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id flvebKHcEPNU; Mon, 25 Feb 2019 19:24:54 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C25808B84C;
        Mon, 25 Feb 2019 19:24:53 +0100 (CET)
Subject: Re: [PATCH v7 00/11] KASAN for powerpc/32
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <cover.1551098214.git.christophe.leroy@c-s.fr>
Message-ID: <9134d1df-01d4-b498-a25c-3b29aa855c70@c-s.fr>
Date:   Mon, 25 Feb 2019 19:24:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1551098214.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/02/2019 à 14:48, Christophe Leroy a écrit :
> This series adds KASAN support to powerpc/32

Looks like only half of defconfigs build ok.

I hope I have now fixes everything. Will run on kisskb tonight and send 
out v8 tomorrow if everything is OK.

Christophe

> 
> Tested on nohash/32 (8xx) and book3s/32 (mpc832x ie 603).
> Boot tested on qemu mac99
> 
> Changes in v7:
> - split in several smaller patches
> - prom_init now has its own string functions
> - full deactivation of powerpc-optimised string functions when KASAN is active
> - shadow area now at a fixed place on very top of kernel virtual space.
> - Early static hash table for hash book3s/32.
> - Full support of both inline and outline instrumentation for both hash and nohash ppc32
> - Earlier full activation of kasan.
> 
> Changes in v6:
> - Fixed oops on module loading (due to access to RO shadow zero area).
> - Added support for hash book3s/32, thanks to Daniel's patch to differ KASAN activation.
> - Reworked handling of optimised string functions (dedicated patch for it)
> - Reordered some files to ease adding of book3e/64 support.
> 
> Changes in v5:
> - Added KASAN_SHADOW_OFFSET in Makefile, otherwise we fallback to KASAN_MINIMAL
> and some stuff like stack instrumentation is not performed
> - Moved calls to kasan_early_init() in head.S because stack instrumentation
> in machine_init was performed before the call to kasan_early_init()
> - Mapping kasan_early_shadow_page RW in kasan_early_init() and
> remaping RO later in kasan_init()
> - Allocating a big memblock() for shadow area, falling back to PAGE_SIZE blocks in case of failure.
> 
> Changes in v4:
> - Comments from Andrey (DISABLE_BRANCH_PROFILING, Activation of reports)
> - Proper initialisation of shadow area in kasan_init()
> - Panic in case Hash table is required.
> - Added comments in patch one to explain why *t = *s becomes memcpy(t, s, ...)
> - Call of kasan_init_tags()
> 
> Changes in v3:
> - Removed the printk() in kasan_early_init() to avoid build failure (see https://github.com/linuxppc/issues/issues/218)
> - Added necessary changes in asm/book3s/32/pgtable.h to get it work on powerpc 603 family
> - Added a few KASAN_SANITIZE_xxx.o := n to successfully boot on powerpc 603 family
> 
> Changes in v2:
> - Rebased.
> - Using __set_pte_at() to build the early table.
> - Worked around and got rid of the patch adding asm/page.h in asm/pgtable-types.h
>      ==> might be fixed independently but not needed for this serie.
> 
> Christophe Leroy (11):
>    powerpc/32: Move early_init() in a separate file
>    powerpc: prepare string/mem functions for KASAN
>    powerpc/prom_init: don't use string functions from lib/
>    powerpc/mm: don't use direct assignation during early boot.
>    powerpc/32: use memset() instead of memset_io() to zero BSS
>    powerpc/32: make KVIRT_TOP dependant on FIXMAP_START
>    powerpc/32: prepare shadow area for KASAN
>    powerpc: disable KASAN instrumentation on early/critical files.
>    powerpc/32: Add KASAN support
>    powerpc/32s: move hash code patching out of MMU_init_hw()
>    powerpc/32s: set up an early static hash table for KASAN.
> 
>   arch/powerpc/Kconfig                         |   6 +
>   arch/powerpc/include/asm/book3s/32/pgtable.h |   2 +-
>   arch/powerpc/include/asm/fixmap.h            |   5 +
>   arch/powerpc/include/asm/kasan.h             |  39 +++++
>   arch/powerpc/include/asm/nohash/32/pgtable.h |   2 +-
>   arch/powerpc/include/asm/string.h            |  32 +++-
>   arch/powerpc/kernel/Makefile                 |  14 +-
>   arch/powerpc/kernel/cputable.c               |  13 +-
>   arch/powerpc/kernel/early_32.c               |  36 +++++
>   arch/powerpc/kernel/head_32.S                |  46 ++++--
>   arch/powerpc/kernel/head_40x.S               |   3 +
>   arch/powerpc/kernel/head_44x.S               |   3 +
>   arch/powerpc/kernel/head_8xx.S               |   3 +
>   arch/powerpc/kernel/head_fsl_booke.S         |   3 +
>   arch/powerpc/kernel/prom_init.c              | 213 +++++++++++++++++++++------
>   arch/powerpc/kernel/prom_init_check.sh       |  12 +-
>   arch/powerpc/kernel/setup-common.c           |   3 +
>   arch/powerpc/kernel/setup_32.c               |  28 ----
>   arch/powerpc/lib/Makefile                    |  19 ++-
>   arch/powerpc/lib/copy_32.S                   |  15 +-
>   arch/powerpc/lib/mem_64.S                    |  10 +-
>   arch/powerpc/lib/memcpy_64.S                 |   4 +-
>   arch/powerpc/mm/Makefile                     |   7 +
>   arch/powerpc/mm/init_32.c                    |   1 +
>   arch/powerpc/mm/kasan/Makefile               |   5 +
>   arch/powerpc/mm/kasan/kasan_init_32.c        | 177 ++++++++++++++++++++++
>   arch/powerpc/mm/mem.c                        |   4 +
>   arch/powerpc/mm/mmu_decl.h                   |   2 +
>   arch/powerpc/mm/ppc_mmu_32.c                 |  34 +++--
>   arch/powerpc/mm/ptdump/ptdump.c              |   8 +
>   arch/powerpc/platforms/powermac/Makefile     |   6 +
>   arch/powerpc/purgatory/Makefile              |   3 +
>   arch/powerpc/xmon/Makefile                   |   1 +
>   33 files changed, 640 insertions(+), 119 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/kasan.h
>   create mode 100644 arch/powerpc/kernel/early_32.c
>   create mode 100644 arch/powerpc/mm/kasan/Makefile
>   create mode 100644 arch/powerpc/mm/kasan/kasan_init_32.c
> 
