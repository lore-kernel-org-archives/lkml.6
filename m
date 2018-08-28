Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEA02087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEs+VNXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEA02087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeH1SXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:23:13 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43340 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1SXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:23:13 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so643073ywb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v8sKi2P6DAMFc+JcszdpTK1IBHj31eJhO4UD+KliJSQ=;
        b=SEs+VNXrtSyuksbnYOStU2cqyj7Q5sGs1WJCXUK6g9GHXUkk4e03N9hX2PGWz2MrtS
         rxl3o7/aqylr0DOv3fuhNsTPBmDrxfPKLBrcCmV3AA+xglRpOPq7ZRX90iOvdOgXCZaF
         JYhQJG0aflz1oQgWHOGQQLAlqnZo9OReClwk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v8sKi2P6DAMFc+JcszdpTK1IBHj31eJhO4UD+KliJSQ=;
        b=hNuNu3jPdGJpvKcui7RfuwyULj9hCcnu+8PX+G3HVJivlCr230AE6SvD3G+UJn5dcW
         oierg9mp8k91MMiVA1GVHUDDZSU1Uox73KSU2z2pRo19NgXBIgnTeitfTE70bN9CX+Rj
         WRefTapR3HANsSICXgA2UpmE2dcjVsXNqPuhK6u6C3uyjaY9RlG35TuRqYce+KLhf2ht
         P+Jg99EFdW9gaqT6f8ovbsdVm9c0AyRUWOxbqb2QVPo7rzOfOC1eLT4TEJRDE/m2B4tm
         HATGZpxh/hCOEvUyKAg+F0ttfBm/8taAbug31we2OMnue5Zri5o5MhTlBHUNcb0GgkRT
         d00A==
X-Gm-Message-State: APzg51AWDeCxyrBPeOIp9w8lCY2U0X+mCyYVaI1MLanjUzszWVI5+jzJ
        pcPYEttspKHV0Jo9mncZ6vyIHEQGYMw=
X-Google-Smtp-Source: ANB0VdZlkNZX+4S2iboq4Rv6GVmaBcB8G755gYaI8Ck0TUxhA47sMAidN8FIuveJOzZxT8bJT9g5mg==
X-Received: by 2002:a81:71c5:: with SMTP id m188-v6mr935136ywc.313.1535466676179;
        Tue, 28 Aug 2018 07:31:16 -0700 (PDT)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com. [209.85.213.178])
        by smtp.gmail.com with ESMTPSA id p78-v6sm1004730ywp.31.2018.08.28.07.31.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:31:15 -0700 (PDT)
Received: by mail-yb0-f178.google.com with SMTP id y20-v6so653645ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:31:14 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr944863ybz.410.1535466674245;
 Tue, 28 Aug 2018 07:31:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 07:31:13
 -0700 (PDT)
In-Reply-To: <20180828142225.7941-1-geert+renesas@glider.be>
References: <20180828142225.7941-1-geert+renesas@glider.be>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 28 Aug 2018 07:31:13 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKQbgFNEYsd3dB0bjkzAhWfFzK3XaOSNKirZdpTdSBz4A@mail.gmail.com>
Message-ID: <CAGXu5jKQbgFNEYsd3dB0bjkzAhWfFzK3XaOSNKirZdpTdSBz4A@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: Stop printing the virtual memory layout
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 7:22 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with
> %p"), the virtual memory layout printed during boot up contains "ptrval"
> instead of actual addresses:
>
>     Memory: 501296K/524288K available (6144K kernel code, 528K rwdata, 1944K rodata, 1024K init, 7584K bss, 22992K reserved, 0K cma-reserved)
>     Virtual kernel memory layout:
>         vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>         fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>         vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
>         lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
>         modules : 0xbf000000 - 0xc0000000   (  16 MB)
>           .text : 0x(ptrval) - 0x(ptrval)   (7136 kB)
>           .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
>           .data : 0x(ptrval) - 0x(ptrval)   ( 529 kB)
>            .bss : 0x(ptrval) - 0x(ptrval)   (7585 kB)
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/mm/init.c | 49 ----------------------------------------------
>  1 file changed, 49 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 0cc8e04295a40dc1..e90422ae8adfa511 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -519,55 +519,6 @@ void __init mem_init(void)
>
>         mem_init_print_info(NULL);
>
> -#define MLK(b, t) b, t, ((t) - (b)) >> 10
> -#define MLM(b, t) b, t, ((t) - (b)) >> 20
> -#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> -
> -       pr_notice("Virtual kernel memory layout:\n"
> -                       "    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -#ifdef CONFIG_HAVE_TCM
> -                       "    DTCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -                       "    ITCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -#endif
> -                       "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -                       "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -                       "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -#ifdef CONFIG_HIGHMEM
> -                       "    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -#endif
> -#ifdef CONFIG_MODULES
> -                       "    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -#endif
> -                       "      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
> -                       "      .init : 0x%p" " - 0x%p" "   (%4td kB)\n"
> -                       "      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
> -                       "       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
> -
> -                       MLK(VECTORS_BASE, VECTORS_BASE + PAGE_SIZE),
> -#ifdef CONFIG_HAVE_TCM
> -                       MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
> -                       MLK(ITCM_OFFSET, (unsigned long) itcm_end),
> -#endif
> -                       MLK(FIXADDR_START, FIXADDR_END),
> -                       MLM(VMALLOC_START, VMALLOC_END),
> -                       MLM(PAGE_OFFSET, (unsigned long)high_memory),
> -#ifdef CONFIG_HIGHMEM
> -                       MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
> -                               (PAGE_SIZE)),
> -#endif
> -#ifdef CONFIG_MODULES
> -                       MLM(MODULES_VADDR, MODULES_END),
> -#endif
> -
> -                       MLK_ROUNDUP(_text, _etext),
> -                       MLK_ROUNDUP(__init_begin, __init_end),
> -                       MLK_ROUNDUP(_sdata, _edata),
> -                       MLK_ROUNDUP(__bss_start, __bss_stop));
> -
> -#undef MLK
> -#undef MLM
> -#undef MLK_ROUNDUP
> -
>         /*
>          * Check boundaries twice: Some fundamental inconsistencies can
>          * be detected at build time already.
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
