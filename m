Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55345C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBED2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBED2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeLJUGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:06:13 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:33786 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726912AbeLJUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:06:12 -0500
Received: (qmail 5481 invoked by uid 2102); 10 Dec 2018 15:06:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2018 15:06:11 -0500
Date:   Mon, 10 Dec 2018 15:06:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <mathias.nyman@linux.intel.com>, <heikki.krogerus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
Subject: Re: [PATCH] usb: core: Remove unnecessary memset()
In-Reply-To: <20181204143143.8407-1-suwan.kim027@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1812101503110.1562-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Suwan Kim wrote:

> register_root_hub() calls memset() setting usb_dev->bus->devmap.
> devicemap to 0 during hcd probe function (usb_hcd_pci_probe). But
> in previous function which is also the procedure of usb_hcd_pci_probe(),
> usb_bus_init() already initialized bus->devmap calling memset().
> Furthermore, register_root_hub() is called only once in kernel.
> So, calling memset() which resets usb_bus->devmap.devicemap in
> register_root_hub() is redundant.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/usb/core/hcd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 487025d31d44..015b126ce455 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1074,8 +1074,6 @@ static int register_root_hub(struct usb_hcd *hcd)
>  
>  	usb_dev->devnum = devnum;
>  	usb_dev->bus->devnum_next = devnum + 1;
> -	memset (&usb_dev->bus->devmap.devicemap, 0,
> -			sizeof usb_dev->bus->devmap.devicemap);
>  	set_bit (devnum, usb_dev->bus->devmap.devicemap);
>  	usb_set_device_state(usb_dev, USB_STATE_ADDRESS);

Acked-by: Alan Stern <stern@rowland.harvard.edu>

