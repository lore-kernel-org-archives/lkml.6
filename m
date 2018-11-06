Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03079C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D8320830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D8320830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeKGHqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:46:53 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39738 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeKGHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:46:53 -0500
Received: by mail-vs1-f67.google.com with SMTP id h78so8315309vsi.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 14:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQqBvSf2K+0TeJcISEsQOASNwwNH/SfmS+R8MJdBLMo=;
        b=l+ZH/cmDQkcWLkzzgJM1ixhwOjXePhH6FuymoLL0f6Ig5SCqiQpQw1yYuBxUJULenj
         eE0KrlYF1yPvWNiTByfg5Kk6k2WuCaBSdR7Ix24KzVFR7vPby7YJxwnAJCh1667b2aoK
         4mg/HLD1McFrtoPkUFoExnV6O9e16F6z/O0ofcUXxwygUKwP8RTqEq2dXRSphwdtQm23
         kAEDVLpo+tohbUJfgCrAfeaIGOIXYgcQawgTuTQbzu0HsJdG7Q+/trOh+qTeNrD9PFCN
         jV+kgGGu7rWlSavW9Rj2BYcve4vyH09WlVpemrq+gcKtyxYSDw965diV5ni5OszvArQ7
         Icmg==
X-Gm-Message-State: AGRZ1gKP+J1w0ne2lcvblLBCGH7yaXjSuhbnb2MW4yJb9iyiFZVBKyjB
        5myW35qMpg5qz/cLF2Aij/qsfi2Mlv4uwg9mcCk=
X-Google-Smtp-Source: AJdET5d//gNbsRFPyV2otQsL4wBpytotw6ctYjhuVEQMpgM3OhHZPbiEzN1eBsWflm6kpKh1rawVckku9NHvWC4qF1Y=
X-Received: by 2002:a67:c202:: with SMTP id i2mr10962178vsj.11.1541542767169;
 Tue, 06 Nov 2018 14:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20181106214416.11342-1-geert@linux-m68k.org> <20181106225829.5ecbe19e@bbrezillon>
In-Reply-To: <20181106225829.5ecbe19e@bbrezillon>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 23:19:14 +0100
Message-ID: <CAMuHMdUQhsikcBzRFAvrCwZwzFK_Coh=fqpSihFP6jEtugCMQw@mail.gmail.com>
Subject: Re: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM
 type probing
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, Nov 6, 2018 at 10:58 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue,  6 Nov 2018 22:44:16 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Toshiba RBTX4927, where map_probe is supposed to fail:
> >
> >     Creating 2 MTD partitions on "physmap-flash.0":
> >     0x000000c00000-0x000001000000 : "boot"
> >     0x000000000000-0x000000c00000 : "user"
> >     physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
> >     CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
> >     ...
> >     Call Trace:
> >     [<80320f40>] get_mtd_chip_driver+0x30/0x8c
> >     [<80321004>] do_map_probe+0x20/0x90
> >     [<80328448>] physmap_flash_probe+0x484/0x4ec
> >
> > The access to rom_probe_types[] was changed from a sentinel-based loop
> > to an infinite loop, causing a crash when reaching the sentinel.
>
> Oops. Do you mind if I fix that in-place (squash your changes in
> Ricardo's original commit)?

No problem. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
