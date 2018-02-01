Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBAKol (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:44:41 -0500
Received: from foss.arm.com ([217.140.101.70]:47510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbeBAKoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:44:39 -0500
Date: Thu, 1 Feb 2018 10:44:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Channagoud Kadabi <ckadabi@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, sboyd@codeaurora.org, kyan@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
Message-ID: <20180201104434.7j27fl2hb4glqd3v@lakrids.cambridge.arm.com>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 03:55:12PM -0800, Channagoud Kadabi wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..d433b0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,93 @@
> +* LLCC (Last Level Cache Controller)
> +
> +Properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,llcc-core"
> +
> +- reg:
> +	Usage: required
> +	Value Type: <prop-encoded-array>
> +	Definition: must be addresses and sizes of the LLCC registers
> +
> +- llcc-bank-off:
> +	Usage: required
> +	Value Type: <u32 array>
> +	Definition: Offsets of llcc banks from llcc base address starting from
> +		    LLCC bank0.
> +
> +- llcc-broadcast-off:
> +	Usage: required
> +	Value Type: <u32>
> +	Definition: Offset of broadcast register from LLCC bank0 address.

Please could we use "offset" rather than "off" for both of these? That
way it's obvious these aren't properties for disabling some feature.

How variable are these offsets in practice? Is the memory map not fixed?

> +
> +- #cache-cells:
> +	Usage: required
> +	Value Type: <u32>
> +	Definition: Number of cache cells, must be 1

What's this for, and how is it used?

> +
> +- max-slices:
> +	usage: required
> +	Value Type: <u32>
> +	Definition: Number of cache slices supported by hardware
> +
> +- status:
> +	Usage: optional
> +	Value type: <string>
> +	Definition: Property to enable or disable the driver

This is a standard property, so I don't think it needs to be described
here.

> +
> +== llcc amon device ==
> +
> +Properties:
> +-qcom,fg-cnt : The value of fine grained counter of activity monitor
> +	        block.

Could you elaborate on this?

> +
> +compatible devices:
> +		qcom,sdm845-llcc

Huh? The "qcom,sdm845-llcc" bindings wasn't described above, and it's
not clear what this means.

> +
> +Example:
> +
> +	qcom,system-cache@1300000 {
> +		compatible = "qcom,llcc-core", "syscon", "simple-mfd";

This looks very wrong. Why do you need syscon and simple-mfd?

> +		reg = <0x1300000 0x50000>;
> +		reg-names = "llcc_base";
> +
> +		llcc: qcom,sdm845-llcc {
> +			compatible = "qcom,sdm845-llcc";

Why is this a sub-node?

Why isn't the top-level node just "qcom,sdm845-llcc" ?

> +			#cache-cells = <1>;
> +			max-slices = <32>;
> +		};
> +
> +		qcom,llcc-ecc {
> +			compatible = "qcom,llcc-ecc";
> +		};
> +
> +		qcom,llcc-amon {
> +			compatible = "qcom,llcc-amon";
> +			qcom,fg-cnt = <0x7>;
> +		};
> +
> +	};
> +
> +== Client ==
> +
> +Properties:
> +- cache-slice-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: A set of names that identify the usecase names of a client that uses
> +		    cache slice. These strings are used to look up the cache slice
> +		    entries by name.
> +
> +- cache-slices:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: The tuple has phandle to llcc device as the first argument and the
> +		    second argument is the usecase id of the client.

What is a "usecase id" ?

Is this meant to align with #cache-cells? It would be best to keep a
common prefix (i.e. call that #cache-slice-cells).

Thanks,
Mark.
