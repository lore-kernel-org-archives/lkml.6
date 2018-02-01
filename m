Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBAKsS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:48:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbeBAKsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:48:12 -0500
Date: Thu, 1 Feb 2018 10:48:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Channagoud Kadabi <ckadabi@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, sboyd@codeaurora.org, kyan@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
Message-ID: <20180201104808.rxgqcrlsevtotq55@lakrids.cambridge.arm.com>
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
> +Example:
> +
> +	qcom,system-cache@1300000 {
> +		compatible = "qcom,llcc-core", "syscon", "simple-mfd";
> +		reg = <0x1300000 0x50000>;
> +		reg-names = "llcc_base";
> +
> +		llcc: qcom,sdm845-llcc {
> +			compatible = "qcom,sdm845-llcc";
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

The "qcom,llcc-ecc" and "qcom,llcc-amon" bindings doesn't seem to be
used by the driver in patch 2, and it's not clear how they are intended
to be used, so I think they should go from the binding for now.

I don't think you need syscon and simple-mfd, and I think you can
simplify the binding to a single node like:

	qcom,system-cache@1300000 {
		compatible = "qcom,sdm845-llcc";
		reg = <0x1300000 0x50000>;
		#cache-slice-cells = <1>;
		max-slices = <32>;
	}

If ECC and AMON are option features, we can always add boolean
properties for those later, e.g. "has-ecc".

Thanks,
Mark.
