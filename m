Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755811AbeEaRVs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:21:48 -0400
Received: from web2.default.djames.uk0.bigv.io ([213.138.101.246]:60168 "EHLO
        web2.default.djames.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755708AbeEaRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:21:46 -0400
X-Google-Smtp-Source: ADUXVKLkXIx8pfaoWuBZbif7WxuB5G50cxJI3etFX7hRgGVxcveYl+grjt90fLjwsXU0fkB5kfLF/DRYvI7yxZ5BPxM=
MIME-Version: 1.0
In-Reply-To: <20180531165109.8476-1-jagan@amarulasolutions.com>
References: <20180531165109.8476-1-jagan@amarulasolutions.com>
From: Christopher Obbard <chris@64studio.com>
Date: Thu, 31 May 2018 17:55:31 +0100
X-Gmail-Original-Message-ID: <CAP03XeoY8_-gG-2h8WP+3ZZFzxeyHERG=o7Y3Btk2svy5kco_Q@mail.gmail.com>
Message-ID: <CAP03XeoY8_-gG-2h8WP+3ZZFzxeyHERG=o7Y3Btk2svy5kco_Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2] arm64: allwinner: a64-amarula-relic:
 Enable AP6330 WiFi support
To: jagan@amarulasolutions.com
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

I cannot find any information on this board online, so I am guessing
it has not been released yet and you are developing software support
now.

Do you have any datasheet/overview document of the board?

Rather than making a lot of noise on the various MLs, why not wait
until all hardware has a driver written for it & bugs have been been
smashed, then patch in one series?

Christopher Obbard
64 Studio Ltd.


On 31 May 2018 at 17:51, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Enable AP6330 WiFi/BT combo chip on Amarula A64-Relic board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi WL-PMU-EN pin connected to gpio PL2: attach to mmc-pwrseq
> - WiFi WL-WAKE-AP pin connected to gpio PL3
> - 32kHz external oscillator gate clock from RTC
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Move external rtc clock nodes into main rtc node definition
>   of sun50i-a64.dtsi
>
>  .../dts/allwinner/sun50i-a64-amarula-relic.dts     | 31 ++++++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  3 +++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index ce4a256ff086..eac4793c8502 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -21,12 +21,43 @@
>         chosen {
>                 stdout-path = "serial0:115200n8";
>         };
> +
> +       wifi_pwrseq: wifi-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               clocks = <&rtc 1>;
> +               clock-names = "ext_clock";
> +               reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* WL-PMU-EN: PL2 */
> +       };
>  };
>
>  &ehci0 {
>         status = "okay";
>  };
>
> +&mmc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins>;
> +       vmmc-supply = <&reg_dcdc1>;
> +       /*
> +        * Schematic shows both dldo4 and eldo1 connected for vcc-io-wifi, but
> +        * dldo4 connection shows DNP(Do Not Populate) and eldo1 connected with
> +        * 0Ohm register to vcc-io-wifi so eldo1 is used.
> +        */
> +       vqmmc-supply = <&reg_eldo1>;
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "okay";
> +
> +       brcmf: wifi@1 {
> +               reg = <1>;
> +               compatible = "brcm,bcm4329-fmac";
> +               interrupt-parent = <&r_pio>;
> +               interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAKE-AP: PL3 */
> +               interrupt-names = "host-wake";
> +       };
> +};
> +
>  &mmc2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc2_pins>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1b2ef28c42bd..82516aec4153 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -634,6 +634,9 @@
>                         reg = <0x01f00000 0x54>;
>                         interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
> +                       clocks = <&osc32k>;
> +                       #clock-cells = <1>;
>                 };
>
>                 r_intc: interrupt-controller@1f00c00 {
> --
> 2.14.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
