Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeEBUh5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:37:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45075 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEBUhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:37:55 -0400
X-Google-Smtp-Source: AB8JxZodNR7DexvuvcAYW+H2ikI3nxZMC9xfM0ut6+7HXuAea5BoqXzWg3apMVWOWN9jr+Dy6UHRjg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180502193749.31004-3-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org
References: <20180502193749.31004-1-ilina@codeaurora.org>
 <20180502193749.31004-3-ilina@codeaurora.org>
Message-ID: <152529347285.138124.5939045845945488373@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 02/10] dt-bindings: introduce RPMH RSC bindings for Qualcomm
 SoCs
Date: Wed, 02 May 2018 13:37:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42Kc3dY032258

Quoting Lina Iyer (2018-05-02 12:37:41)
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> new file mode 100644
> index 000000000000..950d56325284
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> @@ -0,0 +1,132 @@
[...]
> +
> +- qcom,drv-id:
> +       Usage: required
> +       Value type: <u32>
> +       Definition: The id of the DRV in the RSC block that will be used by
> +                   this controller.

used by the OS? instead of by this controller?

> +
> +- qcom,tcs-config:
> +       Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: The tuple defining the configuration of TCS.
> +                   Must have 2 cells which describe each TCS type.
> +                   <type number_of_tcs>.
> +                   The order of the TCS must match the hardware
> +                   configuration.
> +       - Cell #1 (TCS Type): TCS types to be specified -
> +                   SLEEP_TCS
> +                   WAKE_TCS
> +                   ACTIVE_TCS
> +                   CONTROL_TCS
> +       - Cell #2 (Number of TCS): <u32>
> +
> +- label:
> +       Usage: optional
> +       Value type: <string>
> +       Definition: Name for the RSC. The name would be used in trace logs.
> +
> +Drivers that want to use the RSC to communicate with RPMH must specify their
> +bindings as child nodes of the RSC controllers they wish to communicate with.
> +
> +Example 1:
> +
> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
> +register offsets for DRV2 start at 0D00, the register calculations are like

0xd00? Instead of what looks like octal.

> +this -
> +DRV0: 0x179C0000
> +DRV2: 0x179C0000 + 0x10000 = 0x179D0000
> +DRV2: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> +TCS-OFFSET: 0xD00
> +
> +       apps_rsc: rsc@179c0000 {
> +               label = "apps_rsc";
> +               compatible = "qcom,rpmh-rsc";
> +               reg = <0x179c0000 0x10000>, <0x179d0000 0x10000>,
> +                     <0x179e0000 0x10000>, <0xd00 0>;
> +               reg-names = "drv-0", "drv-1", "drv-2", "tcs-offset";

tcs-offset should be a property, not a reg property value.

> +               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;

There should be three interrupts? Not 1?

> +               qcom,drv-id = <2>;
> +               qcom,tcs-config = <SLEEP_TCS   3>,
> +                                 <WAKE_TCS    3>,
> +                                 <ACTIVE_TCS  2>,
> +                                 <CONTROL_TCS 1>;
> +       };
> +
