Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB384C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CE5214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RzIUlPcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CE5214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbeISMsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:48:17 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52397 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeISMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:48:17 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8J7BMcN016253
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 16:11:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8J7BMcN016253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537341083;
        bh=AdXMgsS/2eKg//oxA9wVNM44O0GXSuF6bCTKz5ofg0U=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RzIUlPcWZPu6xCOZib6Q8YbPCYWeT2wit/tg2fNIHkfJFU0aaMm/8ZNwtktz0tIGW
         k4FPKqyol8b8wEOmqrx0a78+R0JaTtmNYdb+N3LUk2Ha7YUz3LWiAb6nV4Xe3mj6ib
         +wkocX3kHXdYaHTTacALJsM7L4NmkdVr8CIIKg4oVw5olHxEf/7QBAVFYcw94T36xE
         H4I/NrM0nGyDUAehF1RGKRDHsfzfaHVsimKjIvDvK1CbeimT9Fhh6DR6FWd6maj85a
         LyDNugdFYNXWgKuKKWliXi3rfzN+4cc9sXcHEyIMp0smpAt9kvOIpL3U+9fufXB86Q
         VRAkAWRYVN3zQ==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id x198-v6so1461412vsx.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:11:22 -0700 (PDT)
X-Gm-Message-State: APzg51DDibCiPZdcxIx/TA2ov1wzNA1c5ivnaFPbliE1+xk2e3a8pOSY
        qA6M23msXJ5cWWVpYCv0VRihxkTEhyBBDqE3HBU=
X-Google-Smtp-Source: ANB0VdY72gv53e1qBiapuA2Qp5nd+/aMonN4NGl6jut/JEB1qIP5YpR2onme16SaMUw3jiTiyCTvwuRbfo+oxYQ+/ZY=
X-Received: by 2002:a67:cd07:: with SMTP id u7-v6mr10296122vsl.78.1537341081737;
 Wed, 19 Sep 2018 00:11:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 00:10:41
 -0700 (PDT)
In-Reply-To: <20180918230002.GA7572@WindFlash>
References: <20180918230002.GA7572@WindFlash>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Sep 2018 16:10:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCai6rPV-ibbKKzm94pr=5Ku_K3r1LY80BGngJWU73FQ@mail.gmail.com>
Message-ID: <CAK7LNASCai6rPV-ibbKKzm94pr=5Ku_K3r1LY80BGngJWU73FQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: Optimize tests and remove shadowed local variable.
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FW: David Howells


2018-09-19 8:00 GMT+09:00 Leonardo Br=C3=A1s <leobras.c@gmail.com>:
> Removes an unnecessary shadowed local variable (start).
> Optimize test of isdigit:
> - If isalpha returns true, isdigit will return false, so no need to test.
>
> Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>


This patch was sent to me, but maybe belong to David's field.

David, will you take care of this patch?

https://lore.kernel.org/patchwork/patch/988171/

I think the commit subject should be changed kbuild: -> ASN.1:


Anyway, this patch looks trivial,
FWIW

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>





> ---
>  scripts/asn1_compiler.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> index c146020fc783..a0056df4e358 100644
> --- a/scripts/asn1_compiler.c
> +++ b/scripts/asn1_compiler.c
> @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
>
>                         /* Handle string tokens */
>                         if (isalpha(*p)) {
> -                               const char **dir, *start =3D p;
> +                               const char **dir;
>
>                                 /* Can be a directive, type name or eleme=
nt
>                                  * name.  Find the end of the name.
> @@ -454,10 +454,10 @@ static void tokenise(char *buffer, char *end)
>
>                                 tokens[tix++].token_type =3D TOKEN_TYPE_N=
AME;
>                                 continue;
> -                       }
>
> -                       /* Handle numbers */
> -                       if (isdigit(*p)) {
> +                       } else if (isdigit(*p)) {
> +                               /* Handle numbers */
> +
>                                 /* Find the end of the number */
>                                 q =3D p + 1;
>                                 while (q < nl && (isdigit(*q)))
> --
> 2.19.0
>



--=20
Best Regards
Masahiro Yamada
