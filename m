Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE8EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2252083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2252083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937388AbeFSHv6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:51:58 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46721 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937201AbeFSHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:51:57 -0400
Received: by mail-vk0-f68.google.com with SMTP id b134-v6so11096706vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdsPyxI1nQeqkB9V9FbDlixuaMjODIf5nbvTS4ZvS4Y=;
        b=H+Du+sYdM7hQupnyVDsz8rdgsvyAgAzMj582lvU5Wz9wCqmsjy1/SyJD0ql5TVBlsE
         3eYHUDXD90Vz7VyYYNhc4gBoU3Qi8fzM6tY3Sdh6fl1q/zzuVC+9OfsLEojm73+wH5PW
         8j4ievsKbKNY4BU2m8pLnxZzFROvFp3XUfVmTTnZp4s8XQyWrqIiez5mF02X96c98zsp
         qcy8Ibpi0fQvTps98HpEhWrcwrhfOVO2l+dw1/DPj/RxI7bspwpmvxSS+vFcqMPy5+bV
         TFAEdTmlX3m98b5GRODA6Ozs/bBOc/w/ItHGhXlfBQnKEDFyJJZk11UOgkracUVfV4FU
         icHg==
X-Gm-Message-State: APt69E17P7wravfGXSaZ7rF7GwJFjCuBfMsSHYdi2Cq3xcwEH2Bk9Hi3
        uss+oyrhH9bovJa3ncRm9Fn6AmKoX/7SfnT8hE0=
X-Google-Smtp-Source: ADUXVKLJsiRSqH5vjHBEizNVKz88PqR5V9+qGFDFGQX70MwcykyO1jqlFar6SIoeO0Vv0fz6RjxXaWwZnAa763sciOU=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr8807630vks.106.1529394716162;
 Tue, 19 Jun 2018 00:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <1529347999-9316-1-git-send-email-hofrat@osadl.org> <20180619073709.schatjhjoitfc3fs@mwanda>
In-Reply-To: <20180619073709.schatjhjoitfc3fs@mwanda>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jun 2018 09:51:44 +0200
Message-ID: <CAMuHMdVuGAh7rya0CJtALDmjyHpQJv=uHA=-n1fLS7s+CnUoXg@mail.gmail.com>
Subject: Re: [PATCH] staging: board: drop refcount in success case
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        natechancellor@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Jun 18, 2018 at 08:53:19PM +0200, Nicholas Mc Guire wrote:
> >  The call to of_find_compatible_node() returns irqc_node with refcount
> > incremented thus it must be explicitly decremented here after it was
> > checked for non-NULL.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: commit 72ee8626eeb1 ("staging: board: Add support for translating hwirq to virq numbers")
> > ---
> >
> > Problem located with an experimental coccinelle script
> >
> > Patch was compile-tested with: x86_64_defconfig + STAGING=y, STAGING_BOARD=y
> >
> > Patch is against 4.18-rc1 (localversion-next is next-20180618)
> >
> >  drivers/staging/board/board.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> > index cb6feb3..8ee48e5 100644
> > --- a/drivers/staging/board/board.c
> > +++ b/drivers/staging/board/board.c
> > @@ -64,12 +64,13 @@ int __init board_staging_gic_setup_xlate(const char *gic_match,
> >       irqc_node = of_find_compatible_node(NULL, NULL, gic_match);
> >
> >       WARN_ON(!irqc_node);
> >       if (!irqc_node)
> >               return -ENOENT;
> >
> > +     of_node_put(irqc_node);
>
> I don't feel like this is the right thing...  We should keep the
> reference until we're done with it.  Which apparently is never?

Indeed. The reference must not be released in this function, as it's stored in
a global variable, and used later.

As all users are __init, it could be released when the init section is freeed,
in theory, but there's no callback for that.

Hence:
NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
