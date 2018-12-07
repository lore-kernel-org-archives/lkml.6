Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA01C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047202064D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047202064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLGKau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:30:50 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:16191 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGKau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:30:50 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 77AA813F8D4;
        Fri,  7 Dec 2018 11:30:27 +0100 (CET)
Subject: Re: [PATCH v2] clk: qcom: smd: Add support for MSM8998 rpm clocks
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1544134310-10227-1-git-send-email-jhugo@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <be08a9ca-9782-6d10-7c44-523c9e8c56f5@free.fr>
Date:   Fri, 7 Dec 2018 11:30:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544134310-10227-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 23:11, Jeffrey Hugo wrote:

> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
> for clients to vote on.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
> v2
> -fix compatible ordering nits per Stephen
> 
>  .../devicetree/bindings/clock/qcom,rpmcc.txt       |  1 +
>  drivers/clk/qcom/clk-smd-rpm.c                     | 62 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,rpmcc.h             |  6 +++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
> index 87b4949..944719b 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
> @@ -16,6 +16,7 @@ Required properties :
>  			"qcom,rpmcc-msm8974", "qcom,rpmcc"
>  			"qcom,rpmcc-apq8064", "qcom,rpmcc"
>  			"qcom,rpmcc-msm8996", "qcom,rpmcc"
> +			"qcom,rpmcc-msm8998", "qcom,rpmcc"
>  			"qcom,rpmcc-qcs404", "qcom,rpmcc"
>  
>  - #clock-cells : shall contain 1
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index d3aadae..b1f95a9 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -655,10 +655,72 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
>  	.num_clks = ARRAY_SIZE(qcs404_clks),
>  };
>  
> +/* msm8998 */
> +DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
> +DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
> +DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, div_clk1, div_clk1_a, 0xb);
> +DEFINE_CLK_SMD_RPM(msm8998, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk1, bb_clk1_a, 1);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk2, bb_clk2_a, 2);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, bb_clk3_pin, bb_clk3_a_pin, 3);
> +DEFINE_CLK_SMD_RPM(msm8998, mmssnoc_axi_rpm_clk, mmssnoc_axi_rpm_a_clk,
> +		   QCOM_SMD_RPM_MMAXI_CLK, 0);
> +DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
> +		   QCOM_SMD_RPM_AGGR_CLK, 1);
> +DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
> +		   QCOM_SMD_RPM_AGGR_CLK, 2);
> +DEFINE_CLK_SMD_RPM_QDSS(msm8998, qdss_clk, qdss_a_clk,
> +			QCOM_SMD_RPM_MISC_CLK, 1);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk1, rf_clk1_a, 4);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin, 5);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
> +static struct clk_smd_rpm *msm8998_clks[] = {
> +	[RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
> +	[RPM_SMD_SNOC_A_CLK] = &msm8998_snoc_a_clk,
> +	[RPM_SMD_CNOC_CLK] = &msm8998_cnoc_clk,
> +	[RPM_SMD_CNOC_A_CLK] = &msm8998_cnoc_a_clk,
> +	[RPM_SMD_CE1_CLK] = &msm8998_ce1_clk,
> +	[RPM_SMD_CE1_A_CLK] = &msm8998_ce1_a_clk,
> +	[RPM_SMD_DIV_CLK1] = &msm8998_div_clk1,
> +	[RPM_SMD_DIV_A_CLK1] = &msm8998_div_clk1_a,
> +	[RPM_SMD_IPA_CLK] = &msm8998_ipa_clk,
> +	[RPM_SMD_IPA_A_CLK] = &msm8998_ipa_a_clk,
> +	[RPM_SMD_BB_CLK1] = &msm8998_bb_clk1,
> +	[RPM_SMD_BB_CLK1_A] = &msm8998_bb_clk1_a,
> +	[RPM_SMD_BB_CLK2] = &msm8998_bb_clk2,
> +	[RPM_SMD_BB_CLK2_A] = &msm8998_bb_clk2_a,
> +	[RPM_SMD_BB_CLK3_PIN] = &msm8998_bb_clk3_pin,
> +	[RPM_SMD_BB_CLK3_A_PIN] = &msm8998_bb_clk3_a_pin,
> +	[RPM_SMD_MMAXI_CLK] = &msm8998_mmssnoc_axi_rpm_clk,
> +	[RPM_SMD_MMAXI_A_CLK] = &msm8998_mmssnoc_axi_rpm_a_clk,
> +	[RPM_SMD_AGGR1_NOC_CLK] = &msm8998_aggre1_noc_clk,
> +	[RPM_SMD_AGGR1_NOC_A_CLK] = &msm8998_aggre1_noc_a_clk,
> +	[RPM_SMD_AGGR2_NOC_CLK] = &msm8998_aggre2_noc_clk,
> +	[RPM_SMD_AGGR2_NOC_A_CLK] = &msm8998_aggre2_noc_a_clk,
> +	[RPM_SMD_QDSS_CLK] = &msm8998_qdss_clk,
> +	[RPM_SMD_QDSS_A_CLK] = &msm8998_qdss_a_clk,
> +	[RPM_SMD_RF_CLK1] = &msm8998_rf_clk1,
> +	[RPM_SMD_RF_CLK1_A] = &msm8998_rf_clk1_a,
> +	[RPM_SMD_RF_CLK2_PIN] = &msm8998_rf_clk2_pin,
> +	[RPM_SMD_RF_CLK2_A_PIN] = &msm8998_rf_clk2_a_pin,
> +	[RPM_SMD_RF_CLK3] = &msm8998_rf_clk3,
> +	[RPM_SMD_RF_CLK3_A] = &msm8998_rf_clk3_a,
> +	[RPM_SMD_RF_CLK3_PIN] = &msm8998_rf_clk3_pin,
> +	[RPM_SMD_RF_CLK3_A_PIN] = &msm8998_rf_clk3_a_pin,
> +};
> +
> +static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
> +	.clks = msm8998_clks,
> +	.num_clks = ARRAY_SIZE(msm8998_clks),
> +};
> +
>  static const struct of_device_id rpm_smd_clk_match_table[] = {
>  	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
>  	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
>  	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
> +	{ .compatible = "qcom,rpmcc-msm8998", .data = &rpm_clk_msm8998 },
>  	{ .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
>  	{ }
>  };
> diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
> index 3658b0c..81dbd1f 100644
> --- a/include/dt-bindings/clock/qcom,rpmcc.h
> +++ b/include/dt-bindings/clock/qcom,rpmcc.h
> @@ -127,5 +127,11 @@
>  #define RPM_SMD_BIMC_GPU_A_CLK			77
>  #define RPM_SMD_QPIC_CLK			78
>  #define RPM_SMD_QPIC_CLK_A			79
> +#define RPM_SMD_BB_CLK3_PIN			80
> +#define RPM_SMD_BB_CLK3_A_PIN			81
> +#define RPM_SMD_RF_CLK3				82
> +#define RPM_SMD_RF_CLK3_A			83
> +#define RPM_SMD_RF_CLK3_PIN			84
> +#define RPM_SMD_RF_CLK3_A_PIN			85
>  
>  #endif
> 

What's the difference between RPM_SMD_LN_BB_CLK and RPM_SMD_BB_CLK1?

$ git grep RPM_SMD_LN_BB_CLK
arch/arm64/boot/dts/qcom/msm8996.dtsi:                  clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
arch/arm64/boot/dts/qcom/msm8996.dtsi:                          <&rpmcc RPM_SMD_LN_BB_CLK>,
drivers/clk/qcom/clk-smd-rpm.c: [RPM_SMD_LN_BB_CLK] = &msm8996_ln_bb_clk,
drivers/clk/qcom/clk-smd-rpm.c: [RPM_SMD_LN_BB_CLK] = &qcs404_ln_bb_clk,
include/dt-bindings/clock/qcom,rpmcc.h:#define RPM_SMD_LN_BB_CLK                        74


$ git grep 'RPM_SMD_BB_CLK1\>'
Documentation/devicetree/bindings/sound/qcom,wcd9335.txt:                <&rpmcc RPM_SMD_BB_CLK1>;
drivers/clk/qcom/clk-smd-rpm.c: [RPM_SMD_BB_CLK1]               = &msm8916_bb_clk1,
drivers/clk/qcom/clk-smd-rpm.c: [RPM_SMD_BB_CLK1] = &msm8996_bb_clk1,
drivers/clk/qcom/clk-smd-rpm.c: [RPM_SMD_BB_CLK1] = &msm8998_bb_clk1,
include/dt-bindings/clock/qcom,rpmcc.h:#define RPM_SMD_BB_CLK1                          10


Because the downstream kernel defines:

DEFINE_CLK_RPM_SMD_XO_BUFFER(ln_bb_clk1, ln_bb_clk1_ao, LN_BB_CLK1_ID);
DEFINE_CLK_RPM_SMD_XO_BUFFER_PINCTRL(ln_bb_clk1_pin, ln_bb_clk1_pin_ao,
				     LN_BB_CLK1_PIN_ID);
DEFINE_CLK_RPM_SMD_XO_BUFFER(ln_bb_clk2, ln_bb_clk2_ao, LN_BB_CLK2_ID);
DEFINE_CLK_RPM_SMD_XO_BUFFER_PINCTRL(ln_bb_clk2_pin, ln_bb_clk2_pin_ao,
				     LN_BB_CLK2_PIN_ID);
DEFINE_CLK_RPM_SMD_XO_BUFFER(ln_bb_clk3, ln_bb_clk3_ao, LN_BB_CLK3_ID);
DEFINE_CLK_RPM_SMD_XO_BUFFER_PINCTRL(ln_bb_clk3_pin, ln_bb_clk3_pin_ao,
				     LN_BB_CLK3_PIN_ID);

	CLK_LIST(ln_bb_clk1),
	CLK_LIST(ln_bb_clk1_ao),
	CLK_LIST(ln_bb_clk1_pin),
	CLK_LIST(ln_bb_clk1_pin_ao),
	CLK_LIST(ln_bb_clk2),
	CLK_LIST(ln_bb_clk2_ao),
	CLK_LIST(ln_bb_clk2_pin),
	CLK_LIST(ln_bb_clk2_pin_ao),
	CLK_LIST(ln_bb_clk3),
	CLK_LIST(ln_bb_clk3_ao),
	CLK_LIST(ln_bb_clk3_pin),
	CLK_LIST(ln_bb_clk3_pin_ao),


While your patch defines

DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk1, bb_clk1_a, 1);
DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk2, bb_clk2_a, 2);
DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, bb_clk3_pin, bb_clk3_a_pin, 3);

	[RPM_SMD_BB_CLK1] = &msm8998_bb_clk1,
	[RPM_SMD_BB_CLK1_A] = &msm8998_bb_clk1_a,
	[RPM_SMD_BB_CLK2] = &msm8998_bb_clk2,
	[RPM_SMD_BB_CLK2_A] = &msm8998_bb_clk2_a,
	[RPM_SMD_BB_CLK3_PIN] = &msm8998_bb_clk3_pin,
	[RPM_SMD_BB_CLK3_A_PIN] = &msm8998_bb_clk3_a_pin,


Regards.
