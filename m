Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BEE218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqpnXoNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeLZMCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:02:51 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36288 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeLZMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:02:51 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so20042956itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVjRXbgxFYGFk9y6ELrr8A6OdFVvdGFRoOhZs8VKPx8=;
        b=jqpnXoNuQH4Y6npYm3Y2uFXpd55m5SqzzyO6HphWz08wfUy/4IgmJP2r1s4+bvxJ/x
         s2wgXo6W4YwVrVx3bgJCH34vyuVLurXj32RtgKEQb4HiADWuz/6Ifu8HnvY+9BAM1exs
         xFkjyd5FCR5s4hhcvNLE85A55c+emVzKGD3mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVjRXbgxFYGFk9y6ELrr8A6OdFVvdGFRoOhZs8VKPx8=;
        b=qVBmHM4+Zx6PR1SMoJxw6xZAqmmd5BdKAOZpEYNbJnnXbrZZzEmYy3+p9xX+1jtMf8
         1VhY5ORsolXUqfKd3gPpOTqURnNiiTsNFXLnvIFkhcQfWAr6B3MIOlxSWW95DVQF8ere
         1hXQ+qy5tFsL2ijRqDgwgV7dnPJbUvgs9mrE39uF8mdpljspS2O5zU4U/X2lMN3WSG60
         1QzGunClPLsNHDmxps5sy19/LTc2wAtxF61Dr/8f6kMOmlrTDB4+2h7zPi+MJskgiJB0
         wtj3n4OjwM0rrg8Impo17vLodDERd8x5dUrnqp8OIcURdD3VqM7ioO5cIFZnWbqk8mqG
         vetA==
X-Gm-Message-State: AA+aEWZmKpwqEhz9Ol3R3GWCaYVM+Z7g4jgco5fmZ1U/9l2MAEwEHekI
        LBj/u8PYcNcFMhTkltTzVK8SkaNPXY95NoODB2MPbA==
X-Google-Smtp-Source: AFSGD/UACFsUr9ithLjnKHB92iRq6d/4awgjLXCysK99G3+FhGWesdRdkf89Pq2E7DiJOn2IJegyRCmr7cRZK+om/30=
X-Received: by 2002:a24:710:: with SMTP id f16mr10914024itf.121.1545825769997;
 Wed, 26 Dec 2018 04:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20181226023534.64048-1-cai@lca.pw>
In-Reply-To: <20181226023534.64048-1-cai@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Dec 2018 13:02:38 +0100
Message-ID: <CAKv+Gu_fiEDffKq_fONBYTOdSk-L7__+LgNEyVaNF3FGzBfAow@mail.gmail.com>
Subject: Re: [PATCH -mmotm] efi: drop kmemleak_ignore() for page allocator
To:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018 at 03:35, Qian Cai <cai@lca.pw> wrote:
>
> a0fc5578f1d (efi: Let kmemleak ignore false positives) is no longer
> needed due to efi_mem_reserve_persistent() uses __get_free_page()
> instead where kmemelak is not able to track regardless. Otherwise,
> kernel reported "kmemleak: Trying to color unknown object at
> 0xffff801060ef0000 as Black"
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Why are you sending this to -mmotm?

Andrew, please disregard this patch. This is EFI/tip material.

> ---
>  drivers/firmware/efi/efi.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7ac09dd8f268..4c46ff6f2242 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -31,7 +31,6 @@
>  #include <linux/acpi.h>
>  #include <linux/ucs2_string.h>
>  #include <linux/memblock.h>
> -#include <linux/kmemleak.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -1027,8 +1026,6 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>         if (!rsv)
>                 return -ENOMEM;
>
> -       kmemleak_ignore(rsv);
> -
>         rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
>         atomic_set(&rsv->count, 1);
>         rsv->entry[0].base = addr;

The patch that adds the kmemleak_ignore() call here is queued in
efi/urgent branch in the tip tree, but did not make it into v4.20.

efi/urgent does not apply cleanly to efi/core, since the kmalloc()
call [which requires the kmemleak_ignore() call] has been replaced
with alloc_pages() [which doesn't], necessitating this patch to remove
the kmemleak_ignore() call again.

So what I would like to suggest is that Ingo resolves this conflict by
simply dropping the call to kmemleak_ignore(). That way, we don't need
this patch, and we can still backport the efi/urgent change to
v4.20-stable.
