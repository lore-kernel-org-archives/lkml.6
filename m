Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeDYOuT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754300AbeDYOuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:50:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB73C21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AB8JxZrjwcg5IVBxQVtASfpQh5/Nbp1qm73F9kbHmfsgHyYKkdlayWvzily68G0v3npX1WIfwPatC623R/NR4UbyWLk=
MIME-Version: 1.0
In-Reply-To: <20180425125449.19755-10-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com> <20180425125449.19755-10-kishon@ti.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 25 Apr 2018 09:49:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+d6VdbYT3djvYQARjEP3qXiG16f9e8XESfNBj3zzf2NQ@mail.gmail.com>
Message-ID: <CAL_Jsq+d6VdbYT3djvYQARjEP3qXiG16f9e8XESfNBj3zzf2NQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] ARM: dts: dra72-evm-common: Add wilink8 wlan support
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Eyal Reizer <eyalr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 7:54 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> From: Hari Nagalla <hnagalla@ti.com>
>
> Wilink8 module is a combo wireless connectivity card based
> on Texas Instrument's wl18xx solution.
>
> Add support for the wlan capabilities of this module by muxing
> the relevant mmc lines, and setting the required device-tree
> data.
>
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [nsekhar@ti.com: drop WLAN_EN pinmux. It should be done by bootloader.
>                  Also, some commit message adjustments]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/dra72-evm-common.dtsi   | 42 +++++++++++++++++++++++
>  arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi | 11 ++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
> index 8e3b185d864b..1e4d36e33a1b 100644
> --- a/arch/arm/boot/dts/dra72-evm-common.dtsi
> +++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
> @@ -44,6 +44,16 @@
>                 regulator-boot-on;
>         };
>
> +       evm_3v6: fixedregulator-evm_3v6 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "evm_3v6";
> +               regulator-min-microvolt = <3600000>;
> +               regulator-max-microvolt = <3600000>;
> +               vin-supply = <&evm_5v0>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
>         vsys_3v3: fixedregulator-vsys3v3 {
>                 /* Output 2 of TPS43351QDAPRQ1 on dra72-evm */
>                 /* Output 2 of LM5140QRWGTQ1 on dra71-evm */
> @@ -171,6 +181,15 @@
>                         clocks = <&atl_clkin2_ck>;
>                 };
>         };
> +
> +       vmmcwl_fixed: fixedregulator-mmcwl {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vmmcwl_fixed";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               gpio = <&gpio5 8 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
>  };
>
>  &dra7_pmx_core {
> @@ -398,6 +417,29 @@
>         max-frequency = <192000000>;
>  };
>
> +&mmc4 {
> +       status = "okay";
> +       vmmc-supply = <&evm_3v6>;
> +       vqmmc-supply = <&vmmcwl_fixed>;
> +       bus-width = <4>;
> +       cap-power-off-card;
> +       keep-power-in-suspend;
> +       non-removable;
> +       pinctrl-names = "default", "hs", "sdr12", "sdr25";
> +       pinctrl-0 = <&mmc4_pins_default>;
> +       pinctrl-1 = <&mmc4_pins_default>;
> +       pinctrl-2 = <&mmc4_pins_default>;
> +       pinctrl-3 = <&mmc4_pins_default>;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       wlcore: wlcore@2 {

wifi@2
