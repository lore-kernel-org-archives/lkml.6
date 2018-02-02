Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeBBQqx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:46:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37972 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeBBQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:46:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3D126050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 2 Feb 2018 16:46:43 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/3] dt-bindings/interrupt-controller: pdc:
 descibe PDC device binding
Message-ID: <20180202164643.GC5319@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-3-ilina@codeaurora.org>
 <396cfc2f-7deb-0c93-7178-d9f5524f110e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <396cfc2f-7deb-0c93-7178-d9f5524f110e@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02 2018 at 16:28 +0000, Marc Zyngier wrote:
>On 02/02/18 14:21, Lina Iyer wrote:
>> From: Archana Sathyakumar <asathyak@codeaurora.org>
>>
>> Add device binding documentation for the PDC Interrupt controller on
>> QCOM SoC's like the SDM845. The interrupt-controller can be used to
>> sense edge low interrupts and wakeup interrupts when the GIC is
>> non-operational.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  .../bindings/interrupt-controller/qcom,pdc.txt     | 78 ++++++++++++++++++++++
>>  1 file changed, 78 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>> new file mode 100644
>> index 000000000000..7bf40cb6a4f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>> @@ -0,0 +1,78 @@
>> +PDC interrupt controller
>> +
>> +Qualcomm Technologies Inc. SoCs based on the RPM Hardened architecture have a
>> +Power Domain Controller (PDC) that is on always-on domain. In addition to
>> +providing power control for the power domains, the hardware also has an
>> +interrupt controller that can be used to help detect edge low interrupts as
>> +well detect interrupts when the GIC is non-operational.
>> +
>> +GIC is parent interrupt controller at the highest level. Platform interrupt
>> +controller PDC is next in hierarchy, followed by others. Drivers requiring
>> +wakeup capabilities of their device interrupts routed through the PDC, must
>> +specify PDC as their interrupt controller and request the PDC port associated
>> +with the GIC interrupt. See example below.
>> +
>> +Properties:
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: Should contain "qcom,<soc>-pdc"
>> +		    - "qcom,sdm845-pdc": For SDM845
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: Specifies the base physical address for PDC hardware.
>> +
>> +- interrupt-cells:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Specifies the number of cells needed to encode an interrupt
>> +		    source.
>> +		    The value must match that of the parent interrupt
>> +		    controller defined in the DT.
>> +		    The encoding of these cells are same as described in [1].
>
>There shouldn't be such a requirement. These are two independent pieces
>of HW, and the first parameter doesn't mean anything for the PDC.
>
Wouldn't that be confusing - that we have different definitions for
interrupts in the same DT? I agree that they are different interrupt
controllers, but it just feels odd.

I will change this to just take 2 cells.

>> +
>> +- interrupt-parent:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: Specifies the interrupt parent necessary for hierarchical
>> +		    domain to operate.
>> +
>> +- interrupt-controller:
>> +	Usage: required
>> +	Value type: <bool>
>> +	Definition: Identifies the node as an interrupt controller.
>> +
>> +- qcom,pdc-range:
>> +	Usage: required
>> +	Value type: <u32 array>
>> +	Definition: Specifies the PDC pin offset and the number of PDC ports.
>> +		    The tuples indicates the valid mapping of valid PDC ports
>> +		    and their hwirq mapping.
>> +		    The first element of the tuple is the staring PDC port num.
>> +		    The second element is the hwirq number for the PDC port.
>> +		    The third element is the number of elements in sequence.
>> +
>> +Example:
>> +
>> +	pdc: interrupt-controller@b220000 {
>> +		compatible = "qcom,sdm845-pdc";
>> +		reg = <0xb220000 0x30000>;
>> +		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
>> +		#interrupt-cells = <3>;
>> +		interrupt-parent = <&intc>;
>> +		interrupt-controller;
>> +	};
>> +
>> +The DT binding of a device that wants to use the GIC SPI 514 as a wakeup
>> +interrupt, would look like this -
>> +
>> +	wake-device {
>> +		[...]
>> +		interrupt-parent = <&pdc>;
>> +		interrupt = <0 2 0>;
>
>Again: 0 is not a valid trigger value.
>
Ok.

Thanks,
Lina
