Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828CAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358A22661C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358A22661C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeFZHg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:36:29 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35848 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeFZHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:36:28 -0400
Received: by mail-ua0-f193.google.com with SMTP id n10-v6so848282uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4YYZZNDubcA62SOhgOG2KWBQsvVz6hv3RzZpHbD6bs=;
        b=Qe1i4i6zAOqhDFcjwEZFjKMDWydB7oLZCElfLNYCveJc6UIy8yWB+9ok0LnVpEmJKp
         7e5HCScn4cVPrtEtowPmtzvj1a84Vy49wVH88NrJjLOz/fcD8q/S9cAMsz4Q7byR+YTA
         cnWll4NtHfBUBmg9HLdJm7tLNjUjabfbx01wAPAO1PFnq+qyR4nn/3u+g5wPHXayebLD
         9DTL5a+C251GpWZLTpsUR7tUnCy1VCdwTH2XTeDsYG1uvsjLY9FQR+XL0bhnR09YVpL8
         BkQ3xZJjjyubzeCyRYZ2aTj8+NTfNv0znnNMAzfnMTfaH7ccvvebChPhu8ACG9n5+Xf5
         uULA==
X-Gm-Message-State: APt69E3jBL9SJF9cZ3b9ojoPdhjZMFAsHNS0jl68iitrgKeXiAwH7BtU
        LTbxO+EYaEQuNO9QS5Hgdq3v1gS3iLI7o+Wg/h0=
X-Google-Smtp-Source: AAOMgpexrFd84ucSrDppBKvacfxj/J59GPfkQGpTe44B5btW6JO3z5QncwfyPPi1BPUuiSbnMlV5hnUViWs7G3S4e9Q=
X-Received: by 2002:ab0:5922:: with SMTP id n31-v6mr267048uad.114.1529998587652;
 Tue, 26 Jun 2018 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180621185442.17086-1-geert@linux-m68k.org> <CACRpkdbCBO3mgPm3czUvBMqrFHvxDqkmfKH9v2X0UMypjjOe_g@mail.gmail.com>
In-Reply-To: <CACRpkdbCBO3mgPm3czUvBMqrFHvxDqkmfKH9v2X0UMypjjOe_g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jun 2018 09:36:16 +0200
Message-ID: <CAMuHMdVQtCh-qbD+ne_iL2tfgwiEN41B_3Eva8-Sg06BhT5PSw@mail.gmail.com>
Subject: Re: [PATCH] w1: Allow compile test of GPIO consumers if !GPIOLIB
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Jun 26, 2018 at 9:34 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 21, 2018 at 8:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> > not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> > functionality only, can still be compiled if GPIOLIB is not enabled.
> >
> > Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> > appropriate.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> > ---
> > v3:
> >   - Add Acked-by,
>
> I think my last change to w1 I just put into the GPIO tree.
>
> Should I simply carry this patch in the GPIO tree?

Fine for me ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
