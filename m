Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9758A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9758A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJ3SjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:39:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:11381 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeJ3SjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:39:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 02:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="86699692"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 02:46:33 -0700
Subject: Re: [PATCH v2] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
To:     "Cherian, George" <George.Cherian@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
References: <1540832062-22224-1-git-send-email-george.cherian@cavium.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <f0d31ea6-5e2c-35c2-c4ab-746181d6f326@linux.intel.com>
Date:   Tue, 30 Oct 2018 11:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540832062-22224-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.2018 18:54, Cherian, George wrote:
> Implement workaround for ThunderX2 Errata-129 (documented in
> CN99XX Known Issues" available at Cavium support site).
> As per ThunderX2errata-129, USB 2 device may come up as USB 1
> if a connection to a USB 1 device is followed by another connection to
> a USB 2 device, the link will come up as USB 1 for the USB 2 device.
> 
> Resolution: Reset the PHY after the USB 1 device is disconnected.
> The PHY reset sequence is done using private registers in XHCI register
> space. After the PHY is reset we check for the PLL lock status and retry
> the operation if it fails. From our tests, retrying 4 times is sufficient.
> 
> Add a new quirk flag XHCI_RESET_PLL_ON_DISCONNECT to invoke the workaround
> in handle_xhci_port_status().
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>   drivers/usb/host/xhci-pci.c  |  5 +++++
>   drivers/usb/host/xhci-ring.c | 35 ++++++++++++++++++++++++++++++++++-
>   drivers/usb/host/xhci.h      |  1 +
>   3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 51dd8e0..334c009 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -231,6 +231,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
>   		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
>   
> +	if ((pdev->vendor == PCI_VENDOR_ID_BROADCOM ||
> +	     pdev->vendor == PCI_VENDOR_ID_CAVIUM) &&
> +	     pdev->device == 0x9026)
> +		xhci->quirks |= XHCI_RESET_PLL_ON_DISCONNECT;
> +
>   	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>   		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
>   				"QUIRK: Resetting on resume");
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index f0a99aa..342dd5ac 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1517,6 +1517,35 @@ static void handle_device_notification(struct xhci_hcd *xhci,
>   		usb_wakeup_notification(udev->parent, udev->portnum);
>   }
>   
> +/*
> + * Quirk hanlder for errata seen on Cavium ThunderX2 processor XHCI
> + * Controller.
> + * As per ThunderX2errata-129 USB 2 device may come up as USB 1
> + * If a connection to a USB 1 device is followed by another connection
> + * to a USB 2 device.
> + *
> + * Reset the PHY after the USB device is disconnected if device speed
> + * is less than HCD_USB3.
> + * Retry the reset sequence max of 4 times checking the PLL lock status.
> + *
> + */
> +static void xhci_handle_tx2_wrapper_reset(struct xhci_hcd *xhci)

Maybe rename this to make it more obvious it's about a quirk.
xhci_cavium_reset_phy_quirk() maybe?

> +{
> +	struct usb_hcd *hcd = xhci_to_hcd(xhci);
> +	u32 pll_lock_check;
> +	u32 retry_count = 4;
> +
> +	do {
> +		/* Assert PHY reset */
> +		writel(0x6F, hcd->regs + 0x1048);
> +		udelay(10);
> +		/* De-assert the PHY reset */
> +		writel(0x7F, hcd->regs + 0x1048);
> +		udelay(200);
> +		pll_lock_check = readl(hcd->regs + 0x1070);
> +	} while (!(pll_lock_check & 0x1) && --retry_count);
> +}
> +
>   static void handle_port_status(struct xhci_hcd *xhci,
>   		union xhci_trb *event)
>   {
> @@ -1642,8 +1671,12 @@ static void handle_port_status(struct xhci_hcd *xhci,
>   		goto cleanup;
>   	}
>   
> -	if (hcd->speed < HCD_USB3)
> +	if (hcd->speed < HCD_USB3) {
>   		xhci_test_and_clear_bit(xhci, port, PORT_PLC);
> +		if ((portsc & PORT_CSC) && !(portsc & 0x1) &&
> +		    (xhci->quirks & XHCI_RESET_PLL_ON_DISCONNECT))
> +			xhci_handle_tx2_wrapper_reset(xhci);
> +	}

Check for the quirk first, this way I can ignore the rest of the code when
debugging other issues,  and use PORT_CONNECT instead of 0x1

something like:

if ((xhci->quirks & XHCI_RESET_PLL_ON_DISCONNECT) &&
     (portsc & PORT_CSC) && !(portsc & PORT_CONNECT))

Thanks
-Mathias
