Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A5C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22220C0A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTE4tGCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C22220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeIVVk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:40:26 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41338 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeIVVk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:40:26 -0400
Received: by mail-yb1-f193.google.com with SMTP id d14-v6so1587850ybs.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bdTMs6Z71xSj/xlF7I4SxziUjWSY2U8NfxbnLUOt2YI=;
        b=aTE4tGCzGsNTd9qYTChBQlczPyO66XkGVZzAGVgjQT3PnhDJCem5pRmcnye1Aq0Ox0
         ryj6m7SbP2jShAEzNNmpBeeWn/mG0rIlcFW/KPfA8IRoIIe7zs7On+Xt9Cq0bXF3rfcQ
         afiP0zQ/rtuG4JVIFQNgKeBpsOWE5l71oL6FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bdTMs6Z71xSj/xlF7I4SxziUjWSY2U8NfxbnLUOt2YI=;
        b=IrOx9MLzeczieZMGxlAARf1WRpg5pSBAfsH2pumRw9kFurW+sscuhdruzivGPcctxA
         mCXfikH8MfqLIqugYmBNr9HzG24VICsbkF0PaeJF6L8lLZQ8IDQFikdOEunEjNwOsLRh
         yw0jkWyrRuBSsHR2LR+l+XAb08EtBTs+XOZ7ky8o5+J+310inJ+r1WajES9aPArFYtQW
         NIiR5OvFdFIddmhoYs1FuvGdCbflfczIMX/C809mMjpwF5k9pbXf4rEogwIHh6YtbXBX
         Kns5fRYkloD4EqUS3+Z7v68C/B6vqOIr4ZNg7Z6BYiYosuyUxwbIUxTQ+Ugj+ZgsBLDW
         bv6Q==
X-Gm-Message-State: ABuFfojvFM07VvH4K5MHH51iTvpJriXNfeq3yC2TqgpvHjowljK6MIaV
        Tajlccnl4q/JIT4XNISUOppl2aLqsnM=
X-Google-Smtp-Source: ACcGV62H+WqTL9YEc+5QQXFNtV5z3q2sdvHWVy4PHrRnBbc6/bs3zlZFwZ/Hk2nHC1IiUOHNi/99gg==
X-Received: by 2002:a25:943:: with SMTP id u3-v6mr1212192ybm.435.1537631184929;
        Sat, 22 Sep 2018 08:46:24 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id i123-v6sm11034255ywe.14.2018.09.22.08.46.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 08:46:23 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 184-v6so6692285ybg.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:46:23 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr1249408ybz.410.1537631183240;
 Sat, 22 Sep 2018 08:46:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 08:46:22
 -0700 (PDT)
In-Reply-To: <20180913104629.5179-3-fanc.fnst@cn.fujitsu.com>
References: <20180913104629.5179-1-fanc.fnst@cn.fujitsu.com> <20180913104629.5179-3-fanc.fnst@cn.fujitsu.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 22 Sep 2018 08:46:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+amHGGCxC9PVrCfV8qNchyAyxd225F1rW2o2t=NRogDg@mail.gmail.com>
Message-ID: <CAGXu5j+amHGGCxC9PVrCfV8qNchyAyxd225F1rW2o2t=NRogDg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:46 AM, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> If CONFIG_MEMORY_HOTREMOVE enabled, walk through the acpi srat memory
> tables and store those immovable memory regions so that kaslr can get
> where to choose for randomization.
>
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 9ed9709d9947..0c3567bc231c 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -417,6 +417,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>         /* Mark the memmap regions we need to avoid */
>         handle_mem_options();
>
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +       /* Mark the immovable regions we need to choose */
> +       get_immovable_mem();
> +#endif

Style nit-pick: I'd prefer the definition of get_immovable_mem() do
the ifdef so it doesn't appear here.

-Kees

> +
>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
>         /* Make sure video RAM can be used. */
>         add_identity_map(0, PMD_SIZE);
> --
> 2.17.1
>
>
>



-- 
Kees Cook
Pixel Security
