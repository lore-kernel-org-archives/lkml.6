Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934650AbeCGUyY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:54:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51836 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934240AbeCGUyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:54:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F30B06022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 7 Mar 2018 13:54:16 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Message-ID: <20180307205416.GH4930@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-3-ilina@codeaurora.org>
 <152037541468.218381.12480897609076588560@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152037541468.218381.12480897609076588560@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06 2018 at 15:30 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-03-02 08:43:09)
>> Add device binding documentation for Qualcomm Technology Inc's RPMH RSC
>> driver. The hardware block is used for communicating resource state
>
>s/driver/hardware/
>
Ok.

>> requests for shared resources.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>
>> Changes in v2:
>>         - Amend text to describe the registers in reg property
>>         - Add reg-names for the registers
>>         - Update examples to use GIC_SPI in interrupts instead of 0
>>         - Rephrase incorrect description
>>
>> Changes in v3:
>>         - Fix unwanted capitalization
>>         - Remove clients from the examples, this doc does not describe
>>           them
>>         - Rephrase introductory paragraph
>>         - Remove hardware specifics from DT bindings
>> ---
>>  .../devicetree/bindings/arm/msm/rpmh-rsc.txt       | 131 +++++++++++++++++++++
>>  1 file changed, 131 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt b/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
>> new file mode 100644
>> index 000000000000..afd3817cc615
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/msm/rpmh-rsc.txt
>
>Shouldn't this go into bindings/soc/qcom/ ?
>
Didn;t realize the location. Thanks for pointing out.

> +
>> +Requests can be made for the state of a resource, when the subsystem is active
>> +or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
>> +will be an aggregate of the sleep votes from each of those subsystem. Drivers
>
>s/subsystem/subsystems/
>s/Drivers/Clients/ ?
>
Ok

>> +may request a sleep value for their shared resources in addition to the active
>> +mode requests.
>> +
>> +Control requests are instance specific requests that may or may not reach an
>> +accelerator. Only one platform device in Linux can request a control channel
>> +on a DRV.
>
>Not sure what this last sentence has to do with the DT binding. We
>generally try to avoid saying 'Linux' or 'driver' in DT binding
>documents, because they usually document hardware.
>
This para can go away.

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
>
>optional?
>
No, it is required. Driver has been using the by_name for clarity.

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
>> +               SLEEP_TCS
>> +               WAKE_TCS
>> +               ACTIVE_TCS
>> +               CONTROL_TCS
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
>Is that going to work for drivers that want to talk to two or more RSCs?
>I suppose that they'll have to hook up into some sort of framework like
>clk or regulator and then drivers that want to use two RSCs for those
>things would be linked to those sub-device drivers with the normal clk
>or regulator bindings?
>
Correct. This follows the same model as RPM SMD driver.

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
>> +               reg-names = "drv", "tcs";
>> +               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +               qcom,drv-id = <2>;
>> +               qcom,tcs-config = <SLEEP_TCS   3>,
>> +                                 <WAKE_TCS    3>,
>> +                                 <ACTIVE_TCS  2>,
>> +                                 <CONTROL_TCS 1>;
>
>Could qcom,tcs-config become something more like below?
>
>	#qcom,sleep-tcs = <3>;
>	#qcom,wake-tcs = <3>;
>	#qcom,active-tcs = <2>;
>	#qcom,control-tcs = <1>;
>
>I don't really understand the binding design to have many cells with the
>*_TCS defines indicating what comes next.
>
This format helps preserve the order in which the TCS are designed in
the firmware. Thats additional information that is described by the
cells.

Thanks,
Lina
