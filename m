Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437052087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAHQWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:22:20 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53562 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728394AbfAHQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:22:19 -0500
Received: (qmail 1690 invoked by uid 2102); 8 Jan 2019 11:22:19 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2019 11:22:19 -0500
Date:   Tue, 8 Jan 2019 11:22:19 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: Re: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
In-Reply-To: <20190108060426.11581-3-ran.wang_1@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901081120580.1355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Ran Wang wrote:

> From: yinbo.zhu <yinbo.zhu@nxp.com>
> 
> Remove USB errata checking code from driver. Applicability of erratum
> is retrieved by reading corresponding property in device tree.
> This property is written during device tree fixup.
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/usb/host/ehci-fsl.c      |    7 +------
>  drivers/usb/host/fsl-mph-dr-of.c |    6 ++++++
>  include/linux/fsl_devices.h      |    7 ++++---
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 59ebe1b..2aa408a 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -304,14 +304,9 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
>  			return -EINVAL;
>  
>  	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
> -		unsigned int chip, rev, svr;
> -
> -		svr = mfspr(SPRN_SVR);
> -		chip = svr >> 16;
> -		rev = (svr >> 4) & 0xf;
>  
>  		/* Deal with USB Erratum #14 on MPC834x Rev 1.0 & 1.1 chips */
> -		if ((rev == 1) && (chip >= 0x8050) && (chip <= 0x8055))
> +		if (pdata->has_fsl_erratum_14 == 1)
>  			ehci->has_fsl_port_bug = 1;
>  
>  		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
> index 677f9d5..4f8b8a0 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -225,6 +225,12 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
>  	pdata->has_fsl_erratum_a005697 =
>  		of_property_read_bool(np, "fsl,usb_erratum-a005697");
>  
> +	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
> +		pdata->has_fsl_erratum_14 = 1;
> +	else
> +		pdata->has_fsl_erratum_14 = 0;
> +
> +
>  	/*
>  	 * Determine whether phy_clk_valid needs to be checked
>  	 * by reading property in device tree
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index 60cef82..7aa51bc 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -98,10 +98,11 @@ struct fsl_usb2_platform_data {
>  
>  	unsigned	suspended:1;
>  	unsigned	already_suspended:1;
> -	unsigned        has_fsl_erratum_a007792:1;
> -	unsigned        has_fsl_erratum_a005275:1;
> +	unsigned    has_fsl_erratum_a007792:1;
> +	unsigned    has_fsl_erratum_14:1;
> +	unsigned    has_fsl_erratum_a005275:1;
>  	unsigned	has_fsl_erratum_a005697:1;
> -	unsigned        check_phy_clk_valid:1;
> +	unsigned    check_phy_clk_valid:1;

You are using spaces here instead of tabs, which alters the alignment.  
Don't do that.

Alan Stern

>  
>  	/* register save area for suspend/resume */
>  	u32		pm_command;

