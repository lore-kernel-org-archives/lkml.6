Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB3BC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AD020831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RqzDupv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AD020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeJ2BXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:23:45 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60784 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeJ2BXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:23:45 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9SGcKii003293;
        Mon, 29 Oct 2018 01:38:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9SGcKii003293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540744701;
        bh=6wTfhA8jd4V+D+sd2TOi97MoDVj3C650L3WDPK86rR8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RqzDupv4xhqMicdpSwEmD42C0UJmnOSphNHpJQifdHmKXEofq8HSVU19jhFpAS607
         YNXHm9C8NTVutslWMKo2AD7iQ1gYmbnuftJH44PXr4crGejcOpF4uyuX/vdSposWfL
         IAXc4jwADM3jl9OjBZr9QcTCbkwIxK4YAO+1KSOn3cNsBgb4+20DgWT1YgMSIJ6Khl
         +nrDhYmPuw/Uk9naGUlt4F547Xw5tgD0hagqbQKZF37ydRdqaw8wS8XGwL5wSQWZyx
         5tA2fXH3IDtzZS1IKNqtHe8AwTwaTsC3I5pFF1fbR3nl2ZIFImE7jm0kSO3+K52kzq
         9XDoMHNvgj/Pw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id s9so3387259vsk.7;
        Sun, 28 Oct 2018 09:38:21 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKAUU7mGTsnIz1iVX3gd1RyhO5s6YnEIUrPNDa5i2pXGCvS5vHl
        2MXgzeAsrgqHWlq97hdm9ZSPWy7gpxH1fTjVsVk=
X-Google-Smtp-Source: AJdET5dpCyylxysSi5hNJDdUoxQYZDnNkx0peLEtINb8K0mNZiHni5VhLCwVb46mOdy6QZt8uA2EQz49Ibz0HqGE/5c=
X-Received: by 2002:a67:385a:: with SMTP id f87mr4732325vsa.179.1540744700386;
 Sun, 28 Oct 2018 09:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181023011042.GA6582@WindFlash>
In-Reply-To: <20181023011042.GA6582@WindFlash>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 01:37:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4uJiR8Nm1agBQwjGFDY81_7O0o6fxuqh=55WizwvhYQ@mail.gmail.com>
Message-ID: <CAK7LNAT4uJiR8Nm1agBQwjGFDY81_7O0o6fxuqh=55WizwvhYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Creates macro to avoid variable shadowing
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:11 AM Leonardo Br=C3=A1s <leobras.c@gmail.com> w=
rote:
>
> Creates DEF_FIELD_ADDR_VAR as a more generic version of the DEF_FIELD_ADD
> macro, allowing usage of a variable name other than the struct element na=
me.
> Also, sets DEF_FIELD_ADDR as a specific usage of DEF_FILD_ADDR_VAR in whi=
ch
> the var name is the same as the struct element name.
>
> Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> ---


Applied to linux-kbuild.



>  scripts/mod/file2alias.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7be43697ff84..3015c0bdecb2 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -95,12 +95,20 @@ extern struct devtable *__start___devtable[], *__stop=
___devtable[];
>   */
>  #define DEF_FIELD(m, devid, f) \
>         typeof(((struct devid *)0)->f) f =3D TO_NATIVE(*(typeof(f) *)((m)=
 + OFF_##devid##_##f))
> +
> +/* Define a variable v that holds the address of field f of struct devid
> + * based at address m.  Due to the way typeof works, for a field of type
> + * T[N] the variable has type T(*)[N], _not_ T*.
> + */
> +#define DEF_FIELD_ADDR_VAR(m, devid, f, v) \
> +       typeof(((struct devid *)0)->f) *v =3D ((m) + OFF_##devid##_##f)
> +
>  /* Define a variable f that holds the address of field f of struct devid
>   * based at address m.  Due to the way typeof works, for a field of type
>   * T[N] the variable has type T(*)[N], _not_ T*.
>   */
>  #define DEF_FIELD_ADDR(m, devid, f) \
> -       typeof(((struct devid *)0)->f) *f =3D ((m) + OFF_##devid##_##f)
> +       DEF_FIELD_ADDR_VAR(m, devid, f, f)
>
>  /* Add a table entry.  We test function type matches while we're here. *=
/
>  #define ADD_TO_DEVTABLE(device_id, type, function) \
> @@ -641,25 +649,27 @@ static void do_pnp_card_entries(void *symval, unsig=
ned long size,
>         unsigned int i;
>
>         device_id_check(mod->name, "pnp", size, id_size, symval);
> +       DEF_FIELD_ADDR(symval, pnp_card_device_id, devs);
> +       typeof(devs) devs_last;
>
>         for (i =3D 0; i < count; i++) {
>                 unsigned int j;
> -               DEF_FIELD_ADDR(symval + i*id_size, pnp_card_device_id, de=
vs);
> +               devs_last =3D devs + i * id_size;
>
>                 for (j =3D 0; j < PNP_MAX_DEVICES; j++) {
> -                       const char *id =3D (char *)(*devs)[j].id;
> -                       int i2, j2;
> +                       const char *id =3D (char *)(*devs_last)[j].id;
> +                       int j2;
>                         int dup =3D 0;
>
>                         if (!id[0])
>                                 break;
>
>                         /* find duplicate, already added value */
> -                       for (i2 =3D 0; i2 < i && !dup; i2++) {
> -                               DEF_FIELD_ADDR(symval + i2*id_size, pnp_c=
ard_device_id, devs);
> +                       while ((devs_last -=3D id_size) >=3D devs && !dup=
) {
>
>                                 for (j2 =3D 0; j2 < PNP_MAX_DEVICES; j2++=
) {
> -                                       const char *id2 =3D (char *)(*dev=
s)[j2].id;
> +                                       const char *id2 =3D
> +                                               (char *)(*devs_last)[j2].=
id;
>
>                                         if (!id2[0])
>                                                 break;
> --
> 2.19.1
>


--=20
Best Regards
Masahiro Yamada
