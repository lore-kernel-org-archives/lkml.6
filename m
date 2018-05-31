Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeEaDbQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:31:16 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43914 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeEaDbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:31:13 -0400
X-Google-Smtp-Source: ADUXVKI9E6IoDwZVeVQTVcxkYJ+XHT9aG8EXQKATMzq0RdIIfblJ3ZVNd+q2uewbURD3t54SN7cwpw==
Date: Wed, 30 May 2018 22:31:10 -0500
From: Rob Herring <robh@kernel.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        collinsd@codeaurora.org
Subject: Re: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
Message-ID: <20180531033110.GA19195@rob-hp-laptop>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-6-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525100121.28214-6-rnayak@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:31:20PM +0530, Rajendra Nayak wrote:
> The RPMh powerdomain driver aggregates the corner votes from various
> consumers for the ARC resources and communicates it to RPMh.
> 
> We also add data for all powerdomains on sdm845 as part of the patch.
> The driver can be extended to support other SoCs which support RPMh
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmhpd.txt |  65 ++++
>  drivers/soc/qcom/Kconfig                      |   9 +
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/rpmhpd.c                     | 360 ++++++++++++++++++
>  4 files changed, 435 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>  create mode 100644 drivers/soc/qcom/rpmhpd.c
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
> new file mode 100644
> index 000000000000..c1fa986c12ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
> @@ -0,0 +1,65 @@
> +Qualcomm RPMh Powerdomains
> +
> +* For RPMh powerdomains, we communicate a performance state to RPMh
> +which then translates it into a corresponding voltage on a rail
> +
> +Required Properties:
> + - compatible: Should be one of the following
> +	* qcom,sdm845-rpmhpd: RPMh powerdomain for the sdm845 family of SoC
> + - power-domain-cells: number of cells in power domain specifier
> +	must be 1
> + - operating-points-v2: Phandle to the OPP table for the power-domain.
> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
> +
> +Example:
> +
> +	rpmhpd: power-controller {
> +		compatible = "qcom,sdm845-rpmhpd";
> +		#power-domain-cells = <1>;
> +		operating-points-v2 = <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>,
> +				      <&rpmhpd_opp_table>;
> +	};
> +
> +	rpmhpd_opp_table: opp-table {
> +		compatible = "operating-points-v2-qcom-level", "operating-points-v2";
> +
> +		rpmhpd_opp1: opp@1 {
> +			qcom-corner = <16>;

Is it corner or level?

> +		};
> +
> +		rpmhpd_opp2: opp@2 {
> +			qcom-corner = <48>;
> +		};
> +
> +		rpmhpd_opp3: opp@3 {
> +			qcom-corner = <64>;
> +		};
> +
> +		rpmhpd_opp4: opp@4 {
> +			qcom-corner = <128>;
> +		};
> +
> +		rpmhpd_opp5: opp@5 {
> +			qcom-corner = <192>;
> +		};
> +
> +		rpmhpd_opp6: opp@6 {
> +			qcom-corner = <256>;
> +		};
> +
> +		rpmhpd_opp7: opp@7 {
> +			qcom-corner = <320>;
> +		};
> +
> +		rpmhpd_opp8: opp@8 {
> +			qcom-corner = <416>;
> +		};
> +	};
