Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeCVCX7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:23:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51017 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeCVCXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:23:55 -0400
X-Google-Smtp-Source: AG47ELsMkFnK055hz5L+x5jrnKr1CCYowtM4qpbObgmBOAc0oKH0MM25/se6SnPM7NX5AP3CRtMzkA==
MIME-Version: 1.0
In-Reply-To: <fbb4d14a83ed80e9740c042cd9df58b8132b4c91.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <fbb4d14a83ed80e9740c042cd9df58b8132b4c91.1520344489.git-series.maxime.ripard@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 22 Mar 2018 10:23:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v65AfHHUZ=fUB+TPUZaLdYb4mN3hZ=3n5GOAD39C42+Nag@mail.gmail.com>
Message-ID: <CAGb2v65AfHHUZ=fUB+TPUZaLdYb4mN3hZ=3n5GOAD39C42+Nag@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] arm: dts: sun8i: a33: Add the DSI-related nodes
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 9:56 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> The A33 has a MIPI-DSI block, along with its D-PHY. Let's add it in order
> to use it in the relevant boards.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 44 +++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 50eb84fa246a..94cfa7b1bbfa 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -236,6 +236,11 @@
>                                         #address-cells = <1>;
>                                         #size-cells = <0>;
>                                         reg = <1>;
> +
> +                                       tcon0_out_dsi0: endpoint@1 {
> +                                               reg = <1>;
> +                                               remote-endpoint = <&dsi0_in_tcon0>;
> +                                       };
>                                 };
>                         };
>                 };
> @@ -280,6 +285,45 @@
>                         #io-channel-cells = <0>;
>                 };
>
> +               dsi0: dsi@1ca0000 {

Nit: There's only one so you don't need the numbered suffix. Also,
is "dsi" specific enough, or should we use "mipi-dsi"

> +                       compatible = "allwinner,sun6i-a31-mipi-dsi";
> +                       reg = <0x01ca0000 0x1000>;
> +                       interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_MIPI_DSI>,
> +                                <&ccu CLK_DSI_SCLK>;
> +                       clock-names = "bus", "mod";
> +                       resets = <&ccu RST_BUS_MIPI_DSI>;
> +                       phys = <&dphy0>;
> +                       phy-names = "dphy";
> +                       status = "disabled";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0>;
> +
> +                                       dsi0_in_tcon0: endpoint {
> +                                               remote-endpoint = <&tcon0_out_dsi0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               dphy0: d-phy@1ca1000 {

Same nit, and "dsi-phy" would be better.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +                       compatible = "allwinner,sun6i-a31-mipi-dphy";
> +                       reg = <0x01ca1000 0x1000>;
> +                       clocks = <&ccu CLK_BUS_MIPI_DSI>,
> +                                <&ccu CLK_DSI_DPHY>;
> +                       clock-names = "bus", "mod";
> +                       resets = <&ccu RST_BUS_MIPI_DSI>;
> +                       status = "disabled";
> +                       #phy-cells = <0>;
> +               };
> +
>                 fe0: display-frontend@1e00000 {
>                         compatible = "allwinner,sun8i-a33-display-frontend";
>                         reg = <0x01e00000 0x20000>;
> --
> git-series 0.9.1
