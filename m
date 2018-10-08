Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957DBC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948520841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3948520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJHRsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:48:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34710 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:48:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id p6-v6so11762447qkg.1;
        Mon, 08 Oct 2018 03:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABAzHvy42/tuYULpp/Kx5+SxMsW4Nke/wMSs9iUcpHc=;
        b=lWo1eimbZvfBtXD6fF2UTnXbEDGNbrrp+TEifioPhlQGsbBSQerg1TYNRKVLWoSbVs
         VMiiUCJ0PqqXLfFh8ln8SVcMVNhkYFF8irHBnx6Z1xFKb+PoiVh5rYq5I/vljqOCX5j1
         9snR5PmSNU/6+/G8hF2OgF+ihEa3o8nK4TDj2/V7N2thqLSbm4eDAenVU9EtBY54ryCT
         RBskVh4KepShJvlZct5z8YzW6sbstZV/6X0d/IF9f3s1VJ3bn9MfpzYWPq2BVqmVRFtD
         dWzif/Gp9lAJ8PrPp/GwLkXIDtkQZhlw+0LQqwz34uaPUwweVIzrstYB/VkilgtSgEXJ
         sJXQ==
X-Gm-Message-State: ABuFfojV9y6t0zdtFM32IC4AafFUrgCCTM80ketp7IXL67VEl6rJDSld
        nwsVWtB14ZV+wG77ON5A6R6npCDaU6AygOWwCo4=
X-Google-Smtp-Source: ACcGV63zXQFCk50m2EUEU9lrbK+4uyARnWqdK6AqV8jqbOOA4wdPAN12MRlvG7lO4uxL+2L/6mXzc/1sNd1jgE0+k8E=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr17611823qki.330.1538995020814;
 Mon, 08 Oct 2018 03:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
 <20181003132212.12619-8-boris.brezillon@bootlin.com> <CAK8P3a21t7pQ2uYWgu2+VZZNYc+pz_w3WCL7YVUEzqqyOFLvnA@mail.gmail.com>
 <20181008122101.7b391070@bbrezillon>
In-Reply-To: <20181008122101.7b391070@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Oct 2018 12:36:44 +0200
Message-ID: <CAK8P3a3Sck0yYzH-Ks=CvHJLgZ1VrUjHvzw2XL7C_GC515=VVg@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] i3c: master: Add driver for Cadence IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 12:21 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Mon, 8 Oct 2018 12:06:30 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > On Wed, Oct 3, 2018 at 3:22 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > >
> > > Add a driver for Cadence I3C master IP.
> > >
> > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > ---
> >
> > > Changes in v7:
> > > - Fix readsl/writesl() usage
> > > - Add a depends on ARM || ARM64 || XTENSA to forbid selection of this
> > >   driver on platforms that are not implementing readsl/writesl
> >
> > Most architectures include asm-generic/io.h, which contains a generic
> > implementation of readsl(). Maybe that #ifdef could be extended here?
> > I remember discussing this with you not so long ago, which led to
> > commit 0bbf47eab469 ("ia64: use asm-generic/io.h"). Do we have
> > a list of architectures that don't include asm-generic/io.h? Maybe
> > the 'depends on' could be for the set of architectures that fail here.
>
> Well, we started patching 2 archs (ia64 and sparc) based on kbuild
> robots failure report, and then I received other reports (still from
> kbuild robots) long after the initial ones. I can't tell for sure which
> archs are not implementing those functions, hence the conservative
> approach taken here.

I think it's a fairly safe assumption that architectures which include
asm-generic/io.h will be fine here. If one of them is broken, that
can be fixed individually. Looking at the ones that don't include this
file:

grep -L asm-generic/io.h arch/*/include/asm/io*.h
arch/alpha/include/asm/io.h        # missing readsl
arch/hexagon/include/asm/io.h   # has its own readsl
arch/mips/include/asm/io.h         # missing readsl (but used from ide.h?)
arch/parisc/include/asm/io.h       # missing readsl
arch/powerpc/include/asm/io.h   # has its own readsl
arch/sh/include/asm/io.h             # has its own readsl
arch/sparc/include/asm/io.h        # has its own readsl

Based on this, I would try what happens on mips, and make it depend
on !(ALPHA || PARISC)

Another option is to just use ioread32_rep(), which should be
available everywhere and has almost the same behavior as
readsl(). The only difference is that on architectures like x86
it takes a few extra cycles to look at the address.

        Arnd
