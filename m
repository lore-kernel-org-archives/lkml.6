Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A571DC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0420645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FHTklxlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E0420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeJSKtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:49:06 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:61551 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJSKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:49:05 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w9J2ihgD031942;
        Fri, 19 Oct 2018 11:44:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9J2ihgD031942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539917084;
        bh=jFzoDNXpRouDpJvSVxSA86hthnTUHuNXXrhH41uc38g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FHTklxlMvTqB2A9VjqOoXoq4blzbQRLHaB8jfDBlEepvt9sc5e0d8L9TsQa7YjK60
         7jUZKXbYhM2ca4lGquflCKf8PTQa95IalPZPaNBScHAOvT+PkpHG+jroT3NvGRB0g5
         5TIgb6woN7XPtu/IKdmI7gIbguB4uttN6Y/EuTdijj1PlTv74lclcuNV+YIou9WOoX
         wDMB5zfp/1J27p3ai7e2BKIJXKf2EeNqog9jefphNgHRaT1R2jpv58ffewkTWvl4Gh
         oM0EpJlgIuULgc8JjYizm+iyGPvWIW7PAwPFJiBI1HHBMVlwrQRiq2Z24dAFGnWK06
         C5I0cSRDUy5Xw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id e206so24458097vsd.0;
        Thu, 18 Oct 2018 19:44:43 -0700 (PDT)
X-Gm-Message-State: ABuFfogNF2IrdyRWIRcXlsvIxuWU9PV5SH9VxvUi1cLB7KhGNq1wSqaw
        u5CeDMCV7JdIuP9/TAHY6Vk6bk21b2K8zCRl/xs=
X-Google-Smtp-Source: ACcGV637J5DBRKupUo33kF0L0p/vUUwMrj8UAaR/q6VkgTh29o6txlTPzdidgZyfeQQ7648Abz/FPN8T99U89ooavrw=
X-Received: by 2002:a67:61c1:: with SMTP id v184mr13719509vsb.179.1539917082903;
 Thu, 18 Oct 2018 19:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000912.GA21339@WindFlash> <d3185020-b1aa-3eeb-b8e7-ecaefd624236@koikeco.de>
 <CADvQ+rGwns4nFjA8wMRC-mY69_Rr8wwdM8dezx0vpdjUymKqSQ@mail.gmail.com>
In-Reply-To: <CADvQ+rGwns4nFjA8wMRC-mY69_Rr8wwdM8dezx0vpdjUymKqSQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 11:44:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ58ZMjFmyNDNmtE+KaQE_LAqo1aRQ-4WpnUsgJSjNT6g@mail.gmail.com>
Message-ID: <CAK7LNAQ58ZMjFmyNDNmtE+KaQE_LAqo1aRQ-4WpnUsgJSjNT6g@mail.gmail.com>
Subject: Re: [Lkcamp] [PATCH 3/4] kbuild: Removes unnecessary shadowed local
 variable and optimize testing.
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc:     helen@koikeco.de, lkcamp@lists.libreplanetbr.org,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Matthew Wilcox <willy6545@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:04 AM Leonardo Bras <leobras.c@gmail.com> wrote:
>
> Hello Helen,
>
> On Wed, Oct 17, 2018 at 12:06 AM Helen Koike <helen@koikeco.de> wrote:
> >
> > Hi Leonardo,
> >
> > On 10/16/18 9:09 PM, Leonardo Br=C3=A1s wrote:
> > >     Removes an unnecessary shadowed local variable (start).
> > >     Optimize test of isdigit:
> > >     - If isalpha returns true, isdigit will return false, so no need =
to test.
> >
> > This patch does two different things, it should be in two separated pat=
ches.
> Sure, no problem.
>
> >
> > >
> > > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > > ---
> > >  scripts/asn1_compiler.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> > > index c146020fc783..08bb6e5fd6ad 100644
> > > --- a/scripts/asn1_compiler.c
> > > +++ b/scripts/asn1_compiler.c
> > > @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
> > >
> > >                       /* Handle string tokens */
> > >                       if (isalpha(*p)) {
> > > -                             const char **dir, *start =3D p;
> > > +                             const char **dir;
> > >
> > >                               /* Can be a directive, type name or ele=
ment
> > >                                * name.  Find the end of the name.
> > > @@ -454,10 +454,9 @@ static void tokenise(char *buffer, char *end)
> > >
> > >                               tokens[tix++].token_type =3D TOKEN_TYPE=
_NAME;
> > >                               continue;
> > > -                     }
> > > +                     } else if (isdigit(*p)) {
> > > +                             /* Handle numbers */
> >
> > Actually you can't do that, p is being altered in the first if statemen=
t.
>
> Yeah, you are right. I will remove this logic for v2.


I drop v1 from my tree.

Please send v2.


> >
> > >
> > > -                     /* Handle numbers */
> > > -                     if (isdigit(*p)) {
> > >                               /* Find the end of the number */
> > >                               q =3D p + 1;
> > >                               while (q < nl && (isdigit(*q)))
> > >
> >
> > Regards
> > Helen
>
> Thanks!
>
> Leonardo Br=C3=A1s



--=20
Best Regards
Masahiro Yamada
