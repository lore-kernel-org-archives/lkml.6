Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22999213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22999213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJIWbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:31:37 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37525 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:31:34 -0400
Received: by mail-vk1-f194.google.com with SMTP id y128-v6so467994vky.4;
        Tue, 09 Oct 2018 08:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAGqBbSA1RSQkPwWyc/kNxdcUaFy54e8ph6hVOVfms4=;
        b=kShC3KzTapKqacPHL++G5IROp/T5BXZJrUX3asi3MsyctH+5sGHP/Wlkj715AFRwbA
         8tiX0zc5ntPr3taE8tZJADkCV1Ce2QaGIIzy/u0zasnRrU6VeM3LTdtiURFcNNTpil91
         ua+mg9KC/r+CiPhZctJTfUMdoyKdZrJWK6s9uu5XJzkUT18ZK/3ASU3379bRGf5qEbMV
         bENQiWTk88sVx8NEmWFZXX24VSj8go/taBRF3lOXe5KIfDW3d/O5KXGuoFI6AzIQux1R
         mhGjhTnPHuaTlHWxI0GekgMc2YFRjs7Ku3cHzOOXObWAah6zwBKtjGsbDTK8W4NaRIKc
         ZOpA==
X-Gm-Message-State: ABuFfohS8+I3RIpI/IUGBuT2cO5Aoe/bKyykDM6zCf1gdvJkNsrQ1LjA
        qf2owDarfH87I1GU4NEf3+gTka1LtSJY1IoF403aLw==
X-Google-Smtp-Source: ACcGV62PaTnruQZsal+60+njskNgOXLchqbSfBlVbYThVVjfFKpN9VJfPfbMU75dGkva7KfCQvpInc5sn8Fywso5RCc=
X-Received: by 2002:a1f:b547:: with SMTP id e68-v6mr10837096vkf.72.1539098049724;
 Tue, 09 Oct 2018 08:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539092111.git.christophe.leroy@c-s.fr> <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
 <1539097191.64374.44.camel@acm.org>
In-Reply-To: <1539097191.64374.44.camel@acm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Oct 2018 17:13:57 +0200
Message-ID: <CAMuHMdVpS2wzUniDdXKSWyyTr3Cn9NsXAxOJEKe=D9BUrpdt=w@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead of __ioremap(_PAGE_WRITETHRU)
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Leo Li <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Debian m68k <debian-68k@lists.debian.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

CC debian-68k, linux-m68k

On Tue, Oct 9, 2018 at 5:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On Tue, 2018-10-09 at 13:51 +0000, Christophe Leroy wrote:
> > _PAGE_WRITETHRU is a target specific flag. Prefer generic functions.
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Hi Geert,
>
> All patches that have been applied to this driver since 2005 are API refactoring
> patches. I haven't found any patches in the history of this driver that seem to
> have been submitted by a user of this driver. Do you perhaps know whether anyone
> is using this driver?

The z2ram is a very simple driver, used to configure (slower) Zorro II RAM as
a swap device.  So I'm not so surprised no one submitted functional patches.

I believe it's still being used.
Probably it could be modified to use mtdram.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
