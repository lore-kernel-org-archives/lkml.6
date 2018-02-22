Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933074AbeBVPiq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:38:46 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:40637 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932919AbeBVPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:38:44 -0500
Date: Thu, 22 Feb 2018 16:38:24 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/19] ARM64: dts: Add R-Car Salvator-x M3-N support
Message-ID: <20180222153823.62bd7xfh7gj75x5j@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-10-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVDCga8htL+UD3P0Kzt9-OQ6hof+szGOiV9d0gwxGExqQ@mail.gmail.com>
 <20180221171504.dac7yikrqfnjiiog@verge.net.au>
 <CAK8P3a30pgOXvLLHe3Hb-ubPz6QeUiZKFqMZLm8Qp_7KRr7QuA@mail.gmail.com>
 <CAMuHMdXJcHLee3mn56pSpUkFie_rQFZEPf=+6MWHe+W-+bMxgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXJcHLee3mn56pSpUkFie_rQFZEPf=+6MWHe+W-+bMxgQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 02:28:46PM +0100, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Thu, Feb 22, 2018 at 12:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Feb 21, 2018 at 6:15 PM, Simon Horman <horms@verge.net.au> wrote:
> >> On Tue, Feb 20, 2018 at 04:46:23PM +0100, Geert Uytterhoeven wrote:
> >>> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> >>> > Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
> >>> >
> >>> > Based on original work from:
> >>> > Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >>> > Magnus Damm <damm+renesas@opensource.se>
> >>> >
> >>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>>
> >>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> Thanks, applied with prefix updated to
> >>
> >> "arm64: dts: renesas:"
> >>
> >> There was some fuzz applying this patch, the result is as follows.
> >>
> >> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >> Subject: [PATCH] arm64: dts: renesas: Add R-Car Salvator-x M3-N support
> >>
> >> Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
> >>
> >> Based on original work from:
> >> Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >> Magnus Damm <damm+renesas@opensource.se>
> >>
> >> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Something went wrong with this patch, I suspect it's missing some prerequisites
> > that fill in a few more device nodes to avoid these warnings in linux-next:
> >
> > arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
> > (reg_format): "reg" property in /soc/ethernet@e6800000/ethernet-phy@0
> > has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> 
> [...]
> 
> > Maybe just take out the patch adding the .dts file for the time being until
> > the important nodes are all in place?
> 
> Removing the .dts file removes the ability to boot the newly added board...
> 
> The issue here is that we are sharing board .dtsi for boards that can be
> equipped with different pin-compatible SiPs (Ri-Car H3, M3-W, M3-N), while
> not all SoC support has been enabled and/or tested. As the board .dtsi
> references on-SoC devices using phandles, the new r8a77965.dtsi declares
> placeholders for the devices that are not yet enabled/tested.
> This worked fine for r8a7796.dtsi before, but causes dtc warnings due to
> recent improvements in DT validation.
> 
> I think the simplest way to fix this is to add reg properties to the
> placeholders, as Simon did for the last two placeholders in r8a7796.dtsi in
> commit 4316989537a6ed53 ("arm64: dts: renesas: r8a7796: add reg properties to
> pciec[01] nodes").

Hi Arnd,

Sorry for letting this slip through.

I think the best solution is an incremental patch on top of the renesas
devel branch to, as Geert suggests, add reg properties to the placeholders.

I've asked Jacopo to prepare such a patch.
