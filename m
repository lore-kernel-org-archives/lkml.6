Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D002C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C702148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfA1PiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:38:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57062 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726775AbfA1PiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:38:11 -0500
Received: (qmail 3465 invoked by uid 2102); 28 Jan 2019 10:38:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jan 2019 10:38:11 -0500
Date:   Mon, 28 Jan 2019 10:38:11 -0500 (EST)
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] usb: host: Stops USB controller init if PLL fails
 to lock
In-Reply-To: <20190125060356.14294-4-yinbo.zhu@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901281037380.1450-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Yinbo Zhu wrote:

> From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> 
> USB erratum-A006918 workaround tries to start internal PHY inside
> uboot (when PLL fails to lock). However, if the workaround also
> fails, then USB initialization is also stopped inside Linux.
> Erratum-A006918 workaround failure creates "fsl,erratum_a006918"
> node in device-tree. Presence of this node in device-tree is
> used to stop USB controller initialization in Linux
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  drivers/usb/host/ehci-fsl.c      |    5 +++++
>  drivers/usb/host/fsl-mph-dr-of.c |    3 ++-
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 373a816..8b47277 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -236,6 +236,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
>  		portsc |= PORT_PTS_PTW;
>  		/* fall through */
>  	case FSL_USB2_PHY_UTMI:
> +		if (pdata->has_fsl_erratum_a006918) {
> +			pr_warn("fsl-ehci: USB PHY clock invalid\n");

Again, you should use dev_warn() instead of pr_warn().

Alan Stern

> +			return -EINVAL;
> +		}
> +
>  	case FSL_USB2_PHY_UTMI_DUAL:
>  		/* PHY_CLK_VALID bit is de-featured from all controller
>  		 * versions below 2.4 and is to be checked only for
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
> index 4f8b8a0..762b976 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -224,13 +224,14 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
>  		of_property_read_bool(np, "fsl,usb-erratum-a005275");
>  	pdata->has_fsl_erratum_a005697 =
>  		of_property_read_bool(np, "fsl,usb_erratum-a005697");
> +	pdata->has_fsl_erratum_a006918 =
> +		of_property_read_bool(np, "fsl,usb_erratum-a006918");
>  
>  	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
>  		pdata->has_fsl_erratum_14 = 1;
>  	else
>  		pdata->has_fsl_erratum_14 = 0;
>  
> -
>  	/*
>  	 * Determine whether phy_clk_valid needs to be checked
>  	 * by reading property in device tree
> 

