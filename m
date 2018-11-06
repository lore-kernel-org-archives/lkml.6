Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763A3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D142081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="fh2SwPwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D142081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbeKGAzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:55:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39624 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbeKGAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:55:36 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so405673qtl.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLwoVVb0vdb+k7Wj3hDL/gN5lfWGYvzdtPiYZHIl41E=;
        b=fh2SwPwfZv2CexklQmNGOLyybQM6hyTe7CTMcRH7FVaLbF5V5DkHz/HUY0HDUPSMPJ
         nR1gdtl0+Oj7lXrYu375cn+Rz4YXIrGvdx5R28YCsqgBsvDQm6yj72CRi/7tPlxCoRLR
         FUQawRddVWE/woFqCNKEZogln2hK8Itvz4q5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLwoVVb0vdb+k7Wj3hDL/gN5lfWGYvzdtPiYZHIl41E=;
        b=D6CK10ezznurlbn8j8AoGyJfv/L1CQ1mMJ3t9S7f4kFcqc47DlwGCSpDGh6cXHemn8
         OhEDInuFTnfOJpXehf+4acZv0paodeE8Seyf8ngBvs9nSb5EwwFB4tpo9AirA9OCpcks
         qxci41ubmd20ZJ3EK66nadhLmjMY4R4Jdc7CqG3KhuEHUCkL6gpIgHfD0bSSJ7WWmmgE
         BB6UBgSCXeXKSLev+kS+4ijX8qeOg50RF4bQSaiQkrHh8Q/JxwMYyMLcHlg52pHPjNWi
         pCXoLeeTGMuDDk9qe+i4gRC+AfMHBzxkgN5eSi6EQX4q9UKaFS3QdAWrOvL2MiQVQbTE
         m1Qw==
X-Gm-Message-State: AGRZ1gJO7SCFMShFWE34e9Exeq8zU+QSmDQSPrJLDoJEyk/CIO1hybbO
        gQQsbio+SRYH/+/3eyJMbjVQtQEm8xR5QvZO6yH/tA==
X-Google-Smtp-Source: AJdET5c94s+Zb+yrg0xu6oaM2qDRnSywjXiafK9ovnA3zif3V3+huIotKaZheoMOLfcPpsRR9P5qzyyWG2kqvw+Vpuc=
X-Received: by 2002:ac8:1c50:: with SMTP id j16mr26922584qtk.320.1541518191320;
 Tue, 06 Nov 2018 07:29:51 -0800 (PST)
MIME-Version: 1.0
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
 <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com> <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
 <CAMT6-xhP=2wjsKJFumKUsUGVL6U_BynMv6RE0cxXgk6cyfjJkw@mail.gmail.com>
In-Reply-To: <CAMT6-xhP=2wjsKJFumKUsUGVL6U_BynMv6RE0cxXgk6cyfjJkw@mail.gmail.com>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Tue, 6 Nov 2018 17:29:40 +0200
Message-ID: <CAMT6-xji=XrteXm6KbUYLiKqSH_-RHzXzwn3zi5hYbtq_R_sRg@mail.gmail.com>
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
To:     geert@linux-m68k.org
Cc:     sergei.shtylyov@cogentembedded.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 3:06 PM Maksym Kokhan
<maksym.kokhan@globallogic.com> wrote:
>
> On Thu, Oct 4, 2018 at 12:14 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > On Thu, Oct 4, 2018 at 10:38 AM Sergei Shtylyov
> > <sergei.shtylyov@cogentembedded.com> wrote:
> > > On 10/3/2018 8:23 PM, Maksym Kokhan wrote:
> > > > CONFIG_BUILTIN_DTB selection is duplicated in menu
> > > > "Machine selection" under MIPS_MALTA.
> > > >
> > > > Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> > > > Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> > > > Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> > > > ---
> > > >   arch/mips/Kconfig | 1 -
> > > >   1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > > index 3551199..71d6549 100644
> > > > --- a/arch/mips/Kconfig
> > > > +++ b/arch/mips/Kconfig
> > > > @@ -539,7 +539,6 @@ config MIPS_MALTA
> > > >       select USE_OF
> > > >       select LIBFDT
> > > >       select ZONE_DMA32 if 64BIT
> > > > -     select BUILTIN_DTB
> > > >       select LIBFDT
> > >
> > >     LIBFDT seems duplicated too.
> >
> > Using random sort order doesn't help. Keep them sorted, please?
>
> We are going to deal with it in the separate patch.

Is it OK to leave this patch as it is and make another patch/patches
for other changes or it would be better to modify it to remove
duplication of LIBFDT too and sort this list of configs?

--
Regards,
Maksym Kokhan
