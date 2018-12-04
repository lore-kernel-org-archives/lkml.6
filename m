Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E137BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A612082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+0U72Zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A612082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeLDREt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:04:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43220 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeLDREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:04:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so8515437pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CrMcdXwHTE8BHGfmTLQygvTSJLZTyQ9V7fs9fIzFu18=;
        b=K+0U72ZtCjXznOJvP3nJkesgzITNE72uHL28O8HwzbKIwO1dcEEctvCZi0nEv5pZX9
         NqlIT2H8uYOHU3Mo7u/RTqZrv5C2yhvazlfteQkZCV3pba8Ud/hD7Zpk5LA9J6p2AaA1
         Dk8B6o3hE4ox8MdBqNel0ft/RrCSDNBqr/Uz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CrMcdXwHTE8BHGfmTLQygvTSJLZTyQ9V7fs9fIzFu18=;
        b=OJEzIhpFiLBE3JcuWr9/g/dK71ac4NwWL5LiPNXT39hGw4xIS9yI3OJdDjwwJCCJIR
         zJS2eZD0AlRhgXUrpID/GVXcPK/qbRgrNp3b02XuSCRpv1PIvERJZcNkcs23f1jjPfdR
         ncnwM6Ec5Le28wdo9srzNJ6uBoXiCcE6fN8LQJqrYt/0zb32ZOzSxSRP7J+SDIrRWB/5
         M7McPmLKCPbEN13X94bTFy73AWhWAnkZB/VliTjuC33SAmGP7lGWioWBt99PPnMDkSzy
         9ACeMQ9Q9Ks2NFMqp5zqS4VLI3SdTMPuYX2bPhFtTPeNvvRe/3/DJq19JrHwzrpA2t2o
         UFgg==
X-Gm-Message-State: AA+aEWZsE4GzFsNP5GpEXOE4nTDS3SH9U/TM4crOxkNJA1x1ecxR0tNY
        8bn3zjBScMmauq3LfidrfvDBTwrhVMc=
X-Google-Smtp-Source: AFSGD/XhXwoLomGu3XizjEJ6ps7Q/LI0yp8P/NJjdd8lWX0W4AP0ILkX//yyEFMTI8O2yrZnZaydEw==
X-Received: by 2002:a63:c942:: with SMTP id y2mr16080260pgg.331.1543943087544;
        Tue, 04 Dec 2018 09:04:47 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k14sm23902593pgs.52.2018.12.04.09.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:04:46 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:04:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Enumerate remaining msm8998 resets
Message-ID: <20181204170444.GK5278@tuxbook-pro>
References: <1543936402-7075-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543936402-7075-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Dec 07:13 PST 2018, Jeffrey Hugo wrote:

> The current list of defined resets is incomplete compared to what the
> hardware implements.  Enumerate the remaining resets according to the
> hardware documentation.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Based upon "Merge branch 'clk-qcom-8998-resets' into clk-next" to hopefully
> avoid any merge conflicts.
> 
>  drivers/clk/qcom/gcc-msm8998.c               | 87 ++++++++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-msm8998.h | 87 ++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index c3bb9ff..14c507d 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2761,6 +2761,93 @@ enum {
>  	[GCC_TSIF_BCR] = { 0x36000 },
>  	[GCC_UFS_BCR] = { 0x75000 },
>  	[GCC_USB_30_BCR] = { 0xf000 },
> +	[GCC_SYSTEM_NOC_BCR] = { 0x4000 },
> +	[GCC_CONFIG_NOC_BCR] = { 0x5000 },
> +	[GCC_AHB2PHY_EAST_BCR] = { 0x7000 },
> +	[GCC_IMEM_BCR] = { 0x8000 },
> +	[GCC_PIMEM_BCR] = { 0xa000 },
> +	[GCC_MMSS_BCR] = { 0xb000 },
> +	[GCC_QDSS_BCR] = { 0xc000 },
> +	[GCC_WCSS_BCR] = { 0x11000 },
> +	[GCC_BLSP1_BCR] = { 0x17000 },
> +	[GCC_BLSP1_UART1_BCR] = { 0x1a000 },
> +	[GCC_BLSP1_UART2_BCR] = { 0x1c000 },
> +	[GCC_BLSP1_UART3_BCR] = { 0x1e000 },
> +	[GCC_CM_PHY_REFGEN1_BCR] = { 0x22000 },
> +	[GCC_CM_PHY_REFGEN2_BCR] = { 0x24000 },
> +	[GCC_BLSP2_BCR] = { 0x25000 },
> +	[GCC_BLSP2_UART1_BCR] = { 0x27000 },
> +	[GCC_BLSP2_UART2_BCR] = { 0x29000 },
> +	[GCC_BLSP2_UART3_BCR] = { 0x2b000 },
> +	[GCC_SRAM_SENSOR_BCR] = { 0x2d000 },
> +	[GCC_PRNG_BCR] = { 0x34000 },
> +	[GCC_TSIF_0_RESET] = { 0x36024 },
> +	[GCC_TSIF_1_RESET] = { 0x36028 },
> +	[GCC_TCSR_BCR] = { 0x37000 },
> +	[GCC_BOOT_ROM_BCR] = { 0x38000 },
> +	[GCC_MSG_RAM_BCR] = { 0x39000 },
> +	[GCC_TLMM_BCR] = { 0x3a000 },
> +	[GCC_MPM_BCR] = { 0x3b000 },
> +	[GCC_SEC_CTRL_BCR] = { 0x3d000 },
> +	[GCC_SPMI_BCR] = { 0x3f000 },
> +	[GCC_SPDM_BCR] = { 0x40000 },
> +	[GCC_CE1_BCR] = { 0x41000 },
> +	[GCC_BIMC_BCR] = { 0x44000 },
> +	[GCC_SNOC_BUS_TIMEOUT0_BCR] = { 0x49000 },
> +	[GCC_SNOC_BUS_TIMEOUT1_BCR] = { 0x49008 },
> +	[GCC_SNOC_BUS_TIMEOUT3_BCR] = { 0x49010 },
> +	[GCC_SNOC_BUS_TIMEOUT_EXTREF_BCR] = { 0x49018 },
> +	[GCC_PNOC_BUS_TIMEOUT0_BCR] = { 0x4a000 },
> +	[GCC_CNOC_PERIPH_BUS_TIMEOUT1_BCR] = { 0x4a004 },
> +	[GCC_CNOC_PERIPH_BUS_TIMEOUT2_BCR] = { 0x4a00c },
> +	[GCC_CNOC_BUS_TIMEOUT0_BCR] = { 0x4b000 },
> +	[GCC_CNOC_BUS_TIMEOUT1_BCR] = { 0x4b008 },
> +	[GCC_CNOC_BUS_TIMEOUT2_BCR] = { 0x4b010 },
> +	[GCC_CNOC_BUS_TIMEOUT3_BCR] = { 0x4b018 },
> +	[GCC_CNOC_BUS_TIMEOUT4_BCR] = { 0x4b020 },
> +	[GCC_CNOC_BUS_TIMEOUT5_BCR] = { 0x4b028 },
> +	[GCC_CNOC_BUS_TIMEOUT6_BCR] = { 0x4b030 },
> +	[GCC_CNOC_BUS_TIMEOUT7_BCR] = { 0x4b038 },
> +	[GCC_APB2JTAG_BCR] = { 0x4c000 },
> +	[GCC_RBCPR_CX_BCR] = { 0x4e000 },
> +	[GCC_RBCPR_MX_BCR] = { 0x4f000 },
> +	[GCC_USB3_PHY_BCR] = { 0x50020 },
> +	[GCC_USB3PHY_PHY_BCR] = { 0x50024 },
> +	[GCC_USB3_DP_PHY_BCR] = { 0x50028 },
> +	[GCC_SSC_BCR] = { 0x63000 },
> +	[GCC_SSC_RESET] = { 0x63020 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
> +	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
> +	[GCC_PCIE_PHY_NOCSR_COM_PHY_BCR] = { 0x6f00c },
> +	[GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x6f010 },
> +	[GCC_PCIE_PHY_COM_BCR] = { 0x6f014 },
> +	[GCC_GPU_BCR] = { 0x71000 },
> +	[GCC_SPSS_BCR] = { 0x72000 },
> +	[GCC_OBT_ODT_BCR] = { 0x73000 },
> +	[GCC_VS_BCR] = { 0x7a000 },
> +	[GCC_MSS_VS_RESET] = { 0x7a100 },
> +	[GCC_GPU_VS_RESET] = { 0x7a104 },
> +	[GCC_APC0_VS_RESET] = { 0x7a108 },
> +	[GCC_APC1_VS_RESET] = { 0x7a10c },
> +	[GCC_CNOC_BUS_TIMEOUT8_BCR] = { 0x80000 },
> +	[GCC_CNOC_BUS_TIMEOUT9_BCR] = { 0x80008 },
> +	[GCC_CNOC_BUS_TIMEOUT10_BCR] = { 0x80010 },
> +	[GCC_CNOC_BUS_TIMEOUT11_BCR] = { 0x80018 },
> +	[GCC_CNOC_BUS_TIMEOUT12_BCR] = { 0x80020 },
> +	[GCC_CNOC_BUS_TIMEOUT13_BCR] = { 0x80028 },
> +	[GCC_CNOC_BUS_TIMEOUT14_BCR] = { 0x80030 },
> +	[GCC_CNOC_BUS_TIMEOUT_EXTREF_BCR] = { 0x80038 },
> +	[GCC_AGGRE1_NOC_BCR] = { 0x82000 },
> +	[GCC_AGGRE2_NOC_BCR] = { 0x83000 },
> +	[GCC_DCC_BCR] = { 0x84000 },
> +	[GCC_QREFS_VBG_CAL_BCR] = { 0x88028 },
> +	[GCC_IPA_BCR] = { 0x89000 },
> +	[GCC_GLM_BCR] = { 0x8b000 },
> +	[GCC_SKL_BCR] = { 0x8c000 },
> +	[GCC_MSMPU_BCR] = { 0x8d000 },
>  };
>  
>  static const struct regmap_config gcc_msm8998_regmap_config = {
> diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
> index 58a242e..c751a40 100644
> --- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
> +++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
> @@ -204,5 +204,92 @@
>  #define GCC_TSIF_BCR						16
>  #define GCC_UFS_BCR						17
>  #define GCC_USB_30_BCR						18
> +#define GCC_SYSTEM_NOC_BCR					19
> +#define GCC_CONFIG_NOC_BCR					20
> +#define GCC_AHB2PHY_EAST_BCR					21
> +#define GCC_IMEM_BCR						22
> +#define GCC_PIMEM_BCR						23
> +#define GCC_MMSS_BCR						24
> +#define GCC_QDSS_BCR						25
> +#define GCC_WCSS_BCR						26
> +#define GCC_BLSP1_BCR						27
> +#define GCC_BLSP1_UART1_BCR					28
> +#define GCC_BLSP1_UART2_BCR					29
> +#define GCC_BLSP1_UART3_BCR					30
> +#define GCC_CM_PHY_REFGEN1_BCR					31
> +#define GCC_CM_PHY_REFGEN2_BCR					32
> +#define GCC_BLSP2_BCR						33
> +#define GCC_BLSP2_UART1_BCR					34
> +#define GCC_BLSP2_UART2_BCR					35
> +#define GCC_BLSP2_UART3_BCR					36
> +#define GCC_SRAM_SENSOR_BCR					37
> +#define GCC_PRNG_BCR						38
> +#define GCC_TSIF_0_RESET					39
> +#define GCC_TSIF_1_RESET					40
> +#define GCC_TCSR_BCR						41
> +#define GCC_BOOT_ROM_BCR					42
> +#define GCC_MSG_RAM_BCR						43
> +#define GCC_TLMM_BCR						44
> +#define GCC_MPM_BCR						45
> +#define GCC_SEC_CTRL_BCR					46
> +#define GCC_SPMI_BCR						47
> +#define GCC_SPDM_BCR						48
> +#define GCC_CE1_BCR						49
> +#define GCC_BIMC_BCR						50
> +#define GCC_SNOC_BUS_TIMEOUT0_BCR				51
> +#define GCC_SNOC_BUS_TIMEOUT1_BCR				52
> +#define GCC_SNOC_BUS_TIMEOUT3_BCR				53
> +#define GCC_SNOC_BUS_TIMEOUT_EXTREF_BCR				54
> +#define GCC_PNOC_BUS_TIMEOUT0_BCR				55
> +#define GCC_CNOC_PERIPH_BUS_TIMEOUT1_BCR			56
> +#define GCC_CNOC_PERIPH_BUS_TIMEOUT2_BCR			57
> +#define GCC_CNOC_BUS_TIMEOUT0_BCR				58
> +#define GCC_CNOC_BUS_TIMEOUT1_BCR				59
> +#define GCC_CNOC_BUS_TIMEOUT2_BCR				60
> +#define GCC_CNOC_BUS_TIMEOUT3_BCR				61
> +#define GCC_CNOC_BUS_TIMEOUT4_BCR				62
> +#define GCC_CNOC_BUS_TIMEOUT5_BCR				63
> +#define GCC_CNOC_BUS_TIMEOUT6_BCR				64
> +#define GCC_CNOC_BUS_TIMEOUT7_BCR				65
> +#define GCC_APB2JTAG_BCR					66
> +#define GCC_RBCPR_CX_BCR					67
> +#define GCC_RBCPR_MX_BCR					68
> +#define GCC_USB3_PHY_BCR					69
> +#define GCC_USB3PHY_PHY_BCR					70
> +#define GCC_USB3_DP_PHY_BCR					71
> +#define GCC_SSC_BCR						72
> +#define GCC_SSC_RESET						73
> +#define GCC_USB_PHY_CFG_AHB2PHY_BCR				74
> +#define GCC_PCIE_0_LINK_DOWN_BCR				75
> +#define GCC_PCIE_0_PHY_BCR					76
> +#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				77
> +#define GCC_PCIE_PHY_BCR					78
> +#define GCC_PCIE_PHY_NOCSR_COM_PHY_BCR				79
> +#define GCC_PCIE_PHY_CFG_AHB_BCR				80
> +#define GCC_PCIE_PHY_COM_BCR					81
> +#define GCC_GPU_BCR						82
> +#define GCC_SPSS_BCR						83
> +#define GCC_OBT_ODT_BCR						84
> +#define GCC_VS_BCR						85
> +#define GCC_MSS_VS_RESET					86
> +#define GCC_GPU_VS_RESET					87
> +#define GCC_APC0_VS_RESET					88
> +#define GCC_APC1_VS_RESET					89
> +#define GCC_CNOC_BUS_TIMEOUT8_BCR				90
> +#define GCC_CNOC_BUS_TIMEOUT9_BCR				91
> +#define GCC_CNOC_BUS_TIMEOUT10_BCR				92
> +#define GCC_CNOC_BUS_TIMEOUT11_BCR				93
> +#define GCC_CNOC_BUS_TIMEOUT12_BCR				94
> +#define GCC_CNOC_BUS_TIMEOUT13_BCR				95
> +#define GCC_CNOC_BUS_TIMEOUT14_BCR				96
> +#define GCC_CNOC_BUS_TIMEOUT_EXTREF_BCR				97
> +#define GCC_AGGRE1_NOC_BCR					98
> +#define GCC_AGGRE2_NOC_BCR					99
> +#define GCC_DCC_BCR						100
> +#define GCC_QREFS_VBG_CAL_BCR					101
> +#define GCC_IPA_BCR						102
> +#define GCC_GLM_BCR						103
> +#define GCC_SKL_BCR						104
> +#define GCC_MSMPU_BCR						105
>  
>  #endif
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
