Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E916C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADC22082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UW3hK+Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADC22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJ2VzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:55:12 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:27695 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeJ2VzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:55:12 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9TD6Lvp014252;
        Mon, 29 Oct 2018 22:06:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9TD6Lvp014252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540818382;
        bh=XGKSz0bIM4/JAST1orHUNl+mRfR3WEzEEwi8+D/NAx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UW3hK+Ob0bdnhpEgIajdvBxc5y+NlamK3u8cN2w/p3fB57jdLU3k0gBLhi9XULLRH
         WRBPsZ2k7ARrM8W45ud/E+HqTH8DJT/+1MDTpo2LAKIva3C7wOX1d/Ro/0gccrlYVV
         8AE02NbB1/k1RgI/x+6+sVs7DCZsxxZl+4achXJWYF8KDzWbsbQbMNbwcZ6bF+KsO+
         TDxuvwZ+twevtUIbrl24um+B9Z3KQKCW6EkMZ7Jq16eKEIK7TzcK4wvELkcYvcGQG8
         M1T+3k5P1BNVgBtQjvh3DVX/QH60zEAKzP6HL9DkZj8/aCj0Z5gitG7jX3B54dPlUN
         4hXG+asJ/S2KA==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id j20so2010174vke.5;
        Mon, 29 Oct 2018 06:06:21 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJ7oabM+LxErtol/E/LmtNir3hE8jb1PGhyNd9vkhbJv6EdIK9S
        vz8JsKXkR29Z8JsZMXaxEw5tDqgfMzmUX1F5w5M=
X-Google-Smtp-Source: AJdET5ffRkwnggUrhtzIL7RHW5a6uIiYJDbORXsA0Qs7pUJfN7tCjcgwM4Q1IFxN3vGDNflXP3ZfVXjjsV5zH1rZTMA=
X-Received: by 2002:a1f:a014:: with SMTP id j20mr5764131vke.64.1540818380381;
 Mon, 29 Oct 2018 06:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181028130945.23581-1-changbin.du@gmail.com> <20181028130945.23581-4-changbin.du@gmail.com>
In-Reply-To: <20181028130945.23581-4-changbin.du@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 22:05:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQP6SgtbYcxZ7ApGg006omEZErNcDAVtPR=2RibxN8Ruw@mail.gmail.com>
Message-ID: <CAK7LNAQP6SgtbYcxZ7ApGg006omEZErNcDAVtPR=2RibxN8Ruw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: mm: fix build error in fix_to_virt with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:13 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> With '-Og' optimization level, GCC would not optimize a count for a loop
> as a constant value. But BUILD_BUG_ON() only accept compile-time constant
> values. Let's use __fix_to_virt() to avoid the error.
>
> arch/arm/mm/mmu.o: In function `fix_to_virt':
> /home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
> Makefile:1051: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Applied to linux-kbuild





-- 
Best Regards
Masahiro Yamada
