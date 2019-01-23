Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8795FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A02184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAWTKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:10:43 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50290 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726432AbfAWTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:10:43 -0500
Received: (qmail 5585 invoked by uid 2102); 23 Jan 2019 14:10:42 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2019 14:10:42 -0500
Date:   Wed, 23 Jan 2019 14:10:42 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
cc:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suresh Gupta <B42813@freescale.com>
Subject: Re: [PATCH v3 2/5] usb: phy: Workaround for USB erratum-A005728
In-Reply-To: <20190123070615.14462-2-yinbo.zhu@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901231407280.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019, Yinbo Zhu wrote:

> From: Suresh Gupta <B42813@freescale.com>
> 
> PHY_CLK_VALID bit for UTMI PHY in USBDR does not set even
> if PHY is providing valid clock. Workaround for this
> involves resetting of PHY and check PHY_CLK_VALID bit
> multiple times. If PHY_CLK_VALID bit is still not set even
> after 5 retries, it would be safe to deaclare that PHY
> clock is not available.
> This erratum is applicable for USBDR less then ver 2.4.
> 
> Signed-off-by: Suresh Gupta <B42813@freescale.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v3:
> 		replace in_be32 with ioread32be
> 
>  drivers/usb/host/ehci-fsl.c |   37 ++++++++++++++++++++++++++-----------
>  drivers/usb/host/ehci-fsl.h |    3 +++
>  2 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index ea7e17b..8b0f3ed 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -183,6 +183,17 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
>  	return retval;
>  }
>  
> +static bool usb_phy_clk_valid(struct usb_hcd *hcd)
> +{
> +	void __iomem *non_ehci = hcd->regs;
> +	bool ret = true;
> +
> +	if (!(ioread32be(non_ehci + FSL_SOC_USB_CTRL) & PHY_CLK_VALID))
> +		ret = false;
> +
> +	return ret;
> +}
> +
>  static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  			       enum fsl_usb2_phy_modes phy_mode,
>  			       unsigned int port_offset)
> @@ -226,6 +237,16 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  		/* fall through */
>  	case FSL_USB2_PHY_UTMI:
>  	case FSL_USB2_PHY_UTMI_DUAL:
> +		/* PHY_CLK_VALID bit is de-featured from all controller
> +		 * versions below 2.4 and is to be checked only for
> +		 * internal UTMI phy
> +		 */
> +		if (pdata->controller_ver > FSL_USB_VER_2_4 &&
> +			pdata->have_sysif_regs && !usb_phy_clk_valid(hcd)) {
> +			pr_err("fsl-ehci: USB PHY clock invalid\n");

How about using dev_err instead of pr_err?  That's what other parts of 
this driver do.

> +			return -EINVAL;
> +		}
> +
>  		if (pdata->have_sysif_regs && pdata->controller_ver) {
>  			/* controller version 1.6 or above */
>  			tmp = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> @@ -249,17 +270,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  		break;
>  	}
>  
> -	/*
> -	 * check PHY_CLK_VALID to determine phy clock presence before writing
> -	 * to portsc
> -	 */
> -	if (pdata->check_phy_clk_valid) {
> -		if (!(ioread32be(non_ehci + FSL_SOC_USB_CTRL) &
> -		    PHY_CLK_VALID)) {
> -			dev_warn(hcd->self.controller,
> -				 "USB PHY clock invalid\n");
> -			return -EINVAL;
> -		}
> +	if (pdata->have_sysif_regs &&
> +		pdata->controller_ver > FSL_USB_VER_1_6 &&
> +		!usb_phy_clk_valid(hcd)) {

Continuation lines should be indented by an amount that lets readers 
easily distinguish them from lines in an inner code block.  (Also 
applies to hunk #2.)

> +		dev_warn(hcd->self.controller, "USB PHY clock invalid\n");
> +		return -EINVAL;
>  	}
>  
>  	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index cbc4220..9d18c6e 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -50,4 +50,7 @@
>  #define UTMI_PHY_EN             (1<<9)
>  #define ULPI_PHY_CLK_SEL        (1<<10)
>  #define PHY_CLK_VALID		(1<<17)
> +
> +/* Retry count for checking UTMI PHY CLK validity */
> +#define UTMI_PHY_CLK_VALID_CHK_RETRY 5
>  #endif				/* _EHCI_FSL_H */
> 

