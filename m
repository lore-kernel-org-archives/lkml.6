Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF94214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfBUJVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:21:39 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41506 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:21:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so30698469qtp.8;
        Thu, 21 Feb 2019 01:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKZLnTtklFeSV7/EHHY7qCASYJbhIzZUiakAHjMZejo=;
        b=YAyKDMDnfGq203vOgPQR1nWaexzPgoqXyvUv+6q107OPsvjyRH8gLnl8gF8y3/kCPp
         zAIV9ukLsPY/a/1z1LcI3NzewZA3Me1+rbBQ2MqmE5cg078yW/ZdAHMV8ZJM34dHTJhE
         DR5Voyr4Jke4xyAydW4mnja5pdxWUXsq1Rjwbtk2iqCVqfc86UxUR1MoDve+cPS89xql
         nn2VIVEqX2dHyhhxAPzniwL++7KqGBq55PCGLxeHpS2BAlWD+vK+a+8+thr3ALWYuTvy
         LeZqY7DfXIPJpd4e71wgsSnQka9EfDEBWpijkwkPPagJFUJT5R3ILoM/bE1OO6M2nLsX
         CJjQ==
X-Gm-Message-State: AHQUAubujbTdFgNRoTRlM0ZqayVqbMkuyCWo6HS05H/K6FVAL49Ed8qW
        rNAMR1Pb5QRNmJO+m62Kr8bzwY3K2XTGAiG0wRI=
X-Google-Smtp-Source: AHgI3IYN8elqX9P70nrpYCZYLUO6S82MGhTHuJ6q6DUjTR9zzPzwNcfkza2vUZF27M/BDOSAgrrmJytpwe3ijJuqV/E=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr28574050qvi.149.1550740897910;
 Thu, 21 Feb 2019 01:21:37 -0800 (PST)
MIME-Version: 1.0
References: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Feb 2019 10:21:20 +0100
Message-ID: <CAK8P3a2V+AYbXZC6zG6iJzOM3HugcB3Odx74jzVzSK4mfQ1Ftw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: compute false-positive -Wmaybe-uninitialized
 cases in Kconfig
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 5:14 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since -Wmaybe-uninitialized was introduced by GCC 4.7, we have patched
> various false positives:
>
>  - commit e74fc973b6e5 ("Turn off -Wmaybe-uninitialized when building
>    with -Os") turned off this option for -Os.
>
>  - commit 815eb71e7149 ("Kbuild: disable 'maybe-uninitialized' warning
>    for CONFIG_PROFILE_ALL_BRANCHES") turned off this option for
>    CONFIG_PROFILE_ALL_BRANCHES
>
>  - commit a76bcf557ef4 ("Kbuild: enable -Wmaybe-uninitialized warning
>    for "make W=1"") turned off this option for GCC < 4.9
>    Arnd provided more explanation in https://lkml.org/lkml/2017/3/14/903
>
> I think this looks better by shifting the logic from Makefile to Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I like how this cleans up the logic and documents it better.
I've had my own plans to move this (and most other conditional warning
options) into a header file using the KBUILD_WARN() infrastructure, but
never got around to doing that. I still think that's what we want eventually,
but in the meantime your patch seems fine as well.

Also, I see that your patch keeps the existing logic, which is good,
but we may want to refine this a little afterwards:

- we may want to turn off -Wuninitialized for gcc-4.6 and gcc-4.7
  instead of turning off -Wmaybe-uninitialized as we do in the later
  compilers.

- the proposed CC_OPTIMIZE_FOR_DEBUGGING may need the
  same workaround as CC_OPTIMZE_FOR_SIZE.

- For clang, we may want to /not/ turn off -Wmaybe-uninitialized
  in all cases. I haven't tried build with with 'clang -Oz
  -Wmaybe-uninitialized', but if the number of false positives is small
  enough, we could decide to just leave that on.

      Arnd
