Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27098C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34F6214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuREFC78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfAZOEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 09:04:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38025 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAZOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 09:04:48 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so9970784ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 06:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2e19XzYJqBwUjvyBJ5oQ7NjCEU5gUXoR9z8LTZJFif4=;
        b=FuREFC78Xo7NCmkjMJUaOMvEf5QKfI1W8s1o4fFN/WephAYfdcbCbtfK2Jh6IEXI/v
         0tt9I+DZu4/ExbdiJY1kIA2tDB9Zv6N4Ui3OGxnOZl8fUajfCuoK8tmIZCVaVMZCx/NU
         nzGvG0L38o+QvrzBXviLguebwXsabjZADpLpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2e19XzYJqBwUjvyBJ5oQ7NjCEU5gUXoR9z8LTZJFif4=;
        b=Jxc3pfYcvj8JA7iltje1aF579MdPrZov5qAV3+W+UzlYb2NV8LwtzBqWNNJQE3OUSL
         8CixPfH/ho2CYAK9BPE25OSPOwNWHD+k+DqMzf5WkmZFfqza3BQK5C1/zVYIjzCJlORg
         B2CWNSfK5GXBemtGg4bHAtv4Ue/dIqtxjqyoMWnZdDe/6CMpEGXgFh0k26wTLGG21sgB
         bSshJUXbwqSpjkungCOsdADJbfrX0tkZZT8wpmjo2vVsb46CgBCrZFyRlP1gQa5XFgTo
         AvG/k0tP/2mJfZQ+9bALn6cfXzzqRFrOf0qqjYl5Ly2u5job1lPf+7ebDtWAeERy9m8j
         jkAg==
X-Gm-Message-State: AHQUAub3Ei5uK98sosPsfzAMSrA5ApH93ck74yImAnMc6WgLkyOKoUIS
        /E/j/5cDoCKhXxO7SE9qzcuURAeNQQYi0fPtduKUHA==
X-Google-Smtp-Source: ALg8bN5D3cFcW9BJTSUM+ltCA30DOeHjTpTHAKGSsNvPNbnTaCJX+LfvkqmtX9rf6RgiJWXWEM0XucfrM6T3i/4dH4A=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr8919521ion.173.1548511487449;
 Sat, 26 Jan 2019 06:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20190109104541.25733-1-hedi.berriche@hpe.com> <20190109104541.25733-3-hedi.berriche@hpe.com>
In-Reply-To: <20190109104541.25733-3-hedi.berriche@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 26 Jan 2019 15:04:36 +0100
Message-ID: <CAKv+Gu8LZmAsJMGBhvOzZTzwqg_p=y7_GdqB=qmFmpMDaRSqwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/platform/UV: kill uv_bios_call_reentrant() as it
 has no callers
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
> uv_bios_call_reentrant() has no callers nor is it exported, kill it.
>
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> Reviewed-by: Russ Anderson <rja@hpe.com>
> Reviewed-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

Please drop these reviewed-bys

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/x86/include/asm/uv/bios.h |  1 -
>  arch/x86/platform/uv/bios_uv.c | 12 ------------
>  2 files changed, 13 deletions(-)
>
> diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
> index e652a7cc6186..4eee646544b2 100644
> --- a/arch/x86/include/asm/uv/bios.h
> +++ b/arch/x86/include/asm/uv/bios.h
> @@ -140,7 +140,6 @@ enum uv_memprotect {
>   */
>  extern s64 uv_bios_call(enum uv_bios_cmd, u64, u64, u64, u64, u64);
>  extern s64 uv_bios_call_irqsave(enum uv_bios_cmd, u64, u64, u64, u64, u64);
> -extern s64 uv_bios_call_reentrant(enum uv_bios_cmd, u64, u64, u64, u64, u64);
>
>  extern s64 uv_bios_get_sn_info(int, int *, long *, long *, long *, long *);
>  extern s64 uv_bios_freq_base(u64, u64 *);
> diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
> index 4a6a5a26c582..cd05af157763 100644
> --- a/arch/x86/platform/uv/bios_uv.c
> +++ b/arch/x86/platform/uv/bios_uv.c
> @@ -66,18 +66,6 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
>         return ret;
>  }
>
> -s64 uv_bios_call_reentrant(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
> -                                       u64 a4, u64 a5)
> -{
> -       s64 ret;
> -
> -       preempt_disable();
> -       ret = uv_bios_call(which, a1, a2, a3, a4, a5);
> -       preempt_enable();
> -
> -       return ret;
> -}
> -
>
>  long sn_partition_id;
>  EXPORT_SYMBOL_GPL(sn_partition_id);
> --
> 2.20.0
>
