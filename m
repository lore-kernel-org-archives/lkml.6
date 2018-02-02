Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeBBQ2R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:28:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751718AbeBBQ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:28:12 -0500
Subject: Re: [PATCH RFC v2 2/3] dt-bindings/interrupt-controller: pdc: descibe
 PDC device binding
To: Lina Iyer <ilina@codeaurora.org>, tglx@linutronix.de,
        jason@lakedaemon.net
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-3-ilina@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <396cfc2f-7deb-0c93-7178-d9f5524f110e@arm.com>
Date: Fri, 2 Feb 2018 16:28:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202142200.6229-3-ilina@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/18 14:21, Lina Iyer wrote:
> From: Archana Sathyakumar <asathyak@codeaurora.org>
> 
> Add device binding documentation for the PDC Interrupt controller on
> QCOM SoC's like the SDM845. The interrupt-controller can be used to
> sense edge low interrupts and wakeup interrupts when the GIC is
> non-operational.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../bindings/interrupt-controller/qcom,pdc.txt     | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> new file mode 100644
> index 000000000000..7bf40cb6a4f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> @@ -0,0 +1,78 @@
> +PDC interrupt controller
> +
> +Qualcomm Technologies Inc. SoCs based on the RPM Hardened architecture have a
> +Power Domain Controller (PDC) that is on always-on domain. In addition to
> +providing power control for the power domains, the hardware also has an
> +interrupt controller that can be used to help detect edge low interrupts as
> +well detect interrupts when the GIC is non-operational.
> +
> +GIC is parent interrupt controller at the highest level. Platform interrupt
> +controller PDC is next in hierarchy, followed by others. Drivers requiring
> +wakeup capabilities of their device interrupts routed through the PDC, must
> +specify PDC as their interrupt controller and request the PDC port associated
> +with the GIC interrupt. See example below.
> +
> +Properties:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Should contain "qcom,<soc>-pdc"
> +		    - "qcom,sdm845-pdc": For SDM845
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Specifies the base physical address for PDC hardware.
> +
> +- interrupt-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Specifies the number of cells needed to encode an interrupt
> +		    source.
> +		    The value must match that of the parent interrupt
> +		    controller defined in the DT.
> +		    The encoding of these cells are same as described in [1].

There shouldn't be such a requirement. These are two independent pieces
of HW, and the first parameter doesn't mean anything for the PDC.

> +
> +- interrupt-parent:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Specifies the interrupt parent necessary for hierarchical
> +		    domain to operate.
> +
> +- interrupt-controller:
> +	Usage: required
> +	Value type: <bool>
> +	Definition: Identifies the node as an interrupt controller.
> +
> +- qcom,pdc-range:
> +	Usage: required
> +	Value type: <u32 array>
> +	Definition: Specifies the PDC pin offset and the number of PDC ports.
> +		    The tuples indicates the valid mapping of valid PDC ports
> +		    and their hwirq mapping.
> +		    The first element of the tuple is the staring PDC port num.
> +		    The second element is the hwirq number for the PDC port.
> +		    The third element is the number of elements in sequence.
> +
> +Example:
> +
> +	pdc: interrupt-controller@b220000 {
> +		compatible = "qcom,sdm845-pdc";
> +		reg = <0xb220000 0x30000>;
> +		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
> +		interrupt-controller;
> +	};
> +
> +The DT binding of a device that wants to use the GIC SPI 514 as a wakeup
> +interrupt, would look like this -
> +
> +	wake-device {
> +		[...]
> +		interrupt-parent = <&pdc>;
> +		interrupt = <0 2 0>;

Again: 0 is not a valid trigger value.

> +	};
> +
> +[1]. Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
