Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeECOyw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbeECOyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:54:46 -0400
X-Google-Smtp-Source: AB8JxZqv/xJqUJBHIU4jrQsik+hnrFVTCvoPwKQ8XNUZKVb1RwQd/N7pTbWBmUr55UYvnB9hTmU2TqC7AFxxQ+HEcp8=
MIME-Version: 1.0
In-Reply-To: <1525359006-27251-1-git-send-email-krzk@kernel.org>
References: <1525359006-27251-1-git-send-email-krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 3 May 2018 16:54:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPenZiTaXL+4b8gyGMLK_06LG5+ACZqfFN+oGRPAkzGYPw@mail.gmail.com>
Message-ID: <CAJKOXPenZiTaXL+4b8gyGMLK_06LG5+ACZqfFN+oGRPAkzGYPw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: tegra: Add support for 256 MB Colibri-T20 (plus
 such board on Iris)
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 4:50 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
> (with 1024 MB NAND) flavors.  Add support for the 256 MB version on Iris
> evaluation board.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/tegra.txt    |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/tegra20-colibri-256.dtsi         |  11 +
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi         | 531 +--------------------
>  ...gra20-colibri-512.dtsi => tegra20-colibri.dtsi} |   4 -
>  arch/arm/boot/dts/tegra20-iris-256.dts             |  10 +
>  arch/arm/boot/dts/tegra20-iris-512.dts             |  98 +---
>  ...gra20-iris-512.dts => tegra20-iris-common.dtsi} |  11 +-
>  8 files changed, 31 insertions(+), 636 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra20-colibri-256.dtsi
>  copy arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi} (99%)
>  create mode 100644 arch/arm/boot/dts/tegra20-iris-256.dts
>  copy arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-iris-common.dtsi} (85%)
>
> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> index 32f62bb7006d..d304574ae441 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
> @@ -49,6 +49,7 @@ board-specific compatible values:
>    toradex,apalis_t30-eval
>    toradex,apalis-tk1
>    toradex,apalis-tk1-eval
> +  toradex,colibri_t20-256
>    toradex,colibri_t20-512
>    toradex,colibri_t30
>    toradex,colibri_t30-eval-v3
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index da7d08c3ae98..d63214c6967c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1031,6 +1031,7 @@ dtb-$(CONFIG_ARCH_TANGO) += \
>         tango4-vantage-1172.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>         tegra20-harmony.dtb \
> +       tegra20-iris-256.dtb \
>         tegra20-iris-512.dtb \
>         tegra20-medcom-wide.dtb \
>         tegra20-paz00.dtb \
> diff --git a/arch/arm/boot/dts/tegra20-colibri-256.dtsi b/arch/arm/boot/dts/tegra20-colibri-256.dtsi
> new file mode 100644
> index 000000000000..8f8922b0b7e7
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra20-colibri-256.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "tegra20-colibri.dtsi"
> +
> +/ {
> +       model = "Toradex Colibri T20 256MB";
> +       compatible = "toradex,colibri_t20-256", "nvidia,tegra20";
> +
> +       memory {
> +               reg = <0x00000000 0x20000000>;

... and obviously this is not 256 MB so I need to resend.

Sorry for the noise.

Best regards,
Krzysztof
