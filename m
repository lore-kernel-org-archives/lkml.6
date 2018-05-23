Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbeEWQJH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:09:07 -0400
Received: from foss.arm.com ([217.140.101.70]:57802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbeEWQJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:09:06 -0400
Date: Wed, 23 May 2018 17:08:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] PM / devfreq: Add support for QCOM devfreq firmware
Message-ID: <20180523160857.GA30950@e107155-lin>
References: <1526629965-28729-1-git-send-email-skannan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526629965-28729-1-git-send-email-skannan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned on the thread that add firmware based cpufreq support, IMO
these 2 bindings look too similar and can be combined or at-least aligned.

On Fri, May 18, 2018 at 12:52:40AM -0700, Saravana Kannan wrote:
> The firmware present in some QCOM chipsets offloads the steps necessary for
> changing the frequency of some devices (Eg: L3). This driver implements the
> devfreq interface for this firmware so that various governors could be used
> to scale the frequency of these devices.
>

Is this firmware the same one which controls the CPUFreq described in the
other thread adding cpufreq support ?

> Each client (say cluster 0 and cluster 1) that wants to vote for a
> particular device's frequency (say, L3 frequency) is represented as a
> separate voter device (qcom,devfreq-fw-voter) that's a child of the
> firmware device (qcom,devfreq-fw).
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  .../bindings/devfreq/devfreq-qcom-fw.txt           |  41 +++
>  drivers/devfreq/Kconfig                            |  14 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/devfreq_qcom_fw.c                  | 330 +++++++++++++++++++++
>  4 files changed, 386 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>  create mode 100644 drivers/devfreq/devfreq_qcom_fw.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
> new file mode 100644
> index 0000000..f882a0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
> @@ -0,0 +1,41 @@
> +QCOM Devfreq firmware device
> +
> +Some Qualcomm Technologies, Inc. (QTI) chipsets have a firmware that
> +offloads the steps for frequency switching. It provides a table of
> +supported frequencies and a register to request one of the supported
> +freqencies.
> +
> +The qcom,devfreq-fw represents this firmware as a device. Sometimes,

As a whole or just a part of it ? I am getting an impression that this
firmware is divided into 'n' different pieces and each of them is
represented as a separate device.

> +multiple entities want to vote on the frequency request that is sent to the
> +firmware. The qcom,devfreq-fw-voter represents these voters as child
> +devices of the corresponding qcom,devfreq-fw device.
> +
> +Required properties:
> +- compatible:		Must be "qcom,devfreq-fw" or "qcom,devfreq-fw-voter"

If this is the same firmware, name it after. What do you need one name
per subsystem in Linux for the same firmware ?

> +Only for qcom,devfreq-fw:
> +- reg:			Pairs of physical base addresses and region sizes of
> +			memory mapped registers.
> +- reg-names:		Names of the bases for the above registers.
> +			Required register regions are:
> +			- "en-base": address of register to check if the
> +			  firmware is enabled.
> +			- "ftbl-base": address region for the frequency
> +			  table.

It's called "lut-base" in the cpufreq binding and that's the only difference
I see.

> +			- "perf-base": address of register to request a
> +			  frequency.
> +

[...]

> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lut-base");
> +	if (!res) {
> +		dev_err(dev, "Unable to find lut-base!\n");
> +		return -EINVAL;
> +	}
> +
...but in the binding it's called "ftbl-base"

--
Regards,
Sudeep
