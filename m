Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4B9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5560B2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5560B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHaX52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:57:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40669 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeHaX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:57:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id c126-v6so2163068qkd.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 12:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSSdABq6e4tZ8A31SioQLLW5+GaszgFF1mM7h377GsU=;
        b=Yg8EPyLlQKmiQ/cBIxmCa9NyJCNyBOxS+u8pUFj9axiiSJtR2GWyajabeMz6LCHJrh
         t6IIkHMTgsnO/eOqyYfqVoNv8R28vpcR6nPyLPG8QEgo3MZlyIf411fwQVFVvRvDV2Xp
         ubP3EBdui0SxIC3MJ2Men+pgSJ6hrhBNz8VEcTLqSx7CZatOThwpeKgsx8R5wGl4ChqC
         DXc/ontIEf5rQGwFAfOyakP755hywU+EFBlG3E4fesNbDIbOF1X+SMytlgl2WFYo5gEG
         8V+K0oNNG8rpnohw0gnmy+eeHpTjaCK53qW1UiSfkwYq1BUUI0PeW1ntLOA+nDmemL3P
         q9Pw==
X-Gm-Message-State: APzg51A2Nb8czyv8u0sykLg1/YndOexRnU1oaqfBG9S7Xai5DFvPv/yb
        jUBDL8FulOv5lcys2TSkISDdEdGzruny0qVkv6k=
X-Google-Smtp-Source: ANB0VdblYNSBRoHA9vW5ZEmdQW/ZEZumfg4jITw7A9w7+wSD5968UthjX4tK5smGs1IWRFntwByeE16MvG5TTiMZwX0=
X-Received: by 2002:a37:1b91:: with SMTP id m17-v6mr16910896qkh.173.1535744908418;
 Fri, 31 Aug 2018 12:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com> <20180831170514.24665-5-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-5-miguel.ojeda.sandonis@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Aug 2018 21:48:12 +0200
Message-ID: <CAK8P3a2N0pPvLvmERpHPZ5pmYQpNpd4Yqfq2d2cJZ96UHLd8VA@mail.gmail.com>
Subject: Re: [PATCH 5/7] Compiler Attributes: naked was fixed in gcc 4.6
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>, asmadeus@codewreck.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 7:05 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
> and noinline on __naked functions") added noinline and noclone
> as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.
>
> Since now the minimum gcc supported version is 4.6,
> we can clean it up.
>
> See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
> and https://godbolt.org/z/h6NMIL
>

> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 66e1eb8822d9..fdf2fbe6d544 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -77,14 +77,8 @@
>   * to trace naked functions because then mcount is called without
>   * stack and frame pointer being set up and there is no chance to
>   * restore the lr register to the value before mcount was called.
> - *
> - * The asm() bodies of naked functions often depend on standard calling
> - * conventions, therefore they must be noinline and noclone.
> - *
> - * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
> - * See GCC PR44290.
>   */
> -#define __naked                __attribute__((naked)) noinline __noclone notrace
> +#define __naked                __attribute__((naked)) notrace
>

Good catch. Can this be moved into linux/compiler.h now so we
don't need separate definitions for clang and gcc?

        Arnd
