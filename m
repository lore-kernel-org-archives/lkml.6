Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbeCINBR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeCINBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:01:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6838821723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AG47ELuJHm/EARAFdgcY1uATotPQ2PCpkSaO5QDwzaf4M7ZJUUQyuMGUXL4vHWe/IJJuxEJaeZaYql/iWDNqkUxlIjg=
MIME-Version: 1.0
In-Reply-To: <20180308162559.391-1-s.nawrocki@samsung.com>
References: <CGME20180308162609epcas1p45458c1671c38b389e047f17804690eb9@epcas1p4.samsung.com>
 <20180307172711.15697-4-s.nawrocki@samsung.com> <20180308162559.391-1-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 9 Mar 2018 14:01:12 +0100
X-Gmail-Original-Message-ID: <CAJKOXPemC09mmjt9AKa9Qfhy14=CdUampi3=x957=NNEzq7LqQ@mail.gmail.com>
Message-ID: <CAJKOXPemC09mmjt9AKa9Qfhy14=CdUampi3=x957=NNEzq7LqQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: Enable HDMI audio on Snow Chromebook
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene@kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 5:25 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This patch adds new cpu, codec subnodes according to the updated
> "google,snow-audio-max98095" DT bindings and the I2S clock tree
> configuration so sound on the HDMI interface can also be supported.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - changed order of codec phandles in codec/cpu-dai property
>    to match the DT bindings documentation.
> ---
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 4 ++++
>  arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> index bdf59dd3654b..932a00cfd716 100644
> --- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/clock/maxim,max77686.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/sound/samsung-i2s.h>
>  #include "exynos5250.dtsi"
>
>  / {
> @@ -523,6 +524,9 @@
>  };
>
>  &i2s0 {
> +       assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
> +       assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
> +       #clock-cells = <1>;

Shouldn't this be property of exynos5250.dtsi? Along with clock-output-names?

BR,
Krzysztof

>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 16e37c337a3f..75fdc5e6d423 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -18,6 +18,14 @@
>
>                 samsung,model = "Snow-I2S-MAX98095";
>                 samsung,audio-codec = <&max98095>;
> +
> +               cpu {
> +                       sound-dai = <&i2s0 0>;
> +               };
> +
> +               codec {
> +                       sound-dai = <&max98095 0>, <&hdmi>;
> +               };
>         };
>  };
>
> --
> 2.14.2
>
