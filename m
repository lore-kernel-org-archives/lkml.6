Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbeBMGXZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 01:23:25 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42924 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeBMGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 01:23:22 -0500
X-Google-Smtp-Source: AH8x226k9HS0LJ/zMGMbSxpYMtGlK5GagQsp17bNaC10iHCrZP2Avwv/Cqyuf5TRXrb8OehekvuvFcvQILJD+k1MZKI=
MIME-Version: 1.0
In-Reply-To: <20180205235757.246758-3-brendanhiggins@google.com>
References: <20180205235757.246758-1-brendanhiggins@google.com> <20180205235757.246758-3-brendanhiggins@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 13 Feb 2018 16:52:56 +1030
X-Google-Sender-Auth: IcbHmKouHDF4Oh91lioBIt2Rt5o
Message-ID: <CACPK8XdXOaPZ5i=qKns3=V87nhfY62PNr4kwH9xwVYxY0djo0g@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Brendan Higgins <brendanhiggins@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>, julien.thierry@arm.com,
        pombredanne@nexb.com, devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

On Tue, Feb 6, 2018 at 10:27 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
> specific device tree for the NPCM750 (Poleg) evaluation board.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Avi Fishman <avifishman70@gmail.com>

This looks well acked, reviewed and tested. How do you plan to have
the ARM SoC maintainers merge your patches?

> ---
>  .../arm/cpu-enable-method/nuvoton,npcm7xx-smp      |  42 ++++++
>  .../devicetree/bindings/arm/npcm/npcm.txt          |   6 +
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts          |  35 +++++
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi             | 162 +++++++++++++++++++++
>  include/dt-bindings/clock/nuvoton,npcm7xx-clks.h   |  35 +++++
>  5 files changed, 280 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm7xx-smp
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clks.h

You need to add nuvoton-npcm750-evb.dts to arch/arm/boot/dts/Makefile

Once you've done that you can add

Tested-by: Joel Stanley <joel@jms.id.au>

as I tested this on an EVB.

> diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> new file mode 100644
> index 000000000000..08e906f88c49
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Nuvoton Technology corporation.
> +// Copyright 2018 Google, Inc.
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/nuvoton,npcm7xx-clks.h>
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&gic>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               enable-method = "nuvoton,npcm7xx-smp";
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <0>;
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <1>;
> +                       next-level-cache = <&l2>;
> +               };
> +       };
> +
> +/* external clock signal rg1refck, supplied by the phy */
> +clk-rg1refck {
> +       compatible = "fixed-clock";
> +       #clock-cells = <0>;
> +       clock-frequency = <125000000>;
> +};
> +
> +/* external clock signal rg2refck, supplied by the phy */
> +clk-rg2refck {
> +       compatible = "fixed-clock";
> +       #clock-cells = <0>;
> +       clock-frequency = <125000000>;
> +};
> +
> +clk-xin {
> +       compatible = "fixed-clock";
> +       #clock-cells = <0>;
> +       clock-frequency = <50000000>;
> +};

The whitespace here needs to be fixed.

Cheers,

Joel

> +
> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic>;
> +               ranges = <0x0 0xf0000000 0x00900000>;
> +
