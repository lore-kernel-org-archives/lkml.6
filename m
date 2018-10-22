Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCBC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3112220853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3112220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJVV1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:27:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:1089 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbeJVV1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:27:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 06:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,412,1534834800"; 
   d="scan'208";a="101585319"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga001.jf.intel.com with ESMTP; 22 Oct 2018 06:09:20 -0700
Subject: Re: [PATCH 1/2] usb: xhci: fix uninitialized completion when USB3
 port got wrong status
To:     Aaron Ma <aaron.ma@canonical.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <57b1da55-3213-8053-7002-f8798d6e1a10@linux.intel.com>
Date:   Mon, 22 Oct 2018 16:12:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.2018 20:08, Aaron Ma wrote:
> Realtek USB3.0 Card Reader [0bda:0328] reports wrong port status on
> Cannon lake PCH USB3.1 xHCI [8086:a36d] after resume from S3,
> after clear port reset it works fine.
> 
> Since this device is registered on USB3 roothub at boot,
> when port status reports not superspeed, xhci_get_port_status will call
> an uninitialized completion in bus_state[0].
> Kernel will hang because of NULL pointer.
> 
> Restrict the USB2 resume status check in USB2 roothub to fix hang issue.
> No harm to initialize USB3 bus_state[0] in case it is called.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   drivers/usb/host/xhci-hub.c  | 2 +-
>   drivers/usb/host/xhci-mem.c  | 1 +
>   drivers/usb/host/xhci-ring.c | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 7e2a531ba321..d30ca6ceffc9 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -876,7 +876,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
>   			status |= USB_PORT_STAT_SUSPEND;
>   	}
>   	if ((raw_port_status & PORT_PLS_MASK) == XDEV_RESUME &&
> -		!DEV_SUPERSPEED_ANY(raw_port_status)) {
> +		!DEV_SUPERSPEED_ANY(raw_port_status) && 1 == hcd_index(hcd)) {
>   		if ((raw_port_status & PORT_RESET) ||
>   				!(raw_port_status & PORT_PE))
>   			return 0xffffffff;

Nice catch.

Maybe use "hcd->speed < HCD_USB3" instead of "1 == hcd_index(hcd)"
It's easier to understand.

Turns out this isn't an issue with your Realtek device, it just happens to trigger
a driver issue.

The original !DEV_SUPERSPEED_ANY() check was not suitable here.
It checks the port-speed field of portsc register (bits 13:10), which are only valid for USB3
ports if all link training is done and port reached its "enabled" state.
Otherwise it will return 0, and USB3 ports may be mistaken for USB2 ports.

Just to make sure, Does your device stay as a USB 3 device, it's never
enumerated as USB2, right?

I'm in the middle of refactoring the get_port_status(), it should solve this
as well, but we need your solution stable releases.

Any chance you to check if the refactored code works with the Realtek device?
I just created a "get_port_status_refactor" branch for it:

git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git get_port_status_refactor

> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index b1f27aa38b10..dd2ad50c5289 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2539,6 +2539,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>   		xhci->bus_state[0].resume_done[i] = 0;
>   		xhci->bus_state[1].resume_done[i] = 0;
>   		/* Only the USB 2.0 completions will ever be used. */
> +		init_completion(&xhci->bus_state[0].rexit_done[i]);
>   		init_completion(&xhci->bus_state[1].rexit_done[i]);
>   	}

I don't think we should init the completion unnecessary for USB3 ports.

>   
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index f0a99aa0ac58..894d4625b8b9 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1634,7 +1634,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
>   	 * RExit to a disconnect state).  If so, let the the driver know it's
>   	 * out of the RExit state.
>   	 */
> -	if (!DEV_SUPERSPEED_ANY(portsc) &&
> +	if (!DEV_SUPERSPEED_ANY(portsc) && 1 == hcd_index(hcd) &&
>   			test_and_clear_bit(hcd_portnum,
>   				&bus_state->rexit_ports)) {
>   		complete(&bus_state->rexit_done[hcd_portnum]);
> 

Same here, prefer hcd->speed < HCD_USB3

Thanks
Mathias
