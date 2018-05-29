Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966329AbeE2S4F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:56:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46592 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S965746AbeE2S4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:56:02 -0400
Date: Tue, 29 May 2018 14:56:01 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Prasanthi Chellakumar <Prasanthi.Chellakumar@microchip.com>
cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ohci: fix sfr kernel warning in ohci-at91
 driver
In-Reply-To: <1527285896-12811-1-git-send-email-Prasanthi.Chellakumar@microchip.com>
Message-ID: <Pine.LNX.4.44L0.1805291455340.1458-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Prasanthi Chellakumar wrote:

> The USB Host Controller driver 'ohci-at91.c' reads a Special Function
> Register - OHCI Interrupt Configuration Register (AT91_SFR_OHCIICR)
> for bits SUSPEND_A/B/C. These bits are defined in sama5d2 alone, so
> sfr register mapping is done with compatible string "atmel,sama5d2-sfr".
> This gives a kernel warning 'failed to find sfr node' with non sama5d2
> cpus which is removed here, thus leaving it up to having a proper DTS.
> 
> Signed-off-by: Prasanthi Chellakumar <prasanthi.chellakumar@microchip.com>
> 
> ---
> 
> The AT91_SFR_OHCIIR register is read for USB suspend and wake
> up control. The OHCI driver has a sfr register mapping for sama5d2
> alone. The USB suspend proceeds only when there is valid sfr regmap.
> So SFR access in boards that it is absent is not required. In such
> boards, USB suspend control requests is processed by usb_hub_control().
> But there is a kernel warning with non sama5d2 cpus. This patch fixes
> the kernel warning, changing to debug message(dev_dbg).
> ---
>  drivers/usb/host/ohci-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index af0566d..ce11c47 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -214,7 +214,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  
>  	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
>  	if (!ohci_at91->sfr_regmap)
> -		dev_warn(dev, "failed to find sfr node\n");
> +		dev_dbg(dev, "failed to find sfr node\n");
>  
>  	board = hcd->self.controller->platform_data;
>  	ohci = hcd_to_ohci(hcd);

Acked-by: Alan Stern <stern@rowland.harvard.edu>
