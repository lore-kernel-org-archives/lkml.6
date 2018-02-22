Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932575AbeBVN2v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:28:51 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40244 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932544AbeBVN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:28:48 -0500
X-Google-Smtp-Source: AH8x227vOQL3S6bhmuO2e8cJxYK4T9SlpJyX1mRGj64KqFFEUsFYBl5yOkhKmyPm7oaCQ3qGR8RPzZQihsudXBDrMSI=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a30pgOXvLLHe3Hb-ubPz6QeUiZKFqMZLm8Qp_7KRr7QuA@mail.gmail.com>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-10-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVDCga8htL+UD3P0Kzt9-OQ6hof+szGOiV9d0gwxGExqQ@mail.gmail.com>
 <20180221171504.dac7yikrqfnjiiog@verge.net.au> <CAK8P3a30pgOXvLLHe3Hb-ubPz6QeUiZKFqMZLm8Qp_7KRr7QuA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2018 14:28:46 +0100
X-Google-Sender-Auth: -QyQ5Olgo0fkCRqjCfYxkg17NOA
Message-ID: <CAMuHMdXJcHLee3mn56pSpUkFie_rQFZEPf=+6MWHe+W-+bMxgQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] ARM64: dts: Add R-Car Salvator-x M3-N support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@verge.net.au>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Feb 22, 2018 at 12:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Feb 21, 2018 at 6:15 PM, Simon Horman <horms@verge.net.au> wrote:
>> On Tue, Feb 20, 2018 at 04:46:23PM +0100, Geert Uytterhoeven wrote:
>>> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>>> > Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
>>> >
>>> > Based on original work from:
>>> > Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>> > Magnus Damm <damm+renesas@opensource.se>
>>> >
>>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Thanks, applied with prefix updated to
>>
>> "arm64: dts: renesas:"
>>
>> There was some fuzz applying this patch, the result is as follows.
>>
>> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Subject: [PATCH] arm64: dts: renesas: Add R-Car Salvator-x M3-N support
>>
>> Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
>>
>> Based on original work from:
>> Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Magnus Damm <damm+renesas@opensource.se>
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Something went wrong with this patch, I suspect it's missing some prerequisites
> that fill in a few more device nodes to avoid these warnings in linux-next:
>
> arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning
> (reg_format): "reg" property in /soc/ethernet@e6800000/ethernet-phy@0
> has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)

[...]

> Maybe just take out the patch adding the .dts file for the time being until
> the important nodes are all in place?

Removing the .dts file removes the ability to boot the newly added board...

The issue here is that we are sharing board .dtsi for boards that can be
equipped with different pin-compatible SiPs (Ri-Car H3, M3-W, M3-N), while
not all SoC support has been enabled and/or tested. As the board .dtsi
references on-SoC devices using phandles, the new r8a77965.dtsi declares
placeholders for the devices that are not yet enabled/tested.
This worked fine for r8a7796.dtsi before, but causes dtc warnings due to
recent improvements in DT validation.

I think the simplest way to fix this is to add reg properties to the
placeholders, as Simon did for the last two placeholders in r8a7796.dtsi in
commit 4316989537a6ed53 ("arm64: dts: renesas: r8a7796: add reg properties to
pciec[01] nodes").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
