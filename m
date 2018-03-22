Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754782AbeCVOtN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:49:13 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:48842 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754403AbeCVOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:49:10 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Frank.Rowand@sony.com, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around during build
Date: Thu, 22 Mar 2018 16:50:15 +0200
Message-ID: <1806382.Agy9d77yKa@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAMuHMdULWVXXSXrEBoomONQhF-Af3FGMijMnL6WL6P1XE-e7zA@mail.gmail.com>
References: <20180315153730.3798004-1-arnd@arndb.de> <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com> <CAMuHMdULWVXXSXrEBoomONQhF-Af3FGMijMnL6WL6P1XE-e7zA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thursday, 22 March 2018 16:26:22 EET Geert Uytterhoeven wrote:
> On Fri, Mar 16, 2018 at 2:39 AM,  <Frank.Rowand@sony.com> wrote:
> > On Thursday, March 15, 2018 8:37 AM, Arnd Bergmann wrote:
> >> The *.dtb and *.dtb.S files get removed by 'make' during the build
> >> process, and later seem to be missed during the 'modpost' stage:
> >> 
> >> rm drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb.S
> >> WARNING: could not open
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S: No such file or
> >> directory
> >> 
> >> As a workaround, this adds all those files to the 'extra-y' target list,
> >> but that's really ugly. Any ideas for a better fix?
> > 
> > Does this work for you (untested, but the way it is done in
> > drivers/of/unittest-data/Makefile):
> > 
> > .PRECIOUS: \
> > 
> >         $(obj)/%.dtb.S \
> >         $(obj)/%.dtb
> 
> Shouldn't that just be moved to scripts/Makefile.lib, just above the rule
> to make dtb.S, like is done for other precious objects?

Without any implied acknowledgment that keeping those intermediate files is 
the right solution (I don't claim to master the kernel build system), I think 
such a rule would indeed be better in a core Makefile, as the rules to build 
the .dtb.o file comes from the core too. Could another option be to create a 
rule to compile a .dtb.o from the .dts file directly without going through 
intermediate files that will be removed automatically ?

-- 
Regards,

Laurent Pinchart
