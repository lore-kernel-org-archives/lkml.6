Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDIQIG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:08:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeDIQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:08:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6DEF60386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 9 Apr 2018 10:08:00 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Message-ID: <20180409160800.GC19682@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-3-ilina@codeaurora.org>
 <152306368031.94378.14957212064809086345@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152306368031.94378.14957212064809086345@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06 2018 at 19:14 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-04-05 09:18:26)
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>> new file mode 100644
>> index 000000000000..dcf71a5b302f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>> @@ -0,0 +1,127 @@
>> +RPMH RSC:
>> +------------
>> +
>> +Resource Power Manager Hardened (RPMH) is the mechanism for communicating with
>> +the hardened resource accelerators on Qualcomm SoCs. Requests to the resources
>> +can be written to the Trigger Command Set (TCS)  registers and using a (addr,
>> +val) pair and triggered. Messages in the TCS are then sent in sequence over an
>> +internal bus.
>> +
>> +The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
>> +(Resource State Coordinator a.k.a RSC) that can handle a multiple sleep and
>
>s/ a / /
>
>> +active/wake resource requests. Multiple such DRVs can exist in a SoC and can
>> +be written to from Linux. The structure of each DRV follows the same template
>> +with a few variations that are captured by the properties here.
>> +
>> +A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
>> +have powered off to facilitate idle power saving. TCS could be classified as -
>
>s/ -/:/
>
>> +
>> +       SLEEP,  /* Triggered by F/W */
>> +       WAKE,   /* Triggered by F/W */
>> +       ACTIVE, /* Triggered by Linux */
>> +       CONTROL /* Triggered by F/W */
>
>Drop the commas?
>
>> +
>> +The order in which they are described in the DT, should match the hardware
>> +configuration.
>> +
>> +Requests can be made for the state of a resource, when the subsystem is active
>> +or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
>> +will be an aggregate of the sleep votes from each of those subsystems. Clients
>> +may request a sleep value for their shared resources in addition to the active
>> +mode requests.
>> +
>> +Properties:
>> +
>> +- compatible:
>> +       Usage: required
>> +       Value type: <string>
>> +       Definition: Should be "qcom,rpmh-rsc".
>> +
>> +- reg:
>> +       Usage: required
>> +       Value type: <prop-encoded-array>
>> +       Definition: The first register specifies the base address of the DRV.
>> +                   The second register specifies the start address of the
>> +                   TCS.
>> +
>> +- reg-names:
>> +       Usage: required
>> +       Value type: <string>
>> +       Definition: Maps the register specified in the reg property. Must be
>> +                   "drv" and "tcs".
>> +
>> +- interrupts:
>> +       Usage: required
>> +       Value type: <prop-encoded-interrupt>
>> +       Definition: The interrupt that trips when a message complete/response
>> +                  is received for this DRV from the accelerators.
>> +
>> +- qcom,drv-id:
>> +       Usage: required
>> +       Value type: <u32>
>> +       Definition: the id of the DRV in the RSC block.
>> +
>> +- qcom,tcs-config:
>> +       Usage: required
>> +       Value type: <prop-encoded-array>
>> +       Definition: the tuple defining the configuration of TCS.
>> +                   Must have 2 cells which describe each TCS type.
>> +                   <type number_of_tcs>.
>> +                   The order of the TCS must match the hardware
>> +                   configuration.
>> +       - Cell #1 (TCS Type): TCS types to be specified -
>> +                   SLEEP_TCS
>> +                   WAKE_TCS
>> +                   ACTIVE_TCS
>> +                   CONTROL_TCS
>> +       - Cell #2 (Number of TCS): <u32>
>> +
>> +- label:
>> +       Usage: optional
>> +       Value type: <string>
>> +       Definition: Name for the RSC. The name would be used in trace logs.
>> +
>> +Drivers that want to use the RSC to communicate with RPMH must specify their
>> +bindings as child of the RSC controllers they wish to communicate with.
>
>s/child/child nodes/
>
>
Ok to these as well as the above.

>> +
>> +Example 1:
>> +
>> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
>> +register offsets for DRV2 start at 0D00, the register calculations are like
>> +this -
>> +First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
>> +Second tuple: 0x179E0000 + 0xD00 = 0x179E0D00
>> +
>> +       apps_rsc: rsc@179e000 {
>> +               label = "apps_rsc";
>> +               compatible = "qcom,rpmh-rsc";
>> +               reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;
>
>The first reg property overlaps the second one. Does this second one
>ever move around? I would hardcode it in the driver to be 0xd00 away
>from the drv base instead of specifying it in DT if it's the same all
>the time.
>
>Also, the example shows 0x179c0000 which I guess is the actual beginning
>of the RSC block. So the binding seems to be for one DRV inside of an
>RSC. Can we get the full description of the RSC in the binding instead?
>I imagine that means there's a DRV0,1,2 and those probably have an
>interrupt per each DRV and then a different TCS config per each one too?
>If the binding can describe all of the RSC then we can use different
>DRVs by changing the qcom,drv-id property.
>
>	rsc@179c0000 {
>		compatible = "qcom,rpmh-rsc";
>		reg = <0x179c0000 0x10000>,
>		      <0x179d0000 0x10000>,
>		      <0x179e0000 0x10000>;
>		qcom,tcs-offset = <0xd00>;
>		qcom,drv-id = <0/1/2>;
>		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>	}
>
>This is sort of what I imagine it would look like. I have no idea how
>the tcs config would work unless each DRV has the same TCS config
>though. Otherwise, if each node is for a drv, then I would expect the
>node would be called 'drv' and we wouldn't need the drv-id property and
>the compatible string would say drv instead of rsc?
>
>BTW, what are the other DRVs used for in the apps RSC?
>
The DRV is the voter for an execution environment (Linux, Hypervisor,
ATF) in the RSC. The RSC has a lot of other registers that Linux is not
privy to. They are access restricted. The memory organization of the RSC
mandates that we know the DRV id to access registers specific to the
DRV. Unfortunately, not all RSC have identical DRV configuration and the
register space is also variable depending on the capability of the RSC.
There are functionalities supported by other RSCs in the SoC that are
not supported by the RSC associated with the application processor,
while not many RSCs' support multiple DRVs. Therefore it doesn't benefit
describing the whole RSC as it is not usable from Linux (because of
access restrictions).

>> +               reg-names = "drv", "tcs";
>> +               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +               qcom,drv-id = <2>;
>> +               qcom,tcs-config = <SLEEP_TCS   3>,
>> +                                 <WAKE_TCS    3>,
>> +                                 <ACTIVE_TCS  2>,
>> +                                 <CONTROL_TCS 1>;
>> +       };
>> +
>> +Example 2:
>> +
>> +For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
>> +register offsets for DRV0 start at 01C00, the register calculations are like
>> +this -
>> +First tuple: 0xAF20000
>> +Second tuple: 0xAF20000 + 0x1C00 = 0xAF21C00
>> +
>> +       disp_rsc: rsc@af20000 {
>> +               label = "disp_rsc";
>> +               compatible = "qcom,rpmh-rsc";
>> +               reg = <0xaf20000 0x10000>, <0xaf21c00 0x3000>;
>
>Ok. The TCS offset seems totally random now.
>
Yes it would appear so. Because the register space is optimized based on
the functionality supported by the RSC, the TCS for a DRV is at a
different offset in the RSC. Hence the explicit description of the
address in the binding.

Thanks,
Lina

>> +               reg-names = "drv", "tcs";
>> +               interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
>> +               qcom,drv-id = <0>;
>> +               qcom,tcs-config = <SLEEP_TCS   1>,
>> +                                 <WAKE_TCS    1>,
>> +                                 <ACTIVE_TCS  0>,
>> +                                 <CONTROL_TCS 0>;
>> +       };
