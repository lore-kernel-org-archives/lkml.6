Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94FBC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E81F20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E81F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJYXTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:19:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41328 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727401AbeJYXTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:19:40 -0400
Received: (qmail 10623 invoked by uid 2102); 25 Oct 2018 10:46:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Oct 2018 10:46:34 -0400
Date:   Thu, 25 Oct 2018 10:46:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Mathias Nyman <mathias.nyman@intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bin Liu <b-liu@ti.com>,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dominik Bozek <dominikx.bozek@intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: USB-C device hotplug issue
In-Reply-To: <7d444d00-5144-452d-4229-e77d38a991f5@secunet.com>
Message-ID: <Pine.LNX.4.44L0.1810251040540.1447-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, Dennis Wassenberg wrote:

> Hi all,
> 
> I have a question regarding the usb hub driver (drivers/usb/core/hub.c).
> 
> There is the following scenario. I am using the Lenovo T580 device with the Lenovo UltraDock CS18 docking station. If I plug an usb-c device to the docking station there is one device which will not be recognized (SanDisk Ultra USB-C Flash Drive, https://www.sandisk.com/home/mobile-device-storage/ultra-usb-type-c). An other usb-c devices (SanDisk Extreme 900 SSD, https://www.sandisk.com/home/ssd/extreme-900-ssd) works fine. I don’t have that much USB-C devices available, so there is one device working and the other one not.
> 
> I made some analysis of the situation where I attached the SanDisk Ultra USB-C Flash Drive.
> I added some debug logs in drivers/usb/core/hub.c in port_event and hub_port_reset and activated all dynamic debug prints in hub.c. The output is the following:
> 
> [  724.110784] usb 4-1-port1: XXX: port_event: portstatus: 0x2c0, portchange: 0x40!
> [  724.110789] usb 4-1-port1: link state change
> [  724.114953] usb 4-1-port1: do warm reset
> [  724.168109] usb 4-1-port1: not warm reset yet, waiting 50ms
> [  724.220768] usb 4-1-port1: not warm reset yet, waiting 200ms
> [  724.425188] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
> [  724.425906] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
> [  724.477429] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
> [  724.477980] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x0!
> 
> The same situation with SanDisk Extreme 900 SSD:
> 
> [  863.647484] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
> [  863.647965] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x1!
> [  863.648305] usb 4-1-port1: status 0203, change 0001, 10.0 Gb/s
> [  863.758573] usb 4-1-port1: debounce total 100ms stable 100ms status 0x203
> [  863.773495] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
> [  863.773699] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
> [  863.826311] usb 4-1.1: new SuperSpeedPlus USB device number 6 using xhci_hcd
> [  863.840002] usb 4-1.1: udev 6, busnum 4, minor = 389
> [  863.840010] usb 4-1.1: New USB device found, idVendor=0781, idProduct=5593
> [  863.840014] usb 4-1.1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
> [  863.840018] usb 4-1.1: Product: EXTREME900
> [  863.840022] usb 4-1.1: Manufacturer: SanDisk
> [  863.840026] usb 4-1.1: SerialNumber: 10000019DF56
> 
> So, at first I am wondering if the usb hub port was in USB_SS_PORT_LS_U3 if I attach the SanDisk Ultra USB-C Flash Drive. In case of the SanDisk Extreme 900 the usb hub port is in USB_SS_PORT_LS_U0. What’ the reason for that?
> 
> I read https://www.kernel.org/doc/html/v4.14/driver-api/usb/power-management.html. In this test usb core was bootet wird autosuspend=-1.Additionally the <hubdev-portX>/power/pm_qos_no_power_off sysfs variable is always set to 1. Nevertheless the hub port is in LS U3, but only using SanDisk Ultra USB-C Flash Drive.
> 
> I looked through the code and wondered why the USB_PORT_FEAT_C_CONNECTION bit is cleared at successful warm usb 3 reset in hub_port_reset.
> In case of the Ultra USB-C Flash Drive at first the link state change is detected. Directly after executing the actual hub_port_reset the USB_PORT_FEAT_C_CONNECTION bit will change to 1. But the hub_port_reset code will set this bit to 0. At the next run the bit remains 0 and the connect_change flag in port_event will not be set. That  means the USB_PORT_FEAT_C_CONNECTION flag will be cleared without taking it into account. That’s why this device will not be detected correctly.
> 
> If I modify the code in this way that I did’t clear the USB_PORT_FEAT_C_CONNECTION bit in hub_port_reset on warm usb3 reset this flag is still set during the next run. This makes sure that the connect_change flag in port_event is set and the usb device is detected correctly.
> Is this code change correct or will it break other use cases? Are there any other ways to make the kernel detect that usb device at the docking station?
> 
> Please refer to the output of the modified usb_hub_reset code:
> 
> [  121.566344] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
> [  121.566805] usb 4-1-port1: XXX: port_event: portstatus: 0x2c0, portchange: 0x40!
> [  121.566810] usb 4-1-port1: link state change
> [  121.573481] usb 4-1-port1: do warm reset
> [  121.625297] usb 4-1-port1: not warm reset yet, waiting 50ms
> [  121.677854] usb 4-1-port1: not warm reset yet, waiting 200ms
> [  121.881091] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
> [  121.881454] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
> [  121.933109] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
> [  121.933407] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x1!
> [  121.933861] usb 4-1-port1: status 0203, change 0001, 10.0 Gb/s
> [  122.042540] usb 4-1-port1: debounce total 100ms stable 100ms status 0x203
> [  122.056865] usb 4-1-port1: XXX: hub_port_reset (before clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
> [  122.057230] usb 4-1-port1: XXX: hub_port_reset (after clear USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
> [  122.109166] usb 4-1.1: new SuperSpeed USB device number 5 using xhci_hcd
> [  122.122392] usb 4-1.1: udev 5, busnum 4, minor = 388
> [  122.122399] usb 4-1.1: New USB device found, idVendor=0781, idProduct=5596
> [  122.122404] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  122.122408] usb 4-1.1: Product: Ultra T C
> [  122.122412] usb 4-1.1: Manufacturer: SanDisk
> [  122.122415] usb 4-1.1: SerialNumber: 4C531001400624115002
> [  122.124151] hub 4-1:1.0: state 7 ports 4 chg 0000 evt 0002
> [  122.125042] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x0!
> 
> 
> The code change for Kernel 4.14 look as follows:
> 
> Subject: [PATCH] usb: core: do not clear USB_PORT_FEAT_C_CONNECTION on warm
>  hub port reset
> 
> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
> ---
>  drivers/usb/core/hub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a9db0887edca..9b4dfe6c8829 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2815,7 +2815,9 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>  					USB_PORT_FEAT_C_BH_PORT_RESET);
>  			usb_clear_port_feature(hub->hdev, port1,
>  					USB_PORT_FEAT_C_PORT_LINK_STATE);
> -			usb_clear_port_feature(hub->hdev, port1,
> +
> +			if (!warm)
> +				usb_clear_port_feature(hub->hdev, port1,
>  					USB_PORT_FEAT_C_CONNECTION);
>  
>  			/*

The key fact is that connection events can get lost if they happen to 
occur during a port reset.

I'm not entirely certain of the logic here, but it looks like the
correct test to add should be "if (udev != NULL)", not "if (!warm)".  
Perhaps Mathias can confirm this.

Are there any reasons for resetting a port when there's no attached 
device, besides a link-state change?  If there are, we might need to 
check for a connect-change when they occur too.

Alan Stern

