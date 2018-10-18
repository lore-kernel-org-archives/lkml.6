Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FABECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080A02098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080A02098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeJRWNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:13:39 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45880 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727711AbeJRWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:13:39 -0400
Received: (qmail 1665 invoked by uid 2102); 18 Oct 2018 10:12:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Oct 2018 10:12:26 -0400
Date:   Thu, 18 Oct 2018 10:12:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Wait for extra delay time after USB_PORT_FEAT_RESET
 for quirky hub
In-Reply-To: <20181018074247.6858-1-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1810181009220.1521-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Kai-Heng Feng wrote:

> Devices connected under Terminus Technology Inc. Hub (1a40:0101) may
> fail to work after the system resumes from suspend:
> [  206.063325] usb 3-2.4: reset full-speed USB device number 4 using xhci_hcd
> [  206.143691] usb 3-2.4: device descriptor read/64, error -32
> [  206.351671] usb 3-2.4: device descriptor read/64, error -32
> 
> Info for this hub:
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=480 MxCh= 4
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1a40 ProdID=0101 Rev=01.11
> S:  Product=USB 2.0 Hub
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> 
> Some expirements indicate that the USB devices connected to the hub are
> innocent, it's the hub itself is to blame. The hub needs extra delay
> time after it resets its port.
> 
> Hence wait for extra delay, if the device is connected to this quirky
> hub.

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2891,6 +2891,11 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>  		if (udev) {
>  			struct usb_hcd *hcd = bus_to_hcd(udev->bus);
>  
> +			/* Hub needs extra delay after resetting its port. */
> +			if (udev->parent &&
> +			    udev->parent->quirks & USB_QUIRK_HUB_SLOW_RESET)

There's no need to test udev->parent, or even to put this code under
the "if (udev)" test.  You should simply use hub->hdev instead; it will
always be defined.

Alan Stern

> +				msleep(100);
> +
>  			update_devnum(udev, 0);
>  			/* The xHC may think the device is already reset,
>  			 * so ignore the status.

