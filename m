Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B4ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35472151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35472151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJQQxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:53:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46059 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJQQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:53:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id m8-v6so15970977qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 01:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2ZYBizhZZZdKFcPGR4+xoM96vAX9n/aBi8/fwI1XUU=;
        b=tS8TA88Zji3+nA9ySDohq+hNTAJlhmCQi6AKhMqXoC9J+tXcHVVSArBgWazfKDS5wk
         sb8D47xS2adHDVIZU5CX4svusjjJIL78jHTUppfdr4OuiPs/qWedOoh72Rr1pOgMoIXP
         q9ZaUUTND/bRETpMGTbVtChUSrFbfwXtzpHUlMIlEkKm9sX3CNmy0zUsVHq1+MCmtdF6
         tsswempvlnsfRY/kCsNvjK/Kw5LydEadXITy1hu1xMEQAlAy3d9PIwEeKCXhh1HdmZxt
         /k+h+dDw79chfIkyW8Uv2bMNlWkmIpBdIUYScgxOVK679lj77ckwTThe9YDkOUAHe+tt
         ikTg==
X-Gm-Message-State: ABuFfoi0fsYAxVesAm+6mOaLhQkzzkrQfx/44cv/RSnm5rdr/wd74Mlk
        nrJR2OgQL+DkZJRxRcIc/DyCkuDt2LI1sayH3f8=
X-Google-Smtp-Source: ACcGV63juRDNf59ghV+nhHu1iWpZCE9DJqJwq0aDQhzw1BvOMmKh6JGWZ7osXeC2h9GmFSAOa6ps8QuWJCpAcB4Iuto=
X-Received: by 2002:a37:4116:: with SMTP id o22-v6mr22539285qka.107.1539766750657;
 Wed, 17 Oct 2018 01:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181015221629.13924-1-stefan@agner.ch> <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk> <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 10:58:53 +0200
Message-ID: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands list
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roman Yeryomin <roman@advem.lv>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:43 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 16 Oct 2018, Russell King - ARM Linux wrote:
> > On Tue, Oct 16, 2018 at 10:00:19AM +0200, Linus Walleij wrote:
> > > On Tue, Oct 16, 2018 at 12:16 AM Stefan Agner <stefan@agner.ch> wrote:
> > It's not obvious yet whether this is right - it contradicts the GCC
> > manual, but then we have evidence that it's required for some GCC
> > versions where GCC may clone the function, or if the function is
> > used within the same file.
>
> Why not getting rid of __naked altogether? Here's what I suggest:
>
> ----- >8
> Subject: [PATCH] ARM: remove naked function usage
>
> Convert page copy functions not to rely on the naked function attribute.
>
> This attribute is known to confuse some gcc versions when function
> arguments aren't explicitly listed as inline assembly operands despite
> the gcc documentation. That resulted in commit 9a40ac86152c ("ARM:
> 6164/1: Add kto and kfrom to input operands list.").

It's probably worth noting that the minimum gcc version for compiling
the kernel is now gcc-4.6, which I think does not suffer from the gcc-4.5
bug that triggered the change. See in particular commits 9c695203a7dd
("compiler-gcc.h: gcc-4.5 needs noclone and noinline on __naked functions")
and d124b44f09ca ("Compiler Attributes: naked was fixed in gcc 4.6").

The first one made sure we don't inline these functions, so gcc-4.5
no longer runs into the problem even in the absence of the workaround,
and the second patch reverts that again, noting that gcc-4.6 is fixed.

I don't see anything wrong with converting the functions to not
use __naked at all, but I think we can also just revert the original
commit 9a40ac86152c to get it to build with clang. When I last
played with clang on arm32, that's what I did. I'll reply with the
patch I have in my randconfig tree.

      Arnd
