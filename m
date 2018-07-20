Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D5EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB01D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB01D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbeGTP2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:28:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:11707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbeGTP2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:28:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 07:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,379,1526367600"; 
   d="scan'208";a="217655388"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2018 07:39:36 -0700
Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <b819a5fc-82aa-dc9c-4272-fecdacbd5880@intel.com>
Date:   Fri, 20 Jul 2018 17:42:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry about the delay with this patch,
I have a couple comments inline.

On 05.06.2018 18:20, Anurag Kumar Vulisha wrote:
> In xhci_plat_probe() both sysdev and pdev->dev are being used
> for finding quirks. There are some drivers(like dwc3 host.c)
> which adds quirks(like usb3-lpm-capable) into pdev and the logic
> present in xhci_plat_probe() checks for quirks in either sysdev
> or pdev for finding the quirks. Because of this logic, some of
> the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
> host.c driver is getting missed).This patch fixes this by iterating
> over all the available parents for finding the quirks. In this way
> all the quirks which are present in child or parent are correctly
> updated.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>   drivers/usb/host/xhci-plat.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index c1b22fc..0cd0489 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -152,7 +152,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>   {
>   	const struct xhci_plat_priv *priv_match;
>   	const struct hc_driver	*driver;
> -	struct device		*sysdev;
> +	struct device		*sysdev, *tmpdev;
>   	struct xhci_hcd		*xhci;
>   	struct resource         *res;
>   	struct usb_hcd		*hcd;
> @@ -272,19 +272,26 @@ static int xhci_plat_probe(struct platform_device *pdev)
>   		goto disable_clk;
>   	}
>   
> -	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
> -		xhci->quirks |= XHCI_HW_LPM_DISABLE;
> +	/* Iterate over all parent nodes for finding quirks */
> +	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {

Isn't sysdev at this point the topmost device that can have any of those
device properties set?
We could loop from &pdev->dev up to and including sysdev.

It doesn't matter much but maybe avoid walking some extra parents.
   
>   
> -	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
> -		xhci->quirks |= XHCI_LPM_SUPPORT;
> +		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
> +			xhci->quirks |= XHCI_HW_LPM_DISABLE;
>   
> -	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
> -		xhci->quirks |= XHCI_BROKEN_PORT_PED;
> +		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
> +			xhci->quirks |= XHCI_LPM_SUPPORT;
>   
> -	/* imod_interval is the interrupt moderation value in nanoseconds. */
> -	xhci->imod_interval = 40000;

Setting the default imod_interval could be moved before the for() loop

> -	device_property_read_u32(sysdev, "imod-interval-ns",
> -				 &xhci->imod_interval);
> +		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
> +			xhci->quirks |= XHCI_BROKEN_PORT_PED;
> +
> +		/*
> +		 * imod_interval is the interrupt moderation
> +		 * value in nanoseconds.
> +		 */
> +		xhci->imod_interval = 40000;
> +		device_property_read_u32(tmpdev, "imod-interval-ns",
> +					 &xhci->imod_interval);
> +	}
>   
>   	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
>   	if (IS_ERR(hcd->usb_phy)) {
> 

Otherwise everything looks fine.
I will unfortunately be away again for another two weeks.

-Mathias
