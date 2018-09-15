Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E8ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629642083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WUKKcbX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629642083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeIPAHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:07:08 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38171 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeIPAHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:07:07 -0400
Received: by mail-yw1-f68.google.com with SMTP id n21-v6so3954836ywh.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g+NDoAAXw55BR8VZSDzGJclroVrIxU3gFRKI/mQux+4=;
        b=WUKKcbX8K33tXJdWbs0us5Tm5vXgiX4nkh05iEfU45NOOAHkWbm6h9pb2Mpz8OavVX
         gEjgCI3woSkY7AgnqrOggZBMV2cxZmwDbOYa/vN9UJk865mu5ywnPkExZxKTE0YKFhvm
         Us0t44ppGdrcKhDN3Qo1lI2ygTy9nTGx//nIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g+NDoAAXw55BR8VZSDzGJclroVrIxU3gFRKI/mQux+4=;
        b=Jr6bxkBm+CB0zhOt5frI3sp/WHhgoMECVPZ8NXmbvqRivGIjnMHqtLEP3lFdiHlBuX
         sdmqP07tuU7qTDvhFYi4fpeR4QO9uiOvA9Q7tgr8sbfn3K3jW++O1DHVqIC/gcOwFW9e
         PBSwB8kyiQQMhGlgqM7HZbNxlhUFInc/xKcqRINJeWOiYkC9U0FdThtz2rqgve8K21Os
         suORfGoBgfMWrqjlkKy6iIV/dBGXqCAezPIftVXSGjKLC16f+dr47+BOg6GAywt4dvmR
         RseiXaunFgI1UkZnKm6EvgKau0kciqynlIoQ9mcy/jycwvR497os6FN/5XFV1K2/0VBH
         c4Zg==
X-Gm-Message-State: APzg51BUUTpQiOx9qPfUXpaKov7V0/gCCijgggzvJUzEGxJ5G6+2B3Gk
        DK6N6XRFQbYBgQbJEbOZqVcyNKW2oKk=
X-Google-Smtp-Source: ANB0VdbGyqZD3PLdWLZvNUnW9OpEd4ANK+JBISvd3HK71QTdvmOpPmpj3BiHSR6lXTdI9cKZtxGJMA==
X-Received: by 2002:a81:78d5:: with SMTP id t204-v6mr7848164ywc.340.1537037230743;
        Sat, 15 Sep 2018 11:47:10 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id m82-v6sm7587907ywm.19.2018.09.15.11.47.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 11:47:09 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id p206-v6so3951022ywg.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 11:47:08 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr7881864ywg.288.1537037228621;
 Sat, 15 Sep 2018 11:47:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sat, 15 Sep 2018 11:47:07
 -0700 (PDT)
In-Reply-To: <1533358023-5801-2-git-send-email-yamada.masahiro@socionext.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com> <1533358023-5801-2-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 15 Sep 2018 11:47:07 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK4aNuZ+RR4eC80yUQ2zxSoU9=ioaJBtt=VaX=_oZC=ew@mail.gmail.com>
Message-ID: <CAGXu5jK4aNuZ+RR4eC80yUQ2zxSoU9=ioaJBtt=VaX=_oZC=ew@mail.gmail.com>
Subject: Re: [PATCH 1/3] um: fix parallel building with O= option
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 9:47 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Randy Dunlap reports UML occasionally fails to build with -j<N> and
> O=<builddir> options.

With v4.19-rc2 I'm still seeing a failure (for any parallelism) under ARCH=um

$ make -j8 ARCH=um O=/tmp/foo
...
/home/kees/src/linux-build/um/Makefile:1185: *** Headers not
exportable for the um architecture.  Stop.

Am I missing something?

-Kees

-- 
Kees Cook
Pixel Security
