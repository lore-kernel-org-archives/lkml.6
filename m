Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43105C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF8A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfAVN65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:58:57 -0500
Received: from foss.arm.com ([217.140.101.70]:53900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfAVN6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:58:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61A7DEBD;
        Tue, 22 Jan 2019 05:58:54 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C73B3F614;
        Tue, 22 Jan 2019 05:58:50 -0800 (PST)
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To:     saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
        david.brown@linaro.org, vivek.gautam@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
Date:   Tue, 22 Jan 2019 14:00:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On 01/22/2019 01:37 PM, Sai Prakash Ranjan wrote:
> Add coresight components found on Qualcomm SDM845 SoC.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 

Sorry, but I hadn't noticed the PID override strings below. Please
find the question.

> ---
> Depends on AOSS QMP side channel patches and AMBA bus pclk change
> by Bjorn Andersson [1][2].
> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
> and size cells for soc") [3].
> 
> [1] https://lore.kernel.org/lkml/20190106080915.4493-1-bjorn.andersson@linaro.org/
> [2] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> [3] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/

[...]

	};
> +
> +		etr@6048000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x06048000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +			arm,scatter-gather;
> +
> +			in-ports {
> +				port {
> +					etr_in: endpoint {
> +						remote-endpoint =
> +						  <&replicator_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/*
> +		 * On QCOM SDM845, we bypass the normal AMBA bus discovery
> +		 * method by forcing the peripheral ID because of the wrong
> +		 * value read from ETM PID registers.
> +		 */

What is the value read back from the ETM PIDx registers ? Do they
provide inconsistent or incompatible value w.r.t the ETM/Coresight
architecture ? If it is an unsupported CPU with proper values,
you must add them to the table in etm4x driver.

> +		etm@7040000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb95d> > +			reg = <0 0x07040000 0 0x1000>;
> +
> +			cpu = <&CPU0>;
> +

You seem to be specifying the PID of A53 ETM all over, while at least
one of your cores is ETMv4.2 (from the other patch) and A53 is not
ETMv4.2. As above, it would be good to add the PID to the table.

Suzuki
