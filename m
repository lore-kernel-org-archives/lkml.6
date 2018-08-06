Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADEDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BE621A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BE621A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeHFOYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:24:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:12816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730919AbeHFOYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:24:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 05:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="78879358"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2018 05:15:45 -0700
Subject: Re: [PATCH v2] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     v.anuragkumar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1533555373-24400-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <efb57c01-5b22-ac06-cb7f-c863f9f4a9f6@linux.intel.com>
Date:   Mon, 6 Aug 2018 15:18:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1533555373-24400-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 06.08.2018 14:36, Anurag Kumar Vulisha wrote:
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
>   Changes in v2:
> 	1. As suggested by Mathias, restoring immod_interval changes to
> 	   default
> ---
>   drivers/usb/host/xhci-plat.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index c1b22fc..f121238 100644
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
> @@ -272,20 +272,24 @@ static int xhci_plat_probe(struct platform_device *pdev)
>   		goto disable_clk;
>   	}
>   
> -	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
> -		xhci->quirks |= XHCI_HW_LPM_DISABLE;
> -
> -	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
> -		xhci->quirks |= XHCI_LPM_SUPPORT;
> -
> -	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
> -		xhci->quirks |= XHCI_BROKEN_PORT_PED;
> -
>   	/* imod_interval is the interrupt moderation value in nanoseconds. */
>   	xhci->imod_interval = 40000;

xhci->imod_interval = 40000 is now in the correct place

>   	device_property_read_u32(sysdev, "imod-interval-ns",
>   				 &xhci->imod_interval);

but the device_propery_read_u32() line above can be moved inside loop below.

>   
> +	/* Iterate over all parent nodes for finding quirks */
> +	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
> +
> +		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
> +			xhci->quirks |= XHCI_HW_LPM_DISABLE;
> +
> +		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
> +			xhci->quirks |= XHCI_LPM_SUPPORT;
> +
> +		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
> +			xhci->quirks |= XHCI_BROKEN_PORT_PED;
> +	}
> +
>   	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
>   	if (IS_ERR(hcd->usb_phy)) {
>   		ret = PTR_ERR(hcd->usb_phy);
> 

-Mathias
