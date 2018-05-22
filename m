Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeEVOX5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:23:57 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:23277 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeEVOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:23:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4MENpY1020891
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: AB8JxZp9wxd5ddGMCfpD3DdlajxGDq2girk55VteWLR/nYezbioCUEn9KnJnFR/OJk6Lk026PwEm5ptnAbS9BBqA24k=
MIME-Version: 1.0
In-Reply-To: <1526885939-1741-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1526885939-1741-1-git-send-email-Julia.Lawall@lip6.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 23:23:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYEGuBvDDyFG98dZPb2nT+Us1w0_Y6dDjG17SK9XyLCA@mail.gmail.com>
Message-ID: <CAK7LNATYEGuBvDDyFG98dZPb2nT+Us1w0_Y6dDjG17SK9XyLCA@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: deref_null: improve performance
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-21 15:58 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> Move rules looking for some special cases of safe dereferences before
> the collection of NULL-tested values.  The special cases are fairly
> rare, but somewhat costly to find, because isomorphisms create many
> variants of the rules.  There is thus no need to search for them over
> and over for each NULL tested expression.  Collecting them just once
> is sufficient and more efficient.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  scripts/coccinelle/null/deref_null.cocci |   40 +++++++++++++++----------------
>  1 file changed, 20 insertions(+), 20 deletions(-)


Applied to linux-kbuild. Thanks!


> diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle/null/deref_null.cocci
> index b16ccb7..cbc6184 100644
> --- a/scripts/coccinelle/null/deref_null.cocci
> +++ b/scripts/coccinelle/null/deref_null.cocci
> @@ -14,18 +14,10 @@ virtual context
>  virtual org
>  virtual report
>
> -@ifm@
> -expression *E;
> -statement S1,S2;
> -position p1;
> -@@
> -
> -if@p1 ((E == NULL && ...) || ...) S1 else S2
> -
>  // The following two rules are separate, because both can match a single
>  // expression in different ways
>  @pr1 expression@
> -expression *ifm.E;
> +expression E;
>  identifier f;
>  position p1;
>  @@
> @@ -33,7 +25,7 @@ position p1;
>   (E != NULL && ...) ? <+...E->f@p1...+> : ...
>
>  @pr2 expression@
> -expression *ifm.E;
> +expression E;
>  identifier f;
>  position p2;
>  @@
> @@ -46,6 +38,14 @@ position p2;
>   sizeof(<+...E->f@p2...+>)
>  )
>
> +@ifm@
> +expression *E;
> +statement S1,S2;
> +position p1;
> +@@
> +
> +if@p1 ((E == NULL && ...) || ...) S1 else S2
> +
>  // For org and report modes
>
>  @r depends on !context && (org || report) exists@
> @@ -212,16 +212,8 @@ else S3
>  // The following three rules are duplicates of ifm, pr1 and pr2 respectively.
>  // It is need because the previous rule as already made a "change".
>
> -@ifm1 depends on context && !org && !report@
> -expression *E;
> -statement S1,S2;
> -position p1;
> -@@
> -
> -if@p1 ((E == NULL && ...) || ...) S1 else S2
> -
>  @pr11 depends on context && !org && !report expression@
> -expression *ifm1.E;
> +expression E;
>  identifier f;
>  position p1;
>  @@
> @@ -229,7 +221,7 @@ position p1;
>   (E != NULL && ...) ? <+...E->f@p1...+> : ...
>
>  @pr12 depends on context && !org && !report expression@
> -expression *ifm1.E;
> +expression E;
>  identifier f;
>  position p2;
>  @@
> @@ -242,6 +234,14 @@ position p2;
>   sizeof(<+...E->f@p2...+>)
>  )
>
> +@ifm1 depends on context && !org && !report@
> +expression *E;
> +statement S1,S2;
> +position p1;
> +@@
> +
> +if@p1 ((E == NULL && ...) || ...) S1 else S2
> +
>  @depends on context && !org && !report exists@
>  expression subE <= ifm1.E;
>  expression *ifm1.E;
>



-- 
Best Regards
Masahiro Yamada
