Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51022C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0887F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0887F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLDVgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:36:20 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:47230 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725899AbeLDVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:36:19 -0500
Received: (qmail 9122 invoked by uid 2102); 4 Dec 2018 16:36:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Dec 2018 16:36:18 -0500
Date:   Tue, 4 Dec 2018 16:36:18 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kyle Williams <kdgwill@chromium.org>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        =?UTF-8?Q?Michael_Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Nico Sneck <snecknico@gmail.com>,
        Tim Anderson <tsa@biglakesoftware.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: quirks: add NO_LPM quirk for Logitech
 Flare|Meetup|Brio|Rally
In-Reply-To: <CAAd214WBzcsFamzqkdTp0AYDRo1=Uq1=Z5fJhzkOZ6znVFo3MA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1812041633580.1537-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Kyle Williams wrote:

> Description: Some USB device / host controller combinations seem to have
> problems with Link Power management. In particular it is described that
> the combination of certain Logitech devices and other powered media
> devices such as the Atrus device causes 'not enough bandwidth for
> new device state'error.
> 
> This patch creates quirk entries for the tested Logitech device
> indicating LPM should remain disabled for the device.
> 
> Signed-off-by: Kyle Williams <kdgwill@chromium.org>
> ---
>  drivers/usb/core/quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 0690fcff0ea2..9403edee4797 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -246,6 +246,22 @@ static const struct usb_device_id usb_quirk_list[] = {
>         /* Logitech Harmony 700-series */
>         { USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT },
> 
> +       /* Logitech Flare */
> +       { USB_DEVICE(0x046d, 0x0876), .driver_info = USB_QUIRK_NO_LPM },

This entry is out of order with the preceding entry.  And some of the 
new entries below are out of order with each other (entries are 
supposed to be sorted by Vendor ID, then Product ID).

Also, perhaps instead of adding all these new entries, we should set 
the NO_LPM quirk flag for all Logitech devices?

Alan Stern

> +
> +       /* Logitech Rally Camera */
> +       { USB_DEVICE(0x046d, 0x0881), .driver_info = USB_QUIRK_NO_LPM },
> +       { USB_DEVICE(0x046d, 0x0888), .driver_info = USB_QUIRK_NO_LPM },
> +       { USB_DEVICE(0x046d, 0x0889), .driver_info = USB_QUIRK_NO_LPM },
> +
> +       /* Logitech Meetup */
> +       { USB_DEVICE(0x046d, 0x0867), .driver_info = USB_QUIRK_NO_LPM },
> +       { USB_DEVICE(0x046d, 0x0866), .driver_info = USB_QUIRK_NO_LPM },
> +       { USB_DEVICE(0x046d, 0x086a), .driver_info = USB_QUIRK_NO_LPM },
> +
> +       /* Logitech Brio */
> +       { USB_DEVICE(0x046d, 0x085e), .driver_info = USB_QUIRK_NO_LPM },
> +
>         /* Philips PSC805 audio device */
>         { USB_DEVICE(0x0471, 0x0155), .driver_info = USB_QUIRK_RESET_RESUME
> },
> 
> 

