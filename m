Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEVSIm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:08:42 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44035 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEVSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:08:40 -0400
X-Google-Smtp-Source: AB8JxZr1lhXK+XxTk7s0hAY13IF7Jo0uHJ7Woa/Qz94aqVOg37hXKCE0D8wxaL0qU2wJ+brUDlhvcg==
Date: Tue, 22 May 2018 13:08:38 -0500
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM / devfreq: Add support for QCOM devfreq firmware
Message-ID: <20180522180838.GA13423@rob-hp-laptop>
References: <1526629965-28729-1-git-send-email-skannan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526629965-28729-1-git-send-email-skannan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:52:40AM -0700, Saravana Kannan wrote:
> The firmware present in some QCOM chipsets offloads the steps necessary for
> changing the frequency of some devices (Eg: L3). This driver implements the
> devfreq interface for this firmware so that various governors could be used
> to scale the frequency of these devices.
> 
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
> +multiple entities want to vote on the frequency request that is sent to the
> +firmware. The qcom,devfreq-fw-voter represents these voters as child
> +devices of the corresponding qcom,devfreq-fw device.
> +
> +Required properties:
> +- compatible:		Must be "qcom,devfreq-fw" or "qcom,devfreq-fw-voter"

No versions of firmware?

> +Only for qcom,devfreq-fw:
> +- reg:			Pairs of physical base addresses and region sizes of
> +			memory mapped registers.

Registers? Is this firmware or h/w block?

> +- reg-names:		Names of the bases for the above registers.
> +			Required register regions are:
> +			- "en-base": address of register to check if the
> +			  firmware is enabled.
> +			- "ftbl-base": address region for the frequency
> +			  table.
> +			- "perf-base": address of register to request a
> +			  frequency.
> +
> +Example:
> +
> +	qcom,devfreq-l3 {
> +		compatible = "qcom,devfreq-fw";
> +		reg-names = "en-base", "ftbl-base", "perf-base";
> +		reg = <0x18321000 0x4>, <0x18321110 0x600>, <0x18321920 0x4>;
> +
> +		qcom,cpu0-l3 {
> +			compatible = "qcom,devfreq-fw-voter";

There's no point in these nodes. They don't have any properties or 
resources.

> +		};
> +
> +		qcom,cpu4-l3 {
> +			compatible = "qcom,devfreq-fw-voter";
> +		};
> +	};
