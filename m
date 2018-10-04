Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD03121470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD03121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJDQHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:07:07 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39943 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeJDQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:07:07 -0400
Received: by mail-vs1-f66.google.com with SMTP id z130-v6so4933776vsc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVgNjryuYaHEROzjKlMjFdkmMkKjiB1Z+5pPT/j+3UI=;
        b=aEPxs2qzG5MMqYiiuXLN4/plNn0kXo2ZDisNRJ0rcF1CBL5dQurWMcmqPPEeSICezN
         2Le2xAmyDZr4BthDny4HQsOQh23byrajhZfqPw4pRYSisV/FWJkswQPgsAmLLkWeSoAz
         dTUGnbL5k6hCkAejd79jlCI6xCgQ8TiowygHWdAYJgcohjA0rVttPZu3yFeSrmd+KKc/
         5U9Mc3UaXi3ZkVF/EfcWoiTHo7nLPsUspG8CeIcRBMP1vAH0QXprVKizcLgB7UhF05K7
         kWUTUrMpPMKgR/ib7vKj3zKMz8GF/nTtoXcvDVAbj+Qjusc29UyI9FFDU7GEhuvVktI/
         KmEg==
X-Gm-Message-State: ABuFfojy1q/2ctsD1tMNg5IFwaR3QaS88DC2/jGQzqirjAvscXNNzLfr
        bWjwBeZ2OmwcLakKWOjKQOFaLJPiuuk3lLMUmtk=
X-Google-Smtp-Source: ACcGV6050K7a4OCceP7Q5BEaBxMluu01m6ebcGv6+UbyyYVYYB9cFE/yJ3ZETo2VHlLhMUrZWVNmGch1UEsYEY1ubLk=
X-Received: by 2002:a67:7b56:: with SMTP id w83mr832115vsc.152.1538644487546;
 Thu, 04 Oct 2018 02:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com> <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com>
In-Reply-To: <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Oct 2018 11:14:35 +0200
Message-ID: <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     maksym.kokhan@globallogic.com, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, andrew.bordunov@gmail.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 10:38 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 10/3/2018 8:23 PM, Maksym Kokhan wrote:
> > CONFIG_BUILTIN_DTB selection is duplicated in menu
> > "Machine selection" under MIPS_MALTA.
> >
> > Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> > Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> > Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> > ---
> >   arch/mips/Kconfig | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 3551199..71d6549 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -539,7 +539,6 @@ config MIPS_MALTA
> >       select USE_OF
> >       select LIBFDT
> >       select ZONE_DMA32 if 64BIT
> > -     select BUILTIN_DTB
> >       select LIBFDT
>
>     LIBFDT seems duplicated too.

Using random sort order doesn't help. Keep them sorted, please?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
