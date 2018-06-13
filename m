Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3A237C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1C5204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1C5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935412AbeFMLgx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:36:53 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39719 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935246AbeFMLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:36:52 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so1475781uad.6;
        Wed, 13 Jun 2018 04:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTR7jy0yOwi9UymdwpuOO9kNU3M5xEqY4Pw1gfOytRI=;
        b=lUAhsFhnGXLm4u+dsDnQpj4gGWaCaZkTG91AAP1I5zImLYTvyBioG3VnV8pXmeoNeT
         +stZ2RK+55YOq3Y1/5Ne2/4201bW82orOTN1hHAy2Bjts9HQ3iBVZNY4MtRBrZMomz5N
         MVg57wrNg/NOdWdCw2ezGRcu0pueDnzQ5KtR8PKKxI/Bfmw8619DRjcllrRukF4IdsO5
         NPNBZJRFmcuJN3CVxrimmoFVwUDDZOgKHMZIGumR+jsi2+OhOXBZxpDR0qYAPB1nF4wE
         O61zt07ggMpH9bTjwQVW9egjX9cQg3Bmy5FFeexupC9S/wr+FSQFvRrzOdJToTRIMiHp
         glGQ==
X-Gm-Message-State: APt69E3KthqbC5Q+N0bppqkjxG5lfyzmOTSPUPtPFfED9TRDurse68Ii
        XyRDslZqG8UfWGEpFaILwN+a/9R3aKi0hlwV3OM=
X-Google-Smtp-Source: ADUXVKLdwpcrs4AMXfHqcxN/yRyOGwp/xCUYLZZMRzQqpoY+pzYLUsXiTjKM4XtLpW1q6Sad0wkxgliGZUWS3r8yayU=
X-Received: by 2002:ab0:48e1:: with SMTP id y30-v6mr3009136uac.180.1528889811049;
 Wed, 13 Jun 2018 04:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <8736xrkrci.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8736xrkrci.wl%kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Jun 2018 13:36:39 +0200
Message-ID: <CAMuHMdV-MoVnfJarHc9xZX_ZN7sHmKjGKxnhHyYUBof_P6R9ew@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: rcar-dmac: don't use DMAC error interrupt
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran@ksquared.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

Thanks for your patch!

On Wed, Jun 13, 2018 at 10:49 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current rcar-dmac is using DMAC error interrupt which will handle all
> channel's error. But in this design, error handling itself will be
> issue if user want to use virtualization, multi OS, etc.
> This patch removes current DMAC error interrupt handling, and handle it
> on each channel interrupt handler.

Just wondering, what's the usage pattern where this causes a problem?
Do you plan to export part of a SYS-DMAC instance to a guest?
How to maintain host/guest isolation?

> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> @@ -38,6 +38,7 @@ Required Properties:
>  - interrupt-names: one entry for the error interrupt, named "error", plus one
>    entry per channel, named "ch%u", where %u is the channel number ranging from
>    zero to the number of channels minus one.
> +  # "error" interrupt will be ignored, so far

Again, DT describes hardware, not software policy.
So please drop all changes to the bindings.

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
