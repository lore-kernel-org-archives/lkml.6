Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F7C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B7E205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B7E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJHRRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:17:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38400 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:17:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so20288677qtf.5;
        Mon, 08 Oct 2018 03:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ND4333KgeiGhqJUZDrQhCAD3jx2kxYi2DF+wzdibHc=;
        b=co83knW1NeYhAcUQpMqAl4c5QBAcm1ybcGTuSspBBL58evDOmAGsdzki3/1cYpbppU
         pf6cqcfFVmzzcD0rlE8Z2X3Rmcqzqqsdox0kJ9dM/8A70GGo4gsAgnC73WxYm1+oJpN3
         4c8jzF/b4Ji3xI5an8pLTuHUBF7QfiKWsFfyYp6QqsF83wiaDfug4x9SP4Ook8niuDBC
         /Mx+u8f7bbZtGmWJeCfizEwq3UC0zKBx1P2ODVigENjVDHzGo0zNK9fwwffL3GLISnxX
         xo4v2yEL44LzX57JsIKLrNI4MgJualIqjSMwi8TYgtFOD85la3gXr5UAu3DLOEgzByde
         DBsA==
X-Gm-Message-State: ABuFfogvr3ekCxhnLJ1SsxsWYg3RhkQJvYSXF4wZqGX8GvxE3DOd8pIi
        6Eapp3xSb++ZVQyeC2UMWuuYGuMFGPQnJx2e91g=
X-Google-Smtp-Source: ACcGV61WzwRlpPpwOYv6FOzQjZYQQ7vVXKDtA3K8PnHL5giF0ufMTnFF/RfLzjtlBC8Oe0EMJwSlgz1Ch3b9+jjBgVU=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr18379305qtf.185.1538993206906;
 Mon, 08 Oct 2018 03:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181003132212.12619-1-boris.brezillon@bootlin.com> <20181003132212.12619-8-boris.brezillon@bootlin.com>
In-Reply-To: <20181003132212.12619-8-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Oct 2018 12:06:30 +0200
Message-ID: <CAK8P3a21t7pQ2uYWgu2+VZZNYc+pz_w3WCL7YVUEzqqyOFLvnA@mail.gmail.com>
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

On Wed, Oct 3, 2018 at 3:22 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Add a driver for Cadence I3C master IP.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---

> Changes in v7:
> - Fix readsl/writesl() usage
> - Add a depends on ARM || ARM64 || XTENSA to forbid selection of this
>   driver on platforms that are not implementing readsl/writesl

Most architectures include asm-generic/io.h, which contains a generic
implementation of readsl(). Maybe that #ifdef could be extended here?
I remember discussing this with you not so long ago, which led to
commit 0bbf47eab469 ("ia64: use asm-generic/io.h"). Do we have
a list of architectures that don't include asm-generic/io.h? Maybe
the 'depends on' could be for the set of architectures that fail here.

> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master *master,
> +                                           u8 *bytes, int nbytes)
> +{
> +       readsl(master->regs + RX_FIFO, bytes, nbytes / 4);
> +       if (nbytes & 3) {
> +               u32 tmp = __raw_readl(master->regs + RX_FIFO);
> +
> +               memcpy(bytes + (nbytes & ~3), &tmp, nbytes & 3);
> +       }
> +}

The __raw_readl() is probably correct here (I can't think of any
architecture on which it is not), but it still makes me feel uneasy
about possible endianess or other issues.

Maybe make this:?

        readsl(master->regs + RX_FIFO, &tmp, 1);


     Arnd
