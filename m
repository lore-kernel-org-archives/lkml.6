Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB634C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9927C2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9927C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbeKMU2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:28:45 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36964 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeKMU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:28:44 -0500
Received: by mail-vk1-f193.google.com with SMTP id 197so2664404vkf.4;
        Tue, 13 Nov 2018 02:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zkVe9uvbhfWW5o+HIUL+OR20y8rSwYl5R26yIGa56Y=;
        b=RamHoPh06/8mrErl52MJgFqyk06c+jKIEeR0Ws2RJJyoWF3rqJxtt68Hy3jdHvTv4i
         Tn4BMU/raldswNFWKo5avPtJGUeuRQfb4b2VmImmsM50yYbLFMS9j3c7cRz+fb1F0CbI
         9f6GN6BBOkQC1ahPiY23GK1oSwQ4E2s/L2glo9FipP3DvK6DpbFYHadWA5Pa6V5ciyx/
         JOj/3yATzpD2h0WSvrwpNWizWvrHP8U8Vnf5ydtzv4UMCYQV40HDwCriAFknAvPaHW88
         8itChMQaDXmMbQZThIyIzeXagtZW3uo/fRxX6DsT4VAVTQK+NHHBlcGyM9m1OA3Xc9jx
         1FDg==
X-Gm-Message-State: AGRZ1gIy2NMUC760xNXz6w6LAARB22Yf4OnuUnCNcA+vSFDujiduWNbd
        +Y6SK3wWZ/+k0Oix8RcABG4jL67UPErQciDb/KelZFZe
X-Google-Smtp-Source: AJdET5d6+HvEtsunUA4LzMfMnJSqcG9trb5Bw1+aJSr4Ib4G+tgN+gP95pGfIyRsrfKUO9SWCLGkEBAZ9NzxbNv5vAs=
X-Received: by 2002:a1f:2ed7:: with SMTP id u206mr1959297vku.72.1542105074798;
 Tue, 13 Nov 2018 02:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20181113102228.820214-1-lkundrak@v3.sk> <20181113102228.820214-6-lkundrak@v3.sk>
In-Reply-To: <20181113102228.820214-6-lkundrak@v3.sk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Nov 2018 11:31:02 +0100
Message-ID: <CAMuHMdV-WvoFN_JOj46fA5st2o3CrX7VK0qQ2rSo+cgFoMD5+A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spi: pxa2xx: Add ready signal
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Strobe a GPIO line when the slave TX FIFO is filled. This is how the
> Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
> master, learns that it can initiate a transaction.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Tested-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
