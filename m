Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbeB1Uu2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934682AbeB1Uu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:50:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB222133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELu+kasrz50InyRZ06E6Uqp7qHqTHIbCHeunYiNGHla7Bvx31OeVg/jPtoOYcsNaG8BTsXXUDmupuJLr/xjHTDA=
MIME-Version: 1.0
In-Reply-To: <300becd6-db35-59e6-1b81-6b1940070df0@gmail.com>
References: <1519000156-14319-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqLa83SKe5vbCkU8pwjPzBszsHrWQEA-ThMMciMwLO1XmA@mail.gmail.com> <300becd6-db35-59e6-1b81-6b1940070df0@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Feb 2018 14:26:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BBHT3AyNeHWJe22KioC9s3Jm1d4pydVQLJA6jKoTGXA@mail.gmail.com>
Message-ID: <CAL_Jsq+BBHT3AyNeHWJe22KioC9s3Jm1d4pydVQLJA6jKoTGXA@mail.gmail.com>
Subject: Re: [PATCH] of: Kconfig: OF_OVERLAY, select OF_EARLY_FLATTREE
To: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay, been away for a few days.

On Mon, Feb 19, 2018 at 12:24 AM, Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 02/18/18 17:46, Rob Herring wrote:
> > On Sun, Feb 18, 2018 at 6:29 PM,  <frowand.list@gmail.com> wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> kbuild test robot reported a new warning for a recent patch:
> >>>> drivers/of/overlay.c:832:2: error: implicit declaration of function 'of_fdt_unflatten_tree' [-Werror=implicit-function-declaration]
> >>      of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
> >>
> >> The cause is that the prototype for of_fdt_unflatten_tree() in
> >> include/linux/of_fdt.c is guarded by OF_EARLY_FLATTREE.

Umm, this is not true. of_fdt_unflatten_tree is outside the ifdef for
OF_EARLY_FLATTREE.

> >>
> >> This was a pre-existing problem for any overlay related caller of
> >> of_fdt_unflatten_device_tree(), who was then going to pass the
> >> unflattened tree to of_overlay_apply().  After the patch that triggered
> >> this warning, all other overlay callers of of_fdt_unflatten_device_tree()
> >> no longer exist, so adding the select to OF_OVERLAY is a sufficient fix.
> >>
> >> To reproduce the warning:
> >>   Use the .config attached to https://lkml.org/lkml/2018/2/17/268
> >>   make ARCH=i386 olddefconfig
> >>   make ARCH=i386 CC=gcc-7 drivers/of/overlay.o
> >>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >>  drivers/of/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> >> index 783e0870bd22..00a6abfaaec7 100644
> >> --- a/drivers/of/Kconfig
> >> +++ b/drivers/of/Kconfig
> >> @@ -92,6 +92,7 @@ config OF_RESOLVE
> >>  config OF_OVERLAY
> >>         bool "Device Tree overlays"
> >>         select OF_DYNAMIC
> >> +       select OF_EARLY_FLATTREE

This should really have been OF_FLATTREE...

> > If we do this, we might as well kill OF_EARLY_FLATTREE. What platform
> > really boots from not FDT, but uses DT without overlays?
>
> Making sure I'm understanding...  So you want to remove OF_EARLY_FLATTREE
> and convert the current users of it to OF_FLATTREE?

Right. OF_EARLY_FLATTREE just controls everything that's in __init
section anyway. So the question is it worth a kconfig option to
control code that's in the __init section and will get discarded
anyway?


> I don't see any way to directly configure OF_FLATTREE and I don't see any
> Kconfig file selecting it, other than drivers/of/Kconfig which selects
> OF_FLATTREE from OF_EARLY_FLATTREE.  So as far as I can tell, the two
> config options are essentially a single config option.  Meaning that
> either one could be replaced by the other.
>
> Changing all to OF_FLATTREE will touch more files and thus will be a
> bit more obtrusive.  It looks like it would take two releases to avoid
> a flag day change.
>
> Changing all to OF_EARLY_FLATTREE can be done in a single release.

I would get rid of OF_EARLY_FLATREE within the DT core code making it
do nothing more than select OF_FLATTREE. Then the arches can later
just select OF_FLATTREE directly.

But this is all orthogonal to your issue. I think we need to keep the
overlay dependencies on FDT separate. In theory we could support
non-FDT sources or some more complex use that needs to unflatten FDT
themselves. I don't really want to add another user visible kconfig
option (OF_FDT_OVERLAY), so I think as long as we structure things to
support that when needed we're fine.

Rob
