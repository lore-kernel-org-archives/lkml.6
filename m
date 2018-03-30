Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeC3Ht1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:49:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40707 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeC3HtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:49:24 -0400
X-Google-Smtp-Source: AIpwx4/aCX2T3T5/ru36B3X1GJoLaNMDk1hpKL32kf7yAXVhycq5Cx3hwVu8Jv3N8xGb/cxW9MJsig==
MIME-Version: 1.0
In-Reply-To: <20180206044905.30508-7-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io> <20180206044905.30508-7-icenowy@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Mar 2018 15:49:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66_7BmKuF_NFDP9L+wZ5h=nJm0LChCdKaYaoHy9sWUKKw@mail.gmail.com>
Message-ID: <CAGb2v66_7BmKuF_NFDP9L+wZ5h=nJm0LChCdKaYaoHy9sWUKKw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 06/10] ARM: sun8i: h2+: add SY8113B
 regulator used by Orange Pi Zero board
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 12:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Orange Pi Zero board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL6 GPIO is set to output 0
> or 1.3V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H2+ SoC.
>
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

However,

> ---
> No changes in v2.
>
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index 6713d0f2b3f4..34fc35737090 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -94,6 +94,27 @@
>                 reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
>                 post-power-on-delay-ms = <200>;
>         };
> +
> +       reg_sy8113b: gpio-regulator {

You might want to change the node name to something a bit more specific,
like vdd-cpux-regulator. This would decrease the chance of name collisions,
either from other additions or device tree overlays.

ChenYu

> +               compatible = "regulator-gpio";
> +               regulator-name = "vdd-cpux";
> +               regulator-type = "voltage";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1300000>;
> +               regulator-ramp-delay = <50>; /* 4ms */
> +
> +               gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +               enable-active-high;
> +               gpios-states = <0x1>;
> +               states = <1100000 0x0
> +                         1300000 0x1>;
> +       };
> +};
> +
> +&cpu0 {
> +       cpu-supply = <&reg_sy8113b>;
>  };
>
>  &ehci0 {
> --
> 2.15.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
