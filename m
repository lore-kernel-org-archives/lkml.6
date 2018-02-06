Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeBFTfh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:35:37 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36926 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeBFTfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:35:34 -0500
X-Google-Smtp-Source: AH8x226iWAOGJVs0OgVC2E9pAzz+2qqWx0WD3ajnlZEmSccQ/ntCil8t9q/Epdv+Fmy6MWMxhUB97++uMB4OxvAaqTs=
MIME-Version: 1.0
In-Reply-To: <20180131161941.29865-4-rnayak@codeaurora.org>
References: <20180131161941.29865-1-rnayak@codeaurora.org> <20180131161941.29865-4-rnayak@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Feb 2018 11:35:32 -0800
X-Google-Sender-Auth: -SNzV2cvhhLQeSfC3P_DyHKmbd0
Message-ID: <CAD=FV=VwTZo2YOxw0W7JbuF_Dic8YHmQZ6_FAxiZG3BXiS_VEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: sdm845: Add serial console support
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        evgreen@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 31, 2018 at 8:19 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add the qup uart node and geni se instance needed to
> support the serial console on the MTP.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 42 +++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 21 +++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 617c7bb25fb1..42fbf2ab9a2d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -10,4 +10,46 @@
>  / {
>         model = "Qualcomm Technologies, Inc. SDM845 MTP";
>         compatible = "qcom,sdm845-mtp";
> +
> +       aliases {
> +               serial0 = &qup_uart2;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0";
> +       };
> +
> +       soc {

I don't know if there's an official position, but in general I'm seen
people use the actual "soc" alias here.  AKA at the top level of this
dts, just do:

&soc {
  ...
};

Normally doing stuff like that is useful so you don't need to
replicate the whole hierarchy.  In this case that's not a huge
savings, but it can be nice to be consistent.  In the very least it
saves you a level of indentation.


> +               serial@a84000 {
> +                       status = "okay";
> +               };

Similarly here you can use the alias from the sdm845.dtsi file to
avoid replicating the hierarchy.  AKA at the top level do:

&qup_uart2 {
  status = "okay";
};

In this case it saves you 2 levels of indentation.

> +
> +               pinctrl@3400000 {
> +                       qup_uart2_default: qup_uart2_default {

I'm not sure how persnickety I should be, but according to
<https://elinux.org/Device_Tree_Linux>:

  node names use dash "-" instead of underscore "_"

...but, of course, labels can't use dashes (and the same page says to
use underscore for labels).  This is why, in rk3288 for instance, you
see:

i2c2_xfer: i2c2-xfer {
  rockchip,pins = <6 9 RK_FUNC_1 &pcfg_pull_none>,
  <6 10 RK_FUNC_1 &pcfg_pull_none>;
};

AKA the label and the node name are the same but the label uses "_"
and the node names use "-".


> +                               pinmux {
> +                                       function = "qup9";
> +                                       pins = "gpio4", "gpio5";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio4", "gpio5";
> +                                       drive-strength = <2>;
> +                                       bias-disable;
> +                               };
> +                       };
> +
> +                       qup_uart2_sleep: qup_uart2_sleep {
> +                               pinmux {
> +                                       function = "gpio";
> +                                       pins = "gpio4", "gpio5";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio4", "gpio5";
> +                                       drive-strength = <2>;
> +                                       bias-disable;
> +                               };
> +                       };
> +               };

As per my (admittedly tardy) response to v1, these shouldn't be in the
board file because every board that happens to need uart2 will need to
duplicate these definitions.


> +       };
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 02520f19e4ca..c4ce70840acf 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-sdm845.h>
>
>  / {
>         model = "Qualcomm Technologies, Inc. SDM845";
> @@ -273,5 +274,25 @@
>                         cell-index = <0>;
>                 };
>
> +               qup_1: qcom,geni_se@ac0000 {
> +                       compatible = "qcom,geni-se-qup";
> +                       reg = <0xac0000 0x6000>;

I think you may have mentioned this in another context, but this
doesn't match the current bindings.  Some clocks should be here.
...and it looks like the uart should be a subnode.


> +               };
> +
> +               qup_uart2: serial@a84000 {
> +                       compatible = "qcom,geni-console", "qcom,geni-uart";
> +                       reg = <0xa84000 0x4000>;
> +                       reg-names = "se_phys";
> +                       clock-names = "se-clk", "m-ahb", "s-ahb";
> +                       clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>,
> +                                <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +                                <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +                       pinctrl-names = "default", "sleep";
> +                       pinctrl-0 = <&qup_uart2_default>;
> +                       pinctrl-1 = <&qup_uart2_sleep>;

In general the "SoC" dtsi file shouldn't be relying on definitions
that are made in the board "dts" file.

...if everyone disagrees with me and we really decide to duplicate all
the pinctrl in all board files, we'll need to move the
"pinctrl-names", "pinctrl-0", and "pinctrl-1" to the board files too.
;)


-Doug
