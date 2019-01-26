Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C035C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5633E2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V83uW5Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfAZOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 09:47:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfAZOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 09:47:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so6023540pfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bf7xZE/Gt9Krzz5Kp61NPYGkKO50EUKxBnoHUsv86/I=;
        b=V83uW5DzhiWlRvwKUrcjI8MWwHaqTAiJVq9zGoLINnXrJCMxESC9QyyuZk0d2vWrkp
         T+Dy0wX1O5SPMS8Ryzh/a3kAZaUtAlOBfm1mnEZ/iPIf0dYGoGjaZZyyqWxGsfrhOpUR
         n+p6iqF51W3koryQ9QtInE//644nSIolXY+c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bf7xZE/Gt9Krzz5Kp61NPYGkKO50EUKxBnoHUsv86/I=;
        b=OE3hWF4donfnzHFvzeUTsRgsIrlJMm+dzJOJXO+maAk7SPYEY6ojrWHdm62sxNdLn4
         UbV1pERqZY/yRDIqfrs8gWw6pgRvpt00zxjTEqt3o5mCoC+IrhIRdyDDF5MTH4fmtXH3
         5H7cy/bNNTnpV8AHuuBpiLYyJX+p5FdOxIndKwivTDy69xszRN6yJ7gF67JaNU3Dej/A
         Y4ftB5lneB4duxT4Z4ZNtIngtL2knGNh5WL2sDdbPsNgZ2//KeHK6Z2gsgxMStZRPGIy
         dYyMo1ik3kwX0RZWnlTO/0iVFVPCkB2YUZvlJxxoJEWRwsKiL/BYf6T5GT9g+qqLAAq4
         OHAg==
X-Gm-Message-State: AJcUukf8ra46jQqxEyC0Mw5gtTa3WpJ2PHVFAaLStmykNNR2OHBng56z
        pZUzH3zTwystSTMxPzp6C6/I
X-Google-Smtp-Source: ALg8bN5VAdk0S/F5DmuPTmXd2cqc2NzYPUDcrALhNnpxTSErMjgnxOIbQJtT0H0HrjU15dUqbjqkmQ==
X-Received: by 2002:a62:8985:: with SMTP id n5mr15334779pfk.255.1548514044113;
        Sat, 26 Jan 2019 06:47:24 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:807:9f85:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id o189sm54970454pfg.117.2019.01.26.06.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 06:47:23 -0800 (PST)
Date:   Sat, 26 Jan 2019 20:17:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org
Subject: Re: [PATCH v2 3/3] scsi: ufs: Add HI3670 SoC UFS driver support
Message-ID: <20190126144711.GA14260@Mani-XPS-13-9360>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105072859.9134-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 12:58:59PM +0530, Manivannan Sadhasivam wrote:
> Add HI3670 SoC UFS driver support by extending the common ufs-hisi
> driver. One major difference between HI3660 ad HI3670 SoCs interms of
> UFS is the PHY. HI3670 has a 10nm variant PHY and hence this parameter is
> used to distinguish the configuration.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Hello,

Ping on this patch!

Thanks,
Mani

> ---
>  drivers/scsi/ufs/ufs-hisi.c | 127 +++++++++++++++++++++++++++++-------
>  drivers/scsi/ufs/ufs-hisi.h |   4 ++
>  2 files changed, 109 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
> index 452e19f8fb47..f2d3df357a97 100644
> --- a/drivers/scsi/ufs/ufs-hisi.c
> +++ b/drivers/scsi/ufs/ufs-hisi.c
> @@ -66,7 +66,7 @@ static int ufs_hisi_check_hibern8(struct ufs_hba *hba)
>  	return err;
>  }
>  
> -static void ufs_hi3660_clk_init(struct ufs_hba *hba)
> +static void ufs_hisi_clk_init(struct ufs_hba *hba)
>  {
>  	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
>  
> @@ -80,7 +80,7 @@ static void ufs_hi3660_clk_init(struct ufs_hba *hba)
>  	ufs_sys_ctrl_set_bits(host, BIT_SYSCTRL_REF_CLOCK_EN, PHY_CLK_CTRL);
>  }
>  
> -static void ufs_hi3660_soc_init(struct ufs_hba *hba)
> +static void ufs_hisi_soc_init(struct ufs_hba *hba)
>  {
>  	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
>  	u32 reg;
> @@ -139,6 +139,7 @@ static void ufs_hi3660_soc_init(struct ufs_hba *hba)
>  
>  static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  {
> +	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
>  	int err;
>  	uint32_t value;
>  	uint32_t reg;
> @@ -153,6 +154,14 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8121, 0x0), 0x2D);
>  	/* MPHY CBOVRCTRL3 */
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8122, 0x0), 0x1);
> +
> +	if (host->caps & UFS_HISI_CAP_PHY10nm) {
> +		/* MPHY CBOVRCTRL4 */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8127, 0x0), 0x98);
> +		/* MPHY CBOVRCTRL5 */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8128, 0x0), 0x1);
> +	}
> +
>  	/* Unipro VS_MphyCfgUpdt */
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xD085, 0x0), 0x1);
>  	/* MPHY RXOVRCTRL4 rx0 */
> @@ -173,10 +182,21 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8113, 0x0), 0x1);
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xD085, 0x0), 0x1);
>  
> -	/* Tactive RX */
> -	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x4), 0x7);
> -	/* Tactive RX */
> -	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x5), 0x7);
> +	if (host->caps & UFS_HISI_CAP_PHY10nm) {
> +		/* RX_Hibern8Time_Capability*/
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0092, 0x4), 0xA);
> +		/* RX_Hibern8Time_Capability*/
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0092, 0x5), 0xA);
> +		/* RX_Min_ActivateTime */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008f, 0x4), 0xA);
> +		/* RX_Min_ActivateTime*/
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008f, 0x5), 0xA);
> +	} else {
> +		/* Tactive RX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x4), 0x7);
> +		/* Tactive RX */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x5), 0x7);
> +	}
>  
>  	/* Gear3 Synclength */
>  	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0095, 0x4), 0x4F);
> @@ -208,7 +228,8 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
>  	if (err)
>  		dev_err(hba->dev, "ufs_hisi_check_hibern8 error\n");
>  
> -	ufshcd_writel(hba, UFS_HCLKDIV_NORMAL_VALUE, UFS_REG_HCLKDIV);
> +	if (!(host->caps & UFS_HISI_CAP_PHY10nm))
> +		ufshcd_writel(hba, UFS_HCLKDIV_NORMAL_VALUE, UFS_REG_HCLKDIV);
>  
>  	/* disable auto H8 */
>  	reg = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
> @@ -253,7 +274,7 @@ static int ufs_hisi_link_startup_post_change(struct ufs_hba *hba)
>  	return 0;
>  }
>  
> -static int ufs_hi3660_link_startup_notify(struct ufs_hba *hba,
> +static int ufs_hisi_link_startup_notify(struct ufs_hba *hba,
>  					  enum ufs_notify_change_status status)
>  {
>  	int err = 0;
> @@ -391,6 +412,28 @@ static void ufs_hisi_set_dev_cap(struct ufs_hisi_dev_params *hisi_param)
>  
>  static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
>  {
> +	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
> +
> +	if (host->caps & UFS_HISI_CAP_PHY10nm) {
> +		/*
> +		 * Boston platform need to set SaveConfigTime to 0x13,
> +		 * and change sync length to maximum value
> +		 */
> +		/* VS_DebugSaveConfigTime */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0xD0A0), 0x13);
> +		/* g1 sync length */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1552), 0x4f);
> +		/* g2 sync length */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1554), 0x4f);
> +		/* g3 sync length */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1556), 0x4f);
> +		/* PA_Hibern8Time */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x15a7), 0xA);
> +		/* PA_Tactivate */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x15a8), 0xA);
> +		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xd085, 0x0), 0x01);
> +	}
> +
>  	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME) {
>  		pr_info("ufs flash device must set VS_DebugSaveConfigTime 0x10\n");
>  		/* VS_DebugSaveConfigTime */
> @@ -429,7 +472,7 @@ static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
>  	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd046), 32767);
>  }
>  
> -static int ufs_hi3660_pwr_change_notify(struct ufs_hba *hba,
> +static int ufs_hisi_pwr_change_notify(struct ufs_hba *hba,
>  				       enum ufs_notify_change_status status,
>  				       struct ufs_pa_layer_attr *dev_max_params,
>  				       struct ufs_pa_layer_attr *dev_req_params)
> @@ -567,25 +610,72 @@ static int ufs_hi3660_init(struct ufs_hba *hba)
>  		return ret;
>  	}
>  
> -	ufs_hi3660_clk_init(hba);
> +	ufs_hisi_clk_init(hba);
> +
> +	ufs_hisi_soc_init(hba);
> +
> +	return 0;
> +}
> +
> +static int ufs_hi3670_init(struct ufs_hba *hba)
> +{
> +	int ret = 0;
> +	struct device *dev = hba->dev;
> +	struct ufs_hisi_host *host;
> +
> +	ret = ufs_hisi_init_common(hba);
> +	if (ret) {
> +		dev_err(dev, "%s: ufs common init fail\n", __func__);
> +		return ret;
> +	}
> +
> +	ufs_hisi_clk_init(hba);
> +
> +	ufs_hisi_soc_init(hba);
>  
> -	ufs_hi3660_soc_init(hba);
> +	/* Add cap for 10nm PHY variant on HI3670 SoC */
> +	host = ufshcd_get_variant(hba);
> +	host->caps |= UFS_HISI_CAP_PHY10nm;
>  
>  	return 0;
>  }
>  
> -static struct ufs_hba_variant_ops ufs_hba_hisi_vops = {
> +static struct ufs_hba_variant_ops ufs_hba_hi3660_vops = {
>  	.name = "hi3660",
>  	.init = ufs_hi3660_init,
> -	.link_startup_notify = ufs_hi3660_link_startup_notify,
> -	.pwr_change_notify = ufs_hi3660_pwr_change_notify,
> +	.link_startup_notify = ufs_hisi_link_startup_notify,
> +	.pwr_change_notify = ufs_hisi_pwr_change_notify,
>  	.suspend = ufs_hisi_suspend,
>  	.resume = ufs_hisi_resume,
>  };
>  
> +static struct ufs_hba_variant_ops ufs_hba_hi3670_vops = {
> +	.name = "hi3670",
> +	.init = ufs_hi3670_init,
> +	.link_startup_notify = ufs_hisi_link_startup_notify,
> +	.pwr_change_notify = ufs_hisi_pwr_change_notify,
> +	.suspend = ufs_hisi_suspend,
> +	.resume = ufs_hisi_resume,
> +};
> +
> +static const struct of_device_id ufs_hisi_of_match[] = {
> +	{ .compatible = "hisilicon,hi3660-ufs", .data = &ufs_hba_hi3660_vops },
> +	{ .compatible = "hisilicon,hi3670-ufs", .data = &ufs_hba_hi3670_vops },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, ufs_hisi_of_match);
> +
>  static int ufs_hisi_probe(struct platform_device *pdev)
>  {
> -	return ufshcd_pltfrm_init(pdev, &ufs_hba_hisi_vops);
> +	const struct of_device_id *of_id;
> +	struct ufs_hba_variant_ops *vops;
> +	struct device *dev = &pdev->dev;
> +
> +	of_id = of_match_node(ufs_hisi_of_match, dev->of_node);
> +	vops = (struct ufs_hba_variant_ops *)of_id->data;
> +
> +	return ufshcd_pltfrm_init(pdev, vops);
>  }
>  
>  static int ufs_hisi_remove(struct platform_device *pdev)
> @@ -596,13 +686,6 @@ static int ufs_hisi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id ufs_hisi_of_match[] = {
> -	{ .compatible = "hisilicon,hi3660-ufs" },
> -	{},
> -};
> -
> -MODULE_DEVICE_TABLE(of, ufs_hisi_of_match);
> -
>  static const struct dev_pm_ops ufs_hisi_pm_ops = {
>  	.suspend	= ufshcd_pltfrm_suspend,
>  	.resume		= ufshcd_pltfrm_resume,
> diff --git a/drivers/scsi/ufs/ufs-hisi.h b/drivers/scsi/ufs/ufs-hisi.h
> index 3df9cd7acc29..667dfe39b57e 100644
> --- a/drivers/scsi/ufs/ufs-hisi.h
> +++ b/drivers/scsi/ufs/ufs-hisi.h
> @@ -91,6 +91,9 @@ enum {
>  #define UFS_HISI_LIMIT_HS_RATE	PA_HS_MODE_B
>  #define UFS_HISI_LIMIT_DESIRED_MODE	FAST
>  
> +#define UFS_HISI_CAP_RESERVED		BIT(0)
> +#define UFS_HISI_CAP_PHY10nm		BIT(1)
> +
>  struct ufs_hisi_host {
>  	struct ufs_hba *hba;
>  	void __iomem *ufs_sys_ctrl;
> @@ -112,4 +115,5 @@ struct ufs_hisi_host {
>  	ufs_sys_ctrl_writel((host),                                            \
>  			    ((~(mask)) & (ufs_sys_ctrl_readl((host), (reg)))), \
>  			    (reg))
> +
>  #endif /* UFS_HISI_H_ */
> -- 
> 2.17.1
> 
