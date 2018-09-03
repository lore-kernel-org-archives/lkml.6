Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD79C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871532075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871532075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeICOxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:53:38 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53675 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeICOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:53:38 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 053DE60002;
        Mon,  3 Sep 2018 10:33:59 +0000 (UTC)
Date:   Mon, 3 Sep 2018 12:33:58 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Message-ID: <20180903103358.GC20333@w540>
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Phil,

On Thu, Aug 30, 2018 at 02:12:52PM +0100, Phil Edworthy wrote:
> This implements the pinctrl driver for the RZ/N1 family of devices, including
> the R9A06G032 (RZ/N1D) device.
>
> One area that is likely to be contentious is the use of 'virtual pins' for the
> MDIO pinmuxing. The driver uses two pins (170 and 171) that don't exist on the
> device to configure the MDIO source within the RZ/N1 devices. On these devices,
> there are two Ethernet MACs, a 5-Port Switch, numerous industrial Ethernet
> peripherals, any of which can be the MDIO source. Configuring the MDIO source
> could be done without the virtual pins, e.g. by extending the functions to
> cover all MDIO variants (a total of 32 additional functions), but this would
> allow users to misconfigure individual MDIO pins, rather than assign all MDIO
> pins to a MDIO source. The choice of how to implement this will affect the
> DT bindings.
>
> This series was originally written by Michel Pollet whilst at Renesas, and I
> have taken over this work.
>
> One point from Michel's v1 series:
> "Note, I used renesas,rzn1-pinmux node to specify the pinmux constants,
> and I also don't use some of the properties documented in
> pinctrl-bindings.txt on purpose, as they are too limited for my use
> (I need to be able to set, clear, ignore or reset level, pull up/down
> and function as the pinmux might be set by another OS/core running
> concurently)."
>

I start by saying that I don't know this HW pin controller well, so
I might be missing something, but as commented on the original series from
Micheal, I still don't see why you need a custom property here...

My understanding, looking at this comment and the header provided by
patch [1/3] (include/dt-bindings/pinctrl/rzn1-pinctrl.h) is that
basically need to control pull-up/down and the output driver strength.

Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt reports
a set of generic pin configuration properties to be applied to a pin
configuration (and multiplexing) pin controller child node that fully
express all (most?) of your needs.

Eg. a pin configuration with pull up applied, using examples from your
cover letter should be expressed as

Your example:
         &pinctrl {
                 pinsuart0: pinsuart0 {
                         renesas,rzn1-pinmux-ids = <
                                 RZN1_MUX(103, UART0_I)  /* UART0_TXD */
                                 RZN1_MUX_PUP(104, UART0_I)      /* UART0_RXD */
                         >;
                 };
         };

Using standard pinctroller bindings pin configuration properties:

         &pinctrl {
                 pinsuart0: uart0  {
                        pinsuart_tx0 {
                                pinmux = <103, UART0_I>;  /* UART0_TXD */
                        };

                        pinsuart_rx0 {
                                 pinmux = <104, UART0_I>; /* UART0_RXD */
                                 bias-pull-up;
                        };
                 };
         };

Is there anything I am missing? Maybe from the interaction with
"another OS/core running concurrently" you mentioned? In this case if
you only have to perform pin configuration (because muxing is handled
already) things are even simpler, just use the pin configuration
bindings, without involving muxing at all:

        &pinctrl {
                pinsuart_conf: uart0 {
                        pins = <103, 104>;
                        bias-pull-up;
                 };
         };

Thanks
  j

> Patch 0003 should really be applied after patch:
>  "ARM: dts: r9a06g032: Correct UART and add all other UARTs", see
>  https://www.spinics.net/lists/arm-kernel/msg673525.html
>
> Main changes:
> v2:
>  - Change to generic rzn1 family driver, instead of device specific.
>  - Review comments fixed.
>  - Fix error handling during probe
>
> Phil Edworthy (3):
>   dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
>   pinctrl: renesas: Renesas RZ/N1 pinctrl driver
>   ARM: dts: r9a06g032: Add pinctrl node
>
>  .../bindings/pinctrl/renesas,rzn1-pinctrl.txt      |  97 +++
>  arch/arm/boot/dts/r9a06g032.dtsi                   |   8 +
>  drivers/pinctrl/Kconfig                            |  10 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-rzn1.c                     | 844 +++++++++++++++++++++
>  include/dt-bindings/pinctrl/rzn1-pinctrl.h         | 191 +++++
>  6 files changed, 1151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
>  create mode 100644 drivers/pinctrl/pinctrl-rzn1.c
>  create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h
>
> --
> 2.7.4
>

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbjQ4WAAoJEHI0Bo8WoVY809sQAI2sohCacWR23p07ZrJpZVLa
Mj+sQnALW+urUxXGXITgFyABscYBZzpbvXUhDYjwkd0MAn+GLCdG6kEJnRgZA1c9
0E5FN8j9Bn3vdsD6xvktZ/pdcUIH9+bvunHhZCzrW4s6UHx7mtReqB1Ih8oQoi2D
y7K1bR/1pxtHQ3VboZSs2aIhUIV8eDzk5L/ZAjgitibH7gcrafNAXJMgi+nO2ioA
RdmzqCNaJ7smkeWrNrlbWjJ2XIJXueSuyY/7XY2sFolljFls48TVWYZG5okYHSyo
bYDfuV2fTfGVfYy9cfvyYZpZXrbXIj9tOoPm6K6qzEnfaK76TMs0EIeFGvyw9Flu
Ym4hQ5af7ELr03sEt/2I18T+3tZ55lPxYbeg/Uisxv39w2q6LvEScR0emuzm+IfW
c+ucfZplP9UadQ+0UVxHFlZqPNAeXuuUly4Y4WW4EN6exXEO0ekjCSRqSm59Vdby
l5B4PTAhpTY602WkabLxvQop9Uk1BNRlwC4sNFN1SXOqqq09bvWmhPDZx5oPKG42
dZccD9inF70DVAmY9lk+HDN0cjfMZz8zmzlFCDwvOLYY/M7C8mIPOGAoXFOy3ivg
OaTO79F00LPpwVN2PiuXW43X2QP0BsMIpAFVvsmOlf8Y1IOe3Ms5H4iXE2xTJZle
HbB1RzvkUR6CH434QdzA
=7OGs
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
