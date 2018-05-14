Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeENWKI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeENWKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:10:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: "moderated list:ARM64 PORT AARCH64 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Yossi Mansharoff <yossim@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1523973390-2387-1-git-send-email-yossim@codeaurora.org>
Cc: Yossi Mansharoff <yossim@codeaurora.org>
References: <1523973390-2387-1-git-send-email-yossim@codeaurora.org>
Message-ID: <152633580491.34267.3508281594437081335@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] arm64: dts: qcom: Collapse usb support into one node
Date: Mon, 14 May 2018 15:10:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EMACJT012292

Quoting Yossi Mansharoff (2018-04-17 06:56:30)
> We currently have three device nodes for the same USB hardware
> block, as evident by the reuse of the same reg address multiple
> times. Now that the chipidea driver fully supports OTG with the
> MSM wrapper we can collapse all these nodes into one USB device
> node, reflecting the true nature of the hardware.

None of this makes sense. Commit text is totally bogus now.

> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 9ff8487..1505921 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -371,18 +372,18 @@
>                         adp-disable;
>                         hnp-disable;
>                         srp-disable;
> -                       dr_mode = "host";
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&usb_sw_sel_pm>;
> +                       mux-controls = <&usb_switch>;
> +                       mux-control-names = "usb_switch";
> +
>                         ulpi {
>                                 phy {
>                                         v1p8-supply = <&pm8916_l7>;
>                                         v3p3-supply = <&pm8916_l13>;
> -                                       extcon = <&usb_id>;
>                                 };
>                         };
>                 };
>  
> +

Why the newline?

>                 lpass@7708000 {
>                         status = "okay";
>                 };
> @@ -512,11 +513,17 @@
>  
>         usb_id: usb-id {
>                 compatible = "linux,extcon-usb-gpio";
> -               vbus-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
> +               id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;

Hmm?

>                 pinctrl-names = "default";
>                 pinctrl-0 = <&usb_id_default>;
>         };
>  
> +       usb_switch: usb-switch {
> +               compatible = "gpio-mux";

Needs a better compatible string for the actual mux part. The gpio-mux
can come after that because it's generic, but it's good to record the
actual mux part too.

> +               mux-gpios = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
> +               #mux-control-cells = <0>;
> +       };
