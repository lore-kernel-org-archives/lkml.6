Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E9DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8343B20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7ahjsC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8343B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbeGWQhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:37:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39141 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbeGWQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:37:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id q12-v6so1035603qtp.6;
        Mon, 23 Jul 2018 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jOXEUEwojPSzHZIAs2rWvCfXbQ5Gp38MYhPZNpsoJKk=;
        b=E7ahjsC4oB1RgvOCKCDGsvgZOzzE3v836tRhPyESNbXSQ5SjmToZHNyOtFXJ5iz2lL
         yESOr/t/eF0ErNvhtYteGkSl8AmvXBCegyGeM58J97CxWJ9BfPKNn2pQo09xTfYvsoLQ
         033p3HydsU0OAjhOe0rJrnGu+cFbRqo21ccSK5fMYjYxXcuDNm/XJ2X/Kyh4ak6y4uQu
         kL2JY4u9KhmYjj43laWPiZ2dY5H8jTjvSrDd8L3mcMt+Jehb4hMhSsoa6SC8N+Qq1gMd
         vgd7N/nIat264gj88ifitkR9fqkvlRMr1Y2vzX1q5lo1gDporGKkZBH2qHqBI/i+S1v7
         3UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jOXEUEwojPSzHZIAs2rWvCfXbQ5Gp38MYhPZNpsoJKk=;
        b=Ok4Tg4Fqor598M6FEwB7W0FI0i3iETmQOtDmKeWEZ9x84WafCYoUwqGVuwhjzh7e0q
         d+umg2I5Z7T0gdt4zMOC4pfSoZ0DYL/SHD2YokeurR9N0cy2hEPMNQXl2YdmQ9hisbsT
         lUqd9d40vsRMS+PlpL9Vbzx2j5faxekcjAIUCe2MBLaqkQDc5DchgKJ7eMf9v9UBST3D
         RO+SgNm5wGm6qs29UtmgIKRYqZaQg9yrpysE9vWKP6u5RTbfWHprEMT8NxGlWpg23i8Q
         C8w68eT+BhK9qAPxrOwBqWJxTCd3kGDNhl4675q92L0cXeuPu8mk0S3f9p8e2k/jtVZh
         FY+w==
X-Gm-Message-State: AOUpUlGceGdFIKT73I8bywSgTyZusRJ/k+5FxcuA4SLG/IT27d2xYJNn
        1N/vd7BMCCkCtVYr3HATyz1499JImsWpObwUM6y+CGW2
X-Google-Smtp-Source: AAOMgpeufr0qGZIrijC4hMeiMM85+Z7jjwplQaA3PIBkwZtzjwtqBnp2iFt/4hobTyhIomc5bHS14kIct8PMqhAXMy0=
X-Received: by 2002:a0c:93b3:: with SMTP id f48-v6mr11565970qvf.151.1532360136182;
 Mon, 23 Jul 2018 08:35:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 08:35:35
 -0700 (PDT)
In-Reply-To: <20180723152323.GA3699@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org> <20180712172942.10094-3-hannes@cmpxchg.org>
 <CAK8P3a3Nsmt54-ed_gWNev3CBS6_Sv5QGOw4G0sY4ZXOi1R4_Q@mail.gmail.com> <20180723152323.GA3699@cmpxchg.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Jul 2018 17:35:35 +0200
X-Google-Sender-Auth: K95sfbcux0lEyNv44XcMpv7ZYwk
Message-ID: <CAK8P3a15K-TXYuFX-ZsJiroqA1GWX2XS4ioZSjcjJYgh1b_xSA@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm: workingset: tell cache transitions from
 workingset thrashing
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Linux-MM <linux-mm@kvack.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 5:23 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> On Mon, Jul 23, 2018 at 03:36:09PM +0200, Arnd Bergmann wrote:
>> On Thu, Jul 12, 2018 at 7:29 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> In file included from /git/arm-soc/include/linux/kernel.h:10,
>>                  from /git/arm-soc/arch/arm64/mm/init.c:20:
>> /git/arm-soc/arch/arm64/mm/init.c: In function 'mem_init':
>> /git/arm-soc/include/linux/compiler.h:357:38: error: call to
>> '__compiletime_assert_618' declared with attribute error: BUILD_BUG_ON
>> failed: sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT)
>
> This BUILD_BUG_ON() is to make sure we're sizing the VMEMMAP struct
> page array properly (address space divided by struct page size).
>
> From the code:
>
> /*
>  * Log2 of the upper bound of the size of a struct page. Used for sizing
>  * the vmemmap region only, does not affect actual memory footprint.
>  * We don't use sizeof(struct page) directly since taking its size here
>  * requires its definition to be available at this point in the inclusion
>  * chain, and it may not be a power of 2 in the first place.
>  */
> #define STRUCT_PAGE_MAX_SHIFT   6
>
...
> However, the check isn't conditional on that config option. And when
> VMEMMAP is disabled, we need 22 additional bits to identify the sparse
> memory sections in page->flags as well:
>
>> CONFIG_NODES_SHIFT=2
>> # CONFIG_ARCH_USES_PG_UNCACHED is not set
>> CONFIG_MEMORY_FAILURE=y
>> CONFIG_IDLE_PAGE_TRACKING=y
>>
>> #define MAX_NR_ZONES 3
>> #define ZONES_SHIFT 2
>> #define MAX_PHYSMEM_BITS 52
>> #define SECTION_SIZE_BITS 30
>> #define SECTIONS_WIDTH 22
>
> ^^^ Those we get back with VMEMMAP enabled.
>
> So for configs for which the check is intended, it passes. We just
> need to make it conditional to those.

Ok, thanks for the analysis, I had missed that and was about to
send a different patch to increase STRUCT_PAGE_MAX_SHIFT
in some configurations, which is not as good.

> From 1d24635a6c7cd395bad5c29a3b9e5d2e98d9ab84 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 23 Jul 2018 10:18:23 -0400
> Subject: [PATCH] arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap
>  setups
>
> Arnd reports the following arm64 randconfig build error with the PSI
> patches that add another page flag:
>

You could add further text here that I had just added to my
patch description (not sent):

    Further experiments show that the build error already existed before,
    but was only triggered with larger values of CONFIG_NR_CPU and/or
    CONFIG_NODES_SHIFT that might be used in actual configurations but
    not in randconfig builds.

    With longer CPU and node masks, I could recreate the problem with
    kernels as old as linux-4.7 when arm64 NUMA support got added.

    Cc: stable@vger.kernel.org
    Fixes: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
    Fixes: 3e1907d5bf5a ("arm64: mm: move vmemmap region right below
the linear region")

>  arch/arm64/mm/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1b18b4722420..72c9b6778b0a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -611,11 +611,13 @@ void __init mem_init(void)
>         BUILD_BUG_ON(TASK_SIZE_32                       > TASK_SIZE_64);
>  #endif
>
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
>         /*

I tested it on two broken configurations, and found that you have
a typo here, it should be 'ifdef', not 'ifndef'. With that change, it
seems to build fine.

Tested-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
