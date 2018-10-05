Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70806C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287FE20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287FE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeJEQF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:05:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37885 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbeJEQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:05:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id x8-v6so7474799qka.4;
        Fri, 05 Oct 2018 02:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htNP80o6BBkOtuNFFZJZQK0NcflO1dHa27ZKc+DFtlY=;
        b=V+VUqgU+A6a1Who/eo20/iro81WutakcsXhrNbHe6ZviA9HZA49hXFGbLIhURgI7gP
         Ep4w5RX5oOfiA6tYSyQ3Nvxxrzn12PCKhrPakj0o7OlexLNEyfp3H68fiJoEMeeJyqLz
         iynMoc4zWtqQxZ34d4Seq1ph04BJMmSGMYQa2Gzp5LMTA7XQ8y/Gz4SDVq+bTIoivwfx
         ddEUj5N6IYOVBqj+VjAhoWhY/pwcuRK9Uu8GMH+IjlSCFYOneH2XKva+MLAlZYNc6zgK
         uBNo4j7cpmurtdpllY5EVU1Wb+EWhFpGSuHvc9XG/mkBO5bh0Xcw3UYQHjDXDRFB+5VP
         dJ3w==
X-Gm-Message-State: ABuFfoieUHc6hVAOG1h5bF/cu5jP/1JTAM74tdkwg7tFDOpsND/EAFC9
        MHjkdm7+5VQdiOmxRKaI66jfexsZZqG0NTiV755zPTPz
X-Google-Smtp-Source: ACcGV601ZG4AvOlThN+EwFM+w2bR5/QDt7Wf1unDCKmGLXcux14tUFlX4Vr0joafldSr6aEJQCztDf+Fy27YiJLC1xA=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr8397175qkc.291.1538730458842;
 Fri, 05 Oct 2018 02:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de> <08b190b9dabd4625ae3d636b88b43ccb@AcuMS.aculab.com>
In-Reply-To: <08b190b9dabd4625ae3d636b88b43ccb@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Oct 2018 11:07:22 +0200
Message-ID: <CAK8P3a0ZWfjGfpCRzoVw9vg=xg2ov2c7et_qTi5mzd81_RParQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kieran.bingham+renesas@ideasonboard.com,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:52 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arnd Bergmann
> > Sent: 05 October 2018 09:33
> >
> > Building any configuration with 'make W=1' produces a warning:
> >
> > kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]
> >
> > When also passing -Werror, this prevents us from building any
> > other files. Nobody ever calls the function, but we can't make
> > it 'static' either since we want the compiler output.
> >
> > Calling it 'main' instead however avoids the warning, because gcc
> > does not insist on having a declaration for main.
>
> Ugg.
> main() might be special in other ways too.
> It wouldn't surprise me if some linkers don't do special stuff for it.
>
> What is wrong with just putting and extra "void foo(void);" before
> the function?

Greg objected to that on the basis that we don't want declarations
in .c files -- they should be in a shared header:

https://lkml.org/lkml/2018/9/21/735

I don't see what could go wrong here with calling it main(), after
all we are just interested in the assembler output, not even
creating an object file.

      Arnd
