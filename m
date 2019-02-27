Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902C6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BE22133F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfB0J2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:28:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:2285 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfB0J2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:28:07 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 353C913F880;
        Wed, 27 Feb 2019 10:27:44 +0100 (CET)
Subject: Re: [PATCH] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20190226065919.22218-1-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b17f2c12-fd2c-549e-92b9-96a422e5f07c@free.fr>
Date:   Wed, 27 Feb 2019 10:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226065919.22218-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 07:59, Bjorn Andersson wrote:

> qcom_qmp_phy_init() is extended to support the additional register
> writes needed in PCS MISC and the appropriate sequences and resources
> are defined for SDM845.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   7 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 160 ++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  12 ++
>  3 files changed, 179 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 5d181fc3cc18..dd2725a9d3f7 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -11,6 +11,7 @@ Required properties:
>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>  	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
>  	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
> +	       "qcom,sdm845-qmp-pcie-phy" for PCIe phy on sdm845,
>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
>  	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> @@ -48,6 +49,10 @@ Required properties:
>  			"aux", "cfg_ahb", "ref".
>  		For "qcom,msm8998-qmp-ufs-phy" must contain:
>  			"ref", "ref_aux".
> +		For "qcom,sdm845-qmp-usb3-phy" must contain:
> +			"aux", "cfg_ahb", "ref", "refgen".

qcom,sdm845-qmp-usb3-phy in a PCIe patch?

> +		For "qcom,sdm845-qmp-usb3-phy" must contain:
> +			"aux", "cfg_ahb", "ref", "com_aux".

qcom,sdm845-qmp-usb3-phy again in a PCIe patch?


> +static const struct qmp_phy_init_tbl sdm845_pcie_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_CONFIG2, 0x52),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG2, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG4, 0x1a),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG5, 0x06),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
> +};

I was thinking I might need to do the same for msm8998, since downstream
tweaks pcs_misc + 0x2c = 0x52
(dunno if that's QPHY_V3_PCS_MISC_OSC_DTCT_CONFIG2)

The thing is, phy driver writes unconditionally to pcs_misc + 0x0c
(QPHY_V3_PCS_MISC_CLAMP_ENABLE). Should that be moved elsewhere?

Regards.
