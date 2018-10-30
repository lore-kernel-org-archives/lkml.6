Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE20C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3037C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3037C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeJ3Xyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:54:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51706 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727545AbeJ3Xyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:54:35 -0400
Received: (qmail 4836 invoked by uid 2102); 30 Oct 2018 11:00:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2018 11:00:46 -0400
Date:   Tue, 30 Oct 2018 11:00:46 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Don't enable LPM if it's already enabled
In-Reply-To: <c5d72c60-c13c-8801-26d5-2fe8ab48d98c@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.1810301058540.1515-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018, Mathias Nyman wrote:

> On 30.10.2018 07:54, Kai-Heng Feng wrote:
> > USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> > after S3:
> > [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> > [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> > 
> > After some experiments, I found that disabling LPM can workaround the
> > issue.
> > 
> > On some platforms, the USB power is cut during S3, so the driver uses
> > reset-resume to resume the device. During port resume, LPM gets enabled
> > twice, by usb_reset_and_verify_device() and usb_port_resume().
> > 
> > So let's enable LPM for just once, as this solves the issue for the
> > device in question.
> > 
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/usb/core/driver.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index 53564386ed57..e11d2eac76b6 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -1901,7 +1901,8 @@ int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
> >   	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> >   	int ret = -EPERM;
> >   
> > -	if (enable && !udev->usb2_hw_lpm_allowed)
> > +	if (enable && !udev->usb2_hw_lpm_allowed ||
> > +	    udev->usb2_hw_lpm_enabled == enable)
> >   		return 0;
> >   
> >   	if (hcd->driver->set_usb2_hw_lpm) {
> > 
> 
> Something like that would probably work.
> 
> Would it make sense to skip USB2 hw LPM enabling in usb_port_resume() if
> port was just reset (and thus LPM enabled)?
> 
> something like this:
> 
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3520,7 +3520,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>                  hub_port_logical_disconnect(hub, port1);
>          } else  {
>                  /* Try to enable USB2 hardware LPM */
> -               if (udev->usb2_hw_lpm_capable == 1)
> +               if (udev->usb2_hw_lpm_capable == 1 && !udev->reset_resume)
>                          usb_set_usb2_hardware_lpm(udev, 1);
>   
>                  /* Try to enable USB3 LTM */

Why not simply test whether udev->usb2_hw_lpm_enabled is already true?

		if (udev->usb2_hw_lpm_capable == 1 &&
				!udev->usb2_hw_lpm_enabled)

Or even put this extra test into usb_set_usb2_hardware_lpm().

Alan Stern

