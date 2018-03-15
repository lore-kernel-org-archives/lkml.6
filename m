Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeCOS5Z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbeCOS5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:57:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F1E204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180315144841.16144-1-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180315144841.16144-1-srinivas.kandagatla@linaro.org>
Message-ID: <152114024246.111154.2712387658941057310@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] ARM: dts: qcom: Add apq8064 Dragon Board 600c support
Date: Thu, 15 Mar 2018 11:57:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting srinivas.kandagatla@linaro.org (2018-03-15 07:48:41)
> diff --git a/arch/arm/boot/dts/qcom-apq8064-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
> new file mode 100644
> index 000000000000..6a3250151038
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "qcom-apq8064-v2.0.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> +#include <dt-bindings/mfd/qcom-rpm.h>
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. DB600c";
> +       compatible = "arrow,apq8064-db600c", "qcom,apq8064";
> +
> +       aliases {
> +               serial0 = &gsbi7_serial;
> +               serial1 = &gsbi1_serial;
> +               i2c0 = &gsbi2_i2c;
> +               i2c1 = &gsbi3_i2c;
> +               i2c2 = &gsbi4_i2c;
> +               i2c3 = &gsbi7_i2c;
> +               spi0 = &gsbi5_spi;
> +       };

Can you also add a chosen node for the stdout-path? Or maybe
that's contentious because there are two serial ports that could
possibly be used for serial console?

> +
> +       regulators {
> +               compatible = "simple-bus";
> +               vph: regulator-fixed@1 {

Drop @1?

> +                       compatible = "regulator-fixed";
> +                       regulator-min-microvolt = <4500000>;
> +                       regulator-max-microvolt = <4500000>;
> +                       regulator-name = "VPH";
> +                       regulator-type = "voltage";
> +                       regulator-boot-on;
> +               };
> +
> +               /* on board fixed 3.3v supply */
> +               vcc3v3: vcc3v3 {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "VCC3V3";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-always-on;
> +               };
> +
> +       };
> +
> +       hdmi-out {
> +               compatible = "hdmi-connector";
> +               type = "a";
> +
> +               port {
> +                       hdmi_con: endpoint {
> +                               remote-endpoint = <&hdmi_out>;
> +                       };
> +               };
> +       };

Cool!

> +
> +       soc {
> +               pinctrl@800000 {
> +                       card_detect: card_detect {
> +                               mux {
> +                                       pins = "gpio26";
> +                                       function = "gpio";
> +                                       bias-disable;
> +                               };
> +                       };
[...]
> +                                       regulator-min-microvolt = <1000000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       bias-pull-down;
> +                               };
> +
> +                               l5 {
> +                                       regulator-min-microvolt = <2750000>;
> +                                       regulator-max-microvolt = <3000000>;
> +                                       bias-pull-down;
> +                                       regulator-boot-on;
> +                                       regulator-always-on;
> +                               };
> +
> +                               l6 {
> +                                       regulator-min-microvolt = <2950000>;
> +                                       regulator-max-microvolt = <2950000>;
> +                                       bias-pull-down;
> +                               };
> +
> +                               l7 {
> +                                       regulator-min-microvolt = <2950000>;
> +                                       regulator-max-microvolt = <2950000>;
> +                                       regulator-boot-on;
> +                                       regulator-always-on;
> +                               };
> +
> +                               /**
> +                               /**

Weird double comment here.

> +                                * 1.8v required on LS expansion
> +                                * for mezzanine boards
> +                                */
> +                               l15 {
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;
> +                               };
> +
