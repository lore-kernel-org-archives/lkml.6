Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeCWN2K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:28:10 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:41669 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeCWN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:28:06 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w2NDRusj030230
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: AG47ELtuP89nX4en5iBe5fqP7PzelY1P7zxpg39x/C4/Qxk3dC5Q8TBrO6dibE7oRzJhSzUs/B66Uvr9Efdz2Oyf9Hc=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUdsH3r7AZMB6NfNyrDdJecXx1JhGZFA=32VYZBtmGP5w@mail.gmail.com>
References: <20180315153730.3798004-1-arnd@arndb.de> <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com>
 <CAMuHMdULWVXXSXrEBoomONQhF-Af3FGMijMnL6WL6P1XE-e7zA@mail.gmail.com>
 <1806382.Agy9d77yKa@avalon> <CAMuHMdUdsH3r7AZMB6NfNyrDdJecXx1JhGZFA=32VYZBtmGP5w@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Mar 2018 22:27:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQB4q-azLkig1eJKvYvAPHeRgM7sYES0LQT-1AP5McQtw@mail.gmail.com>
Message-ID: <CAK7LNAQB4q-azLkig1eJKvYvAPHeRgM7sYES0LQT-1AP5McQtw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around
 during build
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank.Rowand@sony.com, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 0:13 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Laurent,
>
> CC Yamada-san
>
> On Thu, Mar 22, 2018 at 3:50 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> On Thursday, 22 March 2018 16:26:22 EET Geert Uytterhoeven wrote:
>>> On Fri, Mar 16, 2018 at 2:39 AM,  <Frank.Rowand@sony.com> wrote:
>>> > On Thursday, March 15, 2018 8:37 AM, Arnd Bergmann wrote:
>>> >> The *.dtb and *.dtb.S files get removed by 'make' during the build
>>> >> process, and later seem to be missed during the 'modpost' stage:
>>> >>
>>> >> rm drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb.S
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb.S
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb.S
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb.S
>>> >> WARNING: could not open
>>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S: No such file or
>>> >> directory
>>> >>
>>> >> As a workaround, this adds all those files to the 'extra-y' target list,
>>> >> but that's really ugly. Any ideas for a better fix?
>>> >
>>> > Does this work for you (untested, but the way it is done in
>>> > drivers/of/unittest-data/Makefile):
>>> >
>>> > .PRECIOUS: \
>>> >
>>> >         $(obj)/%.dtb.S \
>>> >         $(obj)/%.dtb
>>>
>>> Shouldn't that just be moved to scripts/Makefile.lib, just above the rule
>>> to make dtb.S, like is done for other precious objects?
>>
>> Without any implied acknowledgment that keeping those intermediate files is
>> the right solution (I don't claim to master the kernel build system), I think
>
> Me neither, but I think it is.
>
> Cfr. .y => .tab.c => .tab.o with .tab.c marked PRECIOUS.
>
>> such a rule would indeed be better in a core Makefile, as the rules to build
>> the .dtb.o file comes from the core too. Could another option be to create a
>> rule to compile a .dtb.o from the .dts file directly without going through
>> intermediate files that will be removed automatically ?
>
> Such a rules needs to execute two commands, which is more tricky, considering
> error handling.
> It's easier (to get right) to have two separate rules, and let make chain them
> automatically.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>


I submit the patches.
I'd like to queue them up for the next merge window,
so your problems will be fixed if Kbuild pull requests are pulled.

The driver Makefile has two problems.

[1] Objects are always rebuilt due to missing 'targets'
[2] Intermediate files are removed due to missing .SECONDARY (or .PRECIOUS)

If you want to fix them by yourself, you can.

But, those issues will be taken care of by the core Makefile.

Specifically, [1] will be fixed by
https://patchwork.kernel.org/patch/10304671/

and [2] by
https://patchwork.kernel.org/patch/10304651/




-- 
Best Regards
Masahiro Yamada
