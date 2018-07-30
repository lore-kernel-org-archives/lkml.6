Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9411BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5364A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5364A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeG3K7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:59:14 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42134 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeG3K7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:59:10 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so5371725vke.9;
        Mon, 30 Jul 2018 02:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ju9Jd9qEnbDxSbNmxfr1+J4UbJVqy1PPSjoI9Ui3gLg=;
        b=qw5LnRLxE92s/QmMgch1fgRhVPvVYtmvVaDTh3694prEUx9ryyk+/uN678pSPX2+rX
         t7MKG5XZcKxqDlP93RIeJkXmpAm0xwG15P4mKXLJEOtYn8KC7xplWS0ZJwVXCfZ7WaME
         D38JBgI2okEFLmSqHai2PvOIpUzHaf+AuR3Vf5yTIAfNGcCLM1irm0nqisPJfKivoIIl
         llcwnI5AKSX9n/TBln83M263XIx7kaHSM8kTgZejl2Xy1ZW+dEIhiQNPqQ6b44kB5aQM
         mG+ytyhP/Vg0P+aIqEUxknOuteTy6woMDLLA41zXG+IviRRkjgdf7sDOl2tIv91CJcht
         b58Q==
X-Gm-Message-State: AOUpUlFfLqHproeRSsxb6hLHD1HuEAfu1B8dDd111t4dETPjh2LfEPhq
        0mq4I9wVNsfn9I3QjHPJwMlUWKz13skQQHILT+8KeA==
X-Google-Smtp-Source: AAOMgpcq6GF+uPGwSBMUqGbVrEEIHqvI0qzj9KCz0Np3ez9m64I2wdxiLvX7q5kmkxKTnFMFzZi9cLTYSuvKjE7XfVg=
X-Received: by 2002:a1f:6b11:: with SMTP id g17-v6mr10090522vkc.82.1532942704594;
 Mon, 30 Jul 2018 02:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de> <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
In-Reply-To: <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jul 2018 11:24:52 +0200
Message-ID: <CAMuHMdXkaoypaszdyXyVA-qZvDtbcEdtdbEwpdoT8ocx-2TPYA@mail.gmail.com>
Subject: Re: use the generic dma-noncoherent code for sh V2
To:     Rob Landley <rob@landley.net>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

CC Guennadi

On Fri, Jul 27, 2018 at 6:21 PM Rob Landley <rob@landley.net> wrote:
> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
> > On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
> >> can you review these patches to switch sh to use the generic
> >> dma-noncoherent code?  All the requirements are in mainline already
> >> and we've switched various architectures over to it already.
> >
> > Ok, there is one more issue with this version.   Wait for a new one
> > tomorrow.
>
> Speaking of DMA:
>
> I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
> fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
> reading through all that stuff, but the docs seem kinda... thin?
>
> Is there something I should have read other than
> Documentation/driver-model/platform.txt,
> Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
> source code and the sh7760 hardware pdf? (And watching the youtube video of
> Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
> DMAEngine, the Xilinx video on DMAEngine...)
>
> At first I thought the SH_DMAE could initialize itself, but the probe function
> needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
> _kind_ of like a model I can crib from:
>
> A) "make ARCH=sh se7722_defconfig" results in a config with SH_DMA disabled??!?
> (This is why I use miniconfig instead of defconfig format, I'm assuming that's
> bit rot?)
>
> B) That platform data is supplying sh_dmae_slave_config preallocating slave
> channels to devices? (Does it have to? The docs gave me the impression the
> driver would dynamically request them and devices could even share. Wasn't that
> sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
> minimum amount of micromanaging I have to do?)
>
> C) It's full of stuff like setting ts_low_shift to CHCR_TS_LOW_SHIFT where both
> grepping Docuemntation and Google "dmaengine ts_low_shift" are unhelpful.
>
> What I'd really like is a "hello world" version of DMAEngine somewhere I can
> build and run on a supported qemu target, to set up _one_ channel with a block
> device or something using it. I can't tell what's optional, or what the minimal
> version of this looks like.

I have no experience with DMA on SH, only with DMA on (DT-based) Renesas
ARM SoCs. But I believe the DMA engines are somewhat similar.

I don't know if all pieces to support DMA were ever upstreamed.
See e.g. commit 219fb0c1436e4893 ("serial: sh-sci: Remove the platform data
dma slave rx/tx channel IDs").

Perhaps Guennadi knows/remembers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
