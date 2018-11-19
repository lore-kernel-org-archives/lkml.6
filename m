Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEE120831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1BGXJv8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEE120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbeKTBGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:06:03 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:63360 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeKTBGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:06:02 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAJEg1XV012270
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:42:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAJEg1XV012270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542638522;
        bh=j1aPf8F41vVPMmV7/W9tnbbEBqVn32Tdwx98A0v9vn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1BGXJv8MxnZKAhSCkS63y3jClsRtMSnFUWioRyQvTlA7tcIVGKGP5uqqjFnPLhAsM
         JxUUKu3lDmKbLVirgElpLintzSpCI1EgGxpMc/5hdCAiQkcSYP/YKWNQsvHWZRRAAW
         xVChm7aCka3laK6YPyT/mO6KA7LhkzPy2v87Lnwq1nhiDSBolSzpZTgXZJwUlRboCx
         RDDlkmmQLpQCQz3jN9lSpt8Cmuy9xq/5C3SzZIFt5upsgETKh+6EEm2l6dABgMMYHr
         VNG4ooH/dzCPcD6rYxzCXDiK3GX4BsNAOadKLXYbpRbayBiJuzRP31X/olSp1jPz9y
         EVmlxUQRUe1pQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id z24so10745383ual.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:42:02 -0800 (PST)
X-Gm-Message-State: AGRZ1gLFSJK/HoPMvd0bIIpqAcy6V88kCj0PNNszX/eloy5g0wMEOWRv
        l3kDA8CH7gvilBrHYOzE4FNDLLhqfSagEtivLNI=
X-Google-Smtp-Source: AJdET5cnVVtUatsFCOvFqoJBg668GV+AXZZhMprzYCRv8FBxSE/5N0OgKbvJnQ6PPNbSiTZi2CaeqI76AhTYvGpJLSc=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr9835913uap.6.1542638521054;
 Mon, 19 Nov 2018 06:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20181114230856.30143-1-changbin.du@gmail.com> <20181119112935.txuwqdaitsmnowaj@mail.google.com>
In-Reply-To: <20181119112935.txuwqdaitsmnowaj@mail.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Nov 2018 23:41:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxuciujLq4iu4AaN17YyfVzzwTVdcZRamxEfFY8tA5Sg@mail.gmail.com>
Message-ID: <CAK7LNAQxuciujLq4iu4AaN17YyfVzzwTVdcZRamxEfFY8tA5Sg@mail.gmail.com>
Subject: Re: [PATCH v2] openrisc: make function cache_loop() inline
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 8:31 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi, Yamada,
> Could you add this patch to your kbuild tree? Horne already acked it.
>
> On Thu, Nov 15, 2018 at 07:08:56AM +0800, Changbin Du wrote:
> > The third operand of mtspr instruction must be a constant. To guarantee
> > this condition, function cache_loop() which uses macro mtspr() must be
> > inlined. So let's force it as 'inline'. This is to fix compiling error with
> > new option CONFIG_NO_AUTO_INLINE.
> >
> > In file included from arch/openrisc/mm/cache.c:17:0:
> > arch/openrisc/mm/cache.c: In function 'cache_loop':
> > arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
> >                               ^
> > arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
> >       mtspr(reg, line);
> >       ^~~~~
> > arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Acked-by: Stafford Horne <shorne@gmail.com>


Now applied to linux-kbuild.
Thanks!

> > ---
> >  arch/openrisc/mm/cache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> > index b747bf1fc1b6..4a4b2b6e006b 100644
> > --- a/arch/openrisc/mm/cache.c
> > +++ b/arch/openrisc/mm/cache.c
> > @@ -20,7 +20,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> >
> > -static void cache_loop(struct page *page, const unsigned int reg)
> > +static inline void cache_loop(struct page *page, const unsigned int reg)
> >  {
> >       unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
> >       unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> > --
> > 2.17.1
> >
>
> --
> Cheers,
> Changbin Du



-- 
Best Regards
Masahiro Yamada
