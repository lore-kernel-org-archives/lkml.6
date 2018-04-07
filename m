Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeDGBOp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 21:14:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35290 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDGBOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 21:14:42 -0400
X-Google-Smtp-Source: AIpwx4+Jlf0nqD9lkl5DAHJ4rQ8rzRdo6TwOSmKkzCwQJ8/UdWgDWT5NoRj4bkzYs9yF8v2mHw2Rbg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180405161834.3850-3-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-3-ilina@codeaurora.org>
Message-ID: <152306368031.94378.14957212064809086345@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 02/10] dt-bindings: introduce RPMH RSC bindings for Qualcomm
 SoCs
Date: Fri, 06 Apr 2018 18:14:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w371En1R015660

Quoting Lina Iyer (2018-04-05 09:18:26)
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> new file mode 100644
> index 000000000000..dcf71a5b302f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> @@ -0,0 +1,127 @@
> +RPMH RSC:
> +------------
> +
> +Resource Power Manager Hardened (RPMH) is the mechanism for communicating with
> +the hardened resource accelerators on Qualcomm SoCs. Requests to the resources
> +can be written to the Trigger Command Set (TCS)  registers and using a (addr,
> +val) pair and triggered. Messages in the TCS are then sent in sequence over an
> +internal bus.
> +
> +The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
> +(Resource State Coordinator a.k.a RSC) that can handle a multiple sleep and

s/ a / /

> +active/wake resource requests. Multiple such DRVs can exist in a SoC and can
> +be written to from Linux. The structure of each DRV follows the same template
> +with a few variations that are captured by the properties here.
> +
> +A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
> +have powered off to facilitate idle power saving. TCS could be classified as -

s/ -/:/

> +
> +       SLEEP,  /* Triggered by F/W */
> +       WAKE,   /* Triggered by F/W */
> +       ACTIVE, /* Triggered by Linux */
> +       CONTROL /* Triggered by F/W */

Drop the commas?

> +
> +The order in which they are described in the DT, should match the hardware
> +configuration.
> +
> +Requests can be made for the state of a resource, when the subsystem is active
> +or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
> +will be an aggregate of the sleep votes from each of those subsystems. Clients
> +may request a sleep value for their shared resources in addition to the active
> +mode requests.
> +
> +Properties:
> +
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Should be "qcom,rpmh-rsc".
> +
> +- reg:
> +       Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: The first register specifies the base address of the DRV.
> +                   The second register specifies the start address of the
> +                   TCS.
> +
> +- reg-names:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Maps the register specified in the reg property. Must be
> +                   "drv" and "tcs".
> +
> +- interrupts:
> +       Usage: required
> +       Value type: <prop-encoded-interrupt>
> +       Definition: The interrupt that trips when a message complete/response
> +                  is received for this DRV from the accelerators.
> +
> +- qcom,drv-id:
> +       Usage: required
> +       Value type: <u32>
> +       Definition: the id of the DRV in the RSC block.
> +
> +- qcom,tcs-config:
> +       Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: the tuple defining the configuration of TCS.
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
> +bindings as child of the RSC controllers they wish to communicate with.

s/child/child nodes/


> +
> +Example 1:
> +
> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
> +register offsets for DRV2 start at 0D00, the register calculations are like
> +this -
> +First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> +Second tuple: 0x179E0000 + 0xD00 = 0x179E0D00
> +
> +       apps_rsc: rsc@179e000 {
> +               label = "apps_rsc";
> +               compatible = "qcom,rpmh-rsc";
> +               reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;

The first reg property overlaps the second one. Does this second one
ever move around? I would hardcode it in the driver to be 0xd00 away
from the drv base instead of specifying it in DT if it's the same all
the time.

Also, the example shows 0x179c0000 which I guess is the actual beginning
of the RSC block. So the binding seems to be for one DRV inside of an
RSC. Can we get the full description of the RSC in the binding instead?
I imagine that means there's a DRV0,1,2 and those probably have an
interrupt per each DRV and then a different TCS config per each one too?
If the binding can describe all of the RSC then we can use different
DRVs by changing the qcom,drv-id property.

	rsc@179c0000 {
		compatible = "qcom,rpmh-rsc";
		reg = <0x179c0000 0x10000>,
		      <0x179d0000 0x10000>,
		      <0x179e0000 0x10000>;
		qcom,tcs-offset = <0xd00>;
		qcom,drv-id = <0/1/2>;
		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
	}

This is sort of what I imagine it would look like. I have no idea how
the tcs config would work unless each DRV has the same TCS config
though. Otherwise, if each node is for a drv, then I would expect the
node would be called 'drv' and we wouldn't need the drv-id property and
the compatible string would say drv instead of rsc?

BTW, what are the other DRVs used for in the apps RSC?

> +               reg-names = "drv", "tcs";
> +               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +               qcom,drv-id = <2>;
> +               qcom,tcs-config = <SLEEP_TCS   3>,
> +                                 <WAKE_TCS    3>,
> +                                 <ACTIVE_TCS  2>,
> +                                 <CONTROL_TCS 1>;
> +       };
> +
> +Example 2:
> +
> +For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
> +register offsets for DRV0 start at 01C00, the register calculations are like
> +this -
> +First tuple: 0xAF20000
> +Second tuple: 0xAF20000 + 0x1C00 = 0xAF21C00
> +
> +       disp_rsc: rsc@af20000 {
> +               label = "disp_rsc";
> +               compatible = "qcom,rpmh-rsc";
> +               reg = <0xaf20000 0x10000>, <0xaf21c00 0x3000>;

Ok. The TCS offset seems totally random now.

> +               reg-names = "drv", "tcs";
> +               interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
> +               qcom,drv-id = <0>;
> +               qcom,tcs-config = <SLEEP_TCS   1>,
> +                                 <WAKE_TCS    1>,
> +                                 <ACTIVE_TCS  0>,
> +                                 <CONTROL_TCS 0>;
> +       };
