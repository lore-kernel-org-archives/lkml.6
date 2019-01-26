Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C533C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4AE2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEvVF/wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfAZOLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 09:11:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35344 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 09:11:01 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so13639551itp.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 06:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yiQhDgD+LoNYrE33H1YnbwzccUcgvQS6K9T24TtKbk=;
        b=XEvVF/wW330eCALXbqwNSFUdRYJozWSXLBF1SRbyB+7vNyFk/g9VO2Hix0l0wGwI8C
         EH7Bx9aRGpCCAHBRsbFy7zle1MHQvRiLdU4Q4fYymtXjV8cEu16fHaJWbvX9xzrypbXw
         c1UnPu1+nHTfUtnSIpfWgwD4H6iL56l/7FUOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yiQhDgD+LoNYrE33H1YnbwzccUcgvQS6K9T24TtKbk=;
        b=G2yjad2bJxnMnUC5BH5sNNCCcBczBQSNn6JYBzTHTyWznqq11qVtcqWns0yecJpL02
         gU2IBDwU/V3s6er68zwpKViKp1Ow+5KAUw+jr4DEzpxQ6sRktYBM/llBYR4712D2eUQY
         v4S8Sy77PEFTthxyh4jeMCngV9tKBJ98lortIEFOa/OCO31/ndlWYJmYRT7hL/n2Gu97
         PMexlZoz211i3BmfWxWEF3S3fayBXtT3B+1+BdRfX+yb95qe9yHVGZUlx2zOrrQep2yi
         j1xP/IQ8gM138Hq/yOh5TpJphcE/ge3jzJjMQvzQUiKY1a9OSrlbJmGWfOwVDsi20tF2
         n60Q==
X-Gm-Message-State: AJcUukdUCmsgA2rRrUXScu9qrrwhh9du6va4QbpZhiBxAhkbz0CZiWx6
        LnXuxDwoQOMTx4QIv0oZXC272/BtKsyntN4DrIjHvg==
X-Google-Smtp-Source: ALg8bN4Pzqi+oGBD/3yL4hSurR/QwzkKGs1BZVK3WdbdQyX3Pnm7juEUdsjbRtCGeNyfWvC13r6XBf/p79fmIlGaap0=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr6735212itk.71.1548511860436;
 Sat, 26 Jan 2019 06:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20190109104541.25733-1-hedi.berriche@hpe.com> <20190109104541.25733-4-hedi.berriche@hpe.com>
In-Reply-To: <20190109104541.25733-4-hedi.berriche@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 26 Jan 2019 15:10:49 +0100
Message-ID: <CAKv+Gu97kdYvK+gMF39GXsP-K34OuvhOTODE0F8prb-4tH2FCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/platform/UV: use efi_runtime_sem to serialise
 BIOS calls
To:     Hedi Berriche <hedi.berriche@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 11:46, Hedi Berriche <hedi.berriche@hpe.com> wrote:
>
> Calls into UV firmware must be protected against concurrency, use the
> now visible efi_runtime_sem lock to serialise them.
>
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> Reviewed-by: Russ Anderson <rja@hpe.com>
> Reviewed-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

> ---
>  arch/x86/include/asm/uv/bios.h |  3 ++-
>  arch/x86/platform/uv/bios_uv.c | 25 ++++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
> index 4eee646544b2..33e94aa0b1ff 100644
> --- a/arch/x86/include/asm/uv/bios.h
> +++ b/arch/x86/include/asm/uv/bios.h
> @@ -48,7 +48,8 @@ enum {
>         BIOS_STATUS_SUCCESS             =  0,
>         BIOS_STATUS_UNIMPLEMENTED       = -ENOSYS,
>         BIOS_STATUS_EINVAL              = -EINVAL,
> -       BIOS_STATUS_UNAVAIL             = -EBUSY
> +       BIOS_STATUS_UNAVAIL             = -EBUSY,
> +       BIOS_STATUS_ABORT               = -EINTR

Nit: please add a trailing comma so the next patch looks cleaner.

>  };
>
>  /* Address map parameters */
> diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
> index cd05af157763..92f960798e20 100644
> --- a/arch/x86/platform/uv/bios_uv.c
> +++ b/arch/x86/platform/uv/bios_uv.c
> @@ -29,7 +29,8 @@
>
>  struct uv_systab *uv_systab;
>
> -s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
> +s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
> +                       u64 a4, u64 a5)
>  {
>         struct uv_systab *tab = uv_systab;
>         s64 ret;
> @@ -44,13 +45,26 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
>          * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
>          * callback method, which uses efi_call() directly, with the kernel page tables:
>          */
> -       if (unlikely(test_bit(EFI_OLD_MEMMAP, &efi.flags)))
> +       if (unlikely(efi_enabled(EFI_OLD_MEMMAP)))

This is an unrelated change. You should at least mention it in the
commit log, or put it in a separate patch.

>                 ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
>         else
>                 ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
>
>         return ret;
>  }
> +
> +s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
> +{
> +       s64 ret;
> +
> +       if (down_interruptible(&efi_runtime_sem))
> +               return BIOS_STATUS_ABORT;
> +
> +       ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
> +       up(&efi_runtime_sem);
> +
> +       return ret;
> +}
>  EXPORT_SYMBOL_GPL(uv_bios_call);
>
>  s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
> @@ -59,10 +73,15 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
>         unsigned long bios_flags;
>         s64 ret;
>
> +       if (down_interruptible(&efi_runtime_sem))
> +               return BIOS_STATUS_ABORT;
> +
>         local_irq_save(bios_flags);
> -       ret = uv_bios_call(which, a1, a2, a3, a4, a5);
> +       ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
>         local_irq_restore(bios_flags);
>
> +       up(&efi_runtime_sem);
> +
>         return ret;
>  }
>
> --
> 2.20.0
>
