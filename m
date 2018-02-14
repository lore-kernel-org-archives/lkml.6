Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966275AbeBNAcP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:32:15 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46461 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966208AbeBNAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:32:12 -0500
X-Google-Smtp-Source: AH8x227YzXjH5mQ7KyLz0IJad/jguJYYjyzafMrFncvPAbNZP2FWYIpzXz91VjjazQpz7ntvQec8rh0clDVEhGet67U=
MIME-Version: 1.0
In-Reply-To: <20180212062832.2791-4-rnayak@codeaurora.org>
References: <20180212062832.2791-1-rnayak@codeaurora.org> <20180212062832.2791-4-rnayak@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2018 16:32:09 -0800
X-Google-Sender-Auth: Jba0kRhbNKl7lskTMhdOuHrVWwY
Message-ID: <CAD=FV=UXrmpsK3k+8yZCqVi6S+c_3icPUViDST+shnrQW1A6EA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: sdm845: Add serial console support
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 11, 2018 at 10:28 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add the qup uart node and geni se instance needed to
> support the serial console on the MTP.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 34 ++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 39 +++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 617c7bb25fb1..9eab2b815e0d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -10,4 +10,38 @@
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
> +};
> +
> +&soc {
> +       geni-se@ac0000 {
> +               serial@a84000 {
> +                       status = "okay";
> +               };
> +       };

If others at QC have already decided that they like the style above
then it's OK with me, but I'd prefer instead (at the top level):

&qup_uart2 {
  status = "okay";
};

...then you don't need to replicate all the hierarchy.

> +       pinctrl@3400000 {

Similar here.  This could be:

&qup_uart2_default {
  pinconf {
    ...
  }
};

If you're upset about things being in a "random" order at the top
level, you can still create commented sections in the "dts" file to
organize things, but the above means that you don't end up tabbed in
several levels of indentation for no reason.


> +               qup-uart2-default {
> +                       pinconf {
> +                               pins = "gpio4", "gpio5";
> +                               drive-strength = <2>;
> +                               bias-disable;

Possibly you'd want some sort of pull on the "receive" pin unless
you're guaranteed that on this board that the other side will always
be driving the pin.  As far as I can tell this UART goes to a debug
connector.  If that debug connector is not populated this pin will be
floating, no?


> +                       };
> +               };
> +
> +               qup-uart2-sleep {
> +                       pinconf {
> +                               pins = "gpio4", "gpio5";
> +                               drive-strength = <2>;

Does specifying the "drive-strength" in this case actually do anything
useful?  If not can we leave it out?


> +                               bias-disable;

Feel free to ignore if I'm being ignorant, but I would have expected a
"pull" of some sort to be turned on for the "transmit" pin when you're
in sleep mode.  Otherwise the line will be left floating which could
generate noise to the other side, no?  ...or is there some sort of
external pull present on this board?

Depending on the board you might also want a pull on the "receive" pin
(assuming we wanted one in the "default" state--see above).  With my
extremely limited EE understanding I have the impression that
transitions on a line can still cause power draw even if software
isn't paying attention to them, so it's best to prevent them by adding
a pull.


> +                       };
> +               };
> +       };
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 55a7e0b454e1..8cf8df25b06d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-sdm845.h>
>
>  / {
>         interrupt-parent = <&intc>;
> @@ -193,6 +194,20 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +
> +                       qup_uart2_default: qup-uart2-default {
> +                               pinmux {
> +                                       function = "qup9";
> +                                       pins = "gpio4", "gpio5";
> +                               };
> +                       };
> +
> +                       qup_uart2_sleep: qup-uart2-sleep {
> +                               pinmux {
> +                                       function = "gpio";
> +                                       pins = "gpio4", "gpio5";
> +                               };
> +                       };
>                 };
>
>                 timer@17c90000 {
> @@ -271,5 +286,29 @@
>                         #interrupt-cells = <4>;
>                         cell-index = <0>;
>                 };
> +
> +               qup_1: geni-se@ac0000 {

Color me confused.  So you're saying here that this is "qup_1".
...but above you turn the pinmux for pins "GPIO4" and "GPIO5" to
"qup9", right?  So UART2 is on "qup 1" and "qup 9"?

...OK, so I stared at manuals a bunch more, and _maybe_ I get it.
Maybe there are 3 "QUP v3 modules" each of which handles up to 8
"QUP"s.  So QUP 9 is on "QUP module 1", is that right?  If everyone
understands this already and it's just me that's confused then I guess
you can just ignore this comment.  However, if you can think of any
better alias than "qup_1" that makes this less confusing then that
would make me extra happy.  Like maybe "qupv3_id_1" to match the
manual?
