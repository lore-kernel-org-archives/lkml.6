Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A3CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37FF21104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TstsiSgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37FF21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeKTMAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:00:07 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:25488 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:00:06 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAK1XGJm000409
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:33:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAK1XGJm000409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542677597;
        bh=PwZNHY2T5e6fraX8J2a9TUhGJWKSVLwRTSBfNlG6ytg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TstsiSgr5RcClFrqlgD2V6RQMUMJE5EOJRD3VCEbVWep9zCPedl8s6fh/vOW7TIBC
         8kRSIA1asoaLLoKH8K06iGL2+QwsR/LpkRMPFIx7oBr+a1IwNA8mjOi49PUYhenQpj
         2Ex7IT2njVklGqXRQXzh2GpUJpMXUOcrnAnldb+GzcWgj8PiVkCNmSzNaYdaVLe2KI
         fm0Fx93/DXpgLPKyPodLIQ9S3hgLzWpQHAclc4UMgyG/n7tChhdfBV4WJEmj1KY6VO
         QUwLgO2GEPIkPTf6JtrxTEBhvf84X8t8eCkpvxaYVWTOGu9iH6VwkDNnJ9qpzgICLu
         NSoHZDvrShzbQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id h18so160413vsj.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 17:33:17 -0800 (PST)
X-Gm-Message-State: AA+aEWa15m5m7XiRDQTMnTSDFIFbfSIqsfhkntBivMzsUIGxK/+vNEta
        55hgvm/JT26OmXSCFF0YiAgLFwV+MAw0vuoQMZ8=
X-Google-Smtp-Source: AJdET5dOcPw1L0UNgTRUlEbS1rA4UtcvjU2gszXln07Q9nI7Z+EftfihQFD1qjMEhqC6fMDmE1W5TsuQUGx7SApxHTI=
X-Received: by 2002:a67:485:: with SMTP id 127mr28319vse.54.1542677596203;
 Mon, 19 Nov 2018 17:33:16 -0800 (PST)
MIME-Version: 1.0
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com> <20181119123334.6xr23ok4uy5cflzy@ltop.local>
In-Reply-To: <20181119123334.6xr23ok4uy5cflzy@ltop.local>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 20 Nov 2018 10:32:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrYp1KYe9GveVYz1oOj2_O5TXE368kKvSY2ASAYBeoKg@mail.gmail.com>
Message-ID: <CAK7LNARrYp1KYe9GveVYz1oOj2_O5TXE368kKvSY2ASAYBeoKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] compiler_types.h: make __builtin_types_compatible_p()
 noop for Sparse
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 9:35 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Nov 19, 2018 at 07:31:41PM +0900, Masahiro Yamada wrote:
> > When I tried to delete BUILD_BUG_ON stubs for sparse, the kbuild test
> > robot reported lots of Sparse warnings from container_of(), which
> > seem false positive.
> >
> > The following checker in container_of() seems to be causing something
> > strange for Sparse.
> >
> >   BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
> >                    !__same_type(*(ptr), void),                    \
> >                    "pointer type mismatch in container_of()");    \
> >
> > I narrowed down the problem into the following test code:
> >
> >   --------------------(test_code.c begin)--------------------
> >   struct foo {
> >           int (*callback)(void);
> >   };
> >
> >   void assert(int);
> >
> >   static inline struct foo *get_foo(void)
> >   {
> >           assert(__builtin_types_compatible_p(void, void));
> >
> >           return (struct foo *)0;
> >   }
> >
> >   int test(void);
> >   int test(void)
> >   {
> >           return get_foo()->callback();
> >   }
> >   ---------------------(test_code.c end)---------------------
> >
> > Of course, GCC (and Clang as well) can compile it:
> >
> >   $ gcc -Wall -c -o test_code.o test_code.c
> >
> > However, Sparse complains about this obviously correct code:
> >
> >   $ sparse test_code.c
> >   test_code.c:9:45: warning: unknown expression (4 0)
> >   test_code.c:9:51: warning: unknown expression (4 0)
> >
> > Interstingly, just removing the 'inline' keyword in the test code
> > makes Sparse happy.
> >
> > I concluded that Sparse cannot handle __builtin_types_compatible_p()
> > correctly.
>
> I think it's only caused by comparing 'void' (which is never
> an l-value).
> I'll investigate. Thanks for the small test-case.


Yes, please.


> > Make it no-op.
>
> ...
>
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 4a3f9c0..9e7da0b 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -23,6 +23,7 @@
> >  extern void __chk_user_ptr(const volatile void __user *);
> >  extern void __chk_io_ptr(const volatile void __iomem *);
> >  # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
> > +# define __builtin_types_compatible_p(t1, t2)        (1)
>
> Now, BUILD_BUG_ON() becomes a no-op for sparse but all the other usages
> of __builtin_types_compatible_p() become potentially wrong and can now
> create their onw false warnings.

You are right.
This patch is probably a bad idea.


Thanks.


-- 
Best Regards
Masahiro Yamada
