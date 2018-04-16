Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeDPO7Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:59:16 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42760 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDPO7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:59:13 -0400
X-Google-Smtp-Source: AIpwx48ju36/vkdG7TMtORut3uhoK9rtUofN6TvPMnCs+zUal2P9QNIFjAkZ0tNzGH7mjI79DUHjPw==
Date: Mon, 16 Apr 2018 09:59:12 -0500
From: Rob Herring <robh@kernel.org>
To: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        kyan@codeaurora.org, ckadabi@codeaurora.org,
        stanimir.varbanov@linaro.org, evgreen@chromium.org
Subject: Re: [PATCH v4 1/2] Documentation: Documentation for qcom, llcc
Message-ID: <20180416145912.ja7d2xd2kqiukrgl@rob-hp-laptop>
References: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org>
 <1523390893-10904-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523390893-10904-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 01:08:12PM -0700, Rishabh Bhatnagar wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.

"Documentation: Documentation ..."? That wastes a lot of the subject 
line... The preferred prefix is "dt-bindings: ..."

> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..497cf0f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,58 @@
> +== Introduction==
> +
> +LLCC (Last Level Cache Controller) provides last level of cache memory in SOC,
> +that can be shared by multiple clients. Clients here are different cores in the
> +SOC, the idea is to minimize the local caches at the clients and migrate to
> +common pool of memory
> +
> +Properties:
> +- compatible:
> +	 Usage: required
> +	 Value type: <string>
> +	 Definition: must be "qcom,sdm845-llcc"
> +
> +- reg:
> +	 Usage: required
> +	 Value Type: <prop-encoded-array>
> +	 Definition: must be addresses and sizes of the LLCC registers

How many address ranges?

> +
> +- #cache-cells:

This is all written as it is a common binding, but it is not one.

You already have most of the configuration data for each client in the 
driver, I think I'd just put the client connection there too. Is there 
any variation of this for a given SoC?

> +	 Usage: required
> +	 Value Type: <u32>
> +	 Definition: Number of cache cells, must be 1
> +
> +- max-slices:
> +	 usage: required
> +	 Value Type: <u32>
> +	 Definition: Number of cache slices supported by hardware

What's a slice?

> +
> +Example:
> +
> +	llcc: qcom,llcc@1100000 {
> +		compatible = "qcom,sdm845-llcc";
> +		reg = <0x1100000 0x250000>;
> +		#cache-cells = <1>;
> +		max-slices = <32>;
> +	};
> +
> +== Client ==
> +
> +Properties:
> +- cache-slice-names:
> +	 Usage: required
> +	 Value type: <stringlist>
> +	 Definition: A set of names that identify the usecase names of a
> +			client that uses cache slice. These strings are
> +			used to look up the cache slice entries by name.
> +
> +- cache-slices:
> +	 Usage: required
> +	 Value type: <prop-encoded-array>
> +	 Definition: The tuple has phandle to llcc device as the first
> +			argument and the second argument is the usecase
> +			id of the client.
> +For Example:
> +	venus {
> +		cache-slice-names = "vidsc0", "vidsc1";
> +	 	cache-slices = <&llcc VIDSC0_ID>, <&llcc VIDSC1_ID>;
> +	};
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
