Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DDCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17722087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXhGykbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17722087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeH1SWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:22:33 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41531 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1SWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:22:33 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so644621ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4sEw4kkTgfCYGqe6eJRdxIGFHXQKYqVsaWOAInavVT8=;
        b=XXhGykbsvqmEG+bffcOfBuG3p46vfgQ941onjTQff43qxqnMun5jUNmHUNL8IyxHSU
         gCtuHvYFsUj/c/vr+pI+BTNIIjG0Num/yyFBvosAatvoXjBylHuWYhdbpeGHeZnayWc7
         2/12keQUL9Zv5FCm0CMwXeWsk+8+6WyP/W3No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4sEw4kkTgfCYGqe6eJRdxIGFHXQKYqVsaWOAInavVT8=;
        b=Hw9citArkLiOgET4ocVZ2XYE6Er5/zOk2t7AutpwGZudsEgzh85bE+tmiAhdPD1MFE
         hXOx2miZ1gNwK/tLSTsAD/tYIUws2lko2UI/opXc9QA5Hitv2gXA7CJHaQd611CJt4sL
         jghPbbJD4h+ZTUPPoM6r5Hjv8fxTjzjoU6oDG1VXzf6i3mEATny6mNjv3N09M/uzGzld
         TJaxRbOMQJLDl5QP0C4GQxzdXe+2KFLM1ZKMVvGabIq51hOAimQVJaoK4xpW0cc+/jwt
         PydOyu0eJIKdyNLj+83t3Jb16e+sSM6UXWhyg2l3KBpjcJOAxBLloHSZpu2IcoNnIrFy
         E90g==
X-Gm-Message-State: APzg51CduU7l4Y9c0+E4OQ8mfLIeyDOtUbXBQf1LrD+y65+VMSeSHj5a
        mYt/JGU3hbSAcee/iGigLcCvjkGkh08=
X-Google-Smtp-Source: ANB0Vdbq+vm9iQPJUNgAZ0sJ4lg6nkNHY28Q1zzPn87GZTdPdR8+4z4GEOqzZvz5BiFsiEWRVmmt4w==
X-Received: by 2002:a0d:e547:: with SMTP id o68-v6mr913416ywe.403.1535466636131;
        Tue, 28 Aug 2018 07:30:36 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id d70-v6sm497263ywe.97.2018.08.28.07.30.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:30:34 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id x83-v6so652061ywd.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:30:34 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr970557ywg.288.1535466634246;
 Tue, 28 Aug 2018 07:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 07:30:33
 -0700 (PDT)
In-Reply-To: <20180828142313.8085-1-geert+renesas@glider.be>
References: <20180828142313.8085-1-geert+renesas@glider.be>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 28 Aug 2018 07:30:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ5Xibab=cCsZ1boEUf2m-=ifd2XswhPDeawyJCMiOK_Q@mail.gmail.com>
Message-ID: <CAGXu5jJ5Xibab=cCsZ1boEUf2m-=ifd2XswhPDeawyJCMiOK_Q@mail.gmail.com>
Subject: Re: [PATCH] unicore32: Stop printing the virtual memory layout
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Guan Xuetao <gxt@pku.edu.cn>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 7:23 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with
> %p"), the virtual memory layout printed during boot up contains "ptrval"
> instead of actual addresses.
>
> Instead of changing the printing to "%px", and leaking virtual memory
> layout information again, just remove the printing completely, cfr. e.g.
> commits 071929dbdd865f77 ("arm64: Stop printing the virtual memory
> layout") and  31833332f7987636 ("m68k/mm: Stop printing the virtual
> memory layout").
>
> All interesting information (actual section sizes) is already printed by
> mem_init_print_info() just above anyway.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Nice!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/unicore32/mm/init.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
> index f4950fbfe57493c7..1662058c272a5917 100644
> --- a/arch/unicore32/mm/init.c
> +++ b/arch/unicore32/mm/init.c
> @@ -344,30 +344,6 @@ void __init mem_init(void)
>         free_all_bootmem();
>
>         mem_init_print_info(NULL);
> -       printk(KERN_NOTICE "Virtual kernel memory layout:\n"
> -               "    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -               "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -               "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -               "    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -               "      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
> -               "      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
> -               "      .data : 0x%p" " - 0x%p" "   (%4d kB)\n",
> -
> -               VECTORS_BASE, VECTORS_BASE + PAGE_SIZE,
> -               DIV_ROUND_UP(PAGE_SIZE, SZ_1K),
> -               VMALLOC_START, VMALLOC_END,
> -               DIV_ROUND_UP((VMALLOC_END - VMALLOC_START), SZ_1M),
> -               PAGE_OFFSET, (unsigned long)high_memory,
> -               DIV_ROUND_UP(((unsigned long)high_memory - PAGE_OFFSET), SZ_1M),
> -               MODULES_VADDR, MODULES_END,
> -               DIV_ROUND_UP((MODULES_END - MODULES_VADDR), SZ_1M),
> -
> -               __init_begin, __init_end,
> -               DIV_ROUND_UP((__init_end - __init_begin), SZ_1K),
> -               _stext, _etext,
> -               DIV_ROUND_UP((_etext - _stext), SZ_1K),
> -               _sdata, _edata,
> -               DIV_ROUND_UP((_edata - _sdata), SZ_1K));
>
>         BUILD_BUG_ON(TASK_SIZE                          > MODULES_VADDR);
>         BUG_ON(TASK_SIZE                                > MODULES_VADDR);
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
