Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163028AbeBNTea (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:34:30 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36476 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162964AbeBNTe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:34:27 -0500
X-Google-Smtp-Source: AH8x224xsX7KOP+v9Ke7PcRWxzZw62oxjGVlLqsb8IbZWV/mJyO81qkxmtUrnb+Hb3WmKGLcPVJC/w==
Date: Wed, 14 Feb 2018 11:34:19 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, msivasub@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180214193419.GE93895@bjorns-mbp-2.lan>
References: <20180208195154.3580-1-ilina@codeaurora.org>
 <20180208195154.3580-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208195154.3580-3-ilina@codeaurora.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Feb 11:51 PST 2018, Lina Iyer wrote:

> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB provides information on shared resources like clocks,
> regulators etc., probed at boot by the remote subsytem and made
> available in shared memory.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/cmd-db.txt         | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/cmd-db.txt b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> new file mode 100644
> index 000000000000..e21666e40ebf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> @@ -0,0 +1,38 @@
> +Command DB
> +---------
> +
> +Command DB is a database that provides a mapping between resource key and the
> +resource address for a system resource managed by a remote processor. The data
> +is stored in a shared memory region and is loaded by the remote processor.
> +
> +Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for
> +controlling shared resources. Depending on the board configuration the shared
> +resource properties may change. These properties are dynamically probed by the
> +remote processor and made available in the shared memory.
> +
> +The devicetree representation of the command DB driver should be:
> +
> +PROPERTIES:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Should be "qcom,cmd-db"
> +
> +- memory-region:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: The phandle to the reserved memory region.
> +
> +Example:
> +
> +	reserved-memory {
> +		[...]
> +		cmd_db_mem: qcom,cmd-db@c3f000c {
> +			reg = <0x0 0xc3f000c 0x0 0x8>;

I was hoping that we can describe the actual memory here, as I got the
impression that it will also be a chunk of memory carved out from System
RAM.

If not it would seem unlikely that there's a 8 byte carveout in the
middle of DDR, what else is here?

> +		};
> +	};
> +
> +	qcom,cmd-db@c3f000c {
> +		compatible = "qcom,cmd-db";

Add "qcom,cmd-db" to "reserved_mem_matches" in drivers/of/platform.c,
use of_reserved_mem_lookup(pdev->dev.of_node) to get the reserved_mem
and you can just put the compatible directly on the reserved-memory
node.

That way you don't need this separate node that doesn't really represent
anything.

> +		memory-region = <&cmd_db_mem>;
> +	};

Regards,
Bjorn
