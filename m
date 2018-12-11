Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A77C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4052081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4052081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLKKKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:10:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38455 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKKKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:10:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so15725773qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUptHz8tAupzd+qIgaO0UnYurIGVlvC4FJiiGfsyRnw=;
        b=sBr6j3KbvzY4MyjA7RFIKd7IowT0GZUuq2FCyrk/jDADMSk7hlPWUbPOg2QZ/LY0cm
         vHnUuEBT3Kj3j86kLxXVYePtcE8fHQTqupUyWxPHnlB+JAbiDuu9Dlru/JAzKsjXaBfj
         GUVBXFC+iM8sZ9/JwPHqoI4qAYO3MESCwewouzR0eFsA8ilYMx7v7EuWxOkuZgkORJPD
         hmgC1SI0esxEV2020y+mQ2TZppB9VED+7dD4E0t6OjzeKRUukAM3uZfYD7kn6+qCbOU9
         GF7zD2qim94VBIJOeobFWLrAbYDHgYAppqM7iWaHtPMFKdcR/9fSYuGU83FAnfAHQ5Ru
         dJjw==
X-Gm-Message-State: AA+aEWYSwBT27zHoQtxrQTlQ176UgoIMmzLXbw0hYESwT7jA3njfWIVG
        97N7k/tlDoMhB1dXGGRqMmtopfY6RD7sAZCwXVk=
X-Google-Smtp-Source: AFSGD/X/XjFG5Gua/YHdVFxncInde8iBADRl4mRhSfY4aL+DBb+3kwNNf6ruT8FqSHHJYj+rbC1ke4VDLxJEd/E/kFk=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr15017284qtr.319.1544523038716;
 Tue, 11 Dec 2018 02:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de> <20181210215856.2238253-4-arnd@arndb.de>
 <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
In-Reply-To: <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 11:10:21 +0100
Message-ID: <CAK8P3a0n0zjGjF64F7Dk1rfxsQpn+7R4L2WoZuzXgnKokc-YHg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     arm-soc <arm@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        grinberg@compulab.co.il, Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:40 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 10 Dec 2018 at 23:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> > The function littleton_init_lcd() references
> > the function __init pxa_set_fb_info().
> > This is often because littleton_init_lcd lacks a __init
> > annotation or the annotation of pxa_set_fb_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> > The function zeus_register_ohci() references
> > the function __init pxa_set_ohci_info().
> > This is often because zeus_register_ohci lacks a __init
> > annotation or the annotation of pxa_set_ohci_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> > The function cm_x300_init_u2d() references
> > the function __init pxa3xx_set_u2d_info().
> > This is often because cm_x300_init_u2d lacks a __init
> > annotation or the annotation of pxa3xx_set_u2d_info is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I have queued a bunch of pxa changes via my mmc tree for gpio
> descriptor conversions, by Linus Walleij.
>
> Are those causing this problem? Should I queue this one via mmc tree as well?

Sorry for the lack of description in the changelog. I'm fairly sure that these
are old bugs that only appeared now if you build with CONFIG_NO_AUTO_INLINE,
we should take these through arm-soc, and I should probably add an explanation.

      Arnd
