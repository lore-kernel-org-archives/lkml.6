Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37234C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C572086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfBTJTv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:19:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42451 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:19:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id y140so1544787qkb.9;
        Wed, 20 Feb 2019 01:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7a5F13liLEOhjFNUYGlZ0v2uhiDPuINa7zw+6Y8frSM=;
        b=iROG2/Q+8u+jln/bsV2NqP2M72yNaCmT1HggXwpZJxTBKGItSv/cxOI0jsKTMZqyvs
         xmPkVCm9JuUhPPj+3ORuQxMUr39P9EjqqJm/PJEgnfNmCM6ratlecVnZkcMfzF7OquC4
         vW3+RlqCk6b9mIfYYKriW5KfegrknWJgHi7Leq1hA8jKdQYa3qT/1eS3Mb0Ho31fza94
         5o22GjcFsapwqhZ8r9YJQaenVuRUhi7rkwnDfAq9ohOwB57FE8aFsylRtHs5lRtGKnJz
         r3fHgHAFz1U8FUSU/yaVs/E9CM37ZLD4jz8JIHdRkLKY04R8nPoHbPli+CplOl2xmuwB
         sBtA==
X-Gm-Message-State: AHQUAuZ5aLLYcfzra9JJDikJOCmgldvd/5fcDXNDVtwWml+UvpBVqNAv
        DZd0ZQAmg2n7oeulNeqz4xwNrlS9AR0073mMXVg=
X-Google-Smtp-Source: AHgI3IYa3AJfX3Zj+6sBmh0cqWcQrteyxtF3OTbXY5ZzX36EJSpKWR1pz8RWSp8NxOSPWuhlyqS5kuGwMkRY5zwvzsw=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr24251989qki.291.1550654390340;
 Wed, 20 Feb 2019 01:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <1550614664.6911.45.camel@lca.pw>
 <CAKwvOdn+MJxYc+ykvyf-WhEzzDn0zEusjpQuksknnf8bPb=Q6g@mail.gmail.com>
 <CAN=P9pgC8EzawtxMzp6d3AsMPkSpTd0Ry6j+Jn+YgC_XP2Fd_w@mail.gmail.com> <CACT4Y+ZxCs57qkO7n5tYU4v-J6E9MZsT_FLbXwbQ=B5btHTmwQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZxCs57qkO7n5tYU4v-J6E9MZsT_FLbXwbQ=B5btHTmwQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 10:19:33 +0100
Message-ID: <CAK8P3a0s7VSHENsygwby1OtQWtYBeNiCdowPkbo55_-TbyhxbA@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Kostya Serebryany <kcc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 7:44 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Feb 20, 2019 at 1:34 AM Kostya Serebryany <kcc@google.com> wrote:
> >
> > On Tue, Feb 19, 2019 at 2:43 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > + Evgenii, Kostya for KASAN
> > >
> > > On Tue, Feb 19, 2019 at 2:17 PM Qian Cai <cai@lca.pw> wrote:
> > > >
> > > > On Tue, 2019-02-19 at 22:49 +0100, Arnd Bergmann wrote:
> > > > > Building an arm64 allmodconfig kernel with clang results in over 140 warnings
> > > > > about overly large stack frames, the worst ones being:
> > > > >
> > > > > drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size
> > > > > of 20224 bytes in function 'st7789v_prepare'
> > > > > drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12:
> > > > > error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
> > > > > drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes
> > > > > in function 'max3421_spi_thread'
> > > > > drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes
> > > > > in function 'slic_ds26522_probe'
> > > > > drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in
> > > > > function 'ccp_run_cmd'
> > > > > drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840
> > > > > bytes in function 'stv0367ter_algo'
> > > > >
> > > > > None of these happen with gcc today, and almost all of these are the result
> > > > > of a single known bug in llvm.  Hopefully it will eventually get fixed with
> > > > > the
> > > > > clang-9 release.
> >
> > I am not confident we can fix this in clang.
> > The difference between gcc and clang, AFAICT, is not in the asan
> > instrumentation, but in inining.
> > Looking at the reproducer from https://bugs.llvm.org/show_bug.cgi?id=38809#c4,
> > if I change ltv350qv_write_reg to always inline, gcc also produces a
> > huge 10K stack frame,
> > and making it noinline fixes the stack frame for both gcc and clang.
>
> Does your gcc have fix for https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 ?
>
> For me gcc rejects to inline it:
>
> gcc version 7.3.0 (Debian 7.3.0-5)
>
> $ gcc /tmp/test.c -Wframe-larger-than=128 -c -fsanitize=kernel-address
> -O2 --param asan-stack=1
> /tmp/test.c:23:13: warning: always_inline function might not be
> inlinable [-Wattributes]

I don't see that warning here

>  static void ltv350qv_write_reg(void) {
>              ^~~~~~~~~~~~~~~~~~
> /tmp/test.c: In function ‘ltv350qv_power_on’:
> /tmp/test.c:57:1: warning: the frame size of 416 bytes is larger than
> 128 bytes [-Wframe-larger-than=]
>  }

but I also see the small stack size here: https://godbolt.org/z/Uz5Ruv

gcc definitely inlines the function here but only has one copy of
spi_message and spi_transfer on the stack, while clang inserts
a call to __asan_report_store8_noabort() and has one copy per
inlined call to ltv350qv_write_reg().

      Arnd
