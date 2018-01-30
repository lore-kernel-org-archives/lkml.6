Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeA3PUQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:20:16 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41403 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeA3PUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:20:13 -0500
X-Google-Smtp-Source: AH8x224mWuUjEDNZCUs6vS/loQKlaBDuiAFhR6U1WS7u957OYUYisiwDPjJymqEp6PMD+VmDbSwSEg==
Date: Tue, 30 Jan 2018 09:20:12 -0600
From: Rob Herring <robh@kernel.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] dt-bindings/interrupt-controller: pdc: descibe
 PDC device binding
Message-ID: <20180130152012.ucjmaw3nlim4d4fr@rob-hp-laptop>
References: <20180123175656.11942-1-ilina@codeaurora.org>
 <20180123175656.11942-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123175656.11942-3-ilina@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2018 at 10:56:54AM -0700, Lina Iyer wrote:
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
>  .../bindings/interrupt-controller/qcom,pdc.txt     | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> new file mode 100644
> index 000000000000..c4592bbf678d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> @@ -0,0 +1,55 @@
> +PDC interrupt controller
> +
> +Qualcomm Technologies Inc. SoCs based on the RPM Hardened archicture have a
> +Power Domain Controller (PDC) that is on always-on domain. In addition to
> +providing power control for the power domains, the hardware also has an
> +interrupt controller that can be used to help detect edge low interrupts as
> +well detect interrupts when the GIC is non-operational.
> +
> +GIC is parent interrupt controller at the highest level. Platform interrupt
> +controller PDC is next in hierarchy, followed by others. This driver only
> +configures the interrupts, does not handle them.
> +
> +Properties:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Should contain "qcom,pdc" and "qcom,pdc-<target>"
> +		    - "qcom,pdc-sdm845": For sdm845 pin data

pin data?

Convention is <soc>-<ip block>

Need to make the order of compatibles clear. Generally that is done with 
'followed by "qcom,pdc"' after the list of compatibles. But then, do you 
really need a fallback. This seems like a block that would change 
frequently. If there's not more than 2 or 3 chips with the same block, 
don't do a fallback.

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
> +		    Value must be 3.
> +		    The encoding of these cells are same as described in [1].
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
> +Example:
> +
> +	pdc: interrupt-controller@b220000 {
> +		compatible = "qcom,pdc", "qcom,pdc-sdm845";

This is backwards.

> +		reg = <0xb220000 0x30000>;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
> +		interrupt-controller;
> +	};
> +
> +[1]. Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
