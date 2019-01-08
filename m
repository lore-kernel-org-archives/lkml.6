Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5BDC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674A02173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfAHQUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:20:03 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53552 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729351AbfAHQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:20:02 -0500
Received: (qmail 1681 invoked by uid 2102); 8 Jan 2019 11:20:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2019 11:20:01 -0500
Date:   Tue, 8 Jan 2019 11:20:01 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
In-Reply-To: <20190108060426.11581-2-ran.wang_1@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901081118121.1355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Ran Wang wrote:

> arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(), which
> causing compile failure on some Layerscape Platforms (such as LS1021A and
> LS2012A which also integrates FSL EHCI controller). So use
> ioread32be()/iowrite32be() instead to make it workable on both
> powerpc and arm.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/usb/host/ehci-fsl.c |   64 ++++++++++++++++++++++++++++---------------
>  1 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 0a9fd20..59ebe1b 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/fsl_devices.h>
>  #include <linux/of_platform.h>
> +#include <linux/io.h>
>  
>  #include "ehci.h"
>  #include "ehci-fsl.h"
> @@ -50,6 +51,7 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int irq;
>  	int retval;
> +	u32 tmp;
>  
>  	pr_debug("initializing FSL-SOC USB Controller\n");
>  
> @@ -114,18 +116,23 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Enable USB controller, 83xx or 8536 */
> -	if (pdata->have_sysif_regs && pdata->controller_ver < FSL_USB_VER_1_6)
> -		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
> -				CONTROL_REGISTER_W1C_MASK, 0x4);
> -
> +	if (pdata->have_sysif_regs && pdata->controller_ver < FSL_USB_VER_1_6) {
> +		tmp = ioread32be(hcd->regs + FSL_SOC_USB_CTRL);
> +		tmp &= ~CONTROL_REGISTER_W1C_MASK;
> +		tmp |= 0x4;
> +		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
> +	}
>  	/*
>  	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
>  	 * controller reset for USB Controller version 2.5
>  	 */
>  	if (pdata->has_fsl_erratum_a007792) {
> -		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
> -				CONTROL_REGISTER_W1C_MASK, CTRL_UTMI_PHY_EN);
> -		writel(PORT_PTS_UTMI, hcd->regs + FSL_SOC_USB_PORTSC1);
> +		tmp = ioread32be(hcd->regs + FSL_SOC_USB_CTRL);
> +		tmp &= ~CONTROL_REGISTER_W1C_MASK;
> +		tmp |= CTRL_UTMI_PHY_EN;
> +		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
> +
> +		iowrite32be(PORT_PTS_UTMI, hcd->regs + FSL_SOC_USB_PORTSC1);

Why do you change this writel() into iowrite32be() but leave other 
instances of writel() unchanged?  Was this a mistake?

>  	}
>  
>  	/* Don't need to set host mode here. It will be done by tdi_reset() */
> @@ -174,7 +181,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  			       enum fsl_usb2_phy_modes phy_mode,
>  			       unsigned int port_offset)
>  {
> -	u32 portsc;
> +	u32 portsc, tmp;
>  	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
>  	void __iomem *non_ehci = hcd->regs;
>  	struct device *dev = hcd->self.controller;
> @@ -192,11 +199,16 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  	case FSL_USB2_PHY_ULPI:
>  		if (pdata->have_sysif_regs && pdata->controller_ver) {
>  			/* controller version 1.6 or above */
> -			clrbits32(non_ehci + FSL_SOC_USB_CTRL,
> -				  CONTROL_REGISTER_W1C_MASK | UTMI_PHY_EN);
> -			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> -					CONTROL_REGISTER_W1C_MASK,
> -					ULPI_PHY_CLK_SEL | USB_CTRL_USB_EN);
> +			/* turn off UTMI PHY first */
> +			tmp = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> +			tmp &= ~(CONTROL_REGISTER_W1C_MASK | UTMI_PHY_EN);
> +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> +
> +			/* then turn on ULPI and enable USB controller */
> +			tmp = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> +			tmp &= ~(CONTROL_REGISTER_W1C_MASK);

Unnecessary parens.

> +			tmp |= ULPI_PHY_CLK_SEL | USB_CTRL_USB_EN;
> +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
>  		}
>  		portsc |= PORT_PTS_ULPI;
>  		break;
> @@ -210,16 +222,21 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  	case FSL_USB2_PHY_UTMI_DUAL:
>  		if (pdata->have_sysif_regs && pdata->controller_ver) {
>  			/* controller version 1.6 or above */
> -			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> -					CONTROL_REGISTER_W1C_MASK, UTMI_PHY_EN);
> +			tmp = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> +			tmp &= ~(CONTROL_REGISTER_W1C_MASK);

Unnecessary parens.

> +			tmp |= UTMI_PHY_EN;
> +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> +
>  			mdelay(FSL_UTMI_PHY_DLY);  /* Delay for UTMI PHY CLK to
>  						become stable - 10ms*/
>  		}
>  		/* enable UTMI PHY */
> -		if (pdata->have_sysif_regs)
> -			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> -					CONTROL_REGISTER_W1C_MASK,
> -					CTRL_UTMI_PHY_EN);
> +		if (pdata->have_sysif_regs) {
> +			tmp = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> +			tmp &= ~CONTROL_REGISTER_W1C_MASK;
> +			tmp |= CTRL_UTMI_PHY_EN;
> +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> +		}
>  		portsc |= PORT_PTS_UTMI;
>  		break;
>  	case FSL_USB2_PHY_NONE:
> @@ -241,9 +258,12 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  
>  	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
>  
> -	if (phy_mode != FSL_USB2_PHY_ULPI && pdata->have_sysif_regs)
> -		clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> -				CONTROL_REGISTER_W1C_MASK, USB_CTRL_USB_EN);
> +	if (phy_mode != FSL_USB2_PHY_ULPI && pdata->have_sysif_regs) {
> +		tmp = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> +		tmp &= ~CONTROL_REGISTER_W1C_MASK;
> +		tmp |= USB_CTRL_USB_EN;
> +		iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> +	}
>  
>  	return 0;
>  }

Alan Stern

